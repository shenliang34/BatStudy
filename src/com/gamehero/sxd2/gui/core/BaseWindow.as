package com.gamehero.sxd2.gui.core {
		
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	/**
	 * Base Windonw UI
	 * @author Trey
	 * @create-date: 2012-10-18
	 */
	public class BaseWindow extends Sprite implements IWindow {

		public var windowName:String = "";
		
		public var windowParam:Object;	// 窗口打开参数

		protected var _loaded:Boolean = false;		// 是否已加载
		protected var _modal:Boolean = false;		// 是否模态
		protected var _modalAlpha:Number;	// 模态透明度
		
		protected var _width:Number;
		protected var _height:Number;
		
		private var _position:int;	// 窗口位置

		private var _askVars:Object;
		
		// 是否需要打开/关闭窗口动画相关
		public var canOpenTween:Boolean = true;
		

		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function BaseWindow(position:int) {
			
			this._position = position;
		}
		
		
		/**
		 * Show Window 
		 * 
		 */
		public function show():void {
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		/**
		 * Do Something After Show 
		 * 
		 */
		public function onShow():void 
		{	
			this.playOpenSound();
		}

		
		/**
		 * Close Window 
		 * 
		 */
		public function close():void 
		{	
			this.playCloseSound();
		}
		
		
		
		// 窗口开启音效
		protected function playOpenSound():void
		{
			SoundManager.inst.play(SoundConfig.OPEN_WINDOW);
		}
		
		
		
		// 窗口关闭音效
		protected function playCloseSound():void
		{
			SoundManager.inst.play(SoundConfig.CLOSE_WINDOW);
		}
		
		
		
		/**
		 * 计算实际的width、height
		 * 
		 */		
		protected function calculate():void {
			
			this.width = super.width;
			this.height = super.height;
		}
		
		
		public function get loaded():Boolean {
			
			return _loaded;
		}
		
		
		public function get modal():Boolean {
			
			return _modal;
		}
		
		
		public function set modal(value:Boolean):void
		{
			_modal = value;
		}
		
		
		public function get position():int
		{
			return _position;
		}
		
		
		public function set position(value:int):void
		{
			_position = value;
		}		
		
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
		}

		public function get modalAlpha():Number
		{
			return _modalAlpha;
		}

		public function set modalAlpha(value:Number):void
		{
			_modalAlpha = value;
		}
		
	}
}