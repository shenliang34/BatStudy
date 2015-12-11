package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 产出引导事件
	 * @author xuwenyi
	 * @create 2014-05-13
	 **/
	public class ProduceGuideEvent extends BaseEvent
	{
		// 立即前往某窗口
		public static const GOTO_WINDOW:String = "gotoWindow";
		
		
		public function ProduceGuideEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		override public function clone():Event
		{
			return new ProduceGuideEvent(type , data);
		}
	}
}