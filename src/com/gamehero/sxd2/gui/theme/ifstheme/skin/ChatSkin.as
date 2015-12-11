package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	/**
	 * 聊天皮肤
	 * @author xuwenyi
	 * @create 2015-08-20
	 **/
	public class ChatSkin
	{
		/** 聊天框皮肤 */
		//滚动条滑块
		public static var CHAT_THUMB_UP:BitmapData;
		public static var CHAT_THUMB_OVER:BitmapData;
		public static var CHAT_THUMB_DOWN:BitmapData;
		//滚动条向上按钮
		public static var CHAT_UPBTN_UP:BitmapData;
		public static var CHAT_UPBTN_OVER:BitmapData;
		public static var CHAT_UPBTN_DOWN:BitmapData;
		//滚动条向下按钮
		public static var CHAT_DOWNBTN_UP:BitmapData;
		public static var CHAT_DOWNBTN_OVER:BitmapData;
		public static var CHAT_DOWNBTN_DOWN:BitmapData;
		//滚动条滑道
		public static var CHAT_TRACK_SKIN:BitmapData;
		//聊天框背景
		public static var CHAT_OUTPUT_BG_BD:BitmapData;
		//提示红点
		public static var CHAT_REDPOINT:BitmapData;
		//发送按钮
		public static var ENTERBTN_UP:BitmapData;
		public static var ENTERBTN_DOWN:BitmapData;
		public static var ENTERBTN_OVER:BitmapData;
		//面板向下箭头
		public static var UPBTN_UP:BitmapData;
		public static var UPBTN_DOWN:BitmapData;
		public static var UPBTN_OVER:BitmapData;
		//面板向上箭头
		public static var DOWNBTN_UP:BitmapData;
		public static var DOWNBTN_DOWN:BitmapData;
		public static var DOWNBTN_OVER:BitmapData;
		
		/** 聊天框皮肤 */
		static public var itemMenuOver:BitmapData;
		static public var lineScale9Grid:Rectangle;
		static public var line:BitmapData;
		
		
		
		public function ChatSkin()
		{
		}
		
		
		
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			/** 聊天框皮肤 */
			//滚动条滑块
			CHAT_THUMB_UP = global.getBD(domain , "CHAT_THUMB_UP");
			CHAT_THUMB_OVER = global.getBD(domain , "CHAT_THUMB_OVER");
			CHAT_THUMB_DOWN = global.getBD(domain , "CHAT_THUMB_DOWN");
			//滚动条向上按钮
			CHAT_UPBTN_UP = global.getBD(domain , "CHAT_UPBTN_UP");
			CHAT_UPBTN_OVER = global.getBD(domain , "CHAT_UPBTN_OVER");
			//滚动条向下按钮
			CHAT_DOWNBTN_UP = global.getBD(domain , "CHAT_DOWNBTN_UP");
			CHAT_DOWNBTN_OVER = global.getBD(domain , "CHAT_DOWNBTN_OVER");
			CHAT_DOWNBTN_DOWN = global.getBD(domain , "CHAT_DOWNBTN_DOWN");
			
			//滚动条滑道
			CHAT_TRACK_SKIN = global.getBD(domain , "CHAT_TRACK_SKIN");
			
			//聊天框背景
			CHAT_OUTPUT_BG_BD = global.getBD(domain , "CHAT_OUTPUT_BG_BD");
			//
			itemMenuOver =  global.getBD(domain , "ITEM_MENU_OVER");
			//
			lineScale9Grid = new Rectangle(29, 1, 1, 1);
			// 线条
			line = global.getBD(domain , "LINE_BD");
			//提示红点
			CHAT_REDPOINT = global.getBD(domain , "CHAT_REDPOINT");
			//发送按钮
			ENTERBTN_UP = global.getBD(domain , "ENTERBTN_UP");
			ENTERBTN_DOWN = global.getBD(domain , "ENTERBTN_DOWN");
			ENTERBTN_OVER = global.getBD(domain , "ENTERBTN_OVER");
			//面板向上按钮
			UPBTN_UP = global.getBD(domain , "UPBTN_UP");
			UPBTN_DOWN = global.getBD(domain , "UPBTN_DOWN");
			UPBTN_OVER = global.getBD(domain , "UPBTN_OVER");
			//面板向上按钮
			DOWNBTN_UP = global.getBD(domain , "DOWNBTN_UP");
			DOWNBTN_DOWN = global.getBD(domain , "DOWNBTN_DOWN");
			DOWNBTN_OVER = global.getBD(domain , "DOWNBTN_OVER");
		}
	}
}