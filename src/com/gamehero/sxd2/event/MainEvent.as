package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	
	/**
	 * 主应用事件
	 * @author xuwenyi
	 * @create 2013-08-01
	 **/
	public class MainEvent extends BaseEvent
	{
		// 进入战斗
		public static const SHOW_BATTLE:String = "SHOW_BATTLE";
		// 战斗结束
		public static const BATTLE_END:String = "BATTLE_END";
		
		// 发送GM指令
		public static const GM:String = "GM";
		
		// 隐藏其他玩家
		public static const HIDEOTHERPLAYER:String = "hideOtherPlayer";
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function MainEvent(type:String , data:Object = null)
		{
			super(type, data);
		}
		
		
		
		
		override public function clone():Event
		{
			return new MainEvent(type,data);
		}
	}
}