package com.gamehero.sxd2.gui.equips
{
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipRenderItem;
	import com.gamehero.sxd2.gui.equips.event.EquipEvent;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.player.hero.event.HeroEvent;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_STORE_BUY_REQ;
	import com.gamehero.sxd2.pro.MSG_ITEM_UPGRADE_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.netease.protobuf.UInt64;
	
	import flash.events.Event;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-10 11:15:28
	 * 
	 */
	public class EquipMedia extends Mediator
	{
		
		public function EquipMedia()
		{
			super();
		}
		[Inject]
		public var view:EquipWindow;
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			super.initialize();
			this.addViewListener(HeroEvent.REQ_HERO_LIST,reqHeroList);
			this.addViewListener(EquipEvent.STRENGTHEN,onStren);
			this.addViewListener(EquipEvent.BUY_ITEM,reqBuyItem);
			GameProxy.inst.addEventListener(HeroEvent.HERO_INFO_UPDATA,onUpdata);
		}
		
		private var _canBuy:Boolean = true;
		
		private var _curBuyItem:PropBaseVo;
		private function reqBuyItem(e:EquipEvent):void
		{
			if(_canBuy)
			{
				_curBuyItem = e.data as PropBaseVo;
				var msg:MSGID_STORE_BUY_REQ = new MSGID_STORE_BUY_REQ();
				msg.itemId = _curBuyItem.itemId;
				msg.num = 1;
				GameService.instance.send(MSGID.MSGID_STORE_BUY,msg,onBuyBack);
				_canBuy = false;
			}
		}
		/**
		 * 购买成功 
		 * @param response
		 * 
		 */	
		private function onBuyBack(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				HeroModel.instance.itemHeroEquip(EquipRenderItem.getRecommend(_curBuyItem.subType).id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON,EquipModel.inst.curSelectedId);
			}
			_canBuy = true;
		}
			
		
		private var _canStren:Boolean = true;
		/**
		 * 装备强化 
		 * @param event
		 * 
		 */		
		protected function onStren(event:EquipEvent):void
		{
			if(_canStren)
			{
				var msg:MSG_ITEM_UPGRADE_REQ = new MSG_ITEM_UPGRADE_REQ();
				msg.itemId = event.data as UInt64;
				GameService.instance.send(MSGID.MSGID_ITEM_UPGRADE,msg,onStrenCallBack);
				_canStren = false;
			}
		}
		
		private function onStrenCallBack(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view.updateHeroInfo();
				view.playMc();
			}
			_canStren = true;
		}
		protected function onUpdata(event:Event):void
		{
			this.view.updateHeroInfo();
		}
		
		override public function destroy():void
		{
			super.destroy();
			this.removeViewListener(HeroEvent.REQ_HERO_LIST,reqHeroList);
			this.removeViewListener(EquipEvent.STRENGTHEN,onStren);
			this.removeViewListener(EquipEvent.BUY_ITEM,reqBuyItem);
			GameProxy.inst.removeEventListener(HeroEvent.HERO_INFO_UPDATA,onUpdata);
			
			_canStren = true;
			_canBuy = true;
		}
		private function reqHeroList(evt:HeroEvent):void
		{
			GameService.instance.send(MSGID.MSGID_HREO_BATTLE);
		}
	}
}