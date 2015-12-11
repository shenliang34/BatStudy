package com.gamehero.sxd2.gui.bag.model
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.manager.GameItemEffect;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.quickUse.QuickUseManager;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ITEM_ACK;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.netease.protobuf.UInt64;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * 背包道具
	 * @author weiyanyu
	 * 创建时间：2015-8-7 下午1:49:47
	 * 
	 */
	public class BagModel extends EventDispatcher
	{
		private static var _instance:BagModel;

		public static function get inst():BagModel
		{
			if(_instance == null)
				_instance = new BagModel();
			return _instance;
		}
		public function BagModel()
		{
			if(_instance != null)
				throw "BagModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		public var domain:ApplicationDomain;
		/**
		 * 背包格子字典，方便查找 ,key id
		 * 绑定的是格子内的数据
		 */		
		private var itemCellsDict:Dictionary = new Dictionary();
		
		/**
		 * 伙伴信息
		 * */
		private var _heros:Dictionary = new Dictionary();
		
		/**
		 * 根据唯一id来拿到物品 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:UInt64):PRO_Item
		{
			if(id == null) return null;
			return itemCellsDict[id.toString()];
		}
		
		/**
		 * 背包物品 数据
		 */
		public function get itemArr():Array
		{
			var itemArr:Array = [];
			
			var propBaseVo:PropBaseVo;
			var num:int;
			for each(var item:PRO_Item in itemCellsDict)
			{
				if(item.occupied) continue;
				propBaseVo = ItemManager.instance.getPropById(item.itemId);
				if(propBaseVo.type == ItemTypeDict.HERO_CHIPS) continue;
				itemArr.push(item);
			}
			itemArr.sort(sortBagItem);
			return itemArr;
		}
		
		private function sortBagItem(paraA:PRO_Item,paraB:PRO_Item):int
		{
			if(paraA.itemId > paraB.itemId)
			{
				return 1;
			}
			else if(paraA.itemId < paraB.itemId)
			{
				return -1;
			}
			else 
			{
				if(paraA.num > paraB.num)
				{
					return -1;
				}
				else if(paraA.num < paraB.num)
				{
					return 1;
				}
				else
				{
					return 0;	
				}
			}
		}
			
		/**
		 * 是否是第一次更新数据 
		 */		
		private var _isFirstUpdata:Boolean = true;
		/**
		 * 更新背包道具 
		 * @param data
		 * 
		 */		
		public function updata(data:MSG_UPDATE_ITEM_ACK):void
		{
			var id:String;//道具的id
			
			if(_isFirstUpdata)
			{
				for each(var item:PRO_Item in data.item)
				{
					id = item.id.toString();
					itemCellsDict[id] = item;
				}
				_isFirstUpdata = false;
			}
			else
			{
				for each(var item1:PRO_Item in data.item)
				{
					id = item1.id.toString();
					
					if(item1.num == 0)//删除道具
					{
						itemCellsDict[id] = null;
						delete itemCellsDict[id];
					}
					else//修改道具数量或者添加道具
					{
						var itemPro:PRO_Item = itemCellsDict[id];
						if(itemPro)//背包中有这个道具
						{
							if(itemPro.num < item1.num)//道具数量增加
							{
								showTips(itemPro,item1.num - itemPro.num);
							}
						}
						else//背包中本来不存在这个道具，添加进来
						{
							showTips(item1,item1.num);
						}
						itemCellsDict[id] = item1;
					}
				}
				dispatchEvent(new BagEvent(BagEvent.ITEM_UPDATA_SINGLE,data.item));//背包更新
			}
		}
		
		private function showTips(itemPro:PRO_Item,num:int):void
		{
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(itemPro.itemId);
			if(propBaseVo.type != ItemTypeDict.HERO_CHIPS)
			{
				GameItemEffect.inst.show(itemPro.itemId);
			}
			FloatTips.inst.show(propBaseVo.name + "  x" + num);
			
			if(propBaseVo.canQuick)
				QuickUseManager.inst.show(itemPro);
		}
		
		/**
		 * 获得当前位置的可穿戴装备
		 * @param loc
		 * @return 
		 * 
		 */		
		public function getLocEquip(loc:int):Array
		{
			var propVo:PropBaseVo;
			var canEquipList:Array  = new Array();
			for each(var item:PRO_Item in itemCellsDict)
			{
				propVo = ItemManager.instance.getPropById(item.itemId);
				if(propVo.subType != loc || propVo.type != ItemTypeDict.EQUIP)//如果非对应位置  或者 非装备 ，则跳过去
				{
					continue;
				}
				if(propVo.levelLimited > GameData.inst.playerInfo.level)//等级限制
				{
					continue;
				}
				if(item.occupied)
					continue;
				canEquipList.push(item);
			}
			return canEquipList;
		}
		/**
		 * 获得道具的数量 
		 * @param itemId
		 * @return 
		 * 
		 */		
		public function getItemNum(itemId:int):int
		{
			var num:int;
			for each(var item:PRO_Item in itemCellsDict)
			{
				if(item.itemId == itemId)
				{
					num += item.num;
				}
			}
			return num;
		}
		/**
		 * 获取有相同物品id的格子 
		 * @return 
		 * 
		 */		
		public function getHasSameItemId(itemId:int):Array
		{
			var arr:Array = new Array();
			for each(var item:PRO_Item in itemCellsDict)
			{
				if(item.itemId == itemId)
				{
					arr.push(item);
				}
			}
			return arr;
		}
		/**
		 * 获取 该物品 最大堆叠数量的格子</br>
		 * 在一些情况下使用道具，希望使用的是最大数量，而非本身格子数量；如快速使用功能。
		 * @return 
		 * 
		 */		
		public function getMaxPileItem(itemId:int):PRO_Item
		{
			var returnItem:PRO_Item;
			var arr:Array = getHasSameItemId(itemId);
			var prop:PropBaseVo = ItemManager.instance.getPropById(itemId);
			for each(var item:PRO_Item in arr)
			{
				if(item.num == prop.pileNum)
				{
					return item;//如果找到最大堆叠的物品，则返回
				}
				else
				{
					returnItem = item;
				}
			}
			return returnItem;
		}
		
		
		/**
		 * 获取背包中伙伴碎片数据
		 * */
		public function getSoulNum(itemId:int):int
		{
			
			var num:int;
			for each(var item:PRO_Item in itemCellsDict)
			{
				if(item.itemId == itemId)
				{
					num += item.num;
				}
			}
			return num;
			
			return 0;
		}
		
	}
}