package com.gamehero.sxd2.manager{
	
	import flash.external.ExternalInterface;
	
	import bowser.logging.Logger;
	
	/**
	 * 调用JS Mananger
	 * 
	 * @author Trey
	 */
	public class JSManager {

		/**
		 * 获得Login服务器地址
		 * @return 数组包含：addr/p
		 * 
		public static function getLoginURL():Array {
			
			return ExternalInterface.call('getLoginURL');
		}
		 */
		
		/**
		 * 刷新游戏页面 
		 * 
		 */
		public static function refreshGame():void {
			
			try{
				
				ExternalInterface.call('refreshGame');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
			}
		}
		
		
		/**
		 * 获得Client Session Id
		 * 
		public static function getClientId():String {
			
			return ExternalInterface.call('getClientId');
		}
		 */
		
		
		/**
		 * 获得Debug Switch
		 * 
		 */
		public static function isDebug():Boolean {
			
			try{
				
				return  ExternalInterface.call('isDebug');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return false;
			}
		}
		
		/**
		 * 获得GC Debug Switch
		 * 
		 */
		public static function isGCDebug():Boolean {
			
			try{
				
				return  ExternalInterface.call('isGCDebug');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return false;
			}
		}
		
		
		
		/**
		 * 获得XML Debug Switch
		 * 
		 */
		public static function isXMLDebug():Boolean {
			
			try{
				
				return ExternalInterface.call('isXMLDebug');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return false;
			}
		}
		
		
		
		
		
		/**
		 * 设置js的cookie
		 * */
		public static function setCookie(name:String , value:Object):void
		{
			try{
				
				ExternalInterface.call('setCookie' , name , value);
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
			}
		}
		
		
		
		
		
		/**
		 * 获取js的cookie
		 * */
		public static function getCookie(name:String):Object
		{
			try{
				
				return ExternalInterface.call('getCookie' , name);
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return null;
			}
		}
		
		
		
		
		
		/**
		 * 获取当前浏览器url
		 * */
		public static function getBrowserURL():String
		{
			try{
				
				return ExternalInterface.call('getBrowserURL');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return "";
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 获得Log Level
		 * 
		public static function getLogLevel():String {
			
			var logLevel:String = ExternalInterface.call('getLogLevel');
			return logLevel ? logLevel.toString() : "";
		}
		 */
		
		
		/**
		 * 获得PBE Console Show Switch(PBE)
		 * 
		public static function isShowConsole():Boolean {
			
			return ExternalInterface.call('isShowConsole');
		}
		 */
		
		
		/**
		 * 获得CDN
		 * 
		public static function getCDNSite():String {
			
			var url:String = ExternalInterface.call("getCDNSite");
			return url ? url.toString() : "";
		}
		 */
		
		
		/**
		 * 获得SFS Debug Switch
		 * 
		public static function tutorial():Boolean {
			
			return ExternalInterface.call('tutorial');
		}
		 */
		
	}
}