package com.gamehero.sxd2.gui.theme.ifstheme.skin {
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	
	
	
	
	
	/**
	 * 通用窗口素材类
	 */
	dynamic public class MainSkin 
	{
		// 资源
		public static var resource:MovieClip;
		public static var domain:ApplicationDomain;
		
		// loading
		static public var sceneLoading:MovieClip;
		
		//主UI蓝底通用按钮
		public static var MAINUI_BLUE_BTN_UP:BitmapData;
		public static var MAINUI_BLUE_BTN_OVER:BitmapData;
		public static var MAINUI_BLUE_BTN_DOWN:BitmapData;
		public static var MAINUI_BLUE_BTN_DISABLED:BitmapData;
		
		public static var MAINUI_BLUE_BTN_SELECT_UP:BitmapData;
		public static var MAINUI_BLUE_BTN_SELECT_OVER:BitmapData;
		public static var MAINUI_BLUE_BTN_SELECT_DOWN:BitmapData;
		
		public static var MAINUI_BLUE_BIG_BTN_UP:BitmapData;
		public static var MAINUI_BLUE_BIG_BTN_OVER:BitmapData;
		public static var MAINUI_BLUE_BIG_BTN_DOWN:BitmapData;
		
		
		/**
		 * 窗口名字背景 
		 */		
		static public var NAME_TITLE_BG:BitmapData;
		/**
		 * 窗口标题的云朵 
		 */		
		static public var CLOUD_RIGHT:BitmapData;
		static public var CLOUD_LEFT:BitmapData;

		/**
		 * 五角星 
		 */		
		public static var FiveStar:BitmapData;
		
		public static var MOUSE_PK:MovieClip;
		
		public static var battlePowerBg:BitmapData;
		public static var battlePowerMc:MovieClip;
		/**
		 * 小问号 
		 */		
		public static var INTERROGATION_DISABLED:BitmapData;
		public static var INTERROGATION_DOWN:BitmapData;
		public static var INTERROGATION_OVER:BitmapData;
		public static var INTERROGATION_UP:BitmapData;
		
		
		
		/**
		 * 初始化游戏皮肤
		 * */
		public static function init(res:MovieClip):void
		{
			resource = res;
			domain = resource.loaderInfo.applicationDomain;
			
			// 通用控件皮肤
			CommonSkin.init(res);
			// 对话框皮肤
			DialogSkin.init(res);
			// 地图相关皮肤
			MapSkin.init(res);
			// 聊天皮肤
			ChatSkin.init(res);
			// 数字皮肤
			NumberSkin.init(res);
			// tips皮肤
			GameHintSkin.init(res);
			//伙伴通用标识
			HeroSkin.init(res);
			// 鼠标皮肤
			MouseSkin.init(res);
			//道具？
			ItemSkin.init(res);
			//提示
			NoticeSkin.init(res);
			// 剧情及新手引导皮肤
			GuideSkin.init(res);
			//快速穿戴
			QuickUseSkin.init(res);
			
			//主UI蓝底通用按钮
			MainSkin.MAINUI_BLUE_BTN_UP = getSwfBD("mainUIBtnUp");
			MainSkin.MAINUI_BLUE_BTN_OVER = getSwfBD("mainUIBtnOver");
			MainSkin.MAINUI_BLUE_BTN_DOWN = getSwfBD("mainUIBtnDown");
			MainSkin.MAINUI_BLUE_BTN_DISABLED = getSwfBD("mainUIBtnDisabled");
			
			MainSkin.MAINUI_BLUE_BTN_SELECT_UP = getSwfBD("mainUISelectBtnUp");
			MainSkin.MAINUI_BLUE_BTN_SELECT_OVER = getSwfBD("mainUISelectBtnOver");
			MainSkin.MAINUI_BLUE_BTN_SELECT_DOWN = getSwfBD("mainUISelectBtnDown");
			
			MainSkin.MAINUI_BLUE_BIG_BTN_UP = getSwfBD("mainUIBigBtnUp");
			MainSkin.MAINUI_BLUE_BIG_BTN_OVER = getSwfBD("mainUIBigBtnOver");
			MainSkin.MAINUI_BLUE_BIG_BTN_DOWN = getSwfBD("mainUIBigBtnDown");
			
			
			// 场景loading
			MainSkin.sceneLoading = getSwfMovie("SCENE_LOADING");
			
			// 战斗切换动画
			BattleSkin.BATTLE_CHANGE = getSwfMovie("BATTLE_CHANGE");
			BattleSkin.BATTLE_CHANGE.gotoAndStop(0);
			
			NAME_TITLE_BG = getSwfBD("NAME_TITLE_BG");
			CLOUD_RIGHT = getSwfBD("CLOUD_RIGHT");
			CLOUD_LEFT = getSwfBD("CLOUD_LEFT");

			
			FiveStar = getSwfBD("FiveStar");
		
			battlePowerBg = getSwfBD("battlePowerBg");
			battlePowerMc = getSwfMovie("battlePowerMc");
			
			INTERROGATION_DISABLED = getSwfBD("interrogation_disabled");
			INTERROGATION_DOWN = getSwfBD("interrogation_down");
			INTERROGATION_OVER = getSwfBD("interrogation_over");
			INTERROGATION_UP = getSwfBD("interrogation_up");
		}
		
		
		
		
		/**
		 * 获取对应class
		 * */
		public static function getSwfClass(className:String):Class
		{	
			return domain.getDefinition(className) as Class;
		}
		
		/**
		 * 获取对应BitmapData 
		 */
		public static function getSwfBD(className:String):BitmapData
		{	
			return new (getSwfClass(className))() as BitmapData;
		}
		
		
		
		
		/**
		 * 获取对应MovieClip 
		 */
		public static function getSwfMovie(className:String):MovieClip
		{	
			return new (getSwfClass(className))() as MovieClip;
		}
		
		
	}
}