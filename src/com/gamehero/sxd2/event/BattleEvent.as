package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	
	/**
	 * 战斗mvc层事件
	 * @author xuwenyi
	 * @create 
	 **/
	public class BattleEvent extends BaseEvent
	{
		public static const BATTLE_SPEED_UP_CLICK:String = "battleSpeedUpClick";// 点击战斗加速
		public static const SHOW_BATTLE_RESULT:String = "showBattleResult";// 显示战报
		
		public static const BATTLE_END:String = "battleEnd";// 退出战斗
		public static const BATTLE_REPLAY:String = "battleReplay";
		
		
		
		public function BattleEvent(type:String, data = null)
		{
			super(type , data);
		}
		
		
		override public function clone():Event
		{
			return new BattleEvent(type , data);
		}
	}
}