package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.EquipStrengthenVo;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 有装备，已经强化到最高级 
	 * @author weiyanyu
	 * 创建时间：2015-9-14 下午2:04:42
	 * 
	 */
	public class EquipOprateContMaxLv extends EquipOprateContBase implements IPanel
	{
		
		private var _prop0:Label;
		
		private var _prop1:Label;
		
		public function EquipOprateContMaxLv()
		{
			super();
			
			_prop0 = new Label();
			addChild(_prop0);
			_prop0.color = GameDictionary.WINDOW_WHITE;
			_prop0.x = 398;
			_prop0.y = 321;
			
			_prop1 = new Label();
			addChild(_prop1);
			_prop1.color = GameDictionary.WINDOW_WHITE;
			_prop1.x = 398;
			_prop1.y = 341;
			
			var label:Label = new Label();
			label = new Label();
			label.text = "强化等级不能超过伙伴等级";
			label.x = 341 + (190 - label.width >> 1);
			label.y = 404;
			addChild(label);
			label.color = GameDictionary.BLUE;
		}
		
		public function init():void
		{
			
		}
		
		public function set data(value:PRO_Item):void
		{
			_itemCell.data = value;
			var prop:PropBaseVo = ItemManager.instance.getPropById(value.itemId);
			if(value.addLevel > 0)
			{
				setLabel(prop.name + "  " + value.addLevel + "级",GameDictionary.getColorByQuality(prop.quality));
			}
			else
			{
				setLabel(prop.name,GameDictionary.getColorByQuality(prop.quality));
			}
		
			var equipLv:EquipStrengthenVo = EquipStrengthenManager.getInstance().voList[value.addLevel];
			_prop0.text = Lang.instance.trans("item_prop_" + prop.prop0[0]) + "   " + int(int(prop.prop0[1]) + int(prop.prop0[1]) * equipLv.percent /100);
			if(prop.prop1[0] == 0)
			{
				_prop1.text = "";
			}
			else
			{
				_prop1.text = Lang.instance.trans("item_prop_" + prop.prop1[0]) + "   " + int(int(prop.prop1[1]) + int(prop.prop1[1]) * equipLv.percent / 100);
			}
		}
		
		public function clear():void
		{
			_itemCell.clear();
		}
	}
}