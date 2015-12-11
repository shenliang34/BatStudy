package com.gamehero.sxd2.gui.blackMarket.model
{
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午4:23:30
	 * 
	 */
	public class RandomItemVo
	{
		public function RandomItemVo()
		{
		}
		/**
		 * 商品id 
		 */		
		public var id:int;
		/**
		 *  物品id
		 */		
		public var item_id:int;
		/**
		 *  物品堆叠数量
		 */		
		public var item_num:int;
		/**
		 * 消耗 
		 */		
		public var itemCost:ItemCostVo;
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			item_id = xml.@item_id;
			item_num = xml.@item_num;
			
			itemCost = new ItemCostVo();
			var costArr:Array = String(xml.@remove_item).split("-");
			itemCost.itemId = int(costArr[0]);
			itemCost.itemCostNum = int(costArr[1]);
		}
	}
}