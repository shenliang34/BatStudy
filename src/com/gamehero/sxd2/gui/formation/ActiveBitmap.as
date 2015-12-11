package com.gamehero.sxd2.gui.formation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.mouse.CursorManager;

	/**
	 * @author Wbin
	 * 创建时间：2015-9-17 下午8:45:02
	 * 
	 */
	public class ActiveBitmap extends ActiveObject
	{
		/**
		 * 图片显示 
		 */		
		public var bmp:Bitmap;
		public function ActiveBitmap(bmd:BitmapData)
		{
			super();
			this.cursorType = CursorManager.ARROW;
			bmp = new Bitmap(bmd);
			addChild(bmp);
		}
		
		public function clear():void
		{
			bmp = null;
		}
	}
}