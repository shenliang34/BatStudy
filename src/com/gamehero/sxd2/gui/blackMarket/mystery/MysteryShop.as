package com.gamehero.sxd2.gui.blackMarket.mystery
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.blackMarket.event.BlackMarketEvent;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.blackMarket.mystery.component.MysteryShopBtn;
	import com.gamehero.sxd2.gui.blackMarket.mystery.component.MysteryShopItem;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.core.group.DataGroup;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK;
	import com.gamehero.sxd2.util.Time;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bowser.utils.MovieClipPlayer;
	import bowser.utils.time.TimeTick;
	import bowser.utils.time.TimeTickData;
	
	/**
	 * 神秘商店
	 * @author weiyanyu
	 * 创建时间：2015-9-29 下午2:41:42
	 * 
	 */
	public class MysteryShop extends Sprite implements IPanel
	{
		
		private const REFRESH_TIME:int = /*2 * 60 * 60*/7200;//两小时刷新
		
		private const LINGPAI_ID:int = 15010001;//令牌id
		/**
		 * 元宝刷新需要消耗数量 
		 */		
		private const YUANBAO_NUM:int = 20;
		/**
		 * 令牌需要数量 
		 */		
		private const LINGPAI_NUM:int = 1;
		/**
		 * 最大免费次数 
		 */		
		private const FREE_NUM:int = 10;
		/**
		 * 最大收费次数 
		 */		
		private const MAX_CHARGE_TIME:int = 30;
		/**
		 * 免费刷新状态 
		 */		
		private static var FREE:int = 0;
		/**
		 * 令牌刷新状态 
		 */		
		private static var LINGPAI:int = 1;
		/**
		 * 元宝刷新状态 
		 */		 
		private static var YUANBAO:int = 2;
		/**
		 * 无法刷新 
		 */
		private static var NO_TIME:int = 2;
		
		private var _group:DataGroup;
		/**
		 * 状态，已满or计时 
		 */		
		private var _statusLb:Label;
		/**
		 * 刷新按钮 
		 */		
		private var _freshBtn:MysteryShopBtn;
		/**
		 * 收费次数 
		 */		
		private var _chargeNumLb:Label;
		
		private var _status:int;
		
		private var _msg:MSG_UPDATE_BLACK_MARKET_ACK;
		
		private var _timeTick:TimeTick;
		
		private var _mubu:MovieClip;
		
		public function MysteryShop()
		{
			super();
			
			var global:Global = Global.instance;
			var model:BlackMarketModel = BlackMarketModel.inst;
			
			var bg:MovieClip = global.getRes(model.domain,"MysteryBg") as MovieClip;
			addChild(bg);
			bg.x = -34;
			bg.y = 77;
			
			_group = new DataGroup();
			addChild(_group);
			_group.itemRenderer = MysteryShopItem;
			_group.col = 3;
			_group.x = 182;
			_group.y = 103;
			_group.gapX = 37;
			_group.gapY = 12;
			
			_freshBtn = new MysteryShopBtn();
			addChild(_freshBtn);
			_freshBtn.x = 376;
			_freshBtn.y = 485;
			
			_statusLb = new Label();
			addChild(_statusLb);
			_statusLb.x = 39;
			_statusLb.y = 494;
			_statusLb.color = GameDictionary.GREEN;
			
			
			_chargeNumLb = new Label();
			addChild(_chargeNumLb);
			_chargeNumLb.x = 472;
			_chargeNumLb.y = 494;
			_chargeNumLb.color = GameDictionary.YELLOW;
			
			_mubu = global.getRes(model.domain,"MuBu") as MovieClip;
			addChild(_mubu);
			_mubu.x = 15;
			_mubu.y = 67;
			_mubu.gotoAndStop(1);
			_mubu.mouseEnabled = false;
			_mubu.mouseChildren = false;
			
			_timeTick = new TimeTick();
		}
		
		public function init():void
		{
			_freshBtn.addEventListener(MouseEvent.CLICK,onFreshBtnClick);
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(_mubu , _mubu.totalFrames/24 , 0 , _mubu.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			function over(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , over);
			}
			//直接加在swf到舞台
			_mubu.play();
		}
		
		protected function onFreshBtnClick(event:MouseEvent):void
		{
			if(_status == YUANBAO)
			{
				var str:String = "是否花费"+GameDictionary.createCommonText(YUANBAO_NUM + "元宝",GameDictionary.ORANGE)+ "进行一次刷新";
				ItemCost.showAlert("blackMarketRefresh",onFresh,str);
			}
			else
			{
				dispatchEvent(new BlackMarketEvent(BlackMarketEvent.REFRESH));
			}
		}
	
		private function onFresh():void
		{
			if(ItemCost.canUseSingItem([MoneyDict.YUANBAO,YUANBAO_NUM]))
			{
				dispatchEvent(new BlackMarketEvent(BlackMarketEvent.REFRESH));
			}
		}
		
		
		public function Updata(msg:MSG_UPDATE_BLACK_MARKET_ACK):void
		{
			_msg = msg;
			var leftTime:int = REFRESH_TIME - (TimeTick.inst.getCurrentTime() / 1000 - msg.lastRefreshTime);
			setStatusLb(leftTime);
			_group.dataProvider = msg.item;
		}
		
		private function updataTimeTick(data:TimeTickData):void 
		{
			_statusLb.text = "免费刷新时间： " + Time.getStringTime1(data.remainTime / 1000);
		}
		private function completeTimeTick(data:TimeTickData):void 
		{
			_timeTick.clear();
			_msg.freeNum ++;
			setStatusLb(REFRESH_TIME);
		}
		private function setStatusLb(leftTime:int):void
		{
			_chargeNumLb.text = "剩余次数：" + (MAX_CHARGE_TIME - _msg.totalNum);
			_freshBtn.num = 0;
			_freshBtn.locked = false;
			if(_msg.freeNum > 0)//拥有免费次数
			{
				_chargeNumLb.visible = false;
				_freshBtn.label = "免费刷新";
				_freshBtn.num = _msg.freeNum;
				if(_msg.freeNum == FREE_NUM)
				{
					_statusLb.text = "当前库存已满！";
				}
				_status = FREE;
			}
			else if(MAX_CHARGE_TIME - _msg.totalNum > 0)//拥有收费次数
			{
				_chargeNumLb.visible = true;
				var lingpaiNum:int = BagModel.inst.getItemNum(LINGPAI_ID);
				if(lingpaiNum > 0)//令牌数量不为0
				{
					_freshBtn.label = "令牌刷新";
					_freshBtn.num = lingpaiNum;
					_status = LINGPAI;
				}
				else
				{
					_freshBtn.label = "元宝刷新";
					_status = YUANBAO;
				}
			}
			else
			{
				_freshBtn.label = "免费刷新";
				_freshBtn.locked = true;
				_chargeNumLb.text = "今日已无额外刷新次数";
				_status = NO_TIME;
			}
			if(_msg.freeNum != FREE_NUM && !_timeTick.running)
				_timeTick.addListener(new TimeTickData(leftTime,1000, updataTimeTick, completeTimeTick));
			
		}
		public function clear():void
		{
			_timeTick.clear();
			_statusLb.text = "";
			_group.clear();
			_freshBtn.removeEventListener(MouseEvent.CLICK,onFreshBtnClick);
		}
	}
}