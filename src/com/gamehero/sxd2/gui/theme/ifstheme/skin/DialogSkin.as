package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	/**
	 * 对话框相关皮肤
	 * @author xuwenyi
	 * @create 2015-08-20
	 **/
	public class DialogSkin
	{
		static public var DIALOG_BG:BitmapData;
		static public var DIALOG_BG_9GRID:Rectangle = new Rectangle(31,38,2,2);
		
		static public var EXCLAMATION:BitmapData;
		
		
		public function DialogSkin()
		{
		}
		
		
		
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			
			DIALOG_BG = global.getBD(domain , "DIALOG_BG");
			EXCLAMATION = global.getBD(domain , "EXCLAMATION");
		}
	}
}