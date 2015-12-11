package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author xuwenyi
	 * @create 
	 **/
	public class MenuEvent extends BaseEvent
	{
		public static const OPEN_OPTION:String = "openOption";// 打开选项
		
		
		/**
		 * 弹出菜单事件
		 * */
		public function MenuEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new MenuEvent(type , data);
		}
	}
}