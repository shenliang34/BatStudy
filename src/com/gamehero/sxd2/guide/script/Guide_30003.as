package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	
	
	
	/**
	 *巫师战旗打开引导 
	 * @author wulongbin
	 * 
	 */	
	public class Guide_30003 extends Guide
	{
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_30003()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 显示顶部按钮栏
			MainUI.inst.setTopFuncButtonVisible();
			
			var functionInfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.CHESS_WINDOW);
			this.popupClickGuide(functionInfo.button , false , Lang.instance.trans("AS_1415") , Guide.Direct_Up);
		}
	}
}