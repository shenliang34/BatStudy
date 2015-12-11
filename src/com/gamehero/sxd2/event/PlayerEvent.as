package com.gamehero.sxd2.event {
	import flash.events.Event;
	
	
	/**
	 * 主角相关事件
	 * @author Trey
	 * 
	 */	
	public class PlayerEvent extends BaseEvent {
		
		// 玩家数据更新
		public static const UPDATEPLAYER:String = "updatePlayer";
		// 升级
		public static const LEVEL_UP:String = "levelup";
		// 骑乘升级
		public static const MOUNT:String = "mount";
		// 数据改变
		public static const CHANGE:String = "change";
		// 称号
		public static const TITLE:String = "title";
		// 打坐
		public static const ZAZEN:String = "zazen";
		public static const ZAZEN_UPDATE:String = "zazenUpdate";
		public static const ON_ZAZEN_UPDATE:String = "onZazenUpdate";
		public static const ZAZEN_REWARD:String = "zazenReward";
		// 翅膀
		public static const WING:String = "wing";
		// 天使
		public static const ANGEL:String = "angel";
		// 神兵
		public static const GODWEAPON:String = "godWeapon";
		
		//伙伴详细信息
		public static const REFRESH_HERO_INFO:String = "refreshHeroInfo";

		
		public function PlayerEvent(type:String, data:Object = null) {
			
			super(type, data);
		}
		
		
		
		override public function clone():Event
		{
			return new PlayerEvent(type , data);
		}
	}
}