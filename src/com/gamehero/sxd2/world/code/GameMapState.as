package com.gamehero.sxd2.world.code {
	/**
	 * 游戏地图类型
	 * @author zhanxgueyou
	 * @create-date 2015-8-26
	 */
	public class GameMapState {
		
		// 状态
		public static const WORLD:int = 1;		// 世界地图
		public static const SCENE:int = 2;		// 场景地图
		public static const HURDLE:int = 3;	// 关卡地图
		public static const BATTLE:int = 4;	// 战斗

		// 当前状态
		static public var currentState:String;
		
	}
}