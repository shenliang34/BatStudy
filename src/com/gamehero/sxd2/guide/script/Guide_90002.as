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
	
	import alternativa.gui.base.ActiveObject;
	
	
	/**
	 * 梦魇副本引导2
	 * @author xuwenyi
	 * @create 2014-05-17
	 **/
	public class Guide_90002 extends Guide
	{
		private var window:IncubusWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_90002()
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
			
			var box:ActiveObject = window.currIncusCopyIcon.box;
			if(box && box.locked == false)
			{
				this.popupClickGuide(window.challengeBtn, true, Lang.instance.trans("AS_1435"), Guide.Direct_Left, finish);
			}
			else
			{
				this.finish();
			}
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