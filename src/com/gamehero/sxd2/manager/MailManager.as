package com.gamehero.sxd2.manager
{
	/**
	 * 邮箱工具类
	 * @author zhangxueyou
	 * @create 2015-10-9
	 **/
	public class MailManager
	{
		static private var _inst:MailManager;
		
		private var count:int;
		/**
		 *构造 
		 */		
		public function MailManager()
		{
		}
		
		/**
		 * 获取单例对象
		 * @return
		 */		
		public static function get instance():MailManager 
		{
			return _inst ||= new MailManager();
		}
		
		/** 
		 * 更新邮件数量
		 * */
		public function updataMailCount(num:int):void
		{
			count = num;
		}
		
		/**
		 *获取新邮件数量 
		 * @return 
		 * 
		 */		
		public function get mailCount():int
		{
			return count;
		}
	}
}