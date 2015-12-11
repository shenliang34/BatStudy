package com.gamehero.sxd2.gui.core.group
{
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	
	/**
	 * 模仿flex datagroup<br>
	 * (增加，可以设置 呈现项 的选中，划入状态)
	 * @author weiyanyu
	 * 创建时间：2015-9-10 下午3:59:15
	 * 
	 */
	public class DataGroup extends Sprite
	{
		/**
		 * 组件列表 
		 */		
		private var _itemList:Vector.<ItemRender> = new Vector.<ItemRender>();
		/**
		 * 呈现项 
		 */		
		private var ITEM_CLASS:Class;
		
		private var _gapX:int = 0;
		
		private var _gapY:int = 0;
		
		private var _col:int = 1;//列
		private var _row:int = 1;//行
		
		private var _selectedIndex:int;
		
		private var _curOverItem:ItemRender;
		
		private var _dataProvider:Array;
		/**
		 * 是否可以点击 
		 */		
		public var mouseClickAble:Boolean = false;
		/**
		 * 是否有鼠标滑动的效果 
		 */		
		public var mouseOverAble:Boolean = false;
		
		/**
		 * 划过的状态位图 
		 */		
		private var _overBmp:Bitmap;
		/**
		 * 选中的框框 
		 */		
		private var _clickedBmp:Bitmap;
		
		/**
		 * 单击后需要延时处理的settimeout
		 */		
		private var _clickTime:uint;
		
		public function DataGroup()
		{
			super();
			_overBmp = new Bitmap();
			_clickedBmp = new Bitmap();
		}
		/**
		 * 设置选中跟悬停的状态 
		 * 
		 */		
		public function setOverClickMask(overBd:BitmapData,clickBd:BitmapData):void
		{
			_overBmp.bitmapData = overBd;
			_clickedBmp.bitmapData = clickBd;
		}
		
		
		
		public function get row():int
		{
			return _row;
		}
		
		public function set row(value:int):void
		{
			_row = value;
		}
		
		public function get col():int
		{
			return _col;
		}
		
		public function set col(value:int):void
		{
			_col = value;
		}
		
		public function get gapY():int
		{
			return _gapY;
		}
		
		public function set gapY(value:int):void
		{
			_gapY = value;
		}
		
		public function get gapX():int
		{
			return _gapX;
		}
		
		public function set gapX(value:int):void
		{
			_gapX = value;
		}
		
		public function get selectedItem():Object
		{
			return null;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
		}
		/**
		 * 数据源 
		 * @return 
		 * 
		 */		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		
		public function set dataProvider(list:Array):void
		{
			_dataProvider = list;
			var item:ItemRender;
			var itemRow:int;
			var itemCol:int;
			for(var i:int = 0; i < list.length; i++)
			{
				
				itemRow = int(i / col);
				itemCol = (i % col);
				if(_itemList.length > i)
				{
					item = _itemList[i];
				}
				else
				{
					item = getMouseItem();
					addChild(item);
					_itemList.push(item);
				}
				item.itemIndex = i;
				item.data = list[i];
				item.y = itemRow * (item.height + _gapY);
				item.x = itemCol * (item.width + _gapX);
				
			}
		}
		
		public function getChildByIndex(index:int):ItemRender
		{
			if(index >= _itemList.length || index < 0)
				return null;
			else
			{
				return _itemList[index];
			}
		}
		//添加格子
		protected function getMouseItem():ItemRender
		{
			var item:ItemRender = new ITEM_CLASS();
			if(mouseClickAble)
			{
				item.addEventListener(MouseEvent.MOUSE_UP,onClick);
				item.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = true;
			}
			else
			{
				item.removeEventListener(MouseEvent.MOUSE_UP,onClick);
				item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = false;
			}
			if(mouseOverAble)
			{
				item.addEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			else
			{
				item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			return item;
		}
		protected function onDoubleClick(e:MouseEvent):void
		{
			var item:ItemRender = (e.target as ItemRender);
			item.onDoubleClick();
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			if(_curOverItem && _curOverItem.onMouseOut(e))
			{
				removeBmp(_overBmp,_curOverItem);
			}
			_curOverItem = null;
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			_curOverItem = (e.target as ItemRender);
			if(_curOverItem && _curOverItem.onMouseOver(e))
			{
				_curOverItem.addChild(_overBmp);
			}
		}
		
		/**
		 * 点击 
		 * @param event
		 */		
		protected function onClick(event:MouseEvent):void
		{
			// 区分双击
			if(getTimer() - _clickTime <  GameConfig.MOUSE_DOUBLE_CLICK_TIME)
			{
				return;
			}
			
			_clickTime = getTimer();
			var item:ItemRender;
			item = event.target as ItemRender;
			if(_curOverItem != item) return;
			item.onClick();
			item.addChild(_clickedBmp);
			selectedIndex = (item.itemIndex);
		}
		
		public function set itemRenderer(object:Class):void
		{
			ITEM_CLASS = object;
		}
		
		public function clear():void
		{
			for each(var item:ItemRender in _itemList)
			{
				removeChild(item);
				item.clear();
			}
			removeBmp(_clickedBmp,item);
			removeBmp(_overBmp,item);
			_itemList.length = 0;
		}
		
		/**
		 * 移除 选中的效果
		 * @param bmp
		 * @param father
		 * 
		 */		
		private function removeBmp(bmp:Bitmap,father:ItemRender):void
		{
			if(bmp)
			{
				if(father && bmp.parent == father)
				{
					father.removeChild(bmp);
				}
			}
		}
	}
}