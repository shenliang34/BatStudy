package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	/**
	 * 无装备，背包有 可穿戴装备
	 * @author weiyanyu
	 * 创建时间：2015-9-14 下午2:04:02
	 * 
	 */
	public class EquipOprateContNoEquip extends EquipOprateContBase implements IPanel
	{
		
		/**
		 * 道具展示 
		 */		
		private var _item:EquipRenderItem;
		/**
		 * 穿戴装备按钮 
		 */		
		private var _equipBtn:Button;
		
		private var _data:PRO_Item;
		public function EquipOprateContNoEquip()
		{
			super();
			initUI();
		}
		
		private function initUI():void
		{
			
			setLabel("该部位没有穿戴装备",GameDictionary.ORANGE);
			
			var lb:Label = new Label();
			addChild(lb);
			lb.x = 401;
			lb.y = 378;
			//			lb.text = "背包内装备";
			lb.color = GameDictionary.BLUE;
			
			_item = new EquipRenderItem();
			_item.x = 344;
			_item.y = 306;
			addChild(_item);
			
			_equipBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			_equipBtn.x = 400;
			_equipBtn.y = 400;
			addChild(_equipBtn);
			_equipBtn.width = 68;
			_equipBtn.height = 32;
			_equipBtn.label = "快速装备";
		}
		
		public function init():void
		{
			_equipBtn.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
			_equipBtn.addEventListener(MouseEvent.CLICK,onEquip);
		}
		
		protected function onEquip(event:MouseEvent):void
		{
			HeroModel.instance.itemHeroEquip(_data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON,EquipModel.inst.curSelectedId);
		}
		public function set data(value:PRO_Item):void
		{
			_data = value;
			_item.data = value;
			_itemCell.y = itemY;
			_itemCell.data = value;
		}
		
		public function clear():void
		{
			_equipBtn.removeEventListener(MouseEvent.CLICK,onEquip);
			_data = null;
		}
	}
}