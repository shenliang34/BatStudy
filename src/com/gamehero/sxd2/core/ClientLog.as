package com.gamehero.sxd2.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import bowser.logging.Logger;
	import bowser.utils.effect.NumberUtil;
	
	/**
	 * 记录client日志,保存到服务器
	 * @author xuwenyi
	 * @create 2014-11-27
	 **/
	public class ClientLog
	{
		public static var user:String;
		public static var server:String;
		public static var url:String;
		public static var isDebug:Boolean;
		private static var action:String;
		
		// 聊天类型映射关系(360平台)
		private static const CHAT_TYPE_360:Array = [9,4,6,7,1,9,9];
		
		
		
		/**
		 * 记录pps平台客户端日志 
		 */
		public static function debug(action:String):void
		{	
			if(Agent.check1(Agent.A_pps) == true)
			{
				var ul:URLLoader;
				var requestVars:URLVariables;
				var req:URLRequest;
				ClientLog.action = action;
				
				ul = new URLLoader();
				ul.addEventListener(IOErrorEvent.IO_ERROR, ulErrorHandler, false, 0, true);
				ul.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ulErrorHandler, false, 0, true);
				
				requestVars = new URLVariables();
				requestVars.user = user;
				requestVars.sid = server;
				requestVars.action = action;
				
				req = new URLRequest(url);
				req.method = URLRequestMethod.GET;
				req.data = requestVars;
				ul.load(req);
			}
		}
		
		
		
		
		private static function ulErrorHandler(e:Event):void
		{	
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ulErrorHandler);
			e.currentTarget.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ulErrorHandler);
			
			if(isDebug == true)
			{
				Logger.error(ClientLog , "Client Log Error: action = " + action);
			}
		}
		
		
		
		
		
		
		
		
		
		
		/*
		private static function ulCompleteHandler(event:Event):void {
			
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
		}
		*/
		
		
		
		
		/**
		 * yyyy-MM-dd hh:mm:ss  
		 * 例如：时间格式2010-04-26 11:09:52
		 * 
		 */
		public static function getStringTimeSting5(date:Date=null):String
		{
			if(date==null)
			{
				date = new Date();
			}
			
			var year:String = date.fullYear+"";
			var month:String = NumberUtil.getCompletionNumber(date.month+1 , 2);
			var day:String = NumberUtil.getCompletionNumber(date.date , 2);
			var minute:String = NumberUtil.getCompletionNumber(date.minutes , 2);
			var second:String = NumberUtil.getCompletionNumber(date.seconds , 2);
			var hour:String = NumberUtil.getCompletionNumber(date.hours , 2);
			
			return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
		}
		
		
		/**
		 * 格式yyyyMMddhhmmss
		 * 例如：20140425115150
		 * 
		 */
		public static function getStringTimeSting6():String
		{
			var newDate:Date = new Date();
			
			var year:String = newDate.fullYear+"";
			var month:String = NumberUtil.getCompletionNumber(newDate.month+1 , 2);
			var day:String = NumberUtil.getCompletionNumber(newDate.date , 2);
			var minute:String = NumberUtil.getCompletionNumber(newDate.minutes , 2);
			var second:String = NumberUtil.getCompletionNumber(newDate.seconds , 2);
			var hour:String = NumberUtil.getCompletionNumber(newDate.hours , 2);
			
			return year + month + day + hour + minute + second;
		}
		
	}
}