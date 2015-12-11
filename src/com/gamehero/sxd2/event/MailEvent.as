package com.gamehero.sxd2.event
{
	import flash.events.Event;

	public class MailEvent extends BaseEvent
	{
		public static const MAIL_GET_LIST:String = "mailGetList";//获取邮件列表
		public static const MAIL_GET_DETAIL:String = "mailGetDetail";//获取邮件正文
		public static const MAIL_GET_ATTACH:String = "mailGetAttach";//获取邮件附件
		
		/**
		 *邮件自定义事件 
		 * @param type
		 * @param data
		 * 
		 */		
		public function MailEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		/**
		 *复写 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new MailEvent(type , data);
		}
	}
}