package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	
	/**
	 * 用于存放图片数字
	 * @author xuwenyi
	 * @create 2015-08-11
	 **/
	public class NumberSkin
	{
		//战斗数字
		static public var B_YELLOW_0:BitmapData;
		static public var B_YELLOW_1:BitmapData;
		static public var B_YELLOW_2:BitmapData;
		static public var B_YELLOW_3:BitmapData;
		static public var B_YELLOW_4:BitmapData;
		static public var B_YELLOW_5:BitmapData;
		static public var B_YELLOW_6:BitmapData;
		static public var B_YELLOW_7:BitmapData;
		static public var B_YELLOW_8:BitmapData;
		static public var B_YELLOW_9:BitmapData;
		
		// 加减号
		static public var S_RED_MINUS:BitmapData;
		
		static public var S_RED_0:BitmapData;
		static public var S_RED_1:BitmapData;
		static public var S_RED_2:BitmapData;
		static public var S_RED_3:BitmapData;
		static public var S_RED_4:BitmapData;
		static public var S_RED_5:BitmapData;
		static public var S_RED_6:BitmapData;
		static public var S_RED_7:BitmapData;
		static public var S_RED_8:BitmapData;
		static public var S_RED_9:BitmapData;

		//面板数字
		public static var M_YELLOW_0:BitmapData;
		public static var M_YELLOW_1:BitmapData;
		public static var M_YELLOW_2:BitmapData;
		public static var M_YELLOW_3:BitmapData;
		public static var M_YELLOW_4:BitmapData;
		public static var M_YELLOW_5:BitmapData;
		public static var M_YELLOW_6:BitmapData;
		public static var M_YELLOW_7:BitmapData;
		public static var M_YELLOW_8:BitmapData;
		public static var M_YELLOW_9:BitmapData;
		
		
		static public var W_YELLOW_0:BitmapData;
		static public var W_YELLOW_1:BitmapData;
		static public var W_YELLOW_2:BitmapData;
		static public var W_YELLOW_3:BitmapData;
		static public var W_YELLOW_4:BitmapData;
		static public var W_YELLOW_5:BitmapData;
		static public var W_YELLOW_6:BitmapData;
		static public var W_YELLOW_7:BitmapData;
		static public var W_YELLOW_8:BitmapData;
		static public var W_YELLOW_9:BitmapData;
		
		static public var S_GREEN_0:BitmapData;
		static public var S_GREEN_1:BitmapData;
		static public var S_GREEN_2:BitmapData;
		static public var S_GREEN_3:BitmapData;
		static public var S_GREEN_4:BitmapData;
		static public var S_GREEN_5:BitmapData;
		static public var S_GREEN_6:BitmapData;
		static public var S_GREEN_7:BitmapData;
		static public var S_GREEN_8:BitmapData;
		static public var S_GREEN_9:BitmapData;
		
		//黄色10*16
		static public var S_YELLOW_0:BitmapData;
		static public var S_YELLOW_1:BitmapData;
		static public var S_YELLOW_2:BitmapData;
		static public var S_YELLOW_3:BitmapData;
		static public var S_YELLOW_4:BitmapData;
		static public var S_YELLOW_5:BitmapData;
		static public var S_YELLOW_6:BitmapData;
		static public var S_YELLOW_7:BitmapData;
		static public var S_YELLOW_8:BitmapData;
		static public var S_YELLOW_9:BitmapData;
		
		//绿色10*16
		static public var FATE_S_GREEN_0:BitmapData;
		static public var FATE_S_GREEN_1:BitmapData;
		static public var FATE_S_GREEN_2:BitmapData;
		static public var FATE_S_GREEN_3:BitmapData;
		static public var FATE_S_GREEN_4:BitmapData;
		static public var FATE_S_GREEN_5:BitmapData;
		static public var FATE_S_GREEN_6:BitmapData;
		static public var FATE_S_GREEN_7:BitmapData;
		static public var FATE_S_GREEN_8:BitmapData;
		static public var FATE_S_GREEN_9:BitmapData;
		
		//蓝色10*16
		static public var S_BIUE_0:BitmapData;
		static public var S_BIUE_1:BitmapData;
		static public var S_BIUE_2:BitmapData;
		static public var S_BIUE_3:BitmapData;
		static public var S_BIUE_4:BitmapData;
		static public var S_BIUE_5:BitmapData;
		static public var S_BIUE_6:BitmapData;
		static public var S_BIUE_7:BitmapData;
		static public var S_BIUE_8:BitmapData;
		static public var S_BIUE_9:BitmapData;
		
		//灰色10*16
		static public var S_GRSY_0:BitmapData;
		static public var S_GRSY_1:BitmapData;
		static public var S_GRSY_2:BitmapData;
		static public var S_GRSY_3:BitmapData;
		static public var S_GRSY_4:BitmapData;
		static public var S_GRSY_5:BitmapData;
		static public var S_GRSY_6:BitmapData;
		static public var S_GRSY_7:BitmapData;
		static public var S_GRSY_8:BitmapData;
		static public var S_GRSY_9:BitmapData;
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			//战斗数字
			B_YELLOW_0 = global.getBD(domain , "NUM_B_YELLOW_0");
			B_YELLOW_1 = global.getBD(domain , "NUM_B_YELLOW_1");
			B_YELLOW_2 = global.getBD(domain , "NUM_B_YELLOW_2");
			B_YELLOW_3 = global.getBD(domain , "NUM_B_YELLOW_3");
			B_YELLOW_4 = global.getBD(domain , "NUM_B_YELLOW_4");
			B_YELLOW_5 = global.getBD(domain , "NUM_B_YELLOW_5");
			B_YELLOW_6 = global.getBD(domain , "NUM_B_YELLOW_6");
			B_YELLOW_7 = global.getBD(domain , "NUM_B_YELLOW_7");
			B_YELLOW_8 = global.getBD(domain , "NUM_B_YELLOW_8");
			B_YELLOW_9 = global.getBD(domain , "NUM_B_YELLOW_9");
			
			S_RED_0 = global.getBD(domain , "NUM_S_RED_0");
			S_RED_1 = global.getBD(domain , "NUM_S_RED_1");
			S_RED_2 = global.getBD(domain , "NUM_S_RED_2");
			S_RED_3 = global.getBD(domain , "NUM_S_RED_3");
			S_RED_4 = global.getBD(domain , "NUM_S_RED_4");
			S_RED_5 = global.getBD(domain , "NUM_S_RED_5");
			S_RED_6 = global.getBD(domain , "NUM_S_RED_6");
			S_RED_7 = global.getBD(domain , "NUM_S_RED_7");
			S_RED_8 = global.getBD(domain , "NUM_S_RED_8");
			S_RED_9 = global.getBD(domain , "NUM_S_RED_9");
			
			
			S_GREEN_0 = global.getBD(domain , "NUM_S_GREEN_0");
			S_GREEN_1 = global.getBD(domain , "NUM_S_GREEN_1");
			S_GREEN_2 = global.getBD(domain , "NUM_S_GREEN_2");
			S_GREEN_3 = global.getBD(domain , "NUM_S_GREEN_3");
			S_GREEN_4 = global.getBD(domain , "NUM_S_GREEN_4");
			S_GREEN_5 = global.getBD(domain , "NUM_S_GREEN_5");
			S_GREEN_6 = global.getBD(domain , "NUM_S_GREEN_6");
			S_GREEN_7 = global.getBD(domain , "NUM_S_GREEN_7");
			S_GREEN_8 = global.getBD(domain , "NUM_S_GREEN_8");
			S_GREEN_9 = global.getBD(domain , "NUM_S_GREEN_9");
			
			S_RED_MINUS = global.getBD(domain , "NUM_S_RED_MINUS");
			
			//面板上美术数字
			M_YELLOW_0 = global.getBD(domain , "NUM_M_YELLOW_0");
			M_YELLOW_1 = global.getBD(domain , "NUM_M_YELLOW_1");
			M_YELLOW_2 = global.getBD(domain , "NUM_M_YELLOW_2");
			M_YELLOW_3 = global.getBD(domain , "NUM_M_YELLOW_3");
			M_YELLOW_4 = global.getBD(domain , "NUM_M_YELLOW_4");
			M_YELLOW_5 = global.getBD(domain , "NUM_M_YELLOW_5");
			M_YELLOW_6 = global.getBD(domain , "NUM_M_YELLOW_6");
			M_YELLOW_7 = global.getBD(domain , "NUM_M_YELLOW_7");
			M_YELLOW_8 = global.getBD(domain , "NUM_M_YELLOW_8");
			M_YELLOW_9 = global.getBD(domain , "NUM_M_YELLOW_9");
			
			W_YELLOW_0 = global.getBD(domain ,"W_YELLOW_0");
			W_YELLOW_1 = global.getBD(domain ,"W_YELLOW_1");
			W_YELLOW_2 = global.getBD(domain ,"W_YELLOW_2");
			W_YELLOW_3 = global.getBD(domain ,"W_YELLOW_3");
			W_YELLOW_4 = global.getBD(domain ,"W_YELLOW_4");
			W_YELLOW_5 = global.getBD(domain ,"W_YELLOW_5");
			W_YELLOW_6 = global.getBD(domain ,"W_YELLOW_6");
			W_YELLOW_7 = global.getBD(domain ,"W_YELLOW_7");
			W_YELLOW_8 = global.getBD(domain ,"W_YELLOW_8");
			W_YELLOW_9 = global.getBD(domain ,"W_YELLOW_9");
			
			S_BIUE_0 = global.getBD(domain ,"S_BIUE_0");
			S_BIUE_1 = global.getBD(domain ,"S_BIUE_1");
			S_BIUE_2 = global.getBD(domain ,"S_BIUE_2");
			S_BIUE_3 = global.getBD(domain ,"S_BIUE_3");
			S_BIUE_4 = global.getBD(domain ,"S_BIUE_4");
			S_BIUE_5 = global.getBD(domain ,"S_BIUE_5");
			S_BIUE_6 = global.getBD(domain ,"S_BIUE_6");
			S_BIUE_7 = global.getBD(domain ,"S_BIUE_7");
			S_BIUE_8 = global.getBD(domain ,"S_BIUE_8");
			S_BIUE_9 = global.getBD(domain ,"S_BIUE_9");
			
			S_GRSY_0 = global.getBD(domain ,"S_GRSY_0");
			S_GRSY_1 = global.getBD(domain ,"S_GRSY_1");
			S_GRSY_2 = global.getBD(domain ,"S_GRSY_2");
			S_GRSY_3 = global.getBD(domain ,"S_GRSY_3");
			S_GRSY_4 = global.getBD(domain ,"S_GRSY_4");
			S_GRSY_5 = global.getBD(domain ,"S_GRSY_5");
			S_GRSY_6 = global.getBD(domain ,"S_GRSY_6");
			S_GRSY_7 = global.getBD(domain ,"S_GRSY_7");
			S_GRSY_8 = global.getBD(domain ,"S_GRSY_8");
			S_GRSY_9 = global.getBD(domain ,"S_GRSY_9");
			
			FATE_S_GREEN_0 = global.getBD(domain ,"FATE_S_GREEN_0");
			FATE_S_GREEN_1 = global.getBD(domain ,"FATE_S_GREEN_1");
			FATE_S_GREEN_2 = global.getBD(domain ,"FATE_S_GREEN_2");
			FATE_S_GREEN_3 = global.getBD(domain ,"FATE_S_GREEN_3");
			FATE_S_GREEN_4 = global.getBD(domain ,"FATE_S_GREEN_4");
			FATE_S_GREEN_5 = global.getBD(domain ,"FATE_S_GREEN_5");
			FATE_S_GREEN_6 = global.getBD(domain ,"FATE_S_GREEN_6");
			FATE_S_GREEN_7 = global.getBD(domain ,"FATE_S_GREEN_7");
			FATE_S_GREEN_8 = global.getBD(domain ,"FATE_S_GREEN_8");
			FATE_S_GREEN_9 = global.getBD(domain ,"FATE_S_GREEN_9");
			
			S_YELLOW_1 = global.getBD(domain ,"S_YELLOW_1");
			S_YELLOW_2 = global.getBD(domain ,"S_YELLOW_2");
			S_YELLOW_3 = global.getBD(domain ,"S_YELLOW_3");
			S_YELLOW_4 = global.getBD(domain ,"S_YELLOW_4");
			S_YELLOW_5 = global.getBD(domain ,"S_YELLOW_5");
			S_YELLOW_6 = global.getBD(domain ,"S_YELLOW_6");
			S_YELLOW_7 = global.getBD(domain ,"S_YELLOW_7");
			S_YELLOW_8 = global.getBD(domain ,"S_YELLOW_8");
			S_YELLOW_9 = global.getBD(domain ,"S_YELLOW_9");
			S_YELLOW_0 = global.getBD(domain ,"S_YELLOW_0");
		}
	}
}