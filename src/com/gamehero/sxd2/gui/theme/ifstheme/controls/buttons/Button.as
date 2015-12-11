package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.NumericConst;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.button.BaseButton;

	use namespace alternativagui;


	/**
	 * Button 
	 * @author Trey
	 * @create-date 2013-8-14
	 */
	public class Button extends BaseButton {
		
        // EN: minimal button height
		protected var _minHeight:int;

        // EN: padding
		protected var _padding:int;
		
        // EN: distance between an icon and a text label
		protected var _iconPadding:int;
		
        // EN: text label
		protected var _label:Label;
		
        // EN: icon
		protected var _icon:DisplayObject;

		
		/**
		 * Constuctor
		 * @param UpSkinClass
		 * @param downSkinClass
		 * @param overSkinClass
		 * @param disableSkinClass
		 * 
		 */
//		public function Button(UpSkinClass:Class, downSkinClass:Class = null, overSkinClass:Class = null, disableSkinClass:Class = null) {
		public function Button(UpSkin:BitmapData, downSkin:BitmapData = null, overSkin:BitmapData = null, disableSkin:BitmapData = null) {
	
			super();
			
			_minHeight = NumericConst.buttonMinHeight;
			_height = _minHeight;
			_padding = NumericConst.basePadding;
			_iconPadding = NumericConst.baseIconPadding;
			
            // EN: set the button states
//			stateUP = new ButtonSkinState(ButtonSkin.stateUpBgTexture, ButtonSkin.stateUpBottomGradientTexture);
//			stateDOWN = new ButtonSkinState(ButtonSkin.stateDownBgTexture, ButtonSkin.stateDownBottomGradientTexture, ButtonSkin.stateDownBorderTexture);
//			stateOVER = new ButtonSkinState(ButtonSkin.stateOverBgTexture, ButtonSkin.stateOverBottomGradientTexture);
			
//			var upSkin:Bitmap = new Bitmap(new UpSkinClass());
			var upSkin:Bitmap = new Bitmap(UpSkin);
			
			stateUP = upSkin;
			if(downSkin) {
				
//				stateDOWN = new Bitmap(new downSkinClass());
				stateDOWN = new Bitmap(downSkin);
			}
			if(overSkin) {
				
//				stateOVER = new Bitmap(new overSkinClass());
				stateOVER = new Bitmap(overSkin);
			}
			if(disableSkin) {
				
//				stateOFF = new Bitmap(new disableSkinClass());
				stateOFF = new Bitmap(disableSkin);
			}
			
			
			// TRICKY: 根据UP_SKIN确定按钮大小，无需再设置按钮大小
			this._width = upSkin.width;
			this._height = upSkin.height;
		}

		
		public function get padding():int {
			return _padding;
		}

		public function set padding(value:int):void {
			_padding = value;
		}

		public function get iconPadding():int {
			return _iconPadding;
		}

		public function set iconPadding(value:int):void {
			_iconPadding = value;
		}

		public function get label():String {
			if (_label != null) {
				return _label.text;
			} else {
				return "";
			}
		}

		public function set label(value:String):void {
			
			if (_label == null) {
				
				_label = new Label();
				_label.color = GameDictionary.WHITE;
				addChild(_label);
			}
			
			if (value != null || value != "") {
				
				_label.text = value;
			} 
			else {
				
				if (_label != null) {
					
					if (contains(_label)) {
						
						removeChild(_label);
					}
					
					_label = null;
				}
			}
			
			draw();
		}

		public function get icon():DisplayObject {
			return _icon;
		}

		public function set icon(object:DisplayObject):void {
			if (_icon != null) {
				removeChild(_icon);
			}
			if (object != null) {
				_icon = object;
				addChild(_icon);
			}
			draw();
		}
		
		// RU: если кнопка неактивна(залоченна), тогда меняем прозрачность у икноки и текстовой метки
        // EN: if button is inactive (lock), then change icon transparency and text label transparency
		override public function set locked(value:Boolean):void {
			super.locked = value;
			if (_locked) {
				if (_label != null) {
					_label.alpha = NumericConst.lockedAlpha;
				}
				if (_icon != null) {
					_icon.alpha = NumericConst.lockedAlpha;
				}
				
				this.filters = FiltersUtil.BW_Fiter;
			} else {
				if (_label != null) {
					_label.alpha = 1;
				}
				if (_icon != null) {
					_icon.alpha = 1;
				}
				
				this.filters = null;
			}
		}
		
		// RU: различное поведение при наведении: просто навели, отвели. Навели и отвели когда кнопка была зажатой.
        // EN: different behavior on mouse on: mouse on -> mouse out, mouse on->mouse out when mouse button is pressed
		override public function set over(value:Boolean):void {

			if (!_locked)
				_over = value;
			if (!_locked && !_pressed) {
				setState(value ? _stateOVER : _stateUP);
			} else if (!_locked && _pressed) {
				if (_over && _pressed) {
					if (_label != null) {
						_label.y = ((_height - int(_label.height)) >> 1);
					}
					if (_icon != null) {
						_icon.y = ((_height - _icon.height) >> 1) + 1;
					}
					setState(_stateDOWN);
				} else if (!_over && _pressed) {
					if (_label != null) {
						_label.y = ((_height - int(_label.height)) >> 1);
					}
					if (_icon != null) {
						_icon.y = ((_height - _icon.height) >> 1);
					}
					setState(_stateUP);
				}
			}

			// 悬浮音效
			/*if(value == true)
			{
				SoundManager.inst.play(SoundConfig.BTN_MOUSE_OVER);
			}*/
		}

		override public function set pressed(value:Boolean):void {
			super.pressed = value;

			if (_label != null) {
				if (_pressed) {
					_label.y = ((_height - int(_label.height)) >> 1);
				} else {
					_label.y = ((_height - int(_label.height)) >> 1) - 1;
				}

			}

			if (_icon != null) {
				if (_pressed) {
					_icon.y = ((_height - _icon.height) >> 1) + 1;
				} else {
					_icon.y = (_height - _icon.height) >> 1;
				}
			}
			
			// 点击音效
			/*if(value == true)
			{
				SoundManager.instance.play(SoundConfig.BTN_MOUSE_CLICK);
			}*/
		}
		
		// RU: позиционирование иконки и текстовой метки
        // EN: set position to a icon and a text label
		override protected function draw():void {
			super.draw();
			if (_label != null) {
				_label.x = (_width - int(_label.width)) >> 1;
				_label.y = ((_height - int(_label.height)) >> 1) - 1;
			}

			if (_icon != null) {
				if (_label != null) {
					_icon.x = (_width - _icon.width - _label.width - _iconPadding) >> 1;
					_label.x = _icon.x + int(_icon.width) + _iconPadding;
				} else {
					_icon.x = (_width - _icon.width) >> 1;
				}
				_icon.y = (_height - _icon.height) >> 1;

			}
		}
		
		// RU: смотрим значение ширины, если меньше заданного, отдаем минимальную ширину
        // EN: if width value is less than the specified value, then return minimal width value
		override protected function calculateWidth(value:int):int {
			var w:int = (_label != null ? _label.width : 0) + (_icon != null ? (_icon.width + _iconPadding) : 0) + _padding * 2;
			if (value < w) {
				return w;
			} else {
				return value;
			}
		}
		
		// RU: смотрим значение высоты, если меньше заданного, отдаем минимальную высоту
        // EN: if height value is less than the specified value, then return minimal height value
		override protected function calculateHeight(value:int):int {
			if (value < _minHeight) {
				return _minHeight;
			} else {
				return value;
			}
		}
		
		
		
		// 设置文字颜色 add by xuwenyi 2013-10-16
		public function setLabelColor(color:uint):void
		{
			if(_label)
			{
				_label.color = color;
			}
		}
		
		// 设置文字大小 add by xuwenyi 2015-02-12
		public function setLabelSize(size:uint):void
		{
			if(_label)
			{
				_label.size = size;
				
				// 微调
				if(size <= 11)
				{
					_label.x += 1;
					_label.y -= 1;
				}
			}
		}

	}
}
