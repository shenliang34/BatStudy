package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	
	/**
	 * 进入竞技场引导
	 * @author xuwenyi
	 * @create 2014-06-05
	 **/
	public class Guide_11001 extends Guide
	{	
		
		/**
		 * 构造函数
		 * */
		public function Guide_11001()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 显示顶部按钮栏
			MainUI.inst.setTopFuncButtonVisible();
			
			var funcinfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.ARENA_WINDOW);
			this.popupClickGuide(funcinfo.button , false , Lang.instance.trans("AS_1401"), Guide.Direct_Up , finish);
		}
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{	
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			super.guideCompleteHandler(e);
		}
	}
}