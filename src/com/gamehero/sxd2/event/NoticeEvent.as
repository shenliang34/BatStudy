package com.gamehero.sxd2.event
{
	import flash.events.Event;

	/**
	 * 公告提示
	 * @author zhangxueyou
	 * @create 2015-10-15
	 **/
	
	public class NoticeEvent extends BaseEvent
	{
		/**
		 *构造 
		 * @param type
		 * @param data
		 * 
		 */		
		public static const UPDATA_NOTICEAREA3:String = "updataNoticeArea3";
		
		public function NoticeEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		/**
		 *复写Event 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			return super.clone();
		}
		
	}
}