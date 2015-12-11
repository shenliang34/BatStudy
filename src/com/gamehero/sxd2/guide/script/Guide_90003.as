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
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	/**
	 * 第三次梦魇副本引导
	 * @author xuwenyi
	 * @create 2014-05-22
	 **/
	public class Guide_90003 extends Guide
	{
		private var window:IncubusWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_90003()
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
			this.popupClickGuide(funcInfo.button, false , Lang.instance.trans("AS_1423") , Guide.Direct_Up, next);
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
			
			var icon:DisplayObject = window.getIncubusCopy(1);
			this.popupClickGuide(icon, false, Lang.instance.trans("AS_1436"), Guide.Direct_Down, next2);
		}
		
		
		
		
		
		private function next2():void
		{
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