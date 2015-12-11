package com.gamehero.sxd2.drama.cmds
{
    import com.gamehero.sxd2.drama.base.BaseCmd;
    import com.gamehero.sxd2.local.Lang;
	
	
	public class FightDialogCmd extends BaseCmd
	{
		private var _message:String;
		private var _roleType:int;
		private var _roleId:String;
		private var _offY:Number;
		private var _endType:String;
		
		
		
		
		public function FightDialogCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_message = Lang.instance.trans(xml.@message);
			_roleType = xml.@roleType;
			_roleId = xml.@roleId;
			_offY = xml.@offY;
			_endType = (xml.@endType!=undefined)?xml.@endType:"auto";
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			
		}
	}
}