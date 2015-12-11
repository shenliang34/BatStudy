package com.gamehero.sxd2.gui.player.hero.event
{
	import flash.events.Event;
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * 伙伴事件
	 * @author xuwenyi
	 * @create 2013-08-14
	 **/
	public class HeroEvent extends BaseEvent
	{
		/**请求上阵伙伴列表*/
		public static const REQ_HERO_LIST:String = "heroBattleList";
		
		
		public static const HERO_INFO_UPDATA:String = "hero_info_updata";
		
		/**
		 * 构造函数
		 * */
		public function HeroEvent(type:String, data:Object = null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new HeroEvent(type , data);
		}
	}
}