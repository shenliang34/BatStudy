package com.gamehero.sxd2.gui.theme.ifstheme.controls {

	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ProgressBarSkin;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.primitives.stretch.HorizontalBar;
	import alternativa.gui.primitives.stretch.StretchRepeatBitmap;

	use namespace alternativagui;

	
	/**
	 * ProgressBar
	 * @author Trey
	 * @create-date 2013-8-14
	 */
	// Modify by Trey, 2014-4-11, 为了增加hint显示，继承修改为ActiveObject
//	public class ProgressBar extends GUIobject {
	public class ProgressBar extends ActiveObject {
		
		// RU: фон
        // EN: background
		protected var bgLine:HorizontalBar;

		// RU: заполненная линия
        // EN: filled line
		protected var fullLine:HorizontalBar;

		// RU: маска
        // EN: mask
		protected var maskLine:StretchRepeatBitmap;

		// RU: процент загрузки (0 - 1)
        // EN: load percent (from 0 to 1)
		protected var _percent:Number;

		// RU: смещение
        // EN: shift
		protected var offset:int = 1;

		// RU: текстовая метка
        // EN: text label
//		protected var _label:Label;
		public var labelTF:Label;
		

//		public function ProgressBar(lineBGClass:Class, lineFullClass:Class, maskClass:Class, offset:int = 1) {
		public function ProgressBar(lineBGSkin:BitmapData, lineFullSkin:BitmapData, maskSkin:BitmapData, offset:int = 1) {
			
			this.offset = offset;
			
//			bgLine = new HorizontalBar(ProgressBarSkin.lineBGTexture, ProgressBarSkin.edge, ProgressBarSkin.edge);
			var lineBGBD:BitmapData = lineBGSkin;
			bgLine = new HorizontalBar(lineBGBD, ProgressBarSkin.edge, ProgressBarSkin.edge);
			addChild(bgLine);
			
//			fullLine = new HorizontalBar(ProgressBarSkin.lineFullTexture, ProgressBarSkin.lineFullEdge, ProgressBarSkin.lineFullEdge);
			fullLine = new HorizontalBar(lineFullSkin, ProgressBarSkin.lineFullEdge, ProgressBarSkin.lineFullEdge);
			addChild(fullLine);
			
//			maskLine = new StretchRepeatBitmap(ProgressBarSkin.maskTexture, ProgressBarSkin.edge, ProgressBarSkin.edge, ProgressBarSkin.edge, ProgressBarSkin.edge);
			maskLine = new StretchRepeatBitmap(maskSkin, ProgressBarSkin.edge, ProgressBarSkin.edge, ProgressBarSkin.edge, ProgressBarSkin.edge);
			maskLine.cacheAsBitmap = true;
			fullLine.cacheAsBitmap = true;
			addChild(maskLine);
			fullLine.mask = maskLine;
			bgLine.height = 1;

			labelTF = new Label();
			addChild(labelTF);

//			_height = ProgressBarSkin.lineBGTexture.height;
			_height = lineBGBD.height;
			
			
			// 不需要手型
			this._cursorActive = false;
		}

		public function get percent():Number {
			return _percent;
		}

		public function set percent(value:Number):void {
			_percent = value;
			draw();
			drawChildren();
		}

		override protected function draw():void {
			
			super.draw();
			
//			bgLine.x = bgLine.y = -offset;
//			bgLine.resize(_width + offset * 2, _height + offsetY * 2);
			bgLine.resize(_width, _height);
			
			fullLine.x = fullLine.y = offset;
			fullLine.width = (_width - offset * 2) * _percent;
			
			maskLine.x = maskLine.y = offset;
			maskLine.width = _width - offset * 2;
			maskLine.height = _height;
			
			labelTF.x = (_width - int(labelTF.width)) >> 1;
			labelTF.y = ((_height - int(labelTF.height)) >> 1) - 1;
		}
		
		// RU: отдаем фиксированную высоту
        // EN: pass the fixes height
		override protected function calculateHeight(value:int):int {
			return _height;
		}

		public function get label():String {
			return labelTF.text;
		}

		public function set label(value:String):void {
			labelTF.text = value;
			draw();
			drawChildren();
		}
		
		
		// Add by Trey, 2013-11-21, 增加前景
		public function addForeground(foreground:DisplayObject, point:Point = null):void {
			
			foreground.x = (_width - foreground.width) >> 1;
			foreground.y = (_height - foreground.height) >> 1;
			
			if(point) {
				
				foreground.x += point.x;
				foreground.y += point.y;
			}
			
			this.addChildAt(foreground, getChildIndex(labelTF));
		}
	}
}
