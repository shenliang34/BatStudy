package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	
	import alternativa.gui.mouse.CursorManager;
	
	/**
	 * 鼠标皮肤
	 * @author xuwenyi
	 * @create 2015-09-14
	 **/
	public class MouseSkin
	{
		public function MouseSkin()
		{
		}
		
		
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			// 战斗状态鼠标
			var bmds:Vector.<BitmapData> = new Vector.<BitmapData>();
			for(var i:int=1;i<=15;i++)
			{
				bmds.push(global.getBD(domain , "MOUSE_BATTLE_" + i));
			}
			var cursorData:MouseCursorData = new MouseCursorData();
			cursorData.frameRate = 24;
			cursorData.data = bmds;
			Mouse.registerCursor(CursorManager.SWORD , cursorData);
			
		}
	}
}