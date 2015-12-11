package com.gamehero.sxd2.login
{
	import com.gamehero.sxd2.event.LoginEvent;
	import com.gamehero.sxd2.pro.CHAR_ID_INFO;
	import com.gamehero.sxd2.pro.MSG_CREATE_USER_REQ;
	import com.gamehero.sxd2.pro.MSG_EXIST_CHAR;
	import com.gamehero.sxd2.pro.MSG_LOGIN_ACK;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import bowser.remote.RemoteResponse;
	
	/**
	 * login模块的mediator
	 * @author xuwenyi
	 * @create 2013-07-17
	 * @modify by Trey 2015-11-06
	 */
	public class LoginMediator
	{
		private var view:LoginView;
		private var proxy:LoginProxy;
		
		
		
		/**
		 * 构造函数
		 * */
		public function LoginMediator(view:LoginView)
		{
			this.view = view;
			this.proxy = new LoginProxy();
		}
		
		
		/**
		 * 初始化
		 * */
		public function initialize():void
		{
			view.addEventListener(LoginEvent.CREATE_USER , createUser);
			view.addEventListener(LoginEvent.SHOW_CREATE_USER , showCreateUser);
			
			proxy.addEventListener(LoginEvent.LOGIN_FAIL , onLoginFail);
			proxy.addEventListener(LoginEvent.CREATE_USER_FAIL , onCreateUserFail);
			proxy.addEventListener(LoginEvent.EXIST_CHAR, onExistCharList);
		}
		
		
		/**
		 * 销毁
		 * 
		 */
		public function destroy():void
		{
			view.removeEventListener(LoginEvent.CREATE_USER , createUser);
			view.removeEventListener(LoginEvent.SHOW_CREATE_USER , showCreateUser);
			
			proxy.removeEventListener(LoginEvent.LOGIN_FAIL , onLoginFail);
			proxy.removeEventListener(LoginEvent.CREATE_USER_FAIL , onCreateUserFail);
			proxy.removeEventListener(LoginEvent.EXIST_CHAR, onExistCharList);
			
			proxy.destory();
		}
		
		
		/**
		 * 登录响应
		 *
		 */
		private function onLoginFail(e:LoginEvent):void
		{
			var respnse:RemoteResponse = e.data as RemoteResponse;
			if(respnse.errcode != "0")
			{
				ExternalInterface.call("alert" , e.data.errcode);
			}
		}
		
		
		/**
		 * 创建角色
		 * */
		private function createUser(e:LoginEvent):void
		{
			proxy.createUser(e.data as MSG_CREATE_USER_REQ);
		}
		
		
		/**
		 * 创建角色响应
		 * 
		 */
		private function onCreateUserFail(e:LoginEvent):void
		{
			var errCode:int = int(e.data.errcode);
			if(errCode != 0)
			{
				view.setErrorTip(errCode);
			}
		}
		
		
		/**
		 * 已创建角色列表返回
		 * 
		 */
		private function onExistCharList(e:LoginEvent):void
		{
			var respnse:RemoteResponse = e.data as RemoteResponse;
			if(respnse.protoBytes == null)
			{
				// 进入创角页
				view.showRoleView(1);
			}
			else
			{
				var data:MSG_EXIST_CHAR = new MSG_EXIST_CHAR();
				data.mergeFrom(e.data.protoBytes);
				
				// TO DO: 服务器版本号
				Version.SERVER_VERSION = data.serverVer;
				trace("SERVER_VERSION:", Version.SERVER_VERSION);
				
				// 无角色
				if(data.chars.length <= 0)
				{
					// 进入创角页
					view.showRoleView(1);
				}
				else
				{
					// 进入SXD2Main
					view.dispatchEvent(new LoginEvent(LoginEvent.ENTER_SXD2_MAIN, data.chars));
				}
			}	
		}
		
		
		/**
		 * 显示创角页面成功（统计到达创角页面）
		 * @param event
		 * 
		 */
		private function showCreateUser(event:Event):void
		{
			proxy.showCU();
		}	
	}
}