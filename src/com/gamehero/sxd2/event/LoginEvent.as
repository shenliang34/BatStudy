package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	
	/**
	 * 登录模块事件
	 * @author xuwenyi
	 * @create 2013-07-05
	 **/
	public class LoginEvent extends Event
	{
		public var data:Object;
		
		public static const LOGIN_FAIL:String = "loginFail";
		public static const CREATE_USER:String = "createUser";
		public static const CREATE_USER_FAIL:String = "createUserFail";
		public static const SHOW_CREATE_USER:String = "showCreateUser";
		public static const ENTER_SXD2_MAIN:String = "enterSXD2Main";
		public static const EXIST_CHAR:String = "existChar";
		
		
		public function LoginEvent(type:String , data:Object = null)
		{
			this.data = data;
			
			super(type);
		}
		
		override public function clone():Event
		{
			return new LoginEvent(type , data);
		}
	}
}