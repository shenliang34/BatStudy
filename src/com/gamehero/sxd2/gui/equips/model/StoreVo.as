package com.gamehero.sxd2.gui.equips.model
{
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-10-15 下午3:01:37
	 * 
	 */
	public class StoreVo
	{
		public function StoreVo()
		{
		}
		/**
		 * 物品id 
		 */		
		public var itemId:int;
		/**
		 * 消耗货币 
		 */		
		public var cost:ItemCostVo;
		
		public function fromXML(x:XML):void
		{
			itemId = x.@item_id;
			
			cost = new ItemCostVo(x.@remove_item);
		}
	}
}