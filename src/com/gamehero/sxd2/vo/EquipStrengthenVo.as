package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;

	/**
	 * 装备强化
	 * @author weiyanyu
	 * 创建时间：2015-9-15 上午11:10:14
	 * 
	 */
	public class EquipStrengthenVo
	{
		public function EquipStrengthenVo()
		{
		}
		/**
		 * 强化等级 
		 */		
		public var level:int;
		/**
		 * 提升百分比 
		 */		
		public var percent:int;
		/**
		 * 灵戒 金币消耗数量
		 */		
		public var ring:ItemCostVo;
		/**
		 * 武器 
		 */		
		public var weapon:ItemCostVo;
		/**
		 * 护符 
		 */		
		public var neck:ItemCostVo;
		/**
		 * 玉冠 
		 */		
		public var head:ItemCostVo;
		/**
		 * 玉袍
		 */		
		public var clothes:ItemCostVo;
		/**
		 * 玉冠 
		 */		
		public var shoes:ItemCostVo;
		
		public function fromXML(xml:XML):void
		{
		 	level = xml.@level;
			percent = xml.@percent;
			ring = new ItemCostVo(xml.@ring);
			weapon = new ItemCostVo(xml.@weapon);
			neck = new ItemCostVo(xml.@neck);
			head = new ItemCostVo(xml.@head);
			clothes = new ItemCostVo(xml.@clothes);
			shoes = new ItemCostVo(xml.@shoes);
		}
	}
}