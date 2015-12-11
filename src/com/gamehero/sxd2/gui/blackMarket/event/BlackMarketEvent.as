package com.gamehero.sxd2.gui.blackMarket.event
{
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-22 下午3:08:11
	 * 
	 */
	public class BlackMarketEvent extends Event
	{
		/**
		 * 免费刷新 
		 */		
		public static var REFRESH:String = "refresh";
		/**
		 * 购买黑市物品 
		 */		
		public static var BUYITEM:String = "buyitem";
		
		public var data:Object;
		public function BlackMarketEvent(type:String, data:Object = null)
		{
			this.data = data;
			super(type, true, cancelable);
		}
	}
}