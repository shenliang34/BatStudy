package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	
	import alternativa.gui.mouse.ICursorActive;
	import alternativa.gui.mouse.ICursorActiveListener;


	/**
	 * 带有Hint的自定义Lable控件<br/>
	 * 继承 ICursorActive（实现hint）<br/>
	 * @author Trey
	 * 
	 */
	public class HintLabel extends Label implements ICursorActive{
		
		
		/**
		 * Подписчики на события курсора.	 
		 */		
		protected var _cursorListeners:Array;
		
		/**
		 * Флаг включения/выключения приема событий курсора. 
		 */		
		protected var _cursorActive:Boolean;
		
		/**
		 * Хинт. 
		 */		
		protected var _hint:String;
		
		/**
		 * Тип курсора.
		 */
		protected var _cursorType:String;
		

		
		/**
		 * Constructor 
		 * @param autosize
		 * 
		 */
		public function HintLabel(autosize:Boolean=true) {
			
			super(autosize);
		}
		
		
		
		//----- ICursorActive
		/**
		 * @inheritDoc
		 */		
		public function addCursorListener(listener:ICursorActiveListener):void {
			if (_cursorListeners.indexOf(listener) == -1) {
				_cursorListeners.push(listener);
			}
		}
		
		/**
		 * @inheritDoc
		 */			
		public function removeCursorListener(listener:ICursorActiveListener):void {
			var index:int = _cursorListeners.indexOf(listener);
			if (index != -1) {
				_cursorListeners.splice(index, 1);
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get cursorListeners():Array {
			return _cursorListeners;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get cursorActive():Boolean {
			return _cursorActive;
		}
		public function set cursorActive(value:Boolean):void {
			_cursorActive = value;
		}
		
		/**
		 * @inheritDoc
		 */		 
		public function get hint():String {
			return _hint;
		}
		public function set hint(value:String):void {
			_hint = value;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get cursorType():String {
			return _cursorType;
		}
		
		public function set cursorType(value:String):void {
			_cursorType = value;
		}

		
		
	}
}
