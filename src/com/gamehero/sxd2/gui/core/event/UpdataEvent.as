package com.gamehero.sxd2.gui.core.event
{
	import flash.events.Event;
	
	/**
	 * 窗口打开后会向服务器请求刷新界面
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午5:37:52
	 * 
	 */
	public class UpdataEvent extends Event
	{
		/**
		 * 窗口打开,主动请求刷新数据
		 */		
		public static var WINDOW_ON_SHOW:String = "window_on_show";
		
		public function UpdataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}