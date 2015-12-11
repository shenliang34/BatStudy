package com.gamehero.sxd2.gui.bag.events
{
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-11 下午2:19:00
	 * 
	 */
	public class BagEvent extends Event
	{
		/**
		 * 道具更新 
		 */		
		public static var ITEM_UPDATA:String = "item_updata";
		
		/**
		 * 刷新单个道具 
		 */		
		public static var ITEM_UPDATA_SINGLE:String = "item_updata_single";
		
		public var data:Object;
		
		public function BagEvent(type:String, data:Object = null)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}