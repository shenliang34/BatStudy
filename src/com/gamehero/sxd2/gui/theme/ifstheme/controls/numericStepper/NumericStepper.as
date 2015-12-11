package com.gamehero.sxd2.gui.theme.ifstheme.controls.numericStepper {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextInput;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	public class NumericStepper extends GUIobject {

		// RU: смещение для рамки
        // EN: shift for a frame
		protected var offsetBorder:int = NumericConst.borderThickness;
		
		private var _minValue:int;
		
		private var _maxValue:int;
		
		private var _background:Bitmap;
		
		private var textInput:TextInput;
		
		private var _padding:int = 1;
		
		private var _increaseButton:Button;
		private var _decreaseButton:Button;
		
		private var _value:int;

		/**
         *
		 */
		public function NumericStepper(min:int = 0,max:int = 0) {

			_background = new Bitmap(CommonSkin.NUMBER_INPUT_BG);
			textInput = new TextInput();
			textInput.color = GameDictionary.WINDOW_WHITE;
			textInput.align = TextFormatAlign.CENTER;
			textInput.tf.restrict = "0-9 . ,";
			textInput.text = String(_value);
			textInput.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			textInput.addEventListener(FocusEvent.FOCUS_OUT, keyboardHandler);
			
			_increaseButton = new Button(CommonSkin.PLUS_UP,CommonSkin.PLUS_DOWN,CommonSkin.PLUS_OVER);
			_increaseButton.name = "increaseButton"; 
			_increaseButton.addEventListener(MouseEvent.CLICK,onIncrease);

			// RU: создание и добавление кнопки уменьшения значения
			_decreaseButton = new Button(CommonSkin.CUT_UP,CommonSkin.CUT_DOW,CommonSkin.CUT_OVER);
			_decreaseButton.name = "decreaseButton";
			_decreaseButton.addEventListener(MouseEvent.CLICK,onDecrease);
			
			addChild(_background);
			addChild(textInput);
			addChild(_increaseButton);
			addChild(_decreaseButton);
			// RU: задаем высоту кнопки
            // EN: set the button height
			_height = calculateHeight(_height);
			
		
			// RU: вызываем отрисовку
            // EN: call draw method
			draw();
		}
		
		protected function onIncrease(event:MouseEvent):void
		{
			if(int(textInput.text) >= maxValue)
			{
				textInput.text = maxValue + "";
			}
		}
		
		protected function onDecrease(event:MouseEvent):void
		{
			if(int(textInput.text) <= minValue)
			{
				textInput.text = minValue + "";
			}
		}
		
		protected function keyboardHandler(e:Event):void
		{
			if (e is KeyboardEvent) {
				if ((e as KeyboardEvent).keyCode == Keyboard.ENTER) {
					value = Number(textInput.text);
				}
			}
			else
			{
				value = Number(textInput.text);
			}
		}		
		
		// RU: позиционирование и задание размеров
        // EN: set position and sizes

		public function get value():int
		{
			return _value;
		}

		public function get maxValue():int
		{
			return _maxValue;
		}

		public function set maxValue(value:int):void
		{
			_maxValue = value;
		}

		public function get minValue():int
		{
			return _minValue;
		}

		public function set minValue(value:int):void
		{
			_minValue = value;
		}

		override protected function draw():void {
			
			_decreaseButton.x = 0;
			_decreaseButton.y = 0;

			_background.x = _decreaseButton.x + _decreaseButton.width +  _padding;
			_background.y = _decreaseButton.height - _background.height >> 1;
			
			textInput.x = _background.x + _padding;
			textInput.height = _background.height - _padding * 2;
			textInput.y = _decreaseButton.height - textInput.height >> 1;
			textInput.width = _background.width - _padding * 2;
			
			_increaseButton.x = _background.x + _background.width + _padding;
			_increaseButton.y = 0;
			

		}
		
		public function set value(v:int):void
		{
			_value = v;
			textInput.text = "" + v;
			dispatchEvent(new Event(Event.CHANGE));
		}

		// RU: возвращаем высоту
        // EN: return the height
		override protected function calculateHeight(value:int):int {
			value = NumericConst.buttonMinHeight;
			textInput.height = value;
			return value;
		}
		
		// RU: смотрим значение ширины, если меньше заданного, отдаем минимальную ширину
        // EN: if width value is less than the specified value, then return minimal width value
		override protected function calculateWidth(value:int):int {
			if (value < NumericConst.numStepMinWidth)
				value = NumericConst.numStepMinWidth;
			return value;
		}

		

	}
}
