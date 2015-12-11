package com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.button.BaseButton;
	
	import org.bytearray.display.ScaleBitmap;

	use namespace alternativagui;
	
	
	
	// RU: кнопка для ScrollBar, содержит визуал и иконку. Используется как кнопка "вверх", "вниз", бегунок
    // EN: button for the ScrollBar. It contains a visual part and an icon. It used as up/down button and scroller.
	/**
	 * 自定义ScrollButton 
	 * @author Trey
	 * @create-date 2013-9-7
	 */
	public class ScrollButton extends BaseButton {
		
		// RU: минимальная высота кнопки
        // EN: minimal button height
//		protected var _minHeight:int = NumericConst.scrollBarWidth;
		// 上、下按钮高度
		protected var _minHeight:int = 30;
		
		// RU: флаг фиксированной высоты
        // EN: flag of fixed height
		protected var _autoHeight:Boolean = true;
		
		// RU: иконка
        // EN: icon
		protected var _icon:DisplayObject;

		
		
//		public function ScrollButton(statUPClass:Class, stateDOWNClass:Class, stateOVERClass:Class, stateOFFClass:Class = null, 
//									 scale9Grid:Rectangle = null, iconClass=null) {
		public function ScrollButton(statUPSkin:BitmapData, stateDOWNSkin:BitmapData, stateOVERSkin:BitmapData, stateOFFSkin:BitmapData = null, 
									 scale9Grid:Rectangle = null, iconSkin = null) {
			
			super();
			
			// RU: задаем состояния
            // EN: set states
//			stateUP = new StretchRepeatVBitmap(ScrollBarSkin.runnerUpBD, ScrollBarSkin.edge, ScrollBarSkin.edge);
//			_stateUP.width = ScrollBarSkin.runnerUpBD.width;
//			stateDOWN = new StretchRepeatVBitmap(ScrollBarSkin.runnerDownBD, ScrollBarSkin.edge, ScrollBarSkin.edge);
//			stateOVER = new StretchRepeatVBitmap(ScrollBarSkin.runnerOverBD, ScrollBarSkin.edge, ScrollBarSkin.edge);
			
			if(iconSkin ){
				icon = new Bitmap( iconSkin );
			}
			
			if(!scale9Grid) {
				
				var bd:BitmapData = statUPSkin;
				stateUP = new Bitmap(bd);
				_stateUP.width = bd.width;
				stateDOWN = new Bitmap(stateDOWNSkin);
				stateOVER = new Bitmap(stateOVERSkin);
			}
			else {
				
				var scaleBp:ScaleBitmap;

				scaleBp = new ScaleBitmap( statUPSkin);
				scaleBp.scale9Grid = scale9Grid;
				stateUP = scaleBp;
				_stateUP.width = scaleBp.width;
				
				scaleBp = new ScaleBitmap( stateDOWNSkin);
				scaleBp.scale9Grid = scale9Grid;
				stateDOWN = scaleBp;
				
				scaleBp = new ScaleBitmap( stateOVERSkin);
				scaleBp.scale9Grid = scale9Grid;
				stateOVER = scaleBp;
				
				_minHeight = _minHeight;
			}
			
			_width = calculateWidth(_width);
			_height = calculateHeight(_height);
		}

		public function get icon():DisplayObject {
			return _icon;
		}

		public function set icon(value:DisplayObject):void {
			if (_icon != null) {
				if (contains(_icon)) {
					removeChild(_icon);
				}
				_icon = null;
			}
			if (value != null) {
				_icon = value;
				addChild(_icon);
			}
			draw();
		}

		public function get autoHeight():Boolean {
			return _autoHeight;
		}

		public function set autoHeight(value:Boolean):void {
			_autoHeight = value;
		}

		public function get minHeight():int {
			return _minHeight;
		}

		public function set minHeight(value:int):void {
			_minHeight = value;
		}

		override protected function draw():void {
			super.draw();
			if (_icon != null) {
				_icon.x = (_width - _icon.width) >> 1;
				_icon.y = (_height - _icon.height) >> 1;
			}
		}

		// RU: смотрим значение высоты, если меньше заданного, отдаем минимальную высоту
        // EN: if height value is less than the specified value, then return minimal height value
		override protected function calculateHeight(value:int):int {
			if (_autoHeight) {
				return _minHeight;
			} else {
				if (value < _minHeight) {
					return _minHeight;
				} else {
					return value;
				}
			}
		}
		
		// RU: отдаем фиксированную высоту
        // EN: return the fixed height
		override protected function calculateWidth(value:int):int {
			return _stateUP.width;
		}

	}
}
