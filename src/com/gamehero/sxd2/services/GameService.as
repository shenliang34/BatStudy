package com.gamehero.sxd2.services
{
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import bowser.remote.RemoteEvent;
	import bowser.remote.RemoteResponse;
	
	/**
	 * 游戏服务器
	 * @author xuwenyi
	 * @create 2013-07-03
	 **/
	public class GameService extends Service
	{	
		// 单例引用
		private static var _instance:GameService;
		// 是否需要通过事件机制处理响应接口
		protected var needEventHandle:Dictionary;
		public var isForceRefresh:Boolean = true;	// 服务器连不上是不是强迫用户刷新
		public static const MSG_KEEPALIVE_TIMER:int = 30000;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function GameService()
		{
			super();
			
			remoteClient.logDebug = true;
			
			// 通过事件机制处理响应接口(一般用作后端主动推送的接口)
			needEventHandle = new Dictionary();
			
			// 消息挂起时的白名单
			remoteClient.pendingWhiteList = [MSGID.MSGID_BATTLE_CREATE];
		}
		
		/**
		 * Get Instance 
		 */
		public static function get instance():GameService
		{
			if(_instance == null)
			{
				_instance = new GameService();
			}
			return _instance;
		}
		
		/**
		 * 复写服务器连接成功
		 * */
		override protected function onConnection(e:RemoteEvent):void
		{
			dispatchEvent(e.clone());
			//创建心跳定时器
			var keepaliveTimer:Timer = new Timer(MSG_KEEPALIVE_TIMER);
			keepaliveTimer.addEventListener(TimerEvent.TIMER,keepaliveTimerHandle);
			keepaliveTimer.start()
		}
		
		/**
		 * 发送心跳包
		 * */
		private function keepaliveTimerHandle(e:TimerEvent):void{
			if(this.remoteClient.connected){
				this.remoteClient.send(MSGID.MSGID_SOCKET_KEEPALIVE);
			}
		}
		
		/**
		 * 复写服务器连接失败
		 * */
		override protected function onConnectionError(e:RemoteEvent):void
		{
			if(isForceRefresh == true)
			{
				this.dispatchEvent(new GameServiceEvent(GameServiceEvent.CONNECT_ERROR));
			}
		}
		
		/**
		 * 复写服务器断开
		 * 
		 */
		override protected function onConnectionLost(e:RemoteEvent):void
		{
			if(isForceRefresh == true)
			{
				this.dispatchEvent(new GameServiceEvent(GameServiceEvent.CONNECT_ERROR));
			}
		}
		
		
		
		/**
		 * 复写响应函数
		 * */
		override protected function onExtensionResponse(e:RemoteEvent):void
		{
			var response:RemoteResponse = e.response;
			var functionName:String = response.functionName;
			var errcode:String = response.errcode;
			var protoBytes:ByteArray = response.protoBytes;
			
			this.dispatchEvent(new GameServiceEvent(functionName , response));
			
			// 判断errocode，非0是显示警告窗口
			if(errcode != "0")
			{
				// 存在物品缺失,提示产出引导
				if(protoBytes != null)
				{
					// 通知打开产出引导窗口
					var data:Object = new Object();
					data.protoBytes = protoBytes;
					data.errcode = errcode;
					//this.dispatchEvent(new GameServiceEvent(GameServiceEvent , data));
				}
				// 警示窗口
				else
				{
					this.dispatchEvent(new GameServiceEvent(GameServiceEvent.ERRCODE , errcode));
				}
			}
			
			/*
			
			
			// 是否需要响应事件,或errcode
			var proto:Message;
			if(needEventHandle[functionName] || errcode != "0")
			{
				if(protoName != "")
				{
					// 反射实例化具体的proto类
					var cls:Class = getDefinitionByName(protoName) as Class;
					proto = new cls() as Message;
					proto.mergeFrom(response.protoBytes);
					response.proto = proto;
				}
			}
			
			// 判断errocode，非0是显示警告窗口
			if(errcode != "0")
			{
				// 存在物品缺失,提示产出引导
				if(proto != null)
				{
					// 通知打开产出引导窗口
					var data:Object = new Object();
					data.proto = proto;
					data.errcode = errcode;
					this.dispatchEvent(new MainEvent(MainEvent.SHOW_PRODUCE_WINDOW, data));
				}
				// 警示窗口
				else
				{
					this.dispatchEvent(new MainEvent(MainEvent.SHOW_ERR_CODE, errcode));
				}
			}
			
			//派发服务器响应事件,一般给后端主动推送使用
			if(needEventHandle[e.response.functionName])
			{
				this.dispatchEvent(new GameServiceEvent(e.response.functionName, e.response));
			}
			*/
		}
		
		
		/**
		 * 设置是否输出DEBUG信息 
		 */
		public function set isDebug(value:Boolean):void 
		{
			this.remoteClient.debug = value;
		}

		
		public function get pending():Boolean
		{
			return this.remoteClient.pending;
		}

		public function set pending(value:Boolean):void
		{
			this.remoteClient.pending = value;
		}

	}
}