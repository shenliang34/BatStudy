package com.gamehero.sxd2.gui.equips.equipStrengthen
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipOprateContBase;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipOprateContMaxLv;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipOprateContNoEquip;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipOprateContNoEquipNoBag;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipOprateContNoMaxLv;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipRenderItem;
	
	/**
	 * 装备操作区
	 * @author weiyanyu
	 * 创建时间：2015-9-14 下午1:46:20
	 * 
	 */
	public class EquipOprateCont extends Sprite
	{
		/**
		 * 数据 
		 */		
		private var _dataItem:EquipRenderItem;
		
		private var _equipManager:EquipStrengthenManager;
		
		/**
		 * 有橙色框的格子背景 
		 */		
		private var _itemBg_orange:Bitmap;
		/**
		 * 蓝色框框的格子背景 
		 */		
		private var _itemBg_blue:Bitmap;
		
		private var _panelList:Vector.<IPanel> = new Vector.<IPanel>();
		
		/**
		 * 无装备，背包有  
		 */		
		private var _contentContNoEquip:EquipOprateContNoEquip;//
		/**
		 * 无装备，背包也没有  
		 */		
		private var _contentNoEquipNoBag:EquipOprateContNoEquipNoBag;//无装备，背包也没有 
		/**
		 *  有装备，没有强化到最高级 
		 */		
		private var _contentNoMaxLv:EquipOprateContNoMaxLv;//有装备，没有强化到最高级 
		/**
		 *  有装备，已经强化到最高级 
		 */		
		private var _contentMaxLv:EquipOprateContMaxLv;//有装备，已经强化到最高级 
		
		private var _curContent:IPanel;
		
		public function EquipOprateCont()
		{
			super();
			_equipManager = EquipStrengthenManager.getInstance();
			
			var global:Global = Global.instance;
			var bg:Bitmap = new Bitmap(global.getBD(EquipModel.inst.domain,"NoMaxLvBg"));
			addChild(bg);
			bg.x = 208;
			bg.y = 98;
			
			_itemBg_orange = new Bitmap(global.getBD(EquipModel.inst.domain,"itemBg1"));
			_itemBg_blue = new Bitmap(global.getBD(EquipModel.inst.domain,"itemBg2"));
			addChild(_itemBg_orange);
			addChild(_itemBg_blue);
			
			_itemBg_orange.x = 206;
			_itemBg_orange.y = 76;
			_itemBg_blue.x = 369;
			_itemBg_blue.y = 121;
			
			
			_contentContNoEquip = new EquipOprateContNoEquip();
			_contentNoEquipNoBag = new EquipOprateContNoEquipNoBag();
			_contentNoMaxLv = new EquipOprateContNoMaxLv();
			_contentMaxLv = new EquipOprateContMaxLv();
			
			_panelList.push(_contentContNoEquip);
			_panelList.push(_contentNoEquipNoBag);
			_panelList.push(_contentNoMaxLv);
			_panelList.push(_contentMaxLv);
			
			addChild(_contentContNoEquip);
			addChild(_contentNoEquipNoBag);
			addChild(_contentNoMaxLv);
			addChild(_contentMaxLv);
			resetContentVisible();
		}
		
		private function resetContentVisible():void
		{
			for(var i:int = 0; i < _panelList.length; i++)
			{
				_panelList[i].clear();
				(_panelList[i] as Sprite).visible = false;
			}
		}
		
		/**
		 *  
		 * @param pro 装备信息
		 * @param isSelected 是否切页签
		 */		
		public function setData(item:EquipRenderItem,isSelected:Boolean = false):void
		{
			resetContentVisible();
			_dataItem = item;
			if(_curContent)(_curContent as EquipOprateContBase).stop();
			switch(item.status)
			{
				case EquipRenderItem.MAX_LV:
					_curContent = _contentMaxLv;
					_contentMaxLv.data = item.data;
					_itemBg_orange.visible = true;
					_itemBg_blue.visible = false;
					break;
				case EquipRenderItem.NO_MAX_LV:
					_curContent = _contentNoMaxLv;
					_contentNoMaxLv.data = item.data;
					_itemBg_orange.visible = true;
					_itemBg_blue.visible = false;
					break;
				case EquipRenderItem.NO_EQUIP_NO_BAG:
					_curContent = _contentNoEquipNoBag;
					_contentNoEquipNoBag.data = item.prop;
					_itemBg_orange.visible = true;
					_itemBg_blue.visible = false;
					break;
				case EquipRenderItem.NO_EQUIP:
					_curContent = _contentContNoEquip;
					_contentContNoEquip.data = item.data;
					_itemBg_orange.visible = false;
					_itemBg_blue.visible = true;
					break;
				
			}
			_curContent.init();
			if(isSelected)
			{
				(_curContent as EquipOprateContBase).playChangePage();
			}
			(_curContent as Sprite).visible = true;
		}
		
		public function playMc():void
		{
			if(_curContent == _contentNoMaxLv)
			{
				_contentNoMaxLv.playMc();
			}
		}
		
		public function clear():void
		{
			_curContent = null;
			_dataItem = null;
			for(var i:int = 0; i < _panelList.length; i++)
			{
				_panelList[i].clear();
			}
		}
	}
}