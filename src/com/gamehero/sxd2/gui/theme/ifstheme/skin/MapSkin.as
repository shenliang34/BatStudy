package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	
	/**
	 * 地图相关皮肤
	 * @author xuwenyi
	 * @create 2015-08-14
	 **/
	public class MapSkin
	{
		// tips相关
		static public var MAP_NAME_BG:BitmapData;
		static public var MAP_FOG:BitmapData;
		
		static public var NPC_FACE:BitmapData;
		static public var NPC_BG:BitmapData;
		
		// npc冒泡对话2个方向的底图
		static public var NPC_DIALOGUE_1:BitmapData;
		static public var NPC_DIALOGUE_2:BitmapData;
		
		static public var TASK_CLOSE_BTN_UP:BitmapData;
		static public var TASK_CLOSE_BTN_OVER:BitmapData;
		static public var TASK_CLOSE_BTN_DOWN:BitmapData;
		static public var TASK_AWARD_BG:BitmapData;
		
		static public var LEAVEMAPBTNOVER:BitmapData;
		static public var LEAVEMAPBTNUP:BitmapData;
		
		static public var QUESTION:BitmapData;
		static public var EXCLAMATION:BitmapData;
		
		
		
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			MAP_NAME_BG = global.getBD(domain , "MAP_NAME_BG");
			MAP_FOG = global.getBD(domain , "MAP_FOG");
			
			NPC_FACE = global.getBD(domain , "NPC_FACE");
			NPC_BG = global.getBD(domain , "NPC_BG");
			
			// npc冒泡对话
			NPC_DIALOGUE_1 = global.getBD(domain , "NPC_DIALOGUE");
			var mtx:Matrix = new Matrix();
			mtx.scale(-1 , 1);
			mtx.translate(NPC_DIALOGUE_1.width , 0);
			NPC_DIALOGUE_2 = new BitmapData(NPC_DIALOGUE_1.width,NPC_DIALOGUE_1.height,true,0);
			NPC_DIALOGUE_2.draw(NPC_DIALOGUE_1 , mtx);
			
			TASK_CLOSE_BTN_UP = global.getBD(domain , "TASK_CLOSE_BTN_UP");
			TASK_CLOSE_BTN_OVER = global.getBD(domain , "TASK_CLOSE_BTN_OVER");
			TASK_CLOSE_BTN_DOWN = global.getBD(domain , "TASK_CLOSE_BTN_DOWN");
			TASK_AWARD_BG = global.getBD(domain , "TASK_AWARD_BG");
			/**
			*返回Btn
			*/
			LEAVEMAPBTNOVER = global.getBD(domain , "leaveMapBtnOver");
			LEAVEMAPBTNUP = global.getBD(domain , "leaveMapBtnUp");
			
			QUESTION = global.getBD(domain , "QUESTION");
			EXCLAMATION = global.getBD(domain , "EXCLAMATION");
			
		}
	}
}