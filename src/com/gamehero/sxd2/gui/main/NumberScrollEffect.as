package com.gamehero.sxd2.gui.main
{
	
	import com.gamehero.sxd2.common.BitmapNumber;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 数字滚动动画
	 * @author xuwenyi
	 * @create 
	 **/
	public class NumberScrollEffect extends Sprite
	{
		private var scrollMC:MovieClip;
		private var bn:BitmapNumber;
		
		private var oldValue:String;
		private var newValue:String;
		
		
		
		
		public function NumberScrollEffect(scrollMC:MovieClip)
		{	
			this.scrollMC = scrollMC;
			addChild(this.scrollMC);
			
			bn = new BitmapNumber();
			addChild(this.bn);
		}
		
		
		
		
		public function update(oldValue:String, newValue:String):void
		{	
			if(contains(scrollMC)) {
				
				removeChild(scrollMC);
			}
			
			this.oldValue = oldValue;
			this.newValue = newValue;
			
			bn.update(BitmapNumber.WINDOW_S_YELLOW, oldValue);
		}
		
		
		
		
		
		/**
		 * 开始动画 
		 * 
		 */
		public function start():void {
			
			if(contains(bn)) {
				
				removeChild(bn);
			}
			bn.update(BitmapNumber.WINDOW_S_YELLOW, newValue);
			
			scrollMC.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			scrollMC.gotoAndPlay(1);
			addChild(scrollMC);
		}
		
		
		
		
		private function onEnterFrame(event:Event):void {
			
			if(scrollMC.currentFrame >= scrollMC.totalFrames) {
				
				scrollMC.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(scrollMC);
				
				addChild(bn);
				
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
	}
}