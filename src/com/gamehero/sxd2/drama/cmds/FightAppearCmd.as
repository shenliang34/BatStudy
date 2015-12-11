package com.gamehero.sxd2.drama.cmds
{
    import com.gamehero.sxd2.drama.base.BaseCmd;

	
	
	/**
	 *战斗出现动画命令 
	 */	
	public class FightAppearCmd extends BaseCmd
	{
		private var _roleType:int;
		private var _roleId:String;
		
		
		
		
		public function FightAppearCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_roleType = xml.@roleType;
			_roleId = xml.@roleId;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			
		}
	}
}