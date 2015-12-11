package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.equips.event.EquipEvent;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * 格子网格
	 * @author weiyanyu
	 * 创建时间：2015-8-6 下午2:30:26
	 * 
	 */
	public class EquipGroup extends Sprite
	{
		/**
		 * 装备位置索引 
		 */		
		private const locArr:Array = [2,4,5,3,6,1];//武器、头盔、衣服、护符、鞋、战魂。
		
		public var gapY:int = 0;
		
		private var _col:int = 1;//列
		
		private var _data:Array;//格子数据
		/**
		 * 格子数组 
		 */		
		protected var _itemVec:Vector.<EquipRenderItem>;
		/**
		 * 是否可以点击 
		 */		
		public var clickAble:Boolean = true;
		/**
		 * 是否有鼠标滑动的效果 
		 */		
		public var mouseOverAble:Boolean = true;
		/**
		 * 划过的状态位图 
		 */		
		private var _overBmp:Bitmap;
		/**
		 * 选中的框框 
		 */		
		private var _clickedBmp:Bitmap;
		/**
		 * 当前鼠标所在的 
		 */		
		private var _curOverItem:EquipRenderItem;
		/**
		 * 当前选中de
		 */		
		private var _curSelectedItem:EquipRenderItem;
		
		
		/**
		 *  
		 */		
		public function EquipGroup(downBd:BitmapData,overBd:BitmapData)
		{
			super();
			_overBmp = new Bitmap(overBd);
			_clickedBmp = new Bitmap(downBd);
			
			_itemVec = new Vector.<EquipRenderItem>;
		}

		public function get curSelectedItem():EquipRenderItem
		{
			return _curSelectedItem;
		}

		public function set curSelectedItem(value:EquipRenderItem):void
		{
			_curSelectedItem = value;
			_curSelectedItem.addChild(_clickedBmp);
		}
		//添加格子
		protected function addItem(lx:int,ly:int):EquipRenderItem
		{
			var item:EquipRenderItem = new EquipRenderItem();
			if(clickAble)
			{
				item.addEventListener(MouseEvent.MOUSE_UP,onClick);
				item.doubleClickEnabled = true;
			}
			else
			{
				item.removeEventListener(MouseEvent.MOUSE_UP,onClick);
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
			item.x = lx;
			item.y = ly;
			addChild(item);
			return item;
		}
		
		
		protected function onClick(e:MouseEvent):void
		{
			var item:EquipRenderItem = (e.target as EquipRenderItem);
			curSelectedItem = item;
			dispatchEvent(new EquipEvent(EquipEvent.SELECTED,item));
		}
		
		
		protected function onMouseOut(e:MouseEvent):void
		{
			_curOverItem = null;
			removeBmp(_overBmp);
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			_curOverItem = (e.target as EquipRenderItem);
			_curOverItem.addChild(_overBmp);
		}
		
		
		/**
		 * 格子数据组 
		 */
		public function get data():Array
		{
			return _data;
		}
		
		/**
		 * 设置数据源
		 */
		public function set data(value:Array):void
		{
			_data = value;
			var item:EquipRenderItem;
			var pro:PRO_Item;
			for(var i:int = 0; i < value.length; i++)
			{
				
				if(i <= _itemVec.length -1 && _itemVec[i])//获取数据对应的格子
				{
					item = _itemVec[i];
				}
				else//没有初始化格子，则添加格子
				{
					item =addItem(0,(60 + gapY) * i);
					_itemVec.push(item);
				}
				pro = BagModel.inst.getItemById(value[i]);
				item.itemIndex = i;
				item.equipLoc = locArr[i];
				item.data = pro;
			}
			if(curSelectedItem == null)
			{
				curSelectedItem =  _itemVec[0];
			}
			
		}
		
		
		public function set col(value:int):void
		{
			_col = value;
		}
		/**
		 * @return 列数
		 * 
		 */
		public function get col():int
		{
			return _col;
		}
		
		public function clear():void
		{
			if(_itemVec)
			{
				var item:EquipRenderItem;
				for(var i:int = 0; i < _itemVec.length; i++)
				{
					item = _itemVec[i];
					removeChild(item);
					item.clear();
					removeBmp(_clickedBmp);
					removeBmp(_overBmp);
					item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
					item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
					item.removeEventListener(MouseEvent.CLICK,onClick);
					item.doubleClickEnabled = false;
				}
				_itemVec.length = 0;
			}
			_curOverItem = null;
			
		}
		
		/**
		 * 移除 选中的效果
		 * @param bmp
		 * @param father
		 * 
		 */		
		private function removeBmp(bmp:Bitmap):void
		{
			if(bmp)
			{
				if(bmp.parent)
				{
					bmp.parent.removeChild(bmp);
				}
			}
		}
	}
}

