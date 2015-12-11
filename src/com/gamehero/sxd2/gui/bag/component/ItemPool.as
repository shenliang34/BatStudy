package com.gamehero.sxd2.gui.bag.component
{
	/**
	 * 物品池
	 * @author weiyanyu
	 * 创建时间：2015-8-10 上午11:57:27
	 * 
	 */
	public class ItemPool
	{
		public function ItemPool()
		{
		}
		
		
		private static var _items:Vector.<ItemCell>;
		/**
		 * 获取一个itemCell 
		 * @return 物品格子
		 * 
		 */		
		public static function getItem():ItemCell
		{
			var item:ItemCell;
			if(_items == null)
			{
				_items = new Vector.<ItemCell>();
			}
			if(_items.length > 0)
			{
				item = _items.pop();
			}
			else
			{
				return new ItemCell();
			}
			return item;
		}
		/**
		 * 物品清除的时候将格子推入垃圾回收站 
		 * @param item
		 * 
		 */		
		public static function push(item:ItemCell):void
		{
			if(_items == null)
			{
				_items = new Vector.<ItemCell>();
			}
			_items.push(item);
		}
		
		public static function dispose():void
		{
			if(_items)
			{
				for each(var item:ItemCell in _items)
				{
					item = null;
				}
				_items = null;
			}
		}
	}
}