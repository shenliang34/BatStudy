package com.gamehero.sxd2.gui.takeCards.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-10-15 下午5:15:01
	 * 
	 */
	public class TakeCardsEvent extends BaseEvent
	{
		/**
		 * 开始抽卡
		 */		
		public static var TAKE_CARD:String = "TAKE_CARD";
		/**
		 *  把抽到的卡放到背包里
		 */		
		public static var GET_CARD:String = "GET_CARD";
		/**
		 * 开伙伴卡片 
		 */		
		public static var CARDS_OPEN:String = "CARDS_OPEN";
		
		public function TakeCardsEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}