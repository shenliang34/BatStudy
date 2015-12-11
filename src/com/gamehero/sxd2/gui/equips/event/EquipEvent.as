package com.gamehero.sxd2.gui.equips.event
{
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-15 下午4:05:05
	 * 
	 */
	public class EquipEvent extends Event
	{
		/**
		 * 选择 
		 */		
		public static var SELECTED:String = "selected";
		/**
		 * 装备强化 
		 */		
		public static var STRENGTHEN:String = "strengthen";
		/**
		 * 快速购买道具 
		 */		
		public static var BUY_ITEM:String = "buyItem";
		
		public var data:Object;
		public function EquipEvent(type:String, data:*)
		{
			super(type, true, cancelable);
			this.data = data;
		}
	}
}