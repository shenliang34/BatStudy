package com.gamehero.sxd2.battle.layer
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleAtkData;
	import com.gamehero.sxd2.battle.data.BattleDamageData;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleBurstEf;
	import com.gamehero.sxd2.battle.gui.BFlash;
	import com.gamehero.sxd2.battle.gui.NumberFloatingText;
	import com.gamehero.sxd2.common.GameMovie;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	import com.gamehero.sxd2.vo.BuffVO;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import bowser.utils.MovieClipPlayer;
	import bowser.utils.effect.ShakeEffect;
	
	
	/**
	 * 战斗中效果层(传统层)
	 * @author xuwenyi
	 * BattleAvatar-06-26
	 **/
	public class BattleEfCanvas extends Sprite
	{
		private static var _instance:BattleEfCanvas;
		
		// 分上下2层
		private var topLayer:Sprite;
		private var downLayer:Sprite;
		// swf技能层
		private var skillLayer:BattleSwfSkillLayer;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleEfCanvas()
		{
			topLayer = new Sprite();
			downLayer = new Sprite();
			skillLayer = new BattleSwfSkillLayer();
			
			this.addChild(skillLayer);
			this.addChild(downLayer);
			this.addChild(topLayer);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		public static function get instance():BattleEfCanvas
		{
			if(_instance == null)
			{
				_instance = new BattleEfCanvas();
			}
			return _instance;
		}
		
		
		
		
		
		
		/**
		 * 添加伤害飘字特效
		 * @param data 伤害数据
		 * @param view 需要地震的显示对象
		 * @return 返回是否需要播放受击动画
		 * */
		public function playDmgEf(data:BattleDamageData , view:DisplayObject):void
		{
			var uPlayer:BPlayer = data.uPlayer;
			var atkData:BattleAtkData = data.atkData;
			
			// 角色头顶坐标
			var targetX:int = uPlayer.x;
			var targetY:int = uPlayer.y - uPlayer.playerHeight;
			var offsetX:int = uPlayer.camp == 1 ? 65 : -65;
			var offsetY:int = 0;
			
			// 文字组件
			var text:NumberFloatingText = new NumberFloatingText();
			// 吸收
			if(atkData.abb > 0 && atkData.dmgShow == 0)
			{
				offsetY = -35;
				//text.setText(5 , atkData.abb);
				text.setText(0 , atkData.abb);
				downLayer.addChild(text);
			}
			// 伤害
			else if(atkData.dmgShow > 0)
			{
				// 暴击
				if(atkData.crt == true)
				{
					offsetY = -35;
					text.setText(2 , atkData.dmgShow);
					// 震动
					ShakeEffect.instance.start(view , 5 , 8);
				}
				// 格挡
				else if(atkData.pay == true)
				{
					offsetY = -35;
					text.setText(0 , atkData.dmgShow);
					// 格挡文字动画
					this.playMC(BattleSkin.PAY , targetX + offsetX , targetY + offsetY);
				}
				// 穿透
				else if(atkData.pnt == true)
				{
					offsetY = -35;
					text.setText(0 , atkData.dmgShow);
					// 穿透文字动画
					this.playMC(BattleSkin.PEN , targetX + offsetX , targetY + offsetY);
				}
				// 普通伤害
				else
				{
					// 伤害
					offsetY = -35;
					text.setText(0 , atkData.dmgShow);
				}
			}
			// 加血
			else if(atkData.dmgShow < 0)
			{
				// 治疗
				text.setText(1 , -atkData.dmgShow);
			}
			// 闪避
			else if(atkData.avd == true)
			{
				offsetY = -35;
				this.playMC(BattleSkin.AVD , targetX , targetY + offsetY);
			}
			
			if(text != null)
			{
				text.x = targetX;
				text.y = targetY + offsetY;
				downLayer.addChild(text);
			}
			
		}
		
		
		
		
		
		
		/**
		 * 添加显示传统swf的状态特效
		 * */
		public function playStEf(buff:BuffVO , player:BPlayer):void
		{
			if(buff && buff.displayType == "2")
			{
				// url
				var swfURL:String = GameConfig.BATTLE_BUFF_EFFECT_URL + "swf/" + buff.efURL + ".swf";
				// 定位
				var h:int = player.playerHeight;
				var posX:int = player.x;
				var posY:int = player.y - h;
				
				this.playSwf(swfURL , "EFFECT" , posX , posY , 2);
			}
		}
		
		
		
		
		
		/**
		 * 播放全屏特效
		 * */
		public function playScreenEf(skillEf:BattleSkillEf , view:DisplayObject):void
		{
			var i:int;
			var delays:Array;
			var delay:int;
			var playSpeed:Number = BattleDataCenter.instance.playSpeed;//播放速度系数
			// 是否全屏抖动
			var shakeDelays:Array = skillEf.shakeDelays;
			if(shakeDelays.length > 0 && shakeDelays[0] != "")
			{
				for(i=0;i<shakeDelays.length;i++)
				{
					delay = int(shakeDelays[i]);
					delay *= playSpeed;//播放速度系数
					// 震动
					setTimeout(function():void
					{
						ShakeEffect.instance.start(view , 4 , 8);
					},delay);
				}
			}
			
			// 是否闪屏
			var flashDelays:Array = skillEf.flashDelays;
			if(flashDelays.length > 0 && flashDelays[0] != "")
			{
				for(i=0;i<flashDelays.length;i++)
				{
					delay = int(flashDelays[i]);
					delay *= playSpeed;//播放速度系数
					// 闪屏
					setTimeout(function():void
					{
						var bflash:BFlash = new BFlash();
						topLayer.addChild(bflash);
					},delay);
				}
			}
		}
		
		
		
		
		
		/**
		 * 播放全屏审判技能特效
		 * */
		public function playBurstEf(player:BPlayer , skillEf:BattleSkillEf , head:String = ""):void
		{
			var stage:Stage = this.stage;
			if(stage)
			{
				var burstEf:BattleBurstEf = new BattleBurstEf();
				// 计算场景尺寸
				var viewWidth:int = Math.max(stage.stageWidth , BattleView.MIN_WIDTH);
				viewWidth = Math.min(viewWidth , BattleView.MAX_WIDTH);
				var viewHeight:int = Math.max(stage.stageHeight , BattleView.MIN_HEIGHT);
				viewHeight = Math.min(viewHeight , BattleView.MAX_HEIGHT);
				// 效果位置
				burstEf.x = viewWidth>>1;
				burstEf.y = viewHeight>>1;
				// 加载并播放
				burstEf.load(player , skillEf , head);
				burstEf.play();
				topLayer.addChild(burstEf);
			}
			
		}
		
		
		
		
		
		
		/**
		 * 添加swf技能se
		 * */
		public function playSwfSE(skillEf:BattleSkillEf , aPlayer:BPlayer):void
		{
			var seDelay:int = skillEf.seDelay;
			seDelay *= BattleDataCenter.instance.playSpeed;// 播放速度系数
			
			if(seDelay == 0)
			{
				playSE();
			}
			else
			{
				setTimeout(playSE , seDelay);
			}
			
			function playSE():void
			{
				skillLayer.playSE(skillEf , aPlayer);
			}
		}
		
		
		
		
		
		
		
		/**
		 * 添加swf技能ua
		 * */
		public function playSwfUA(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
		{
			skillLayer.playUA(skillEf , aPlayer , uPlayer);
		}
		
		
		
		
		
		
		
		/**
		 * 添加swf技能sk
		 * */
		public function playSwfSK(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
		{
			skillLayer.playSK(skillEf , aPlayer , uPlayer);
		}
		
		
		
		
		
		
		/**
		 * 播放swf特效
		 * */
		private function playSwf(url:String , classname:String , posX:int , posY:int , whichLayer:int , blendMode:String = ""):void
		{
			// 决定层级
			var layer:Sprite = whichLayer == 1 ? topLayer : downLayer;
			
			var gm:GameMovie = new GameMovie();
			gm.movieBlendMode = blendMode;
			gm.load(url , classname , BattleDataCenter.instance.loader);
			gm.play();
			gm.x = posX;
			gm.y = posY;
			gm.addEventListener(Event.COMPLETE , onPlayOver);
			layer.addChild(gm);
		}
		
		
		
		
		
		/**
		 * 播放已有的mc动画
		 * */
		private function playMC(cls:Class , posX:int , posY:int):void
		{
			var movie:MovieClip = new cls() as MovieClip;
			movie.x = posX;
			movie.y = posY;
			
			var pl:MovieClipPlayer = new MovieClipPlayer();
			pl.play(movie , movie.totalFrames * 0.042 , 0 , movie.totalFrames);
			pl.addEventListener(Event.COMPLETE , over);
			downLayer.addChild(movie);
			
			function over(e:Event):void
			{
				pl.removeEventListener(Event.COMPLETE , over);
				pl = null;
				
				if(movie != null && downLayer.contains(movie) == true)
				{
					downLayer.removeChild(movie);
					movie = null;
				}
			}
		}
		
		
		
		
		
		/**
		 * swf动画播放完毕
		 * */
		private function onPlayOver(e:Event):void
		{
			var gm:GameMovie = e.currentTarget as GameMovie; 
			gm.removeEventListener(Event.COMPLETE , onPlayOver);
			
			var layer:DisplayObjectContainer = gm.parent;
			if(layer && layer.contains(gm) == true)
			{
				layer.removeChild(gm);
			}
		}
		
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			// 清除swf播放器的事件
			var target:DisplayObject;
			for(var i:int=0;i<topLayer.numChildren;i++)
			{
				target = topLayer.getChildAt(i);
				if(target is GameMovie)
				{
					GameMovie(target).stop();
					GameMovie(target).clear();
					target.removeEventListener(Event.COMPLETE , onPlayOver);
				}
			}
			for(i=0;i<downLayer.numChildren;i++)
			{
				target = downLayer.getChildAt(i);
				if(target is GameMovie)
				{
					GameMovie(target).stop();
					GameMovie(target).clear();
					target.removeEventListener(Event.COMPLETE , onPlayOver);
				}
			}
			
			Global.instance.removeChildren(topLayer);
			Global.instance.removeChildren(downLayer);
			
			// 清空swf技能层
			skillLayer.clear();
		}
		
	}
}