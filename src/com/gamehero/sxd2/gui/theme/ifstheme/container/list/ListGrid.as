package com.gamehero.sxd2.gui.theme.ifstheme.container.list
{
	import com.gamehero.sxd2.gui.bag.component.ItemGrid;
	import com.gamehero.sxd2.util.ObjectPool;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.container.list.IItemRenderer;

	use namespace alternativagui;
	public class ListGrid extends Sprite
	{
		protected var _gridWidth:Number=50;
		protected var _gridHeight:Number=50;
		protected var _itemWidth:Number=40;
		protected var _itemHeight:Number=40;
		protected var _data:Array;
		protected var _listItems:Vector.<IItemRenderer>;
		protected var _itemLength:uint=0;
		protected var _scrollIndex:int=0;
		protected var _maxScrollIndex:uint=0;
		protected var _maxScrollValue:Number=0;
		protected var _dataLength:uint=0;
		protected var _selectIndex:int=-1;
		protected var _selectItem:IItemRenderer;
		protected var _enableFunc:Function;
		protected var _itemPool:ObjectPool;
		protected var _width:Number=1;
		protected var _height:Number=1;

		alternativagui var _col:uint;
		alternativagui var _row:uint;
		alternativagui var _scrollRect:Rectangle;
		
		public function ListGrid(cla:Class,w:Number=200,h:Number=200)
		{
			super();
			_data=[];
			_itemPool=new ObjectPool(cla);
			_listItems=new Vector.<IItemRenderer>;
			_scrollRect=new Rectangle(0,0,w,h);
			setSize(w,h);
		}
		
		public function setSize(w:Number, h:Number):void
		{
			_width=w;
			_height=h;
			_scrollRect.width=w;
			_scrollRect.height=h;
			scrollRect=_scrollRect
			createItemsAsyn();
		}
		/**
		 * 
		 * @param gridW 网格宽高
		 * @param gridH
		 * @param itemW 子项宽高
		 * @param itemH
		 * 
		 */			
		public function setGridAndItem(gridW:Number,gridH:Number,itemW:Number=NaN,itemH:Number=NaN):void
		{
			_gridWidth=gridW;
			_gridHeight=gridH;
			_itemWidth=itemW||gridW;
			_itemHeight=itemH||gridH;
			createItemsAsyn();
		}
		
		protected function createItemsAsyn():void
		{
			_col=(_width/_gridWidth);
			_row=(_height/_gridHeight);
			_row++;
			updateScrollData();
			WasynManager.instance.addFuncToEnd(createItemsNow);
		}
		
		protected function createItemsNow():void
		{
			_itemLength=_col*_row;
			var i:int=0; 
			var oldItems:Vector.<IItemRenderer>=_listItems;
			var oldLength:uint=oldItems.length;
			_listItems=new Vector.<IItemRenderer>();
			var col:uint;
			var row:uint;
			if(_itemLength>oldLength)
			{
				for(i=0;i<oldLength;i++)
				{
					_listItems[i]=oldItems[i];
				}
				for(i=oldLength;i<_itemLength;i++)
				{
					_listItems[i]=createItem();
					var display:DisplayObject=_listItems[i] as DisplayObject;
					addChild(display);
					col=i%_col;
					row=uint(i/_col);
					display.x=col*_gridWidth;
					display.y=row*_gridHeight;
				}
			}
			else
			{
				for(i=0;i<_itemLength;i++)
				{
					_listItems[i]=oldItems[i];
				}
				for(i=_itemLength;i<oldLength;i++)
				{
					oldItems[i].data=null;
					removeChild(oldItems[i] as DisplayObject)
					createItem(false,oldItems[i]);
				}
			}
			drawAsyn();
		}
		
		protected function createItem(isCreate:Boolean=true,item:IItemRenderer=null):IItemRenderer
		{
			if(isCreate)
			{
				item =_itemPool.getObject();
				(item as IEventDispatcher).addEventListener(MouseEvent.CLICK,mouseClickHd);
				return item;
			}
			else
			{
				(item as IEventDispatcher).removeEventListener(MouseEvent.CLICK,mouseClickHd);
				_itemPool.release(item);
				return null;
			}
		}
		
		protected function mouseClickHd(e:MouseEvent):void
		{
			_selectItem=e.currentTarget as IItemRenderer;
			if(_selectItem==null) return;
			selectIndex=_data.indexOf(_selectItem.data);
		}
		
		public function set data(value:Array):void
		{
			_data=value||[];
			_dataLength=_data.length;
			updateScrollData();
			_selectIndex=-1;
			scrollValue=scrollValue;
			drawAsyn();
		}
		
		protected function updateScrollData():void
		{
			if(false)
			{
				_maxScrollIndex=Math.max(0,Math.ceil(_dataLength/_col)-_row+1);
				_maxScrollValue=_maxScrollIndex*_gridHeight;
			}
			else
			{
				_maxScrollIndex=uint.MAX_VALUE;
				_maxScrollValue=Number.MAX_VALUE;
			}
			WasynManager.instance.addFuncToEnd(changeScrollData);
		}
		
		protected function changeScrollData():void
		{
			_scrollRect.y=_scrollValue;
			scrollRect=_scrollRect;
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get data():Array
		{
			return _data;
		}
		
		public function drawAsyn():void
		{
			WasynManager.instance.addFuncToEnd(drawNow);
		}
		
		public function drawNow():void
		{
			var i:int=0;
			var col:uint;
			var row:uint;
			var index:uint;
			var tempX:Number=(_gridWidth-_itemWidth)*0.5;
			var tempY:Number=(_gridHeight-_itemHeight)*0.5;
			var item:IItemRenderer;
			var display:DisplayObject;
			var startIndex:uint=_scrollIndex*_col;
			for(;i<_itemLength;i++)
			{
				index=startIndex+i;
				item=_listItems[i];
				display=item as DisplayObject;
				col=index%_col;
				row=uint(index/_col);
				display.x=tempX+col*_gridWidth;
				display.y=tempY+row*_gridHeight;
				if(index<_dataLength)
				{
					item.data=_data[index];
//					if(_enableFunc!=null)
//					{
//						item.enabled=_enableFunc(_data[index]);
//					}
//					else item.enabled=true;
				}
				else
				{
					item.data=null;
//					item.enabled=false;
				}
				item.selected=index==_selectIndex;
			}
		}
		
		public function get scrollIndex():int
		{
			return _scrollIndex;
		}
		
		public function set scrollIndex(value:int):void
		{
			if(_scrollIndex==value) return;
			_scrollIndex=Math.max(0,Math.min(value,_maxScrollIndex));
			scrollValue=_scrollIndex*_gridHeight
			drawAsyn();
		}
		
		protected var _scrollValue:Number=0;
		public function set scrollValue(value:Number):void
		{
			value=Math.max(0,Math.min(value,_maxScrollValue));
			if(value==_scrollValue) return;
			_scrollValue=value;
			scrollIndex=Math.floor(_scrollValue/_gridHeight);
			WasynManager.instance.addFuncToEnd(changeScrollData);
		}
		
		public function get scrollValue():Number
		{
			return _scrollRect.y;
		}
		
		public function get maxScrollIndex():uint
		{
			return _maxScrollIndex;
		}
		
		public function get maxScrollValue():Number
		{
			return _maxScrollValue;
		}
		
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		
		public function set selectIndex(value:int):void
		{
			value=Math.max(-1,Math.min(_dataLength-1,value));
			if(_selectIndex!=value)
			{
				if(_enableFunc!=null&&value>=0)
				{
					if(_enableFunc(_data[value]))
					{
						_selectIndex = value;
					}
					else
					{
						_selectIndex=-1;
					}
				}
				else
				{
					_selectIndex = value;
				}
				drawAsyn();
			}
			this.dispatchEvent(new Event(Event.SELECT));
		}
		
		public function nextSelectIndex():void
		{
			var i:int=_selectIndex+1;
			var len:int=_data.length;
			for(;i<len;i++)
			{
				if(_enableFunc!=null)
				{
					if(_enableFunc(_data[i]))
					{
						selectIndex=i;
						break;
					}
				}
				else
				{
					selectIndex=i;
					break;
				}
			}
		}
		
		public function prevSelectIndex():void
		{
			var i:int=_selectIndex-1;
			for(;i>=0;i--)
			{
				if(_enableFunc!=null)
				{
					if(_enableFunc(_data[i]))
					{
						selectIndex=i;
						break;
					}
				}
				else
				{
					selectIndex=i;
					break;
				}
			}
		}
		
		public function get dataLength():uint
		{
			return _dataLength;
		}
		/**
		 *将可见区域移动至选择项 
		 * 
		 */
		public function viewToSelect():void
		{
			if(_selectIndex==-1) return;
			var viewLength:int=_itemLength-_col-1;
			if(_selectIndex<_scrollIndex)
			{
				scrollIndex=Math.max(0,_selectIndex);
			}
			else if(_selectIndex>=_scrollIndex+viewLength)
			{
				scrollIndex=_selectIndex-viewLength;
			}
			viewToScrollIndex();
		}
		/**
		 * 将可见区域对齐
		 * 
		 */		
		public function viewToScrollIndex():void
		{
			scrollValue=_scrollIndex*_gridHeight;
		}
		/**
		 *设置过滤器，格式function(data:Object):Boolean 
		 * @param value
		 * 
		 */
		public function set enableFunc(value:Function):void
		{
			_enableFunc = value;
			drawAsyn();
		}
		/**
		 *可见行数 
		 * @return 
		 * 
		 */
		public function get visibleRow():int
		{
			return _row-1;
		}
		
		public function get gridHeight():Number
		{
			return _gridHeight;
		}
		
		override public function set width(value:Number):void
		{
			setSize(value,_height);
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(value:Number):void
		{
			setSize(_width,value);
		}
		
		override public function get height():Number
		{
			return _height;
		}

		public function get selectItem():IItemRenderer
		{
			return _selectItem;
		}

	}
}