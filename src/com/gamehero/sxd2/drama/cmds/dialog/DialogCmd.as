package com.gamehero.sxd2.drama.cmds.dialog
{
	import com.gamehero.sxd2.drama.DramaDialogWindow;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.local.Lang;
	
	
	/**
	 * 对话剧情 
	 * @author xuwenyi
	 * @date 2015-09-17
	 */
	public class DialogCmd extends BaseCmd
	{
		private var head:String;
		private var name:String;
		private var message:String;
		private var direction:int;
		
		
		
		public function DialogCmd() 
		{	
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			head = xml.@head;
			name = Lang.instance.trans(xml.@name);
			message = Lang.instance.trans(xml.@message);
			direction = xml.@direction == "1" ? 1 : -1;
		}
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var window:DramaDialogWindow = WindowManager.inst.openWindow(DramaDialogWindow,WindowPostion.CENTER,false,false,false) as DramaDialogWindow;
			window.showMessage(head , name , message , direction , complete);
		}
		
		  
		override public function clear():void  
		{
			super.clear();
			
		}
		
	}
}