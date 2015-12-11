package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 竞技场事件
	 * @author xuwenyi
	 * @create 2015-09-29
	 **/
	public class ArenaEvent extends BaseEvent
	{
		public static const ARENA_INFO:String = "ARENA_INFO";
		public static const ARENA_START_FIGHT:String = "ARENA_START_FIGHT";
		public static const ARENA_BUY_TICKET:String = "ARENA_BUY_TICKET";
		public static const ARENA_RANKING_LIST:String = "ARENA_RANKING_LIST";
		
		
		public function ArenaEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		
		
		override public function clone():Event
		{
			return new ArenaEvent(type , data);
		}
	}
}