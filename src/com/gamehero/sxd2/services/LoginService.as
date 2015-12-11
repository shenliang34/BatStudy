package com.gamehero.sxd2.services
{
	import com.gamehero.sxd2.core.ClientLog;
	
	import flash.events.Event;
	
	import alternativa.gui.container.list.IItemRenderer;
	import alternativa.gui.event.ListEvent;
	
	import bowser.remote.RemoteEvent;
	import bowser.remote.RemoteResponse;
	
	
	
	/**
	 * 登录服务器
	 * @author xuwenyi
	 * @create 2013-07-03  
	 **/
	public class LoginService extends Service
	{	
		private static var _instance:LoginService;
		
		
		/**
		 * 构造函数
		 * */
		public function LoginService()
		{
			super();
		}
		
		
		/**
		 * Get Instance 
		 */
		public static function get instance():LoginService
		{
			if(_instance == null)
			{
				_instance = new LoginService();
			}
			return _instance;
		}
		
		
		/**
		 * 复写服务器连接成功
		 * */
		override protected function onConnection(e:RemoteEvent):void
		{
			dispatchEvent(e.clone());
		}
		
		/**
		 * 复写请求响应
		 * */
		override protected function onExtensionResponse(e:RemoteEvent):void
		{
			dispatchEvent(new Event(e.response.functionName, e.response.protoBytes));
		}
		
		/**
		 * 服务器连接失败
		 * */
		override protected function onConnectionError(e:RemoteEvent):void
		{
			var response:RemoteResponse = e.response;
			ClientLog.debug("CONNECT_ERROR_" + response.errcode);
		}
	}
}