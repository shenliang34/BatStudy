package com.gamehero.sxd2.gui.notice
{
	import com.gamehero.sxd2.event.MailEvent;
	import com.gamehero.sxd2.event.NoticeEvent;
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.chat.ChatFormat;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_NOTIFY_INFO_3_ACK;
	import com.gamehero.sxd2.pro.MSG_CHAT_NOTICE_ACK;
	import com.gamehero.sxd2.pro.MSG_MAIL_INFO_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import flash.events.Event;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 游戏提示层
	 * @author zhangxueyou
	 * @create 2015-09-22
	 **/
	public class NoticeUIMediator extends Mediator
	{
		[Inject] 
		public var view:NoticeUI;
		
		public function NoticeUIMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 */
		override public function initialize():void
		{
			super.initialize();
			GameService.instance.addEventListener(MSGID.MSGID_CHAT_NOTICE.toString() , onChatNoticeHandle);
			GameService.instance.addEventListener(MSGID.MSGID_NOTIFY_INFO_3.toString() , notifyInfoHandle);
			GameService.instance.addEventListener(MSGID.MSGID_TASK_COMMIT.toString(),taskCompleteAckHandle);
			GameService.instance.addEventListener(MSGID.MSGID_TASK_START.toString(),taskStartAckHandle);
			
			addViewListener(MailEvent.MAIL_GET_LIST,mailGetListHandle);
		}
		
		/**
		 * 清理
		 */
		override public function destroy():void
		{
			super.destroy();
			GameService.instance.removeEventListener(MSGID.MSGID_CHAT_NOTICE.toString() , onChatNoticeHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_NOTIFY_INFO_3.toString() , notifyInfoHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_TASK_COMMIT.toString(),taskCompleteAckHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_TASK_START.toString(),taskStartAckHandle);
			
			removeViewListener(MailEvent.MAIL_GET_LIST,mailGetListHandle);
		}
		
		/**
		 *任务完成返回 
		 * @param e
		 * 
		 */		
		private function taskCompleteAckHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0")
				view.setCompleteTaskVisible();
		}
		
		/**
		 *任务开始返回 
		 * @param e
		 * 
		 */		
		private function taskStartAckHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0")
				view.setSatrtTaskVisible();
		}
		
		
		/**
		 * 邮件列表请求
		 */
		private function mailGetListHandle(e:MailEvent):void
		{
			var req:MSG_MAIL_INFO_REQ = new MSG_MAIL_INFO_REQ();
			req.curPage = int(e.data);
			
			GameService.instance.send(MSGID.MSGID_MAIL_INFO,req);
		}
		
		/**
		 *3号区域提示 
		 * @param e
		 * 
		 */		
		private function notifyInfoHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0") 
			{
				var ack:MSGID_NOTIFY_INFO_3_ACK = new MSGID_NOTIFY_INFO_3_ACK();
				ack.mergeFrom(respones.protoBytes);
				view.showNoti(view.NOTIAREA3,ack);
			}
		}
		
		/**
		 * 公告返回
		 */
		private function onChatNoticeHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0") 
			{
				var noticeAck:MSG_CHAT_NOTICE_ACK = new MSG_CHAT_NOTICE_ACK();
				respones.protoBytes.position = 0;
				noticeAck.mergeFrom(respones.protoBytes);
				
				var messageXml:XML = ChatFormat.getMessage(ChatData.SYSTEM,noticeAck).xml;
				var content:String = "";		
				if (messageXml.hasOwnProperty("text")) content += messageXml.text;
				
				view.showNoti(view.NOTIAREA1,content);
			}
		}
	}
}