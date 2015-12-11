package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	import com.gamehero.sxd2.gui.theme.ifstheme.Gametheme;
	
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.utils.effect.FontEffect;
	
	
	/**
	 * 渐变色文字 
	 * @author Trey
	 * @create-date 2013-11-10
	 */
	// Modify by Trey, 2013-11-30, 增加align、width设置
	// Modify by Trey, 2013-12-4, 增加ActiveObject、修正设置align不能显示文字的bug
	public class GText extends ActiveObject {
		
		private const COLORS:Array = [[0xFCFBB3, 0xDA9428] , [0xb7a56e, 0x5f4722],[0xd7deed,0xd7deed]];
		
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		private var _gtextSp:Sprite;
		
		// 渐变色类型 0    面板白色  2 
		public var colorType:int = 2;
		
		private var _width:int = 0;
		private var _height:int = 14;
		
		
		/**
		 * Constructor 
		 * 
		 */
		public function GText() {
		
			// 默认
//			_textFormat = new TextFormat("SimHei");	// 黑体
			_textFormat = new TextFormat("宋体");	// 宋体
			_textFormat.size = 12;
			_textFormat.leading  = 5;
			_textFormat.bold = false;
			
			// 创建个文本
			_textField = new TextField(); 
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.height = _height;
			_textField.selectable = false;
			_textField.defaultTextFormat = _textFormat;
			_textField.antiAliasType = AntiAliasType.ADVANCED;
			_textField.setTextFormat(_textFormat);
			_textField.mouseEnabled = false;
			
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			_gtextSp = new Sprite();
			_gtextSp.mouseEnabled = false;
			_gtextSp.mouseChildren = false;
			addChild(_gtextSp);
			_gtextSp.filters = [Gametheme.TEXT_FILTER];
			
			
			this._cursorActive = false;
		}
		
		
		/**
		 * Set Text 
		 * @param value
		 * 
		 */
		public function set text(value:String):void {
			
			_textField.text = value;
			
			FontEffect.getGradientText(_textField, COLORS[colorType] , "top", _gtextSp);
			
			// TRICKY: 必须设置，否则无法获得width、height
			super.width = _textField.width;
			super.height  = _textField.height;

//			draw();
		}
		public function get text():String {
			return _textField.text;
		}
		
		
		/**
		 * 设置字体大小 
		 * @param value
		 * 
		 */
		public function set size(value:int):void {
			
			_textFormat.size = value;
			_textField.defaultTextFormat = _textFormat;

			this.text = _textField.text;
		}
		
		
		/**
		 * 设置文本换行
		 * @param value
		 * 
		 */
		public function set wordWrap(value:Boolean):void {
			
			_textField.multiline = true;
			_textField.wordWrap = value;
			
			this.text = _textField.text;
		}
		
		
		/**
		 * Set Align 
		 * @param value
		 * 
		 */
		public function set align(value:String):void {
			
			// 需要先关闭autoSize
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.width = _width;
			_textField.height = _height;
			
			_textFormat.align = value;
			_textField.defaultTextFormat = _textFormat;
			
			this.text = _textField.text;
		}
		
		
		/**
		 * Set Width 
		 * @param value
		 * 
		 */
		override public function set width(value:Number):void {
			
			_width = value;
			_textField.width = _width;
			
			this.text = _textField.text;
		}
		
		/**
		 * Set Heigth 
		 * @param value
		 * 
		 */
		override public function set height(value:Number):void {
			
			_height = value;
			_textField.height = _height;
			
			this.text = _textField.text;
		}
		
		
		
		public function draw():void {
			
			graphics.clear();
			graphics.beginFill(0xFF0000, 1);
			graphics.drawRect(0, 0, this.width, this.height);
			
		}
		
	}
}