package com.gamehero.sxd2.event {
	
	import flash.events.Event;
	
	/**
	 * Game World Event 
	 * @author Trey
	 * @create-date 2013-7-17
	 */
	public class GameWorldEvent extends Event {
		
		static public const ENTER_BATTLE:String = "EnterBattle";
		
		// 打开地图
		public static const OPEN_GLOBAL_GAME_WORLD:String = "openGlobalGameWorld";	// 打开世界地图
//		public static const OPEN:String = "gameWorldOpen";
		public static const INTO_GAME_WORLD:String = "intoGameWorld";
		public static const LEAVE_GAME_WORLD:String = "leaveGameWorld";
		
		
		public static const INTO_SCENE:String = "intoScene";		// 进入地图场景
		public static const INTO_SCENE_OK:String = "intoSceneOK";	// 进入地图场景成功
		public static const LEAVE_SCENE:String = "leaveScene";		// 离开场景
		public static const LEAVE_SCENE_OK:String = "leaveSceneOK";	// 离开场景成功
		public static const GET_SCENE_INFO:String = "getSceneInfo";	// 获得场景信息

		public static const MEET_NPC:String = "meetNPC";			// 遇到NPC
		public static const MEET_NPC_OVER:String = "meetNPCOver";	// 遇到NPC结束

//		public static const WIN_BATTLE:String = "winBattle";		// 战斗胜利
		
		public static const SET_PLAYERS_SHOW_CHANGE:String = "setPlayersShowChange"; // 显示/隐藏其他玩家设置改变

		
		static public const AUTO_MOVE_CHANGE:String = "autoMoveChageEvent";		// 自动寻路改变

		static public const AUTO_TRACE_CHANGE:String = "autoTraceChageEvent";	// 自动追踪改变
		
		
		//哥布林宝藏拥有者信息更新
		public static const GOBULIN_INFO_UPDATE:String = "gobulinInfoUpdate";
		
		
		/** 关卡相关  */
		public static const INTO_HURDLE_OK:String = "intoHurdleOK";		// 进入关卡返回
		public static const UPDATE_HURDLE_OK:String = "updateHurdleOK";	// 关卡更新返回
		public static const HURDLE_LIST_UPDATE:String = "hurdleListUpdate";	// 关卡更新返回

		
		// 退出全屏玩法
		public static const QUIT_FULL_SCREEN:String = "quitFullScreen";
		
		
		/** 钓鱼相关 */
		public static const FISHING:String = "fishing";
		public static const ON_FISH_ACTION:String = "onFishAction";
		public static const GET_FISH:String = "getFish";
		public static const ON_FISH_INFO_UPDATE:String = "onFishInfoUpdate";
		public static const FISH_INFO_Story_OVER:String = "FISH_INFO_Story_OVER"; // 剧情结束通知后端
		public static const ON_FISH_INFO_Story_OVER:String = "ON_FISH_INFO_Story_OVER"; //剧情结束通知
		public static const FISH_ONE_KEY:String = "fishOneKey";// 一键寻鱼饵
		
		public static const ANGEL_NAME_CHANGE:String = "ANGEL_NAME_CHANGE"; //天使更名

		
		//进入跨服场景
		public static const GOIN_CROSS_SERVER:String = "GOIN_CROSS_SERVER";
		public static const ON_GOIN_CROSS_SERVER:String = "ON_GOIN_CROSS_SERVER";
		
		//地牢玩家选择隐藏名称
		public static const DUNGEON_HIDDEN:String = "DUNGEON_HIDDEN";
		
		public var data:Object;
		
		
		
		public function GameWorldEvent(type:String, data:Object = null) {
			
			super(type, true);
			
			this.data = data;
		}
		
		
			
		override public function clone():Event {
			return new GameWorldEvent(type, data);
		}
	}
}