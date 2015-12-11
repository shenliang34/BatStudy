package com.gamehero.sxd2.util
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	
	/**
	 * 
	 * @author wulongbin
	 * 
	 */
	public class MouseUtil
	{
		/**
		 * 添加鼠标手型 
		 * @param display
		 * 
		 */		
		public static function addMouseCursor(display:DisplayObject):void
		{
			display.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			display.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
		}
		
		/**
		 * 移除鼠标手型 
		 * @param display
		 * 
		 */		
		public static function removeMouseCursor(display:DisplayObject):void
		{
			display.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			display.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
		}
		
		private static function onRollOver(event:Event):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private static function onRollOut(event:Event):void
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
	}
}