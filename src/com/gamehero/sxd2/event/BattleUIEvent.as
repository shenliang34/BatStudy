package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 战斗UI事件
	 * @author xuwenyi
	 * @create 2014-03-27
	 **/
	public class BattleUIEvent extends BaseEvent
	{
		public static const LOADED:String = "loaded";
		public static const OPENING_START:String = "openingStart";
		public static const OPENING_END:String = "openingEnd";
		
		
		/**
		 * 构造函数
		 * */
		public function BattleUIEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		
		override public function clone():Event
		{
			return new BattleUIEvent(type , data);
		}
	}
}