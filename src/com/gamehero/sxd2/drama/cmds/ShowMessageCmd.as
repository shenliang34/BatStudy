package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.ScreenNotice;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.local.Lang;
	
	
	/**
	 * 场景内飘字 
	 * @author xuwenyi
	 * @date 2015-09-16
	 */
	public class ShowMessageCmd extends BaseCmd
	{
		private var _offY:Number;
		private var _message:String;
		private var _closeType:String;
		private var _isMode:Boolean=false;
		
		
		
		
		public function ShowMessageCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_offY = xml.@offY;
			_message = Lang.instance.trans(xml.@message);
			_closeType = xml.@closeType!=undefined?xml.@closeType:ScreenNotice.CLOSETYPE_CLICK;
			_isMode = (xml.@isMode != undefined) ? String(xml.@isMode)=="true":false;
		}
		
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			ScreenNotice.instance.showMessage(_message,_offY,_closeType,complete,_isMode);
		}
	}
}