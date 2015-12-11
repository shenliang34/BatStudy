package com.gamehero.sxd2.services.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	import flash.events.Event;
	
	
	/**
	 * Game服务器事件
	 * @author xuwenyi
	 * @create 2013-07-15
	 **/
	public class GameServiceEvent extends BaseEvent
	{
		public static const CONNECT_ERROR:String = "CONNECT_ERROR";
		public static const ERRCODE:String = "ERRCODE";
		public static const PRODUCE_GUIDE:String = "PRODUCE_GUIDE";
		
		
		/**
		 * 构造函数
		 * */
		public function GameServiceEvent(type:String, data:Object = null)
		{
			super(type , data);
		}
		
		override public function clone():Event
		{
			return new GameServiceEvent(type , data);
		}
	}
}