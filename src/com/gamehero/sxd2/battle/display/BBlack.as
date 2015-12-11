package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.event.BattleWorldEvent;
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	
	import bowser.render.display.RenderItem;
	
	
	/**
	 * 全屏变黑效果
	 * @author xuwenyi
	 * @create 
	 **/
	public class BBlack extends RenderItem
	{
		// 缓动
		private var tween1:TweenMax;
		private var tween2:TweenMax;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BBlack(w:int , h:int)
		{
//			this.eventDisp = new EventDispatcher();
			
			var bmd:BitmapData = new BitmapData(w,h,false,0);
			this.renderSource = bmd;
		}
		
		
		
		
		/**
		 * 开始播放
		 * */
		public function play(duration1:Number , duration2:Number , duration3:Number):void
		{
			this.alpha = 0;
			
			var target:BBlack = this;
			tween1 = TweenMax.to(target , duration1 , {alpha:0.65 , onComplete:phase1});
			
			function phase1():void
			{
				tween2 = TweenMax.to(target , duration3 , {alpha:0 , delay:duration2 , onComplete:end});
			}
		}
		
		
		
		/**
		 * 播放结束
		 * */
		private function end():void
		{
			this.clear();
			
			this.dispatchEvent(new BattleWorldEvent(BattleWorldEvent.SCREEN_BLACK_COMPLETE , this));
		}
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			if(tween1)
			{
				tween1.kill();
				tween1 = null;
			}
			if(tween2)
			{
				tween2.kill();
				tween2 = null;
			}
		}
		
	}
}