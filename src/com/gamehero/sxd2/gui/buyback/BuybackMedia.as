package com.gamehero.sxd2.gui.buyback
{
	import com.gamehero.sxd2.gui.buyback.model.BuyBackDict;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_STORE_OPT_REQ;
	import com.gamehero.sxd2.pro.MSG_UPDATE_STORE_BUY_BACK_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.netease.protobuf.UInt64;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-23 11:21:49
	 * 
	 */
	public class BuybackMedia extends Mediator
	{
		[Inject]
		public var view:BuybackWindow;
		
		private var _service:GameService;
		
		public function BuybackMedia()
		{
			super();
			_service = GameService.instance;
		}
		override public function initialize():void
		{
			super.initialize();
			addViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			addViewListener(BuyBackEvent.BUY_BACK,onBuback);
			_service.addEventListener(MSGID.MSGID_UPDATE_STORE_BUY_BACK.toString(),onUpdata);
		}
		
		private function onBuback(e:BuyBackEvent):void
		{
			// TODO Auto Generated method stub
			var msg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
			msg.opt = BuyBackDict.BUYBACK;
			msg.id = UInt64(e.data);
			GameService.instance.send(MSGID.MSGID_STORE_OPT,msg);
		}
		
		private function onUpdataReq(e:UpdataEvent):void
		{
			var msg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
			msg.opt = BuyBackDict.UPDATA;
			msg.id = new UInt64(0);
			_service.send(MSGID.MSGID_STORE_OPT,msg);
		}
		
		private function onUpdata(event:GameServiceEvent):void
		{
			var response:RemoteResponse = event.data as RemoteResponse;
			if(response.errcode == "0"&&response.protoBytes)
			{
				var msg:MSG_UPDATE_STORE_BUY_BACK_ACK = new MSG_UPDATE_STORE_BUY_BACK_ACK();
				GameService.instance.mergeFrom(msg, response.protoBytes);
				//打印此次数据
				GameService.instance.debug(response, msg);
				view.updata(msg);
			}
			else
			{
				view.updata(null);//清空数据
			}
		}
		override public function destroy():void
		{
			super.destroy();
			addViewListener(UpdataEvent.WINDOW_ON_SHOW,onUpdataReq);
			_service.removeEventListener(MSGID.MSGID_UPDATE_STORE_BUY_BACK.toString(),onUpdata);
		}
	}
}