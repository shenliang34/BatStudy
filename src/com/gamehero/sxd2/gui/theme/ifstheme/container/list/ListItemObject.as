package com.gamehero.sxd2.gui.theme.ifstheme.container.list
{
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.container.list.IItemRenderer;
	
	/**
	 *listItem基类 
	 * @author wulongbin
	 * 
	 */	
	public class ListItemObject extends ActiveObject implements IItemRenderer
	{
		protected var _data:Object;
		
		protected var _selected:Boolean = false;
		
		protected var _itemIndex:int = 0;
		public function ListItemObject()
		{
			super();
		}
		
		public function get itemIndex():int
		{
			return _itemIndex;
		}
		
		public function set itemIndex(value:int):void
		{
			_itemIndex=value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data=value;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected=value;
		}
	}
}