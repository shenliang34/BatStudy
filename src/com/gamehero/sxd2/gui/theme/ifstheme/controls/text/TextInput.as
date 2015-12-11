package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	import com.gamehero.sxd2.data.GameDictionary;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.text.TextInput;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 * 自定义TextInput 
	 * @author Trey
	 * @create-date 2013-10-26
	 */
	// Modify by Trey, 2013-11-19, 支持设置height
	public class TextInput extends alternativa.gui.controls.text.TextInput {
		
		// RU: высота текста
        // EN: text height
		protected var textHeight:int;
		
		// RU: флаг ширины текстовой метки у инпут поля. Если true - ширина, отводимая под текстовую метку, равна ширине текстовой метки, иначе задается извне - labelWidth
        // EN: flag of text label height on input area. If true, then width reserved for the text label is equal to text label width, else width is set from outside - labelWidth
		protected var labelAutoSize:Boolean = true;

		// RU: смещение от краев по горизонтали
        // EN: Shift from borders horizontally
		protected var _offsetBorder:int = 0;
		
		// RU: флаг блокировки
        // EN: locked/unlocked
		protected var _locked:Boolean;

		public function TextInput(isNeedBackground:Boolean = true) {
			
			super();
			color = NumericConst.textColor;
			_paddingH = 8;
			
			//background = new WhiteBG();
			if(isNeedBackground) {
				
				//var sb:ScaleBitmap = new ScaleBitmap(CommonSkin.textInputBg);
				//sb.scale9Grid = CommonSkin.textInputScale9Grid;
				//background = sb;
			}
			
			this.color = GameDictionary.WHITE;

			_height = calculateHeight(_height);
		}
		


		override public function set labelWidth(value:int):void {
			
			super.labelWidth = value;
			labelAutoSize = false;
		}

		override public function set labelText(value:String):void {
			
			super.labelText = value;
			if (label != null) {
				
				if (labelAutoSize) {
					label.autosize = true;
					_labelWidth = label.width;
				}
				label.size = NumericConst.textSize;
//				label.color = NumericConst.textColor;
				label.color = _labelColor;
			}
			draw();
		}
		
		
		// Add by Trey, 2013-12-3, 增加labelColor功能
		private var _labelColor:uint = NumericConst.textColor;;
		public function set labelColor(value:uint):void {
			
			_labelColor = value;
			if (label != null) {
				
				label.color = _labelColor;
			}
			
			draw();
		}
		

		// RU: позиционирование и задание размеров
        // EN: set position and sizes
		override protected function draw():void {
			
			super.draw();
			if (label != null) {
				
				label.x = 0;
				label.y = (_height - label.height) >> 1;
			}
			if (_background != null) {
				_background.x = -_offsetBorder + ((label != null) ? (_labelWidth + _labelMargin) : 0);
				_background.y = -_offsetBorder;
				_background.width = _width + _offsetBorder * 2 - ((label != null) ? (_labelWidth + _labelMargin) : 0);
				;
				_background.height = _height + _offsetBorder * 2;
			}
			tf.x = _paddingH - 3 + ((label != null) ? (_labelWidth + _labelMargin) : 0);
			
			// Modify by Trey, 2013-11-19, 若有背景，才居中tf
//			tf.y = int((_height - tf.textHeight) >> 1) - 2;
			if(background) {
				
				tf.y = int((_height - tf.textHeight) >> 1) - 2;
			}
			
			
			tf.width = _width - _paddingH * 2 + 4 - ((label != null) ? (_labelWidth + _labelMargin) : 0);
			tf.height = _height - tf.y;
		}

		public function get locked():Boolean {
			
			return _locked;
		}
		
		// RU: неактивность компоненты. Изменяется прозрачность
        // EN: component inactivity. Transparency is changed
		public function set locked(value:Boolean):void {
			
			_locked = value;

			if (_locked) {
				this.alpha = NumericConst.lockedAlpha;
			} else {
				this.alpha = 1;
			}

			tf.tabEnabled = !_locked;
			tf.mouseEnabled = !_locked;
		}
		
		// RU: отдаем фиксированную высоту
        // EN: pass the  fixed height
		override protected function calculateHeight(value:int):int {
			
			// Comment by Trey, 2013-11-19, 使用自己的height
//			value = NumericConst.buttonMinHeight;
			
			tf.height = value - _paddingV;
			return value;
		}
		
		// RU: смотрим значение ширины, если меньше заданного, отдаем минимальную ширину
        // EN: if height value is less than the specified value, then return minimal height value
		override protected function calculateWidth(value:int):int {
			
			var labelW:int = label != null ? (_labelWidth + _labelMargin) : 0;
			if ((value) < (NumericConst.textInputMinWidth + labelW))
				value = NumericConst.textInputMinWidth + labelW;
			tf.width = value - _paddingH * 2;
			textHeight = _height - _paddingV;
			return value;
		}

		override public function set width(value:Number):void {
			_width = calculateWidth(value);
			draw();
		}
		// RU: корректировка ширины текстового поля
        // EN: adjusting the text field width
		override protected function correctSize():void {
			super.correctSize();
			tf.width = _width - _paddingH * 2;
		}


		// Add by Trey, 2013-11-19, 支持设置height
		override public function set height(value:Number):void {
			
			_height = calculateHeight(value);
			draw();
		}
	}
}
