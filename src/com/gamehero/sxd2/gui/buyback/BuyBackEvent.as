package com.gamehero.sxd2.gui.buyback
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-11-11 下午4:22:40
	 * 
	 */
	public class BuyBackEvent extends BaseEvent
	{
		/**
		 * 回购 
		 */		
		public static var BUY_BACK:String = "buy_back";
		public function BuyBackEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}