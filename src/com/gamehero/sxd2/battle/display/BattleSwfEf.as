package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.common.GameMovie;
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * swf技能特效元件
	 * @author xuwenyi
	 * @create 2015-06-04
	 **/
	public class BattleSwfEf extends Sprite
	{
		public var effectItem:GameMovie;
		public var animCompHandler:Function;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSwfEf(url:String)
		{
			effectItem = new GameMovie();
			effectItem.load(url , "EFFECT" , BattleDataCenter.instance.loader);
			effectItem.addEventListener(Event.COMPLETE , onPlayComplete);
			this.addChild(effectItem);
		}
		
		
		
		
		
		/**
		 * 开始播放动画
		 * */
		public function play(loop:Boolean):void
		{
			effectItem.play(0 , loop , BattleDataCenter.instance.playSpeed);
		}
		
		
		
		
		/**
		 * 效果播放完毕
		 * */
		private function onPlayComplete(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE , onPlayComplete);
			
			this.clear();
			
			// 回调
			if(this.animCompHandler)
			{
				var tempFunc:Function = this.animCompHandler;
				this.animCompHandler = null;
				tempFunc(this);
			}
		}
		
		
		
		
		
		/**
		 * 移动
		 * */
		public function move(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer , needRotate:Boolean = false):void
		{
			// 飞行持续时间
			var duration:Number = skillEf.bulletDuration != 0 ? skillEf.bulletDuration : 200;
			duration *= BattleDataCenter.instance.playSpeed;//播放速度系数
			
			var from:Vector2D = new Vector2D(aPlayer.x , aPlayer.y);
			var to:Vector2D;
			if(skillEf.bulletOffset != null)// 若配置了子弹目标点,则直接通过阵型位置计算坐标
			{
				to = uPlayer.position.add(skillEf.bulletOffset);
			}
			else
			{
				to = new Vector2D(uPlayer.x , uPlayer.y);
			}
			
			// 计算角度
			if(needRotate == true)
			{
				var angle:Number = to.subtract(from).angle;
				effectItem.rotation = angle * 180 / Math.PI;
			}
			
			// 起始位置
			var fromX:int = from.x;
			var fromY:int = from.y;
			// 目标位置
			var toX:int = to.x;
			var toY:int = to.y;
			
			// 偏移量
			var fromW:int = aPlayer.playerWidth>>1;
			var fromH:int = -(aPlayer.playerHeight>>1);
			var toW:int = -(uPlayer.playerWidth>>1);
			var toH:int = -(uPlayer.playerHeight>>1);
			
			// 根据站位确定偏移向量
			if(aPlayer.camp == 2)
			{
				fromW *= -1;
				toW *= -1;
			}
			
			// 左右偏移
			fromX += fromW;
			toX += toW;
			
			switch(skillEf.bulletPos)
			{
				// 头顶-头顶
				case "1":
					fromY += fromH*2;
					toY += toH*2;
					break;
				// 头顶-中间
				case "2":
					fromY += fromH*2;
					toY += toH;
					break;
				// 头顶-脚底
				case "3":
					fromY += fromH*2;
					toY += 0;
					break;
				// 中间-头顶
				case "4":
					fromY += fromH;
					toY += toH*2;
					break;
				// 中间-中间
				case "5":
					fromY += fromH;
					toY += toH;
					break;
				// 中间-脚底
				case "6":
					fromY += fromH;
					toY += 0;
					break;
				// 脚底-头顶
				case "7":
					fromY += 0;
					toY += toH*2;
					break;
				// 脚底-中间
				case "8":
					fromY += 0;
					toY += toH;
					break;
				// 脚底-脚底
				default:
					fromY += 0;
					toY += 0;
					break;
			}
			
			this.x = fromX;
			this.y = fromY;
			
			// 开始播放
			TweenMax.to(this , duration*0.001 , {x:toX,y:toY,onComplete:onMoveComplete});
		}
		
		
		
		
		
		
		/**
		 * 效果播放完毕
		 * */
		private function onMoveComplete():void
		{
			this.clear();
			
			// 回调
			if(this.animCompHandler)
			{
				var tempFunc:Function = this.animCompHandler;
				this.animCompHandler = null;
				tempFunc(this);
			}
		}
		
		
		
		
		/**
		 * 回收
		 * */
		public function clear():void
		{
			if(effectItem)
			{
				effectItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , onPlayComplete);
				effectItem.clear();
				effectItem = null;
			}
			
			this.removeChildren();
		}
	}
}