package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	
	/**
	 * 自定义事件基类
	 * @author xuwenyi
	 * @create 2013-08-01
	 **/
	public class BaseEvent extends Event
	{
		public var data:Object;
		
		/**
		 * 构造函数
		 * */
		public function BaseEvent(type:String, data:Object = null)
		{	
			this.data = data;
			
			super(type, true);
		}
		
		
	}
}