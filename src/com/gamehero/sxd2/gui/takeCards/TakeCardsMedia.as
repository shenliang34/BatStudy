package com.gamehero.sxd2.gui.takeCards
{
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.gui.takeCards.event.TakeCardsEvent;
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_UPDATE_PRAY_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * 抽卡
	 * @author weiyanyu
	 * 创建时间：2015-10-14 15:18:09
	 * 
	 */
	public class TakeCardsMedia extends Mediator
	{
		[Inject]
		public var view:TakeCardsWindow;
		
		private var _service:GameService;
		
		private var _model:TakeCardsModel;
		public function TakeCardsMedia()
		{
			super();
			_service = GameService.instance;
			_model = TakeCardsModel.inst;
		}
		override public function initialize():void
		{
			super.initialize();
			addViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			addViewListener(TakeCardsEvent.TAKE_CARD,takeCardsReq);
			addViewListener(TakeCardsEvent.GET_CARD,getCardsReq);
			
			GameProxy.inst.addEventListener(BagEvent.ITEM_UPDATA,onUpdataBag);
			
			_service.addEventListener(MSGID.MSGID_UPDATE_PRAY + "",onUpdataAck);
		}
		/**
		 * 更新伙伴令数量 
		 * @param event
		 * 
		 */		
		protected function onUpdataBag(event:BagEvent):void
		{
			view.setHeroItemNum();
		}
		
		protected function onUpdataAck(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0"&&response.protoBytes)
			{
				var msg:MSG_UPDATE_PRAY_ACK = new MSG_UPDATE_PRAY_ACK();
				GameService.instance.mergeFrom(msg, response.protoBytes);
				//打印此次数据
				GameService.instance.debug(response, msg);
				_model.msg = msg;
				_model.initOpenVec();
			}
		}
		/**
		 *  抽到的卡放到背包里
		 * @param e
		 * 
		 */		
		private function getCardsReq(e:TakeCardsEvent):void
		{
			_service.send(MSGID.MSGID_PRAY_CONFIRM,null,onGetCardsBack);
		}
		
		private function onGetCardsBack(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				_model.clearOpenVec();
				view.onGetCardsBack();
			}
		}
		/**
		 * 求神 
		 * @param e
		 * 
		 */		
		private function takeCardsReq(e:TakeCardsEvent):void
		{
			_service.send(MSGID.MSGID_PRAY_START,null,takeCardsBack);
		}
		
		private function takeCardsBack(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view.takeBackUpdata();
			}
		}
		/**
		 * 第一次打开界面主动请求刷新 
		 * @param e
		 * 
		 */		
		private function onUpdataReq(e:UpdataEvent):void
		{
			_service.send(MSGID.MSGID_PRAY_INFO,null,onUpdataBack);
		}
		
		private function onUpdataBack(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view.updata();
			}
		}
		override public function destroy():void
		{
			super.destroy();
			removeViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			removeViewListener(TakeCardsEvent.TAKE_CARD,takeCardsReq);
			removeViewListener(TakeCardsEvent.GET_CARD,getCardsReq);
			
			GameProxy.inst.removeEventListener(BagEvent.ITEM_UPDATA,onUpdataBag);
			
			_service.removeEventListener(MSGID.MSGID_UPDATE_PRAY + "",onUpdataAck);
		}
	}
}