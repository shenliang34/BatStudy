package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.event.MercenaryEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.window.MercenaryTaskWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	import com.gamehero.sxd2.pro.GS_Quality_Pro;
	import com.gamehero.sxd2.pro.GS_TaskStatus_Pro;
	import com.gamehero.sxd2.util.WasynManager;
	import com.gamehero.sxd2.world.core.GameWorldType;
	
	import flash.display.DisplayObject;
	
	import bowser.logging.Logger;

	
	
	
	/**
	 * 佣兵任务 
	 * @author wulongbin
	 */	
	public class Guide_70001 extends Guide
	{
		private var window:MercenaryTaskWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_70001()
		{
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			WasynManager.instance.addFuncByFrame(checkInScene, 3);
		}
		
		
		
		
		/**
		 *检查是否在普通场景内 
		 */	
		private function checkInScene():void
		{
			if(SXD2Main.inst.currentState == GameWorldType.SCENE_MAP)
			{
				WasynManager.instance.removeFuncByFrame(checkInScene);
				
				// 显示顶部按钮栏
				MainUI.inst.setTopFuncButtonVisible();
				
				var info:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.MERCENARY_TASK_WINDOW);
				this.popupClickGuide(info.button, false, Lang.instance.trans("AS_1427") , Guide.Direct_Up , next1);
			}
		}
		
		
		
		
		/**
		 * 加载佣兵任务窗口
		 * */
		private function next1():void
		{
			// 佣兵任务窗口
			window = WindowManager.inst.getWindowInstance(MercenaryTaskWindow, WindowPostion.CENTER) as MercenaryTaskWindow;
			window.addEventListener(MercenaryEvent.MERCENARY_TASKLIST_LOADED , next2);
		}
		
		
		
		
		
		/**
		 * 指向橙色任务
		 * */
		private function next2(e:MercenaryEvent = null):void
		{
			window.removeEventListener(MercenaryEvent.MERCENARY_TASKLIST_LOADED , next2);
			
			var button:DisplayObject = window.getTaskButton(GS_Quality_Pro.Orange , GS_TaskStatus_Pro.UNTAKE);
			if(button)
			{
				this.popupClickGuide(button , false, Lang.instance.trans("AS_1428") , Guide.Direct_Up , finish);
			}
			else
			{
				Logger.debug(Guide_70001 , "找不到橙色任务");
				
				this.finish();
			}
		}
		
		
		
		
		
		protected function finish():void
		{
			// 关闭窗口
			WindowManager.inst.closeWindow(window);
			
			this.guideCompleteHandler();
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent = null):void
		{
			if(window)
			{
				window.removeEventListener(MercenaryEvent.MERCENARY_TASKLIST_LOADED , next2);
				window = null;
			}
			
			super.guideCompleteHandler();
		}
	}
}