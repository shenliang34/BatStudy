package com.gamehero.sxd2.gui.theme.ifstheme.skin {
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	/**
	 * GameHint Skin 
	 * @author Trey
	 * @create-date 2013-8-26
	 */
	public class GameHintSkin
	{	
		public static const edge:int = 5;	
		public static const hintBgScale9Grid:Rectangle = new Rectangle(13, 13, 3, 3);
		
		
		// tips相关
		static public var TIPS_BG:BitmapData;
		static public var TIPS_LINE:BitmapData;
		
		
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			// tips相关
			TIPS_BG = global.getBD(domain , "TIPS_BG");
			TIPS_LINE = global.getBD(domain , "TIPS_LINE");
		}
	}
}