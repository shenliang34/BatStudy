package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 战斗tips事件
	 * @author xuwenyi
	 * @create 2013-12-10
	 **/
	public class BattleTipsEvent extends BaseEvent
	{
		public static const OPEN:String = "open";
		public static const UPDATE:String = "update";
		public static const CLOSE:String = "close";
		
		
		
		public function BattleTipsEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		
		override public function clone():Event
		{
			return new BattleTipsEvent(type , data);
		}
	}
}