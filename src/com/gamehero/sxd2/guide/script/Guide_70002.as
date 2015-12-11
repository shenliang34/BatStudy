package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.gui.window.MercenaryTaskWindow;
	import com.gamehero.sxd2.pro.GS_Quality_Pro;
	import com.gamehero.sxd2.pro.GS_TaskStatus_Pro;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.DisplayObject;
	
	import bowser.logging.Logger;
	
	
	/**
	 * 引导完成佣兵任务
	 * @author xuwenyi
	 * @create 2014-04-17
	 **/
	public class Guide_70002 extends Guide
	{
		private var window:MercenaryTaskWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_70002()
		{
			super();
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 获取佣兵任务面板
			window = WindowManager.inst.getWindowInstance(MercenaryTaskWindow, WindowPostion.CENTER) as MercenaryTaskWindow;
			var button:DisplayObject = window.getTaskButton(GS_Quality_Pro.Orange , GS_TaskStatus_Pro.FINISH);
			if(button)
			{
				this.popupClickGuide(button , true , Lang.instance.trans("AS_1429") , Guide.Direct_Up , finish);
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
			window = null;
			
			super.guideCompleteHandler();
		}
	}
}