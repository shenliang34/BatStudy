package com.gamehero.sxd2.gui.bag.model.vo
{
	import com.gamehero.sxd2.pro.PRO_Item;

	/**
	 * 格子信息
	 * 包括物品来源；物品服务器数据；物品基础数据
	 * @author weiyanyu
	 * 创建时间：2015-9-23 下午10:00:06
	 * 
	 */
	public class ItemCellData
	{
		/**
		 *  物品来源
		 */		
		public var itemSrcType:int;
		/**
		 *  物品服务器数据
		 */		
		public var data:PRO_Item;
		/**
		 * 物品基础数据 
		 */		
		public var propVo:PropBaseVo;
		
		public function ItemCellData()
		{
		}
	}
}