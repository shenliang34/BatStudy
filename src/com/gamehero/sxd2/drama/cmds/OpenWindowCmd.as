package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.gui.main.MainUI;

	
	
	/**
	 *打开窗口 
	 */	
	public class OpenWindowCmd extends BaseCmd
	{
		protected var _windowName:String;
		
		
		
		public function OpenWindowCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_windowName = xml.@windowName;
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			// 打开窗口
			MainUI.inst.openWindow(_windowName);
			
			complete();
		}
	}
}