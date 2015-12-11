package com.gamehero.sxd2.services
{
	import com.gamehero.sxd2.core.ClientLog;
	import com.gamehero.sxd2.manager.JSManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.netease.protobuf.Message;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import bowser.remote.RemoteClient;
	import bowser.remote.RemoteEvent;
	import bowser.remote.RemoteResponse;
	
	
	/**
	 * 服务器连接基类
	 * @author xuwenyi
	 * @create 2013-07-03
	 **/
	// Modify by Trey, 增加debug开关功能setDebug()
	public class Service extends EventDispatcher
	{
		// socket
		protected var remoteClient:RemoteClient;
		
		protected var ip:String;
		protected var port:int;
		
		
		/**
		 * 构造函数
		 * */
		public function Service()
		{ 
			remoteClient = new RemoteClient(new GameCHandler());
			
			// 是否debug模式
			var isdebug:Boolean = false;
			CONFIG::DEBUG 
			{
				if(JSManager.isDebug()) 
				{
					isdebug = true;
				}
			}
			remoteClient.debug = isdebug;
			
			remoteClient.addEventListener(RemoteEvent.onConnection , onConnection);
			remoteClient.addEventListener(RemoteEvent.onConnectionError , onConnectionError);
			remoteClient.addEventListener(RemoteEvent.onConnectionLost , onConnectionLost);
			remoteClient.addEventListener(RemoteEvent.onDebugMessage , onDebugMessage);
			remoteClient.addEventListener(RemoteEvent.onExtensionResponse , onExtensionResponse);
			remoteClient.addEventListener(RemoteEvent.ON_SOCKET_BYTES_ERROR , onSocketBytesError);
			remoteClient.addEventListener(RemoteEvent.ON_SOCKET_RPC,rpcOkHandle);
		}
		
		/**
		 * 连接server
		 * @param ip
		 * @param port
		 * @param isAutoClose
		 * 
		 */
		public function connect(ip:String , port:uint, isAutoClose:Boolean = false):void
		{
			// 连接
			remoteClient.connect(ip , port, isAutoClose);
		}
		
		
		/**
		 *断线 
		 * 
		 */		
		public function disconnect():void
		{
			remoteClient.disconnect();
		}
		
		
		
		/**
		 * 发送请求
		 * */
		public function send(functionName:int , message:Message = null , callback:Function = null):void
		{
			if(connected == true)
			{
				// 发送数据
				remoteClient.send(functionName , message , callback);
				
				// 打印日志
				if(remoteClient.debug == true)
				{
					// 转换接口id -> 接口name
//					var funcName:String = functionName+"";//InterfaceManager.instance.getFunName(functionName);
					var funcName:String = functionName.toString(16) + "";	//InterfaceManager.instance.getFunName(functionName);
					funcName = funcName + "@" + remoteClient.sequence;
					
					var data:RemoteResponse = new RemoteResponse();
					data.functionName = funcName;
					remoteClient.debugProtoMessage(data , message);
				}
			}
		}
		
		/**
		 * 服务器连接成功
		 * */
		protected function onConnection(e:RemoteEvent):void
		{
			trace("Service--------------------");
		}
		
		/**
		 * 连接后准备，接收验证成功，发送100
		 * */
		private function rpcOkHandle(e:RemoteEvent):void{
			remoteClient.send(MSGID.MSGID_SOCKET_VALIDATE);
		}
		
		/**
		 * 服务器连接失败
		 * */
		protected function onConnectionError(e:RemoteEvent):void
		{
			
		}
		
		/**
		 * 服务器断开
		 * */
		protected function onConnectionLost(e:RemoteEvent):void
		{
			
		}
		
		/**
		 * debug事件
		 * */
		protected function onDebugMessage(e:RemoteEvent):void
		{
			
		}
		
		/**
		 * 请求响应
		 * */
		protected function onExtensionResponse(e:RemoteEvent):void
		{
		}
		
		/**
		 * socket字节解析出错
		 * */
		protected function onSocketBytesError(e:RemoteEvent):void
		{
			var responce:RemoteResponse = e.response;
			var error:Error = e.error;
			ClientLog.debug("SOCKET ERR!func:" + responce.functionName + ",len:" + responce.messageBodyLength + ";errid:" + error.errorID);
		}
		
		/**
		 * 将2进制文件转成proto数据
		 * */
		public function mergeFrom(proto:Message , data:ByteArray):void
		{
			proto.mergeFrom(data);
		}
		
		
		
		/**
		 * 打印debug信息
		 * */
		public function debug(response:RemoteResponse , message:Message = null):void
		{
			if(remoteClient.debug == true)
			{
				var data:RemoteResponse = new RemoteResponse();
				// 转换接口id -> 接口名
				if(response.functionName != null)
				{
//					data.functionName = response.functionName;
					data.functionName = int(response.functionName).toString(16);
					data.sequence = response.sequence;
					data.errcode = response.errcode;
				}
				
				remoteClient.debugProtoMessage(data , message);
			}
		}
		
		
		
		// 是否已连接成功
		public function get connected():Boolean
		{
			return remoteClient.connected;
		}

		
		/**
		 * debug开关 
		 * @param value
		 * 
		 */
		public function setDebug(value:Boolean):void {
			
			remoteClient.debug = value;
		}
		
		/**
		 *保存计算延迟文件 
		 * 
		 */		
		public function saveDebugHandle():void
		{
			remoteClient.saveDebugHandle();
		}
	}
}