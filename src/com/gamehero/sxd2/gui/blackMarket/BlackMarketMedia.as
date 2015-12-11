package com.gamehero.sxd2.gui.blackMarket
{
	import com.gamehero.sxd2.gui.blackMarket.event.BlackMarketEvent;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_BLACK_MARKET_BUY_REQ;
	import com.gamehero.sxd2.pro.MSGID_BLACK_MARKET_REFRESH_REQ;
	import com.gamehero.sxd2.pro.MSGID_BLACK_MARKET_REQ;
	import com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-17 15:58:59
	 * 
	 */
	public class BlackMarketMedia extends Mediator
	{
		private var _gameService:GameService;
		
		[Inject]
		public var view:BlackMarketWindow;
		
		private var _msg:MSG_UPDATE_BLACK_MARKET_ACK;
		
		/**
		 * 是否可以刷新，为了拦截点击过快造成的问题 
		 */		
		private var _canMysteryShopFresh:Boolean = true;
		
		public function BlackMarketMedia()
		{
			super();
			_gameService = GameService.instance;
		}
		override public function initialize():void
		{
			super.initialize();
			
			addViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			addViewListener(BlackMarketEvent.REFRESH,onFreeRefresh);
			addViewListener(BlackMarketEvent.BUYITEM,onBuyItem);
			
			_gameService.addEventListener(MSGID.MSGID_UPDATE_BLACK_MARKET.toString(),onUpdata);
			_gameService.addEventListener(MSGID.MSGID_UPDATE_PLAYER.toString(),onSetLingyun);
		}
		/**
		 * 设置灵蕴数量 
		 * @param event
		 * 
		 */		
		private function onSetLingyun(event:GameServiceEvent):void
		{
			view.setLingyun();
		}
		/**
		 * 购买道具 
		 * @param e
		 * 
		 */		
		private function onBuyItem(e:BlackMarketEvent):void
		{
			var msg:MSGID_BLACK_MARKET_BUY_REQ = new MSGID_BLACK_MARKET_BUY_REQ();
			msg.index = int(e.data);
			_gameService.send(MSGID.MSGID_BLACK_MARKET_BUY, msg,onBuyItemRspd);
		}
		
		private function onBuyItemRspd(response:RemoteResponse):void
		{
			if(response.errcode == "0")	
			{
				BlackMarketModel.inst.optFromType = 3;
				view.Updata(_msg);
			}
		}
		/**
		 * 刷新 
		 * @param e
		 */		
		private function onFreeRefresh(e:BlackMarketEvent):void
		{
			if(_canMysteryShopFresh)
			{
				_gameService.send(MSGID.MSGID_BLACK_MARKET_REFRESH, new MSGID_BLACK_MARKET_REFRESH_REQ(),onFreeRefreshRspd);
				_canMysteryShopFresh = false;
			}
		}
		private function onFreeRefreshRspd(response:RemoteResponse):void
		{
			if(response.errcode == "0")	
			{
				BlackMarketModel.inst.optFromType = 2;
				view.Updata(_msg);
				_canMysteryShopFresh = true;
			}
		}
		/**
		 * * 获取黑市数据 
		 * @param e
		 */		
		private function onUpdataReq(e:UpdataEvent):void
		{
			var msg:MSGID_BLACK_MARKET_REQ = new MSGID_BLACK_MARKET_REQ();
			_gameService.send(MSGID.MSGID_BLACK_MARKET, msg,onUpdataRspd);
		}
		private function onUpdataRspd(response:RemoteResponse):void
		{
			if(response.errcode == "0")	
			{
				BlackMarketModel.inst.optFromType = 1;
				view.Updata(_msg);
			}
		}
		
		private function onUpdata(event:GameServiceEvent):void
		{
			var response:RemoteResponse = event.data as RemoteResponse;
			if(response.errcode == "0"&&response.protoBytes)
			{
				var msg:MSG_UPDATE_BLACK_MARKET_ACK = new MSG_UPDATE_BLACK_MARKET_ACK();
				GameService.instance.mergeFrom(msg, response.protoBytes);
				//打印此次数据
				GameService.instance.debug(response, msg);
				_msg = msg;
			}
		}
		override public function destroy():void
		{
			super.destroy();
			
			_canMysteryShopFresh = true;
			
			removeViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			removeViewListener(BlackMarketEvent.REFRESH,onFreeRefresh);
			removeViewListener(BlackMarketEvent.BUYITEM,onBuyItem);
			
			_gameService.removeEventListener(MSGID.MSGID_UPDATE_BLACK_MARKET.toString(),onUpdata);
			_gameService.removeEventListener(MSGID.MSGID_UPDATE_PLAYER.toString(),onSetLingyun);
		}
	}
}