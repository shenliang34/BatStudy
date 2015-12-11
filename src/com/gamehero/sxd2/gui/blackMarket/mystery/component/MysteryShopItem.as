package com.gamehero.sxd2.gui.blackMarket.mystery.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.blackMarket.event.BlackMarketEvent;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.blackMarket.model.RandomItemVo;
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.RandomItemManager;
	import com.gamehero.sxd2.pro.PRO_BlackMarketItem;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.enum.Align;
	
	import bowser.utils.MovieClipPlayer;
	
	/**
	 * 
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午4:02:05
	 * 
	 */
	public class MysteryShopItem extends ItemRender
	{
		private var _item:BlackMarketItemCell;
		/**
		 * 可以购买 
		 */		
		public static var CAN_BUY:int = 0;
		/**
		 * 已经购买 
		 */		 
		public static var BUY_OVER:int = 1;
		/**
		 * 名字 
		 */ 
		private var _nameLb:Label;
		/**
		 * 消耗数量 
		 */		
		private var _costLb:MoneyLabel;
		
		private var _pro:PRO_BlackMarketItem;
		
		private var _buyBtn:Button;
		
		private var _itemVo:RandomItemVo;
		/**
		 * 
		 */		
		private var _tweenSp:Sprite;
		
		private var _itemSpecialEff:MovieClip;
		
		private var _tween:TweenMax;
		
		public function MysteryShopItem()
		{
			super();
			
			var global:Global = Global.instance;
			var model:BlackMarketModel = BlackMarketModel.inst;
			
			var bg:Bitmap = new Bitmap(global.getBD(model.domain,"ItemBg"));
			addChild(bg);
			
			_tweenSp = new Sprite();
			addChild(_tweenSp);
			
			_itemSpecialEff = global.getRes(model.domain,"ItemDissipate") as MovieClip;
			addChild(_itemSpecialEff);
			_itemSpecialEff.visible = false;
			
			_item = new BlackMarketItemCell();
			_item.x = 34;
			_item.y = 25;
			_tweenSp.addChild(_item);
			
			
			_nameLb = new Label();
			_tweenSp.addChild(_nameLb);
			_nameLb.width = 80;
			_nameLb.align = Align.CENTER;
			_nameLb.x = 24;
			_nameLb.y = 108;
			
			_costLb = new MoneyLabel();
			_tweenSp.addChild(_costLb);
			_costLb.x = 34;
			_costLb.y = 120;
			
			_buyBtn = new Button(global.getBD(model.domain,"BuyBtn_up"),global.getBD(model.domain,"BuyBtn_over"),global.getBD(model.domain,"BuyBtn_over"),global.getBD(model.domain,"HasBuy"));
			addChild(_buyBtn);
			_buyBtn.x = 37;
			_buyBtn.y = 143;
			
			this.width = bg.width;
			this.height = bg.height;
		}
		
		
		override public function set data(value:Object):void
		{
			if(BlackMarketModel.inst.optFromType != 3)
			{
				_tween = TweenMax.to(_tweenSp , .1 , {alpha:0 , onComplete:ontweenSpAlpha});
				playItemEff();
			}
			_pro = value as PRO_BlackMarketItem;
			
			
			if(_pro.status == CAN_BUY)
			{
				if(!_buyBtn.hasEventListener(MouseEvent.CLICK))
				{
					_buyBtn.addEventListener(MouseEvent.CLICK,onBuy);
				}
				_buyBtn.locked = false;
			}
			else
			{
				_buyBtn.locked = true;
			}
			
		}
		/**
		 * 播放item数据变动的特效 
		 * 
		 */		
		private function playItemEff():void
		{
			_itemSpecialEff.visible = true;
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(_itemSpecialEff,.6,1,_itemSpecialEff.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			function over(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , over);
				
				_itemSpecialEff.visible = false;
			}
		}
		
		private function ontweenSpAlpha():void
		{
			_itemVo = RandomItemManager.inst.getVoById(_pro.id);
			var propBase:PropBaseVo = ItemManager.instance.getPropById(_itemVo.item_id);
			_item.propVo = propBase;
			_item.num = "x" + _itemVo.item_num;
			
			_nameLb.text = propBase.name;
			_nameLb.color = GameDictionary.getColorByQuality(propBase.quality);
			
			_costLb.iconId = _itemVo.itemCost.itemId;
			_costLb.text = _itemVo.itemCost.itemCostNum + "";
			_tween = TweenMax.to(_tweenSp , .2 , {alpha:1,delay:.3});
		}
		
		protected function onBuy(event:MouseEvent):void
		{
			var moneyProp:PropBaseVo = ItemManager.instance.getPropById(_itemVo.itemCost.itemId);
			if(moneyProp.itemId == MoneyDict.YUANBAO)
			{
				var propBase:PropBaseVo = ItemManager.instance.getPropById(_itemVo.item_id);
				var str:String = "是否花费"+GameDictionary.createCommonText(_itemVo.itemCost.itemCostNum + moneyProp.name,GameDictionary.ORANGE)+ "购买" + _itemVo.item_num
					+ "个" + GameDictionary.createCommonText(propBase.name,GameDictionary.getColorByQuality(propBase.quality)) + "?";
				ItemCost.showAlert("blackMarketBuyItem",doBuy,str);
			}
			else
			{
				doBuy();
			}
		}	
		
		private function doBuy():void
		{
			if(ItemCost.canUseSingCost(_itemVo.itemCost))
			{
				dispatchEvent(new BlackMarketEvent(BlackMarketEvent.BUYITEM,itemIndex + 1));
			}
		}
		
		
		override public function clear():void
		{
			_buyBtn.removeEventListener(MouseEvent.CLICK,onBuy);
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
			_item.clear();
			_itemSpecialEff.stop();
			removeChild(_itemSpecialEff);
		}
	}
}