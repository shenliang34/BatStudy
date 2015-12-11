package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.equips.event.EquipEvent;
	import com.gamehero.sxd2.gui.equips.model.StoreVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.StoreManager;
	
	import flash.events.MouseEvent;
	
	/**
	 * 无装备，背包也没有 
	 * @author weiyanyu
	 * 创建时间：2015-9-14 下午2:04:16
	 * 
	 */
	public class EquipOprateContNoEquipNoBag extends EquipOprateContBase implements IPanel
	{
		/**
		 * 花费 
		 */		
		private var _cost:MoneyLabel;
		/**
		 * 购买按钮 
		 */		
		private var _buyBtn:Button;
		
		public function EquipOprateContNoEquipNoBag()
		{
			super();
			var label:Label = new Label();
			label.text = "你还没有获得此装备，\n我们为你准备了一件.";
			label.leading = 1;
			label.color = GameDictionary.BLUE;
			label.width = 116;
			label.height = 40;
			addChild(label);
			label.x = 376;
			label.y = 318;
			
			_cost = new MoneyLabel();
			addChild(_cost);
			_cost.x = 402;
			_cost.y = 374;
			
			_buyBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			addChild(_buyBtn);
			_buyBtn.x = 400;
			_buyBtn.y = 400;
			_buyBtn.label = "购买";
			_buyBtn.width = 68;
			_buyBtn.height = 32;
		}
		public function init():void
		{
			_buyBtn.addEventListener(MouseEvent.CLICK,onBuy);
		}
		
		protected function onBuy(event:MouseEvent):void
		{
			if(ItemCost.canUseSingItem([_itemCost.itemId,_itemCost.itemCostNum]))
			{
				dispatchEvent(new EquipEvent(EquipEvent.BUY_ITEM,_itemCell.propVo));
			}
		}
		
		public function set data(prop:PropBaseVo):void
		{
			_itemCell.propVo = prop;
			setLabel(prop.name,GameDictionary.getColorByQuality(prop.quality));
			var storeVo:StoreVo = StoreManager.inst.getVoById(prop.itemId);
			_itemCost = storeVo.cost;
			_cost.iconId = _itemCost.itemId;
			_cost.text = _itemCost.itemCostNum + "";
			if(GameData.inst.playerExtraInfo.coin >= _itemCost.itemCostNum)
			{
				_cost.lb.color = GameDictionary.ORANGE;
			}
			else
			{
				_cost.lb.color = GameDictionary.RED;
			}
			_itemCell.y = itemY;
		}
		
		public function clear():void
		{
			_buyBtn.removeEventListener(MouseEvent.CLICK,onBuy);
			_itemCell.clear();
		}
	}
}