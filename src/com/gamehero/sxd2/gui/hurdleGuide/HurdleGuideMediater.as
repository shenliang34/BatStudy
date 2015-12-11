package com.gamehero.sxd2.gui.hurdleGuide
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleGuideEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_ACCEPT_REQ;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_ENTER_REQ;
	import com.gamehero.sxd2.pro.MSG_UPDATE_INSTANCE_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_INSTANCE_REQ;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-9 下午2:37:34
	 * 
	 */
	public class HurdleGuideMediater extends Mediator
	{
		[Inject]
		public var view:HurdleGuideWindow;
		
		private var _gameService:GameService;
		
		private var _model:HurdleGuideModel;
		
		public function HurdleGuideMediater()
		{
			super();
			_model = HurdleGuideModel.inst;
			_gameService  = GameService.instance;
		}
		override public function initialize():void
		{
			super.initialize();
			view.addEventListener(HurdleGuideEvent.UPDATE,onUpdate);
			view.addEventListener(HurdleGuideEvent.ENTER_INSTANCE,enterInstance);
			view.addEventListener(HurdleGuideEvent.ACCEPT,acceptGift);
		}
		private var _curGiftBtnIndex:int = -1;//当前领取奖励的箱子索引
		protected function acceptGift(event:HurdleGuideEvent):void
		{
			var req:MSG_INSTANCE_ACCEPT_REQ = new MSG_INSTANCE_ACCEPT_REQ();
			req.chapterId = event.id;
			req.index = event.ent + 1;
			_curGiftBtnIndex = event.ent;
			GameService.instance.send(MSGID.MSGID_INSTANCE_ACCEPT,req,acceptGiftHandler);
		}
		
		private function acceptGiftHandler(remote:RemoteResponse):void
		{
			if(remote.errcode == "0")
			{
				view.updataGiftBtn(_curGiftBtnIndex);
			}
		}
		private var _hurdleId:int;//当前请求进入的副本
		//请求进入副本
		protected function enterInstance(event:HurdleGuideEvent):void
		{
			var req:MSG_INSTANCE_ENTER_REQ = new MSG_INSTANCE_ENTER_REQ();
			req.instanceId = event.id;
			_hurdleId = event.id;
			GameService.instance.send(MSGID.MSGID_INSTANCE_ENTER,req,enterInstanceCallBack);
		}
		//请求进入副本 返回
		private function enterInstanceCallBack(remote:RemoteResponse):void
		{
			if(remote.errcode == "0")
			{
				GameData.inst.curHurdleId = _hurdleId;
			}
		}
		/**
		 * 刷新章节内容 
		 * @param event
		 * 
		 */		
		protected function onUpdate(event:HurdleGuideEvent):void
		{
			var msg:MSG_UPDATE_INSTANCE_REQ = new MSG_UPDATE_INSTANCE_REQ();
			msg.chapterId = event.id;
			_gameService.send(MSGID.MSGID_UPDATE_INSTANCE,msg,onUpdateChapter);
		}
		/**
		 * 更新章节 
		 * @param event
		 * 
		 */		
		private function onUpdateChapter(remote:RemoteResponse):void
		{
			if(remote.errcode == "0"&&remote.protoBytes)
			{
				var chapterList:MSG_UPDATE_INSTANCE_ACK = new MSG_UPDATE_INSTANCE_ACK();
				GameService.instance.mergeFrom(chapterList, remote.protoBytes);
				GameService.instance.debug(remote, chapterList);
				_model.init(chapterList.instance);
				view.update(chapterList);
			}
		}
		
		/**
		 * 请求进入副本 
		 * @param value
		 * 
		 */		
		public function reqEnterInstance(value:int):void
		{
			var req:MSG_INSTANCE_ENTER_REQ = new MSG_INSTANCE_ENTER_REQ();
			req.instanceId = value;
			GameService.instance.send(MSGID.MSGID_INSTANCE_ENTER,req);
		}
		
		override public function destroy():void
		{
			super.destroy();
			_curGiftBtnIndex = -1;
			_hurdleId = 0;
			
			view.removeEventListener(HurdleGuideEvent.UPDATE,onUpdate);
			view.removeEventListener(HurdleGuideEvent.ENTER_INSTANCE,enterInstance);
			view.removeEventListener(HurdleGuideEvent.ACCEPT,acceptGift);
		}
	}
}