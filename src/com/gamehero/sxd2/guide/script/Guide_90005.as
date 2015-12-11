package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.window.IncubusWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.events.Event;
	
	
	/**
	 * 梦魇副本再次挑战金霹雳引导
	 * @author xuwenyi
	 * @create 2014-07-25
	 **/
	public class Guide_90005 extends Guide
	{
		private var window:IncubusWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_90005()
		{
			super();
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 梦魇副本窗口
			window = WindowManager.inst.getWindowInstance(IncubusWindow, WindowPostion.CENTER) as IncubusWindow;
			if(window.loaded)
			{
				this.next1();
			}
			else
			{
				window.addEventListener(Event.COMPLETE , next1);
			}
		}
		
		
		
		
		
		
		private function next1(e:Event = null):void
		{
			window.removeEventListener(Event.COMPLETE , next1);
			
			this.popupClickGuide(window.challengeBtn, false, Lang.instance.trans("AS_1437"), Guide.Direct_Right, finish);
		}
		
		
		
		
		
		
		protected function finish():void
		{
			this.guideCompleteHandler();
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent = null):void
		{
			if(window)
			{
				window.removeEventListener(Event.COMPLETE , next1);
				window = null;
			}
			
			super.guideCompleteHandler();
		}
	}
}