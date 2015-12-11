package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree {

	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.theme.defaulttheme.controls.buttons.Button;

	use namespace alternativagui;

	
    // EN: extend ListObject class. Visual class of tree item. Contains icons: opened/closed, folder, file.
	/**
	 * 自定义TaskTracerTreeObject 
	 * @author Trey
	 * @create-date 2013-9-6
	 * @modify by xuqiuyang 
	 */
	public class TaskTracerTreeObject extends TaskTreeListObject {

		static private const LIST_OBJECT_HEIGHT:int = 20;
		
		static private const WIDTH:int = 200;
		

//		static public var ARROW_OPEN:Class;
//		static public var ARROW_CLOSE:Class;
		static public var ARROW_OPEN:BitmapData;
		static public var ARROW_CLOSE:BitmapData;
		
		
        // EN: nesting level
		protected var level:int = 0;
		
        // EN: icon of the opened button
		protected var folderOpen:Bitmap;
		
        // EN: icon of the closed button
		protected var folderClose:Bitmap;
		
        // EN: file icon
		protected var file:Bitmap;
		
        // EN: container for the arrow icon
		protected var arrowIcon:DisplayObject;
		
        // EN: arrow icon - branch is opened
		protected var arrowOpened:Bitmap;
		
        // EN: arrow icon - branch is closed
		protected var arrowClosed:Bitmap;
		
        // EN: width of the arrow icon
//		protected var arrowWidth:int = 9;
		protected var arrowWidth:int = 50;
		
        // EN: padding of the arrow icon
//		protected var arrowPadding:int = NumericConst.basePadding;
//		protected var arrowPadding:int = 10;
		protected var arrowPadding:int = 5;

		private var redBtn:Button;
		private var blueBtn:Button;
		private var btn:Button;
		
		private var arrow:ActiveObject;

		public function TaskTracerTreeObject() {
			
			super();
			
            // EN: padding
			_padding = 15;
			
            // EN: set an icon
//			folderOpen = new Bitmap(TreeSkin.folderOpen);
//			folderClose = new Bitmap(TreeSkin.folderClose);

//			arrowOpen = new Bitmap(TreeSkin.arrowOpen);
//			arrowClose = new Bitmap(TreeSkin.arrowClose);
			/*
			arrow = new ActiveObject();
			addChild(arrow);
			arrow.cursorActive = true;
			
			arrowOpened = new Bitmap(ARROW_CLOSE);
			arrow.addChild(arrowOpened);
			arrowOpened.visible = false;
			
			arrowClosed = new Bitmap(ARROW_OPEN);
			arrow.addChild(arrowClosed);
			arrowClosed.visible = false;

//			file = new Bitmap(TreeSkin.file);
			
			arrowIcon = new GUIobject();
			*/
			
			// Add by xuqiuyang，为了修改_label的属性，支持换行
			_label.setTextWidth(WIDTH);
			var tf:TextFormat = _label.textField().defaultTextFormat;
			tf.leading = 10;
			
			var textField:TextField = _label.textField();
			textField.defaultTextFormat = tf;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.wordWrap = true;
			textField.mouseWheelEnabled = false;
			
			this.mouseEnabled = false;
			this.cursorActive = false;
		}
		
		
        // EN: receive the data
		override public function set data(value:Object):void {
			
			_data = value;
			if (_data != null) {
				
				level = _data.level;
				_label.text = _data.label;
			} 
			else 
			{
				_label.text = " ";
				level = 0;
			}
			draw();
		}
        // EN: set position and sizes
		override protected function draw():void {
			
			super.draw();
			
			if (_data != null) {
				
//				_label.y = (_height - _label.height) >> 1;
				_label.y = 0;
				
				if (_data.canExpand) {
					/*
					arrowIcon.x = _padding * level + ((arrowWidth - arrowIcon.width) >> 1);
					arrowIcon.y = (_height - arrowIcon.height) >> 1;
					*/
//					_label.x = _padding * level;// + arrowWidth + arrowPadding;

//					_label.width = _width - _padding * level - arrowPadding - arrowWidth;
					_label.y = 10;
				} 
				// 子项
				else {
					
					/** 子项x */
//					_label.x = _padding * level + arrowPadding + arrowWidth;
					// 子项多缩进10
//					_label.x = arrowPadding + arrowWidth - 10;
					_label.x = 20;//arrowPadding + arrowWidth + 1;
					_label.y = 5;
					
//					_label.width = _width - _padding * level - arrowPadding - arrowWidth;
				}
				
//				_label.height = 1;
				
			}
		}
		
		
		// EN: height of this item is constant
		override public function get height():Number {
			
			//			return NumericConst.itemHeight;
//			return LIST_OBJECT_HEIGHT;
//			trace("_label.height:",_label.height);
			
			var hh:Number = _label.height;
			
			if(btn) {
				
				hh += btn.height + 5;
			}
			
			return hh;
		}
	}
}
