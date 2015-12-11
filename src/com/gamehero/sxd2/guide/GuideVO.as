package com.gamehero.sxd2.guide
{
	import flash.system.ApplicationDomain;

	public class GuideVO
	{
		
		public var id:uint;
		public var conditionType:uint;
		public var conditionParam:String;
		public var param1:String;
		public var param2:String;
		public var param3:String;
		public var isCloseAllWindow:Boolean = false;
		
		public var isPlay:Boolean = false;
		public var guide:Class;
		
		
		
		public function GuideVO()
		{
		}
		
		
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			conditionType = xml.@conditionType;
			conditionParam = xml.@conditionParam;
			param1 = xml.@param1;
			param2 = xml.@param2;
			param3 = xml.@param3;
			isCloseAllWindow = String(xml.@isCloseAllWindow) == "1";
			
			try
			{
				guide = ApplicationDomain.currentDomain.getDefinition("com.pps.ifs.guide.script::Guide_"+id) as Class;
			}
			catch(e:Error)
			{
				
			}
		}
	}
}