package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.window.IncubusWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.events.Event;
	
	
	/**
	 * 梦魇副本引导1
	 * @author xuwenyi
	 * @create 2014-05-17
	 **/
	public class Guide_90001 extends Guide
	{
		private var window:IncubusWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_90001()
		{
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			
			// 显示顶部按钮栏
			MainUI.inst.setTopFuncButtonVisible();
			
			
			// 引导打开梦魇面板
			var funcInfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.INCUBUS_WINDOW);
			this.popupClickGuide(funcInfo.button, false , Lang.instance.trans("AS_1423") , Guide.Direct_Right, next);
		}
		
		
		
		
		
		private function next():void
		{
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
			
			this.popupClickGuide(window.challengeBtn, false, Lang.instance.trans("AS_1434"), Guide.Direct_Right, finish);
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