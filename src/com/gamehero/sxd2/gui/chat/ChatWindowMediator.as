package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.pro.MSG_FRIEND_CHAT_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.netease.protobuf.UInt64;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 
	 * @author cuixu
	 * @create：2015-11-18
	 **/
	public class ChatWindowMediator extends Mediator
	{
		[Inject] 
		public var view:ChatWindow;
		
		public function ChatWindowMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 */
		override public function initialize():void
		{
			super.initialize();
			GameService.instance.addEventListener("MSGID.MSG_FRIEND_CHAT_ACK.toString()",friendChatHandle);
			GameService.instance.addEventListener("chatwindowlist",chatWindowListHandle);
			GameService.instance.addEventListener("historycontent",historyContentsHandle);
			addViewListener(ChatEvent.CHAT , onSendChatHandle);
			addViewListener(ChatEvent.CHAT_HISTORY , chatHistory);
			addViewListener(ChatEvent.CHAT_HISTORY_UPDATE , chatHistoryUpdate);
			addViewListener(ChatEvent.ANOTHER_PLAYER_INFO_CLICK , anotherPlayerInfoClick);
		}
		
		/**
		 * 清理
		 */
		override public function destroy():void
		{
			super.destroy();
			GameService.instance.removeEventListener("MSGID.MSG_FRIEND_CHAT_ACK.toString()",friendChatHandle);
			GameService.instance.removeEventListener("chatwindowlist",chatWindowListHandle);
			GameService.instance.removeEventListener("historycontent",historyContentsHandle);
			removeViewListener(ChatEvent.CHAT , onSendChatHandle);
			removeViewListener(ChatEvent.CHAT_HISTORY , chatHistory);
			removeViewListener(ChatEvent.CHAT_HISTORY_UPDATE , chatHistoryUpdate);
			removeViewListener(ChatEvent.ANOTHER_PLAYER_INFO_CLICK , anotherPlayerInfoClick);
		}
		
		private function chatWindowListHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				//var ack:MSG_MAIL_DETAIL_ACK = new MSG_MAIL_DETAIL_ACK();
				if(respones.protoBytes)
				{
					//ack.mergeFrom(respones.protoBytes);
					//view.setMailContentHamdle(ack.mailDetail);	
				}
			}
		}
		
		private function historyContentsHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				//var ack:MSG_FRIEND_HISTORY_CONTENTS = new MSG_FRIEND_HISTORY_CONTENTS();
				if(respones.protoBytes)
				{
					//ack.mergeFrom(respones.protoBytes);
					//view.onChatHistory(ack.historyChats);//[PRO_ChatContents]
				}
			}
		}
		
		private function friendChatHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				var ack:MSG_FRIEND_CHAT_ACK = new MSG_FRIEND_CHAT_ACK();
				if(respones.protoBytes)
				{
					ack.mergeFrom(respones.protoBytes);
					view.friendChatHandle(ack.chats);//[PRO_ChatContents]
				}
			}
		}
		
		/**
		 * 发起聊天
		 * */
		private function onSendChatHandle(e:ChatEvent):void
		{
			//GameService.instance.send(MSGID.MSG_FRIEND_CHAT,e.data as Message);
		}
		
		/**
		 * 聊天记录
		 * */
		private function chatHistory(e:ChatEvent):void
		{
			//GameService.instance.send(MSGID.MSG_FRIEND_HISTORY_CONTENTS,e.data as Message);
		}
		
		private function chatHistoryUpdate(e:ChatEvent):void
		{
			dispatch(new ChatEvent(ChatEvent.CHAT_HISTORY_UPDATE));
		}
		
		/**
		 * 点击查看其它玩家信息
		 * */
		private function anotherPlayerInfoClick(e:ChatEvent):void
		{
			var userID:UInt64 = e.data as UInt64;
			//this.dispatch(new AnotherPlayerEvent(AnotherPlayerEvent.VIEW_ANOTHER_PLAYER_E , userID)); 
		}
		
	}
}