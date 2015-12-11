package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.netease.protobuf.Message;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 聊天mediator
	 * @author 张学优
	 * @create 2015-7-28
	 **/
	public class ChatMediator extends Mediator
	{
		[Inject] 
		public var view:ChatView;

		/**
		 * 构造函数
		 * */
		public function ChatMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 */
		override public function initialize():void
		{
			super.initialize();
			this.addViewListener(ChatEvent.CHAT , onSendChatHandle);
			GameService.instance.addEventListener(MSGID.MSGID_CHAT_SEND.toString() , onSendChatCallBackHandle);
			GameService.instance.addEventListener(MSGID.MSGID_CHAT_NOTIFY.toString() , onReceiveChatHandle);
			GameService.instance.addEventListener(MSGID.MSGID_CHAT_NOTICE.toString() , onChatNoticeHandle);
			this.addContextListener(ChatEvent.CHATSHOWITEMTIPS,chatShowItemTipsHandle);
		}
		
		/**
		 * 清理
		 */
		override public function destroy():void
		{
			super.destroy();
			this.removeViewListener(ChatEvent.CHAT , onSendChatHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_CHAT_SEND.toString() , onSendChatCallBackHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_CHAT_NOTIFY.toString() , onReceiveChatHandle);
		}
		
		/**
		 * 发送聊天消息
		 * */
		private function onSendChatHandle(e:ChatEvent):void
		{
			GameService.instance.send(MSGID.MSGID_CHAT_SEND,e.data as Message);
		}
		
		/**
		 * 发送聊天消息返回
		 * */
		private function onSendChatCallBackHandle(e:GameServiceEvent):void
		{
			view.sendChatCallbackHandle(e.data);
		}
		
		/**
		 * 接收广播聊天消息
		 * */
		private function onReceiveChatHandle(e:GameServiceEvent):void
		{
			view.receiveChatHandle(e.data);
		}
		
		/**
		 * 显示道具提示信息
		 * */
		public function chatShowItemTipsHandle(e:ChatEvent):void
		{
			view.chatShowItemTipsHandle(e.data as PRO_Item);
		}
		
		/**
		 * 系统公告
		 * */
		private function onChatNoticeHandle(e:GameServiceEvent):void
		{
			view.showNoticeHandle(e.data);
		}
	}
}