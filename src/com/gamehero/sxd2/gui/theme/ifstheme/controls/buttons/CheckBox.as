package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {

	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.button.CheckBox;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 * 自定义CheckBox 
	 * @author Trey
	 * @create-date 2013-10-26
	 */
	public class CheckBox extends alternativa.gui.controls.button.CheckBox {

//		public function CheckBox(checkBoxUpClass:Class = null, checkBoxIconClass:Class = null) {
		public function CheckBox(checkBoxUpSkin:BitmapData = null, checkBoxIconSkin:BitmapData = null) {
	
			super();

			// RU: задаем размеры квадрату - фон под галкой
            // EN: set sizes to square - background over the check
//			boxMinSize = 16;
//			boxMaxSize = 16;
			boxMinSize = 19;
			boxMaxSize = 19;
			
			boxWidth = 19;
			boxHeight = 18;
			

			_space = NumericConst.baseIconPadding;

			// RU: задаем состояния
            // EN: set states
			var skin:BitmapData = checkBoxUpSkin != null ? checkBoxUpSkin : CommonSkin.checkboxUp;
			var skinBD:BitmapData = skin;
			stateUP = new Bitmap(skinBD);
			_stateUP.width = skinBD.width;
			_stateUP.height = skinBD.height;
			
			stateOVER = new Bitmap(skinBD);
			stateDOWN = new Bitmap(skinBD);
			stateOFF = new Bitmap(skinBD);

			// RU: задаем галку
            // EN: set the check
			skin = checkBoxIconSkin != null ? checkBoxIconSkin : CommonSkin.checkboxSelectUp;
			checkSign = new Bitmap(skin);
			
			resize(1,1);
		}
		
		// RU: при неактивности компоненты изменяется прозрачность
        // EN: on component inactivity transparency is changed
		override public function set locked(value:Boolean):void {
			super.locked = value;
			if (locked) {
				this.alpha = NumericConst.lockedAlpha;
			} else {
				this.alpha = 1;
			}
		}

		override public function get label():String {
			return _label.text;
		}

		override public function set label(value:String):void {
			
//			super.label = value;
//			
//			if (_label != null) {
//				
//				_label.size = NumericConst.textSize;
//				_label.color = NumericConst.textColor;
//				width = _width;
//			}
			
			if (_label == null) {
				
				_label = new Label();
				addChild(_label);
			}
			_label.text = value;
			
			width = _width;
		}
		
		
		
		override public function set pressed(value:Boolean):void
		{
			super.pressed = value;
			
			// 点击音效
			/*if(value == true)
			{
				SoundManager.instance.play(SoundConfig.BTN_MOUSE_CLICK);
			}*/
		}
		
		
		
		
		
		// 设置文字颜色 add by xuwenyi 2013-10-16
		public function setLabelColor(color:uint):void
		{
			if(_label)
			{
				_label.color = color;
			}
		}
		
	}
}
