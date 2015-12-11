package com.gamehero.sxd2.world.event
{
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-16 上午10:51:14
	 * 
	 */
	public class SwfRenderEvent extends Event
	{
		/**
		 * mc加载完成 
		 */		
		public static var LOADED:String = "loaded";
		/**
		 * 播放结束 
		 */		
		public static var ISOVER:String = "isOver";
		
		/**
		 * 被添加到舞台上 
		 */		
		public static var ADDED:String = "added";
		public function SwfRenderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}