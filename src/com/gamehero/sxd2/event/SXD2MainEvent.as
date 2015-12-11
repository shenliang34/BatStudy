package com.gamehero.sxd2.event
{
	
	/**
	 * 主游戏事件
	 * @author xuwenyi
	 * @create 2015-08-24
	 **/
	public class SXD2MainEvent extends BaseEvent
	{
		/**
		 * 进入场景 
		 */		
		public static var ENTER_MAP:String = "enter_map";
		/**
		 * 离开场景 
		 */		
		public static var LEAVE_MAP:String = "leave_map";
		
		// 创建战斗
		public static var BATTLE_CREATE:String = "BATTLE_CREATE";
		// 观看战斗录像
		public static var BATTLE_REPORT:String = "BATTLE_REPORT";
		
		
		
		
		public function SXD2MainEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}