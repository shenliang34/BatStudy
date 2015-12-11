package com.gamehero.sxd2.gui.mail
{
	import com.gamehero.sxd2.event.MailEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_MAIL_DETAIL_ACK;
	import com.gamehero.sxd2.pro.MSG_MAIL_DETAIL_REQ;
	import com.gamehero.sxd2.pro.MSG_MAIL_GET_ATTACH_REQ;
	import com.gamehero.sxd2.pro.MSG_MAIL_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_MAIL_INFO_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.netease.protobuf.UInt64;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 邮箱窗口
	 * @author zhangxueyou
	 * @create 2015-10-9
	 **/
	
	public class MailWindowMediator extends Mediator
	{
		[Inject] 
		public var view:MailWindow;
		
		public function MailWindowMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 */
		override public function initialize():void
		{
			super.initialize();
			GameService.instance.addEventListener(MSGID.MSGID_MAIL_INFO.toString() , mailListHandle);
			GameService.instance.addEventListener(MSGID.MSGID_MAIL_DETAIL.toString() , mailDetailHandle);
			GameService.instance.addEventListener(MSGID.MSGID_MAIL_GET_ATTACH.toString() , mailAttachHandle);
			
			addViewListener(MailEvent.MAIL_GET_LIST,mailGetListHandle);
			addViewListener(MailEvent.MAIL_GET_DETAIL,mailGetDetailHandle);
			addViewListener(MailEvent.MAIL_GET_ATTACH,mailGetAttachHandle);
		}
		
		/**
		 * 清理
		 */
		override public function destroy():void
		{
			super.destroy();
			GameService.instance.removeEventListener(MSGID.MSGID_MAIL_INFO.toString() , mailListHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_MAIL_DETAIL.toString() , mailDetailHandle);
			GameService.instance.removeEventListener(MSGID.MSGID_MAIL_GET_ATTACH.toString() , mailAttachHandle);
			
			removeViewListener(MailEvent.MAIL_GET_LIST,mailGetListHandle);
			removeViewListener(MailEvent.MAIL_GET_DETAIL,mailGetDetailHandle);
			removeViewListener(MailEvent.MAIL_GET_ATTACH,mailGetAttachHandle);
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
		 * 返回邮件列表
		 */
		private function mailListHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				var ack:MSG_MAIL_INFO_ACK = new MSG_MAIL_INFO_ACK();
				
				if(!respones.protoBytes) return;
				
				ack.mergeFrom(respones.protoBytes);
				view.initWindowInfo(ack.pageInfo,ack.mail);
			}
		}
		
		/**
		 * 邮件详情请求
		 */
		private function mailGetDetailHandle(e:MailEvent):void
		{
			var req:MSG_MAIL_DETAIL_REQ = new MSG_MAIL_DETAIL_REQ();
			req.mailId = e.data as UInt64;
			
			GameService.instance.send(MSGID.MSGID_MAIL_DETAIL,req);
		}
		
		/**
		 * 邮件详情返回
		 */
		private function mailDetailHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				var ack:MSG_MAIL_DETAIL_ACK = new MSG_MAIL_DETAIL_ACK();
				if(respones.protoBytes)
				{
					ack.mergeFrom(respones.protoBytes);
					view.setMailContentHamdle(ack.mailDetail);	
				}
			}
		}
		
		/**
		 * 领取附件请求
		 */
		private function mailGetAttachHandle(e:MailEvent):void
		{
			var req:MSG_MAIL_GET_ATTACH_REQ = new MSG_MAIL_GET_ATTACH_REQ();
			req.mailId = e.data as UInt64;
			
			GameService.instance.send(MSGID.MSGID_MAIL_GET_ATTACH,req);
		}
		
		/**
		 * 领取附件返回
		 */
		private function mailAttachHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				/*
				var ack:MSG_MAIL_GET_ATTACH_ACK = new MSG_MAIL_GET_ATTACH_ACK();
				ack.mergeFrom(respones.protoBytes);
				*/
				var req:MSG_MAIL_DETAIL_REQ = new MSG_MAIL_DETAIL_REQ();
				req.mailId = view.curMailId;
				
				GameService.instance.send(MSGID.MSGID_MAIL_DETAIL,req);
			}
		}
		
		
	}
}