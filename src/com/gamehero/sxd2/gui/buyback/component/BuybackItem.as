package com.gamehero.sxd2.gui.buyback.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.buyback.BuyBackEvent;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyIcon;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * 黑市呈现项
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午3:44:16
	 * 
	 */
	public class BuybackItem extends ItemRender implements ICellData
	{
		/**
		 */		
		private var _item:ItemCell;
		
		private var _name:Label;
		
		
		private var _pro:PRO_Item;
		
		private var _moneyLb:MoneyLabel;
		
		
		public function BuybackItem()
		{
			super();
			
			var bg:Bitmap = new Bitmap(Global.instance.getBD(BuybackWindow.uiDomain,"ItemBg"));
			addChild(bg);
			_item = new ItemCell();
			addChild(_item);
			_item.x = 8;
			_item.y = 8;
			_item.mouseEnabled = false;
			_item.mouseChildren = false;
			
			_name = new Label();
			_name.color = GameDictionary.WINDOW_BLUE;
			addChild(_name);
			_name.x = 72;
			_name.y = 15;
			_moneyLb = new MoneyLabel();
			addChild(_moneyLb);
			_moneyLb.y = 41;
			_moneyLb.iconId = MoneyDict.TONG_QIAN;
			_moneyLb.lb.color = GameDictionary.ORANGE;
			
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xff0000,.01);
			shape.graphics.drawRect(0,0,197,66);
			shape.graphics.endFill();
			addChild(shape);
			this.width = 197;
			this.height = 66;
		}
		
		public function init():void
		{
			
		}
		override public function set data(value:Object):void
		{
			_pro = BagModel.inst.getItemById(value as UInt64);
			_item.data = _pro;
			if(_pro)
			{
				var propVo:PropBaseVo = ItemManager.instance.getPropById(_pro.itemId);
				_name.text = propVo.name;
				_moneyLb.text = propVo.cost.itemCostNum + "";
				_moneyLb.x = 153;
				this.hint = "BuybackItem";
			}
			else
			{
				this.hint = "";
			}
			_moneyLb.visible = _pro != null;
		}
		private var _itemCellData:ItemCellData = new ItemCellData();
		public function get itemCellData():ItemCellData
		{
			_itemCellData.data = _pro;
			_itemCellData.itemSrcType = ItemSrcTypeDict.BUY_BACK;
			return _itemCellData;
		}
		
		override public function onClick():void
		{
			if(_pro != null)
			{
				var options:Array = [];
				options.push(new OptionData(MenuPanel.BUY_BACK , "回购"));
				MenuPanel.instance.initOptions(options);
				MenuPanel.instance.showLater(_pro , App.topUI);
			}
		}
		/**
		 * 双击购买 
		 * 
		 */		
		override public function onDoubleClick():void
		{
			MenuPanel.instance.hide();
			if(_pro != null)
			{
				dispatchEvent(new BuyBackEvent(BuyBackEvent.BUY_BACK,_pro.id));
			}
		}
		
		override public function clear():void
		{
			super.clear();
			_item.clear();
			MenuPanel.instance.hide();
		}
	}
}