package com.gamehero.sxd2.gui.core.tab
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-11-25 上午10:46:00
	 * 
	 */
	public class TabBarBtn extends ActiveObject
	{
		
		/**
		 * 背景 
		 */		
		protected var _bg:Bitmap;
		
		protected var _data:Object;
		
		/**
		 * 划过状态 
		 */		
		protected var _overBd:BitmapData;
		/**
		 * 正常状态 
		 */		
		protected var _normalBd:BitmapData;
		/**
		 * 选中状态 
		 */		
		protected var _selectedBd:BitmapData;
		
		protected var _index:int;
		
		protected var _canClick:Boolean;
		
		/**
		 * 是否选中 
		 */		
		protected var _selected:Boolean = false;
		
		
		public function TabBarBtn(normalBd:BitmapData,selectedBd:BitmapData,overBd:BitmapData)
		{
			super();
			_overBd = overBd;
			_normalBd = normalBd;
			_selectedBd = selectedBd;
			//拼图
			_bg = new Bitmap();
			addChild(_bg);
			_bg.bitmapData = normalBd;
			
			this.mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			addEventListener(MouseEvent.ROLL_OVER,onMouseOver);
			addEventListener(MouseEvent.MOUSE_UP,onClick);
			
		}
		
		
		/**
		 * 是否可以接受鼠标事件 
		 */
		public function get canClick():Boolean
		{
			return _canClick;
		}

		/**
		 * @private
		 */
		public function set canClick(value:Boolean):void
		{
			_canClick = value;
		}

		/**
		 * 索引位置 
		 */
		public function get index():int
		{
			return _index;
		}

		/**
		 * @private
		 */
		public function set index(value:int):void
		{
			_index = value;
		}

		/**
		 * 
		 */
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			if(!_selected)
			{
				_bg.bitmapData = _normalBd;
			}
		}	
		protected function onMouseOver(event:MouseEvent):void
		{
			if(!_selected)
			{
				_bg.bitmapData = _overBd;
			}
		}
		/**
		 * 点击 
		 * @param event
		 * 
		 */		
		protected function onClick(event:MouseEvent):void
		{
			_bg.bitmapData = _selectedBd;
			_selected = true;
		}
		
		
		
		
		public function set selected(value:Boolean):void {
			_selected = value;
		}
		/**
		 * 是否选中 
		 * @return 
		 * 
		 */		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function clear():void
		{
			removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
			removeEventListener(MouseEvent.MOUSE_UP,onClick);
			_data = null;
		}
	}
}