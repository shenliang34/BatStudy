package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	
	/**
	 * 战斗场景事件
	 * @author xuwenyi
	 * @create 2013-07-09
	 **/
	public class BattleWorldEvent extends BaseEvent
	{
		public static const PLAYER_MOVE_COMPLETE:String = "playerMoveComplete";
		public static const PLAYER_MOVE_ARRIVE:String = "playerMoveArrive";
		public static const PLAYER_MOVE_BACK:String = "playerMoveBack";
		
		// 黑屏效果播放结束
		public static const SCREEN_BLACK_COMPLETE:String = "screenBlackComplete";
		
		
		public function BattleWorldEvent(type:String, data:Object = null)
		{
			super(type , data);
		}
		
		override public function clone():Event
		{
			return new BattleWorldEvent(type , data);
		}
	}
}