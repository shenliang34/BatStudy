package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Shape;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-10 下午6:30:37
	 * 
	 */
	public class EquipRenderItem extends ActiveObject implements ICellData
	{
		/**
		 * 强化到最高级 
		 */		
		public static var MAX_LV:int = 1;
		/**
		 * 没有穿戴装备，背包里有可推荐的 
		 */		
		public static var NO_EQUIP:int = 2;
		/**
		 * 没有装备，背包里也没推荐的 
		 */		
		public static var NO_EQUIP_NO_BAG:int = 3;
		/**
		 * 装备没有达到最高级 
		 */		
		public static var NO_MAX_LV:int = 4;
		
		private var _data:PRO_Item;
		/**
		 * 呈现项索引 
		 */		
		private var _itemIndex:int;
		
		private var _equipLoc:int;
		/**
		 * 物品格子 
		 */		
		private var _itemIcon:ItemCell;
		/**
		 * 名字 
		 */		
		private var _nameLabel:Label;
		/**
		 * 强化等级 
		 */		 
		private var _levelLabel:Label;
		
		private var _status:int;
		
		private var _prop:PropBaseVo;
		
		private var RecommendList:Vector.<int> = new <int>[12010011,12020011,12030011,12040011,12050011,12060011];
		
		
		public function EquipRenderItem()
		{
			super();
			
			_itemIcon = new ItemCell();
			addChild(_itemIcon);
			_itemIcon.x = 4;
			_itemIcon.y = 4;
			
			_nameLabel = new Label();
			_nameLabel.x = 68;
			_nameLabel.y = 11;
			addChild(_nameLabel);
			
			_levelLabel = new Label();
			_levelLabel.x = 68;
			_levelLabel.y = 35;
			addChild(_levelLabel);
			
			var shap:Shape = new Shape();
			shap.graphics.beginFill(0,0);
			shap.graphics.drawRect(0,0,177,60);
			shap.graphics.endFill();
			addChild(shap);
		}
		
		
		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			_status = value;
		}

		/**
		 * 装备的位置 
		 * @return 
		 * 
		 */
		public function get equipLoc():int
		{
			return _equipLoc;
		}

		public function set equipLoc(value:int):void
		{
			_equipLoc = value;
		}
		private var _itemCellData:ItemCellData = new ItemCellData();
		/**
		 * 格子信息，来源；基础数据；服务器数据； 
		 */
		public function get itemCellData():ItemCellData
		{
			_itemCellData.data = data;
			return _itemCellData;
		}
		
		public function get data():PRO_Item
		{
			return _data;
		}

		public function set data(value:PRO_Item):void
		{
			_data = value;
			_itemIcon.data = value;
			if(value)//如果此处有装备
			{
				this.hint = _itemIcon.propVo.name;
				_nameLabel.text = _itemIcon.propVo.name;
				if(data.addLevel == EquipStrengthenManager.getInstance().voList.length - 1 || data.addLevel >= GameData.inst.playerInfo.level)
				{
					status = MAX_LV;
				}
				else
				{
					status = NO_MAX_LV;
				}
				_levelLabel.text = value.addLevel + "级";
				_levelLabel.visible = true;
				_levelLabel.color = GameDictionary.WINDOW_BLUE;
				_nameLabel.color = GameDictionary.getColorByQuality(_itemIcon.propVo.quality);
			}
			else//没有装备则从背包里面找
			{
				this.hint = "";
				if(getRecommend(equipLoc))
				{
					_data = getRecommend(equipLoc);
					status = NO_EQUIP;
				}
				else
				{
					status = NO_EQUIP_NO_BAG;
				}
				_prop = ItemManager.instance.getPropById(RecommendList[equipLoc - 1]);
				_levelLabel.visible = false;
				_nameLabel.color = GameDictionary.WINDOW_BLUE;
				_nameLabel.text = _prop.name;
			}
		}
		/**
		 * 获取推荐装备 
		 * @param equipLoc
		 * @return 
		 * 
		 */		
		public static function getRecommend(equipLoc:int):PRO_Item
		{
			var propVo:PropBaseVo;//
			var canEquipList:Array  = BagModel.inst.getLocEquip(equipLoc);
			if(canEquipList.length > 0)
			{
				canEquipList.sortOn("addLevel" , Array.DESCENDING);
				var addlevel:int = (canEquipList[0] as PRO_Item).addLevel;//最高的强化等级
				var addLvList:Array = new Array();//强化等级最高的列表
				var proPropVo:ProPropVo;
				for each(var pro:PRO_Item in canEquipList)//找到高强化等级的装备
				{
					if(pro.addLevel == addlevel)
					{
						propVo = ItemManager.instance.getPropById(pro.itemId);
						proPropVo = new ProPropVo();
						proPropVo.pro = pro;
						proPropVo.quality = propVo.quality;
						proPropVo.levelLimited = propVo.levelLimited;
						addLvList.push(proPropVo);
					}
				}
				addLvList.sortOn("levelLimited" , Array.DESCENDING);
				var maxLevelLimited:int = addLvList[0].levelLimited;
				var lvList:Array = new Array();//等级限制最高的列表
				for each(var pp:ProPropVo in addLvList)//在高强化的装备里找到高等级的装备
				{
					if(pp.levelLimited == maxLevelLimited)
					{
						lvList.push(pp);
					}
				}
				lvList.sortOn("quality" , Array.DESCENDING);
				var maxQuily:int = lvList[0].quality;
				var quilyList:Array = new Array();//品质最高的列表
				for each(pp in lvList)//在高等级的装备里面找到高品质的
				{
					if(pp.quality == maxQuily)
					{
						quilyList.push(pp);
					}
				}
				return quilyList[0].pro;
			}
			else
			{
				return null;
			}
		}
		
		public function get prop():PropBaseVo
		{
			return _prop;
		}
		
		
		
		public function get itemIndex():int
		{
			return _itemIndex;
		}
		
		public function set itemIndex(value:int):void
		{
			_itemIndex = value;
			_itemIcon.setBackGroud(Global.instance.getBD(EquipModel.inst.domain,"equip_" + value));
		}
		
		/**
		 * 打扫卫生 
		 */		
		public function clear():void
		{
			_data = null;
			_itemIcon.clear();
		}
	}
}
import com.gamehero.sxd2.pro.PRO_Item;

class ProPropVo
{
	/**
	 * 物品
	 */	
	public var pro:PRO_Item;
	/**
	 * 品质 
	 */	
	public var quality:int;
	/**
	 * 等级限制 
	 */	
	public var levelLimited:int;
}