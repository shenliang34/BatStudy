package com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar {

	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	
	import org.bytearray.display.ScaleBitmap;

	use namespace alternativagui;

	
	/**
	 * 自定义ScrollBar Track
	 * @author Trey
	 * @create-date 2013-9-7
	 */
	public class Track extends GUIobject {

//		private var bg:StretchRepeatBitmap;
		private var bg:ScaleBitmap;
		
		private var _edge:int;
		
//		public function Track(trackSkinClass:Class, edge:int = 0) {
		public function Track(trackSkinSkin:BitmapData, edge:int = 0) {
			
			super();
//			bg = new StretchRepeatBitmap(TextInputSkin.bgTexture, TextInputSkin.edge, TextInputSkin.edge, TextInputSkin.edge, TextInputSkin.edge);
			bg = new ScaleBitmap(trackSkinSkin);
			bg.scale9Grid = new Rectangle(3, 8, 5, 58);
			addChild(bg);
			
			
			_edge = edge;
			
			
			// RU: задаем ширину
            // EN: set the width
			_width = calculateWidth(_width);
		}
		
		// RU: отдаем фиксированную ширину
        // EN: return the fixed width
		override protected function calculateWidth(value:int):int {
			
//			return NumericConst.scrollBarWidth;
			return ScrollBar.SCROLL_BAR_WIDTH;
		}
		
		override protected function draw():void {
			
			super.draw();
			
//			bg.x = bg.y = -TextInputSkin.offset;
//			bg.width = _width + TextInputSkin.offset * 2;
//			bg.height = _height + TextInputSkin.offset * 2;
//			bg.width = _width;
			
			this.x = 1;//(_width - bg.width) >> 1;
			this.y = _edge;
			
			bg.height = _height - _edge * 2;
		}
	}
}
