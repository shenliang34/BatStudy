package com.gamehero.sxd2.login
{
	import com.gamehero.sxd2.core.URI;
	import com.gamehero.sxd2.event.LoginEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_ACK;
	import com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_REQ;
	import com.gamehero.sxd2.pro.MSG_CREATE_USER_REQ;
	import com.gamehero.sxd2.pro.MSG_LOGIN_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import flash.events.EventDispatcher;
	
	import bowser.remote.RemoteEvent;
	import bowser.remote.RemoteResponse;
	
	
	
	/**
	 * 登录代理
	 * @author xuwenyi
	 * @create 2013-07-04
	 **/
	public class LoginProxy extends EventDispatcher
	{
		
		private var loginKey:String;	// 登录游戏服凭证
		
		
		/**
		 * 构造函数
		 * 
		 */
		public function LoginProxy()
		{
			// 先加载策略文件
			//var crossdomainURL:String = "http://" + URI.ip + "/crossdomain.xml";
			//Security.loadPolicyFile(crossdomainURL);
			
			// 连接服务器
			// 中心服务器连接返回
			GameService.instance.addEventListener(RemoteEvent.onConnection, onSocketConnection1);
			GameService.instance.connect(URI.params.ip, URI.params.port);

			GameService.instance.addEventListener(MSGID.MSGID_EXIST_CHAR.toString(), onExistCharList);
		}
		
		
		/**
		 * destroy 
		 * 
		 */
		public function destory():void {
			
			GameService.instance.removeEventListener(RemoteEvent.onConnection, onSocketConnection1);
			GameService.instance.removeEventListener(RemoteEvent.onConnection, onSocketConnection2);
			GameService.instance.removeEventListener(MSGID.MSGID_EXIST_CHAR.toString(), onExistCharList);
		}
		
		
		/**
		 * 中心服务器连接成功
		 * @param event
		 * 
		 */
		private function onSocketConnection1(event:RemoteEvent):void 
		{
			GameService.instance.removeEventListener(RemoteEvent.onConnection, onSocketConnection1);
			
			// 连接成功后必须发送 验证消息(无须等待返回 )
			GameService.instance.send(MSGID.MSGID_SOCKET_VALIDATE);
			
			// 立即发送中心服登录消息
			var centerLoginReq:MSG_CENTER_LOGIN_REQ = new MSG_CENTER_LOGIN_REQ();
			centerLoginReq.server = int(URI.server);
			centerLoginReq.userId = URI.params.user;
			// TO DO: 今后需要添加key，由登录php传递给flash
			centerLoginReq.key = "";
			
			GameService.instance.send(MSGID.MSGID_CENTER_LOGIN, centerLoginReq, onCenterLogin);
		}	
		
		
		/**
		 * 连接游戏服Gateway服务器
		 * @param response
		 * 
		 */
		private function onCenterLogin(response:RemoteResponse):void
		{
			var centerLoginAck:MSG_CENTER_LOGIN_ACK = new MSG_CENTER_LOGIN_ACK();
			centerLoginAck.mergeFrom(response.protoBytes);
			
			// 第二次连接，连接GameServer
			loginKey = centerLoginAck.loginKey;
			// GameServer连接返回
			GameService.instance.addEventListener(RemoteEvent.onConnection, onSocketConnection2);
			GameService.instance.connect(centerLoginAck.ip, centerLoginAck.port, true);
		}		

		/**
		 * 游戏服Gateway服务器连接成功 
		 * @param event
		 * 
		 */
		private function onSocketConnection2(event:RemoteEvent):void
		{
			GameService.instance.removeEventListener(RemoteEvent.onConnection, onSocketConnection2);
			
			// 连接成功后必须发送 验证消息(无须等待返回 )
			GameService.instance.send(MSGID.MSGID_SOCKET_VALIDATE);
			
			
			// 发送登录消息
			var loginReq:MSG_LOGIN_REQ = new MSG_LOGIN_REQ();
			loginReq.loginKey = loginKey;
			
			GameService.instance.send(MSGID.MSGID_LOGIN, loginReq, onLoginFail);
		}		
		
		
		/**
		 * 登录结果返回(失败才会返回)
		 * 
		 */
		private function onLoginFail(response:RemoteResponse):void
		{
			trace("LoginProxy onLoginFail()->errcode:" + response.errcode);
			this.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_FAIL, response));
		}
		
		
		/**
		 * 创建角色
		 *
		 */
		public function createUser(loginAck:MSG_CREATE_USER_REQ):void
		{
			GameService.instance.send(MSGID.MSGID_CREATE_USER, loginAck , onCreateUserFail);
		}
		
		
		/**
		 * 创建角色结果返回(失败才会返回)
		 * 
		 */
		private function onCreateUserFail(response:RemoteResponse):void
		{
			trace("LoginProxy onCreateUserFail()->errcode:" + response.errcode);
			this.dispatchEvent(new LoginEvent(LoginEvent.CREATE_USER_FAIL , response));
		}
		
		
		/**
		 * 发送客户端到达创角页面（登录成功有角色 or 创角成功）
		 * 
		 */
		public function showCU():void 
		{
			GameService.instance.send(MSGID.MSGID_SHOW_CU);
		}
		
		
		/**
		 * 已创建角色列表返回
		 * @param event
		 * 
		 */
		private function onExistCharList(event:GameServiceEvent):void
		{
			this.dispatchEvent(new LoginEvent(LoginEvent.EXIST_CHAR, (event.data as RemoteResponse) ));
		}			
		
		
	}
}