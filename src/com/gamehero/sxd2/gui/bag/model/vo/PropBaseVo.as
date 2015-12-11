package com.gamehero.sxd2.gui.bag.model.vo
{
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.BaseVO;

	/**
	 * 道具基类
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午8:01:00
	 * 
	 */
	public class PropBaseVo extends BaseVO
	{
		/**
		 * 道具ico路径 
		 */		
		public var ico:String;
		
		public var itemId:int;
		/**
		 * 大类 
		 */		
		public var type:int;
		/**
		 * 子类 
		 */		
		public var subType:int;
		/**
		 * 等级限制 
		 */		
		public var levelLimited:int;
		/**
		 * 职业需求 
		 */		
		public var job:int;
		/**
		 * 种族 
		 */		
		public var race:int;
		/**
		 * 品质 
		 */		
		public var quality:int;
		/**
		 * 堆叠数量 
		 */		
		public var pileNum:int;
		
		public var name:String;
		
		public var tips:String;
		/**
		 * 出售/回购消耗货币
		 */		
		public var cost:ItemCostVo;
		/**
		 * 能否出售 
		 */		
		public var price_limit:Boolean;
		/**
		 * 属性值 
		 */		
		public var proValue:Array;
		/**
		 * 属性增强0 
		 */		
		public var prop0:Array;
		/**
		 * 属性增强1 
		 */		
		public var prop1:Array;
		/**
		 * 是否弹出快速使用框 
		 */		
		public var canQuick:Boolean;
		
		
		public function PropBaseVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			itemId = xml.@item_id;
			type = xml.@type;
			subType = xml.@sub_type;
			name = Lang.instance.trans(xml.@name);
			levelLimited = xml.@level_limit;
			tips = Lang.instance.trans(xml.@tips);
			ico = xml.@icon;
			job = xml.@job;
			cost = new ItemCostVo(xml.@remove_item);
			price_limit = xml.@price_limit == 1 ? true:false;
			proValue = String(xml.@proValue).split("^");
			quality = xml.@quality;
			
			pileNum = xml.@pile_num;
			
			prop0 = [int(xml.@property1),int(xml.@property1_num)];
			prop1 = [int(xml.@property2),int(xml.@property2_num)];
			
			canQuick = xml.@canQuick == 1 ? true : false;
		}
		
	}
}