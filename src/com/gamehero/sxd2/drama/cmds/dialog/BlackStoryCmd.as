package com.gamehero.sxd2.drama.cmds.dialog
{
	import com.gamehero.sxd2.drama.DramaBlackStoryWindow;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.local.Lang;
	
	
	/**
	 * 显示黑屏文字
	 * @author xuwenyi
	 * @create 2015-09-16
	 **/
	public class BlackStoryCmd extends BaseCmd
	{
		private var message:String;
		
		
		
		public function BlackStoryCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			message = Lang.instance.trans(xml.@message);
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var window:DramaBlackStoryWindow = WindowManager.inst.openWindow(DramaBlackStoryWindow, WindowPostion.CENTER , false , false , false) as DramaBlackStoryWindow;
			window.showMessage(message , complete);
		}
		
	}
}