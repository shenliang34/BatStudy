package com.gamehero.sxd2.world.model
{
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-6-23 下午3:04:02
	 * 
	 */
	public class MapConfig
	{	
		// 人物距离脚底的位置 
		public static var  ROLE_OFFSETY:int = 150;
		
		// 名字的偏移量 
		public static var ROLE_NAME_OFFSET:int = 20;
		// 人物的默认帧频 	
		public static var ROLE_FRAME_RATE:int = 12;
		// 最大窗口 
		public static var STAGE_MAX_WIDTH:int = 1920;
		public static var STAGE_MAX_HEIGHT:int = 1080;
		
		// 人物跑动速度 ms/px
		static public const RUN_SPEED_MILLISENDS:Number = 1000 / 300;
		// 人物行走速度 ms/px
		static public const WALK_SPEED_MILLISENDS:Number = 1000 / 200;
		// 怪物速度 
		static public const LEVEL_MONSTER_SPEED:Number = 1000 / 200;
		// 坐骑速度
		static public const MOUNT_SPEED_MILLISENDS:Number = 1000 / 300;
		
		
		/**
		 * 鼠标移入的滤镜 
		 */		
		public static var NPCFILTER:Vector.<BitmapFilter> = new <BitmapFilter>[new ColorMatrixFilter([1,0,0,0,40,0,1,0,0,40,0,0,1,0,40,0,0,0,1,0])];
		/**
		 * 角色名的滤镜 
		 */		
		public static var NAME_LABEL_FILTER:GlowFilter = new GlowFilter(0x1c1c20, 1, 2, 2, 8);
		/**
		 * 挂件之间最小距离的平方，当小于这个距离的时候表明已经碰到了。 
		 */		
		public static var ITEM_DISTANCE:int = 100;
		/**
		 * 角色自身点击距离
		 */		
		public static var OWN_DISTANCE:int = 20;
		
		/**
		 * 战争迷雾消除的距离 
		 */		
		public static var FOG_DISSTANCE:int = 360000;
		/**
		 * 鼠标按住 500 ms（ 相当于点击一次场景）
		 */		
		public static var MOUSE_DOWN_TIME:int = 500;
		/**
		 * 角色移动间隔100ms（向服务器发送位置信息） 
		 */		
		public static var ROLE_MOVE_TIME:int = 100;
		/**
		 * 地图格子大小 
		 */		
		public static var TILE_SIZE:int = 256;
		/**
		 * 默认动画的帧频 
		 */		
		public static var FRAME_RATE:int = 24;
		/**
		 * 主角皮肤 
		 */		
		public static var MAIN_ROLE_SKIN_URL:String = "player_zhujue01_m";
		/**
		 * 副本地图里面的右边go图标 边界距离 
		 */		
		public static var HURDLE_GUIDE_ARROW_DISTANCE:int = 240;
		
		/**
		 * 世界地图ID
		 */		
		public static var GOLBALWORLDCODE:int = 99999;
		/**
		 * 升级动画
		 */		
		public static var UPGRADE_URL:String = "upgrade.swf";
		
		public function MapConfig()
		{
		}
	}
}