package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * 道具
	 * @author weiyanyu
	 * 创建时间：2015-8-7 上午11:12:57
	 * 
	 */
	public class ItemManager
	{
		
		private static var _instance:ItemManager;
		
		private var ITEMS:Dictionary = new Dictionary();
		private var itemXMLList:XMLList;
		
		public function ItemManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.itemXMLList = settingsXML.items.items;
		}
		
		
		public static function get instance():ItemManager {
			
			return _instance ||= new ItemManager();
		}
		
		
		/**
		 * 获取某个道具
		 * */
		public function getPropById(id:int):PropBaseVo
		{
			var item:PropBaseVo = ITEMS[id];
			if(item == null)
			{
				var x:XML = GameTools.searchXMLList(itemXMLList , "item_id" , id);
				if(x)
				{
					item = new PropBaseVo();
					// 配置表属性
					item.fromXML(x);
				}
				else
				{
					Logger.warn(BattleUnitManager , "找不到道具.. item_id = " + id);
				}
			}
			return item;
		}
		/**
		 * ，获得奖励的礼包 
		 * @param itemId 通过礼包类型的道具
		 * @return 返回必然获得/几率获得
		 * 
		 */		
		public function getBoxItemList(itemId:int):Vector.<Vector.<GiftBoxVo>>
		{
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(itemId);
			return getMustProList(propBaseVo.proValue);
		}
		/**
		 * 获取必然/几率获取的道具列表 
		 * @param idArr 礼包奖励列表
		 * @return 
		 * 
		 */		
		public function getMustProList(idArr:Array):Vector.<Vector.<GiftBoxVo>>
		{
			var mustList:Vector.<GiftBoxVo> = new Vector.<GiftBoxVo>();
			var probList:Vector.<GiftBoxVo> = new Vector.<GiftBoxVo>();
			
			var boxVo:GiftBoxVo;
			for each(var boxId:String in idArr)
			{
				boxVo = GiftBoxManager.instance.getBoxById(int(boxId));
				if(boxVo)
				{
					if(boxVo.type == 0)
					{
						probList.push(boxVo);
					}
					else
					{
						mustList.push(boxVo);
					}
				}
			}
			return new <Vector.<GiftBoxVo>>[mustList,probList];
		}
	}
}