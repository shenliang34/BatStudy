package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 引导事件
	 * @author xuwenyi
	 * @create 2014-04-16
	 **/
	public class GuideEvent extends BaseEvent
	{
		public static const GUIDE_COMPLETE:String = "guideComplete";
		
		public static const GUIDE_QUICK_BUY:String = "guideQuickBuy";
		public static const ON_GUIDE_QUICK_BUY:String = "onGuideQuickBuy";
		
		public function GuideEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		override public function clone():Event
		{
			return new GuideEvent(type , data);
		}
	}
}