package com.gamehero.sxd2.vo
{
	/**
	 * 宝箱
	 * @author weiyanyu
	 * 创建时间：2015-8-28 下午3:14:33
	 * 
	 */
	public class GiftBoxVo
	{
		public function GiftBoxVo()
		{
		}
		/**
		 * 掉落id 
		 */		
		public var id:int;
		/**
		 * 必然掉落or几率掉落  
		 * 必然掉落为 1 ；几率掉落为0 
		 */		
		public var type:int;
		/**
		 * 获得物品 
		 */		
		public var items:Array;
		
		
		/**
		 * 道具id 
		 */		 
		public var itemArr:Array;
		/**
		 * 最小数量 
		 */		
		public var  minNumArr:Array;
		/**
		 * 最大数量 
		 */		
		public var maxNumArr:Array;
		/**
		 * 掉率 
		 */		
		private var rate:Number;
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			rate = (xml.@rate) / 10000;
			
			itemArr = String(xml.@item_id).split("^");
			minNumArr = String(xml.@min_num).split("^");
			maxNumArr = String(xml.@max_num).split("^");
		
			items = new Array();
			
			var item:GiftBoxItemVo;
			if(rate >= 1)
			{
				if(itemArr.length == 1)
				{
					type = 1;
				}
			}
			for(var i:int in minNumArr)
			{
				item = new GiftBoxItemVo();
				item.dropId = itemArr[i];
				item.min = minNumArr[i];
				item.max = maxNumArr[i];
				items.push(item);
			}
		}
	}
}

