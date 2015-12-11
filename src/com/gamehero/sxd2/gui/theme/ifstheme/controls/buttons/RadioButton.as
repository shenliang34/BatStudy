package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {

	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.button.RadioButton;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 * RU: Кнопка - переключатель
     * EN: Radiobutton
	 * 
	 */	
	public class RadioButton extends alternativa.gui.controls.button.RadioButton 
	{
		// 按钮上的文字(区别于RadioButton自带的label)
		private var btnLabel:Label;
		
		
		/**
		 * 构造函数
		 * */
		public function RadioButton(statUPSkin:BitmapData, stateOVERSkin:BitmapData, stateDotSkin:BitmapData = null) {
			
			super();
			
			// RU: задаем размеры квадрату - фон под галкой
			// EN: set sizes to square - background over the check
//			boxMinSize = 16;
//			boxMaxSize = 16;
			
			// RU: зазор между иконкой и текстовой меткой
            // EN: distance between an icon and a text label
			_space = NumericConst.baseIconPadding;
			
			// RU: задаем состояния кнопки
            // EN: set the button states
			
			var bd:BitmapData = statUPSkin;
			stateUP = new Bitmap(bd);
			_stateUP.width = bd.width;
			_stateUP.height = bd.height;
			boxMinSize = bd.width;
			boxMaxSize = bd.height;
			
			stateOVER = new Bitmap(stateOVERSkin);
			stateDOWN = new Bitmap(statUPSkin);
			stateOFF = new Bitmap(statUPSkin);
			
			
			// RU: кружок для кнопки
            // EN: circle for the button
			checkSign = new Bitmap(stateDotSkin);
			
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		override public function get label():String {
			return _label.text;
		}
		
		override public function set label(value:String):void {
			super.label = value;
			if (_label != null) {
//				_label.size = NumericConst.textSize;
//				_label.color = NumericConst.textColor;
				width = _width;
			}
		}
		
		/**
		 * 点击
		 */
		private function onClick(evt:MouseEvent):void
		{
			SoundManager.instance.play(SoundConfig.BTN_MOUSE_CLICK);
		}
		
		/**
		 * 鼠标移入
		 */
		private function onOver(evt:MouseEvent):void
		{
			SoundManager.instance.play(SoundConfig.BTN_MOUSE_OVER);
		}
		
		
		
		
		/**
		 * 自定义的按钮文字
		 * */
		public function setBtnLabel(text:String , color:uint , size:uint = 12):void
		{
			if (btnLabel == null) 
			{
				btnLabel = new Label(false);
				btnLabel.height = 14;
				btnLabel.align = Align.CENTER;
				this.addChild(btnLabel);
			}
			btnLabel.text = text;
			btnLabel.color = color;
			btnLabel.size = size;
			
			// 定位文本
			width = _width;
			height = _height;
			btnLabel.width = _width;
			btnLabel.y = (_height - btnLabel.height) >> 1;
			
			// 微调
			/*if(size <= 11)
			{
				btnLabel.x += 1;
				btnLabel.y -= 1;
			}*/
		}
		
	}
}
