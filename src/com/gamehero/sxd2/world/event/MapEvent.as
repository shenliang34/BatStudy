package com.gamehero.sxd2.world.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	import flash.events.Event;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-5-15 下午2:04:47
	 * 
	 */
	public class MapEvent extends BaseEvent
	{
		// 地图资源加载完成
		public static var MAP_RESLOAD_COMPLETE:String = "mapResLaodComplete";
		// gameworld初始化地图成功后发出
		public static var MAP_INIT:String = "MAP_INIT";
		
		/**
		 * 第一次渲染成功
		 */	
		public static var NPC_FIRST_RENDER:String = "npcFirstRender";
		
		/**
		 * 地图主动碰撞
		 */	
		public static var MAP_ACTIVE_COLLIDE:String = "mapActiveCollide";
		
		/**
		 * 地图被动碰撞
		 */	
		public static var MAP_DRIVEN_COLLIDE:String = "mapDrivenCollide";
		
		/**
		 * 地图移动到指定地点
		 */	
		public static var MAP_MOVE_COMPLETE:String = "mapMoveComplete";
		
		/**
		 * 点击玩家角色
		 */	
		public static var MAP_CLICK_PLAYER:String = "mapClickPlayer";
		
		/**
		 * 人物跑动后停止事件
		 * */
		public static var ROLE_STOP:String = "roleStop";
		
		/**
		 * 进入世界地图
		 * */
		public static var ENTER_GOLBAL_WORLD:String = "enterGolbalWorld";
		
		/**
		 * 返回地图
		 * */
		public static var RETURN_SCENE_MAP:String = "returnSceneMap";
		/**
		 * 关卡里面设置 go 图标是否可见 
		 */		
		public static var SET_ARROW_VISIBLE:String = "set_arrow_visible";
		/**
		 * 关卡里面移动事件 
		 */		
		public static var HURDL_EMOVE:String = "hurdleMove";
		
		public static var PK:String = "pk";
		
		
		public static var MAP_NAME_LOAD_COMPLETE:String = "mapNameLoadComplete";
		
		public function MapEvent(type:String,data:Object = null)
		{
			super(type,data);
		}
		
		override public function clone():Event
		{
			return new MapEvent(type , data);
		}
	}
}