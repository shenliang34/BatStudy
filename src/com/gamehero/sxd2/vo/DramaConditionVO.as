package com.gamehero.sxd2.vo
{
	
	/**
	 * 剧情触发条件vo
	 * @author xuwenyi
	 * @create 2015-09-17
	 **/
	public class DramaConditionVO
	{
		public var dramaID:int;
		public var type:int;
		public var rate:int;
		public var condition:String;
		
		
		public function DramaConditionVO()
		{
		}
		
		
		public function fromXML(xml:XML):void
		{
			dramaID = xml.@dramaID;
			type = xml.@type;
			rate = xml.@rate == "" || xml.@rate == "0" ? 0 : xml.@rate;
			condition = xml.@condition;
		}
	}
}