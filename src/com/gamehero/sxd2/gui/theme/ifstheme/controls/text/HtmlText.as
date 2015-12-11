package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	import com.gamehero.sxd2.data.GameDictionary;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 带html格式的TextField
	 * @author Trey
	 * @create-date 2014-1-22
	 */
	public class HtmlText extends ActiveObject {
		
		private var _textField:TextField;
		
		// 鼠标手型使用
		private var _activeObject:ActiveObject
		private var _isClickActive:Boolean
		
		protected var myEvent:EventDispatcher = new EventDispatcher();
		
		
		/**
		 * Constructor 
		 * 
		 */
		public function HtmlText() {
			
			super();
			
			this.cursorActive = true;
			
			_textField = new TextField();
			_textField.height = 20;
//			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.filters = [Label.TEXT_FILTER];
			_textField.selectable = false;
			_textField.type = TextFieldType.DYNAMIC;
//			_textField.border = true;
			_textField.multiline = true;
//			_textField.mouseEnabled = false;
			_textField.wordWrap = true; 
			_textField.multiline = true;
			addChild(_textField);
			
			var tf:TextFormat = new TextFormat();
			tf.color = GameDictionary.WHITE
			tf.size = 12;
			tf.font = GameDictionary.FONT_NAME;
			_textField.defaultTextFormat = tf;
			
			_activeObject = new ActiveObject();
		}
		
		
		public function set text(value:String):void {
			
			if(value == null)	return;
			
			
			_textField.htmlText = value;
			
			_textField.mouseEnabled = value.indexOf("</a") >= 0;
			
			// TO DO：为了使链接文字也有手型，今后通过MouseManager修改
			if(_textField.mouseEnabled) {
				addChild(_activeObject);
				_activeObject.cursorActive = true;
				_activeObject.graphics.clear();
				_activeObject.graphics.beginFill(0x777777, 0);
				_activeObject.graphics.drawRect(0, 0, _textField.width, _textField.height);
			}
			if(_isClickActive)
				_activeObject.addEventListener(MouseEvent.CLICK,activeObjectClickHandle);
			
			this.height = _textField.height;
		}
		
		private function activeObjectClickHandle(e:MouseEvent):void
		{
			var str:String = this._textField.htmlText;
			var strList:Array = str.split("event:");
			str = strList[1];
			strList = str.split('"');
			var textEvent:TextEvent = new TextEvent(TextEvent.LINK, true, false, strList[0]);
			dispatchEvent(textEvent);	
		}
		
		public function get text():String {
			
			return _textField.htmlText;
		}
		
		
		public function setTextWidth(value:Number):void {
			
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.width = value;
		}
		
		public function textField():TextField
		{
			return this._textField;
		}
		
		public function set isClickActive(bool:Boolean):void
		{
			_isClickActive = bool;
		}
		
		
		
		override public function set hint(value:String):void
		{
			if(_activeObject)
			{
				_activeObject.hint = value;
			}
		}
	}
}