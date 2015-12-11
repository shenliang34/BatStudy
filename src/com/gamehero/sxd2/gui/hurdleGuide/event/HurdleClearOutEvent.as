package com.gamehero.sxd2.gui.hurdleGuide.event
{
	import flash.events.Event;
	
	/**
	 * 扫荡副本
	 * @author weiyanyu
	 * 创建时间：2015-9-6 下午8:13:21
	 * 
	 */
	public class HurdleClearOutEvent extends Event
	{
		/**
		 * 扫荡 
		 */		
		public static var CLEAR_OUT:String = "CLEAR_OUT";
		
		public var id:int;
		public function HurdleClearOutEvent(type:String, data:int)
		{
			super(type, bubbles, cancelable);
			id = data;
		}
	}
}