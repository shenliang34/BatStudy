import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.battle.display.BattleFigureItem;
import com.gamehero.sxd2.event.RenderItemEvent;
import com.gamehero.sxd2.vo.BattleSkillEf;
import com.gamehero.sxd2.vo.BattleSkillMove;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Cubic;

import flash.geom.Point;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import bowser.utils.effect.FilterEffect;
import bowser.utils.effect.ShakeEffect;

/**
 * 战斗角色动作逻辑
 * @author xuwenyi
 * @create 2014-01-15
 **/


/**
 * 跑动
 * */
public function run():void
{
	if(alive == true)
	{
		// 调整帧频
		avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.RUN);
		// 动作
		avatar.setFigureStatus(BattleFigureItem.RUN);
		avatar.play(true);
	}
}





/**
 * 跳跃
 * */
public function jump():void
{
	if(alive == true)
	{
		// 调整帧频
		avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.JUMP);
		// 动作
		avatar.setFigureStatus(BattleFigureItem.JUMP);
		avatar.play(true);
	}
}




/**
 * 待机
 * */
public function stand(e:RenderItemEvent = null):void
{
	if(alive == true)
	{
		// 调整帧频
		avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.STAND);
		// 动作
		avatar.setFigureStatus(BattleFigureItem.STAND);
		avatar.play(true);
	}
}




/**
 * 攻击
 * */
public function attack(skillEf:BattleSkillEf):void
{
	if(alive == true)
	{
		// 调整帧频
		var actionFrame:int = skillEf.actionFrame != 0 ? skillEf.actionFrame : 16;
		actionFrame /= dataCenter.playSpeed;// 播放速度系数
		avatar.frameRate = actionFrame;
		
		// 攻击动作
		avatar.setFigureStatus(BattleFigureItem.ATTACK , skillEf.attackId);
		avatar.play(false);
		avatar.addEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
		
		// 播放se音效
		this.playSound(skillEf.seSound , skillEf.seSoundDelay);
	}
	
}





/**
 * 被攻击
 * @param skillEf 攻击效果
 * @param needHit 是否播放受击动作
 * */
public function underAttack(skillEf:BattleSkillEf):void
{
	// 人物未死亡并且此技能没有壳动画
	if(hasDead == false)
	{
		// 当前动作不是受击
		//var idx:int = avatar.status.indexOf(BattleFigureItem.HIT);
		if(skillEf.moves == null && skillEf.isSkillMove == false)
		{
			// 若之前有受击动作，则清除此timer
			if(hitTimerID > 0)
			{
				clearTimeout(hitTimerID);
			}
			
			// 调整帧频
			avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.HIT);
			// 受击
			avatar.setFigureStatus(BattleFigureItem.HIT , skillEf.hit);
			avatar.play(false);
			// 受击持续时间
			var uatkDuration:Number = skillEf.uatkDuration;
			if(uatkDuration != 0)
			{
				// 持续一段时间后结束动作
				var t:int = int(uatkDuration) * dataCenter.playSpeed;// 播放速度系数
				hitTimerID = setTimeout(actOver , t);
			}
			else
			{
				avatar.addEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
			}
			
			// 人物受击抖动
			ShakeEffect.instance.start(avatarSprite , 2 , 4 , this.faceAngle + Math.PI/4 , 2);
			
			// 受击阴影
			setTimeout(playShadow , 100);
			
			// 播放ua音效
			this.playSound(skillEf.uaSound , skillEf.uaSoundDelay);
		}
		
		// 人物受击变色
		this.changeColor(avatar , UA_PLAYER_COLORS);
	}
}







/**
 * 格挡
 * */
public function parry():void
{
	if(hasDead == false)
	{
		// 当前动作不是格挡
		var idx:int = avatar.status.indexOf(BattleFigureItem.PARRY);
		if(idx < 0)
		{
			// 调整帧频
			avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.PARRY);
			// 格挡
			avatar.setFigureStatus(BattleFigureItem.PARRY);
			avatar.addEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
			avatar.play(false);
		}
		
		// 播放格挡动画
		this.showParryEf();
	}
}






/**
 * 摔倒后起身
 * */
public function standup():void
{
	if(alive == true)
	{
		// 调整帧频
		avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.STANDUP);
		// 格挡
		avatar.setFigureStatus(BattleFigureItem.STANDUP);
		avatar.addEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
		avatar.play(false);
	}
}






/**
 * 动作播放结束
 * */
private function actOver(e:RenderItemEvent = null):void
{
	hitTimerID = 0;
	
	if(avatar)
	{
		avatar.removeEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
		avatar.clear();
		
		// 若角色已死亡,则播放死亡特效
		if(this.alive == false)
		{
			this.dead();
		}
		else
		{
			// 站立
			this.stand();
		}
	}
}







/**
 * 角色死亡
 * */
public function dead():void
{
	// 若已死亡,播放死亡特效
	if(this.alive == false && hasDead == false)
	{
		hasDead = true;
		var playSpeed:Number = dataCenter.playSpeed;//播放速度系数
		
		// 死亡动作(如果之前的受击动作不是卧倒的姿势,则先播放死亡动作)
		if(avatar.status != BattleFigureItem.DEAD_HIT)
		{
			avatar.frameRate = dataCenter.getFrameRate(playerType , BattleFigureItem.DEAD);
			avatar.setFigureStatus(BattleFigureItem.DEAD);
			avatar.addEventListener(RenderItemEvent.PLAY_COMPLETE , showDeadEf);
			avatar.play(false);
		}
		else
		{
			// 死亡特效
			this.showDeadEf();
		}
		
		// 不显示血条和名字
		this.clearUI();
		
		// 显示命魂
		if(isMonster == true)
		{
			this.playSoul();
		}		
	}
	
}








/**
 * 闪避(向后移动)
 * */
public function avoid(skillEf:BattleSkillEf):void
{
	if(skillEf.isSkillMove == false && avatarSprite)
	{
		var oriX:int = this.x;
		var targetX:int = camp == 1 ? oriX-40 : oriX+40;
		
		// 退后
		var playSpeed:Number = dataCenter.playSpeed;//播放速度系数
		var self:BPlayer = this;
		TweenMax.to(self , 0.1*playSpeed , {x:targetX , onComplete:back});
		
		// 返回原来位置
		function back():void
		{
			TweenMax.to(self , 0.1*playSpeed , {x:oriX , delay:0.3*playSpeed});
		}
	}
}









/**
 * 壳动画移动
 * */
public function uaMove(moves:Array):void
{
	var self:BPlayer = this;
	var ox:Number = this.x;
	var oy:Number = this.y;
	
	var delay:int;
	var preDuration:int = 0;//上一次壳动画的duration
	var iLen:int = moves.length;
	for(var i:int=0;i<iLen;i++)
	{
		var move:BattleSkillMove = moves[i];
		delay += move.delay * dataCenter.playSpeed + preDuration;
		setTimeout(play , delay , move , i == iLen - 1);
		preDuration = move.duration * dataCenter.playSpeed;
	}
	
	function play(move:BattleSkillMove , isEnd:Boolean):void
	{
		self.isNeedRender = true;
		// 隐藏技能圈圈
		self.showPreSkill(false);
		
		var duration:Number = move.duration * dataCenter.playSpeed;
		var face:Number = move.mirror == 1 ? -1 : 1;
		var scaleX:Number = move.scale * face;
		var scaleY:Number = move.scale;
		var angle:Number = /*camp == 1 ? */move.angle/* : -move.angle*/;//角色若是阵营1的需要转变角度
		var offset:Point = move.move;
		var targetX:Number = camp == 1 ? -offset.x + ox : offset.x + ox;//角色若是阵营1的需要转变x坐标
		var targetY:Number = offset.y + oy;
		// 若有曲线
		var bezier:Point;
		var curve:Point = move.curve;
		if(curve != null)
		{
			if(camp == 1)//角色若是阵营1的需要转变x坐标
			{
				bezier = new Point(-curve.x + ox , curve.y + oy);
			}
			else
			{
				bezier = new Point(curve.x + ox , curve.y + oy);
			}
		}
		
		// 受击
		if(avatar != null)
		{
			avatar.frameRate = 16;
			avatar.setFigureStatus(move.hit);
			avatar.play(false);
			
			// 是否反转
			if( (face == -1 && self.scaleX > 0) || (face == 1 && self.scaleX < 0) )
			{
				self.scaleX *= -1;
			}
			
			if(duration <= 0)
			{
				self.x = targetX;
				self.y = targetY;
				avatar.rotation = angle;
				self.scaleX = scaleX;
				self.scaleX = scaleY;
			}
			else
			{
				// 曲线
				if(curve != null)
				{
					TweenMax.to(self , duration*0.001 , {bezier:{values:[bezier,new Point(targetX,targetY)]} , scaleX:scaleX , scaleY:scaleY , ease:move.ease});
				}
				else
				{
					TweenLite.to(self , duration*0.001 , {x:targetX , y:targetY , scaleX:scaleX , scaleY:scaleY , ease:move.ease});
				}
				// 角度变化
				if(avatar.rotation != angle)
				{
					TweenLite.to(avatar , duration*0.001 , {rotation:angle , ease:move.ease});
				}
			}
		}
		
		
		// 壳动画已结束
		if(isEnd == true)
		{
			setTimeout(end , duration);
		}
		
		function end():void
		{
			// 壳动画全部已播放完毕,还原属性
			avatar.rotation = 0;
			scaleX = scaleY = 1;
			
			// 角色是否死亡
			if(alive == true)
			{
				var preStatus:String = avatar.status;
				avatar.clear();
				stand();
				
				// 移动回到原来的位置
				if(x != position.x || y != position.y)
				{
					// 最后一个动作是卧倒姿势
					if(preStatus == BattleFigureItem.DEAD_HIT)
					{
						//起身
						standup();
						
						setTimeout(move , 100);
					}
					else
					{
						move();
					}
					
					function move():void
					{
						var t:Number = 0.3 * dataCenter.playSpeed;
						// 跑动
						TweenMax.to(self , t , {x:position.x , y:position.y , ease:Cubic.easeInOut});
						// 往返透明
						FilterEffect.instance.alpha(avatar , t , 1 , 0);
					}
				}
				else
				{
					x = position.x;
					y = position.y;
				}
				
				// 恢复技能圈圈
				self.showPreSkill(self.canUseSkill);
			}
			else
			{
				x = position.x;
				y = position.y;
				
				dead();
			}
		}
	}
	
}