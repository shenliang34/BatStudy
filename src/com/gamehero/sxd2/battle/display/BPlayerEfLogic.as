import com.gamehero.sxd2.battle.data.BattleConfig;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.battle.display.BattleEfItem;
import com.gamehero.sxd2.core.GameConfig;
import com.gamehero.sxd2.event.RenderItemEvent;
import com.gamehero.sxd2.manager.SoundManager;
import com.gamehero.sxd2.vo.BattleSkillEf;
import com.gamehero.sxd2.world.display.GameRenderItem;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Cubic;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flash.utils.setTimeout;

import bowser.logging.Logger;
import bowser.render.display.RenderItem;
import bowser.utils.effect.color.ColorTransformUtils;

/**
 * 战斗角色特效逻辑
 * @author xuwenyi
 * @create 2014-01-15
 **/

// 受击时人物的颜色变化
private static const UA_PLAYER_COLORS:Array = [	new ColorTransform(1,1,1,1,255,64,64)
												,new ColorTransform(1,1,1,1,200,48,48)
												,new ColorTransform(1,1,1,1,150,32,32)
												,new ColorTransform(1,1,1,1,100,16,16)
												,new ColorTransform(1,1,1,1,50,0,0)];
// 受击时人物阴影的颜色变化
private static const UA_SHADOW_COLORS:Array = [	new ColorTransform(1,1,1,1,255,255,255,-160)
												,new ColorTransform(1,1,1,1,255,255,255,-180)
												,new ColorTransform(1,1,1,1,255,255,255,-200)
												,new ColorTransform(1,1,1,1,255,255,255,-220)
												,new ColorTransform(1,1,1,1,255,255,255,-255)];
// 死亡时人物变黑
private static const DEAD_COLORS:Array = [	new ColorTransform(1,1,1,1,-40,-40,-40)
												,new ColorTransform(1,1,1,1,-80,-80,-80)
												,new ColorTransform(1,1,1,1,-128,-128,-128)];

// 开场伙伴亮度变化
public static const OPENING_FILTERS:Array = [	ColorTransformUtils.getColorMatrixFilter(40)
												,ColorTransformUtils.getColorMatrixFilter(34)
												,ColorTransformUtils.getColorMatrixFilter(28)
												,ColorTransformUtils.getColorMatrixFilter(22)
												,ColorTransformUtils.getColorMatrixFilter(16)
												,ColorTransformUtils.getColorMatrixFilter(8)];




/**
 * 变身
 * @param callback 变身后回调
 * @param transformURL 变身资源url
 * */
public function transform(callback:Function = null , transURL:String = null):void
{
	if(transURL)
	{
		// 变身URL
		this.transformURL = transURL;
		transformURL = GameConfig.BATTLE_FIGURE_URL + transformURL + "_" + this.avatarFace;
		
		// url发生变化才需要重新加载
		if(avatar.url != transformURL)
		{
			// 渐隐原avatar
			TweenMax.to(avatar , 0.3 , {alpha:0 , onComplete:show});
			
			// 开始渐现并变身
			function show():void
			{
				// 渐现变身avatar
				TweenMax.to(avatar , 0.3 , {alpha:1,onComplete:complete});
				
				// 加载变身素材
				avatar.clear();
				loadAvatar(transformURL);
				
				// log
				Logger.debug(BPlayer , "[" + name + "]开始变身!!!");
			}
		}
		else
		{
			complete();
		}
	}
	else
	{
		complete();
	}
	
	// 渐现结束
	function complete():void
	{
		// 回调
		if(callback)
		{
			callback();
		}
	}
}





/**
 * 取消变身
 * */
public function cancelTransform():void
{
	var url:String = this.avatarURL;
	// url发生变化才需要重新加载
	if(avatar.url != url && transformURL == null)
	{
		// 渐隐变身avatar
		TweenMax.to(avatar , 0.2 , {alpha:0 , onComplete:show});
		
		function show():void
		{
			// 渐现原avatar
			TweenMax.to(avatar , 0.2 , {alpha:1});
			
			// 加载原素材
			loadAvatar(url);
		}
	}
}





/**
 * 准备释放技能的圈圈
 * */
public function showPreSkill(value:Boolean):void
{
	if(preSkillItem && this.alive == true && isPlayer == false)
	{
		if(value == true)
		{
			preSkillItem.play(true);
		}
		else
		{
			preSkillItem.stop();
		}
		preSkillItem.visible = value;
	}
}








/**
 * 聚气效果
 * */
public function showJuqi(callback:Function = null):void
{
	juqiItem.status = "TX_jq_";
	juqiItem.frameRate = 24 / dataCenter.playSpeed;//播放速度系数
	juqiItem.play(false);
	juqiItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , animCompHandler);
	juqiItem.visible = true;
	
	// 播放完毕后回调
	function animCompHandler(e:RenderItemEvent):void
	{
		juqiItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , animCompHandler);
		juqiItem.stop();
		juqiItem.visible = false;
		
		if(callback) callback();
	}
}





/**
 * 格挡效果
 * */
public function showParryEf():void
{
	defenseItem.url = BattleConfig.PARRY;
	defenseItem.frameRate = 12 / dataCenter.playSpeed;//播放速度系数
	defenseItem.play(false);
	defenseItem.visible = true;
	defenseItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
}





/**
 * 穿透效果
 * */
public function showPenetrationEf():void
{
	defenseItem.url = BattleConfig.PENETRATION;
	defenseItem.frameRate = 12 / dataCenter.playSpeed;//播放速度系数
	defenseItem.play(false);
	defenseItem.visible = true;
	defenseItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
}






/**
 * 死亡效果
 * */
public function showDeadEf(e:RenderItemEvent = null):void
{
	avatar.removeEventListener(RenderItemEvent.PLAY_COMPLETE , showDeadEf);
	avatar.clear();
	
	var playSpeed:Number = dataCenter.playSpeed;//播放速度系数
	
	// 死亡粒子特效
	if(deathParticleItem != null)
	{
		deathParticleItem.visible = true;
		deathParticleItem.frameRate = 24 / playSpeed;//播放速度系数
		deathParticleItem.play(false);
		deathParticleItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
	}
	// 死亡火星蒙板
	if(deathMaskItem != null)
	{
		// 组装一个死亡动作最后一帧的renderData
		if(avatar.renderSource != null)
		{
			var deathData:Object = new Object();
			deathData.texture = avatar.renderSource;
			deathData.frame = new Rectangle(avatar.x , avatar.y);
			
			deathMaskItem.visible = true;
			deathMaskItem.frameRate = 14 / playSpeed;//播放速度系数
			deathMaskItem.playDead(deathData);
			deathMaskItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
		}
	}
	
	// 变黑
	this.changeColor(avatar , DEAD_COLORS , over);
	
	function over():void
	{
		avatar.colorTransform = DEAD_COLORS[2];
		
		TweenMax.to(avatar , 0.8*playSpeed , {alpha:0 , onComplete:disappear});
	}
}







/**
 * 角色死亡后消失
 * */
private function disappear(e:RenderItemEvent = null):void
{
	if(isDisappear == false)
	{
		avatar.colorTransform = null;
		avatar.visible = false;
		
		if(deathParticleItem != null)
		{
			deathParticleItem.stop();
			deathParticleItem.clear();
			deathParticleItem.clearRender();
			deathParticleItem.visible = false;
		}
		if(deathMaskItem != null)
		{
			deathMaskItem.stop();
			deathMaskItem.clear();
			deathMaskItem.clearRender();
			deathMaskItem.visible = false;
		}
		isDisappear = true;
	}
}





/**
 * 受击时播放阴影
 * */
private function playShadow():void
{
	// 受击动作图
	var bd:BitmapData = avatar.renderSource;
	
	uaShadowItem.renderSource = bd;
	uaShadowItem.x = avatar.x;
	uaShadowItem.y = avatar.y;
	uaShadowItem.scaleX = uaShadowItem.scaleY = 1;
	uaShadowItem.visible = true;
	this.changeColor(uaShadowItem , UA_SHADOW_COLORS);
	
	// 原始坐标
	var targetWidth:Number = bd.width;
	var targetHeight:Number = bd.height;
	var offsetX:String = "-" + targetWidth*0.1;
	var offsetY:String = "-" + targetHeight*0.2;
	
	// 放大
	TweenLite.to(uaShadowItem , 0.24*dataCenter.playSpeed , {x:offsetX,y:offsetY,scaleX:1.2,scaleY:1.2,onComplete:over});
	
	function over():void
	{
		uaShadowItem.scaleX = uaShadowItem.scaleY = 1;
		uaShadowItem.colorTransform = null;
		uaShadowItem.visible = false;
	}
}





/**
 * 变色
 */
private function changeColor(target:RenderItem , colors:Array , callback:Function = null):void
{
	ColorTransformUtils.instance.playGradiantColor2(target , 42 , colors , callback);
}






/**
 * colorMatrix变化(亮度，对比度等)
 */
public function changeColorMatrix(target:RenderItem , filters:Array , callback:Function = null):void
{
	ColorTransformUtils.instance.playGradiantColorMatrix2(target , 42 , filters , callback);
}






/**
 * 播放自身特效
 * */
public function playSE(skillEf:BattleSkillEf):void
{
	if(alive == true)
	{
		// 技能自身效果
		var seDelay:int = skillEf.seDelay != 0 ? skillEf.seDelay : 10;
		seDelay *= dataCenter.playSpeed;// 播放速度系数
		setTimeout(playSE , seDelay);
	}
	
	function playSE():void
	{
		if(seAirItem != null)
		{
			// 自身效果帧频
			var seFrame:int = skillEf.seFrame != 0 ? skillEf.seFrame : 12;
			seFrame /= dataCenter.playSpeed;// 播放速度系数
			
			seAirItem.url = skillEf.getSeURL();
			seAirItem.frameRate = seFrame;
			seAirItem.play(false);
			seAirItem.visible = true;
			seAirItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
			
			// 如果该技能存在自身效果地面层
			if(skillEf.seLayer == "1")
			{
				seGroundItem.url = skillEf.getSeURL();
				seGroundItem.frameRate = seFrame;
				seGroundItem.play(false);
				seGroundItem.visible = true;
				seGroundItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
			}
		}
	}
}






/**
 * 播放受击特效
 * */
public function playUA(skillEf:BattleSkillEf , aPlayerFace:String , isSpurt:Boolean):void
{
	if(uaAirItem != null)
	{
		// 受击ua效果
		var uaAirURL:String = "";
		var uaGroundURL:String = "";
		
		// 非溅射
		var efUA:String = skillEf.efUA;
		var efSUA:String = skillEf.efSUA;
		if(efUA != "" && skillEf.isPNG(efUA) == true && isSpurt == false)
		{
			uaAirURL = skillEf.getUaURL();
			uaGroundURL = skillEf.getUaURL();
		}
			// 溅射
		else if(efSUA != "" && skillEf.isPNG(efSUA) == true && isSpurt == true)
		{
			uaAirURL = skillEf.getSUaURL();
			uaGroundURL = skillEf.getSUaURL();
		}
		// 受击效果帧频
		var uaFrame:int = skillEf.uaFrame != 0 ? skillEf.uaFrame : 12;
		uaFrame /= dataCenter.playSpeed;// 播放速度系数
		
		// 受击空中效果
		if(uaAirURL != "")
		{
			uaAirItem.url = uaAirURL;
			uaAirItem.face = aPlayerFace;
			uaAirItem.frameRate = uaFrame;
			uaAirItem.play(false);
			uaAirItem.visible = true;
			uaAirItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
		}
		// 受击地面效果
		if((skillEf.uaLayer == "1" || skillEf.suaLayer == "1") && uaGroundURL != "")
		{
			uaGroundItem.url = uaGroundURL;
			uaGroundItem.face = aPlayerFace;
			uaGroundItem.frameRate = uaFrame;
			uaGroundItem.play(false);
			uaGroundItem.visible = true;
			uaGroundItem.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
		}
	}
}






/**
 * 技能类战斗效果播放结束
 * */
private function effectOver(e:RenderItemEvent):void
{
	var item:GameRenderItem = e.data as GameRenderItem;
	item.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
	
	item.url = null;
	item.isPlaying = false;
	item.visible = false;
	item.clearRender();
	item.clear();
}






/**
 * 触发技能音效
 * */
private function playSound(soundID:String , delay:Number):void
{
	if(soundID != "")
	{
		delay += 1;
		delay *= dataCenter.playSpeed;// 播放速度系数
		
		setTimeout(function():void
		{
			SoundManager.inst.play(soundID);
		},delay);
	}
}






/**
 * 主角云动画
 */
public function playCloud():void
{
	var offy:String = "-180";
	
	// 显示云
	cloudItem.visible = true;
	cloudItem.play(true);
	cloudItem.alpha = 0;
	TweenLite.to(cloudItem , 0.7 , {alpha:1});
	
	// 移动主角
	TweenLite.to(this , 0.7 , {y:offy , ease:Cubic.easeOut , onComplete:over});
	
	function over():void
	{
		cloudShadowItem.visible = true;
		cloudShadowItem.play(true);
	}
}







/**
 * 死亡后出现命魂
 */
public function playSoul():void
{
	preSkillItem.url = BattleConfig.SOUL;
	preSkillItem.status = BattleEfItem.SELF_AIR;
	preSkillItem.frameRate = 16;
	preSkillItem.visible = true;
	preSkillItem.play(true);
}