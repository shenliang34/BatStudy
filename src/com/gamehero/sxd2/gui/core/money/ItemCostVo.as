package com.gamehero.sxd2.gui.core.money
{
	/**
	 * 物品消耗
	 * @author weiyanyu
	 * 创建时间：2015-10-12 下午5:42:53
	 * 
	 */
	public class ItemCostVo
	{
		public function ItemCostVo(cost:String = null)
		{
			if(cost && cost != "")
			{
				setProp(cost);
			}
		}
		
		/**
		 * 物品id 
		 */	
		public var itemId:int;
		/**
		 * 物品消耗 
		 */	
		public var itemCostNum:int;
		
		
		/**
		 * 设置消耗数据
		 * @param cost 消耗的统一格式
		 * 
		 */		
		public function setProp(cost:String):void
		{
			var arr:Array = cost.split("-");
			itemId = arr[0];
			itemCostNum = arr[1];
		}
	}
}