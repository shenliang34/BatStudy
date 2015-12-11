package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import alternativa.gui.mouse.CursorManager;

	public class MapCityItem extends InterActiveItem
	{
		private var _item:SwfRenderItem;
		public var entMapId:int
		/**
		 * 
		 * @param url
		 * @param isback 是否是背景
		 * 
		 */		
		public function MapCityItem(url:String,id:int,isback:Boolean = false)
		{
			super();
			entMapId = id;
			_item = new SwfRenderItem(url);
			_item.isBackground = isback;
			addChild(_item);
		}
		
		override public function onMouseOverHandler(event:MouseEvent):void
		{
			CursorManager.cursorType = CursorManager.HAND;
			
			_item.filters = MapConfig.NPCFILTER;
		}
		
		
		override public function onMouseOutHandler(event:MouseEvent):void
		{
			CursorManager.cursorType = CursorManager.ARROW;
			
			_item.filters = null;
		}
		
		override public function get activeRect():Rectangle
		{
			return _item.drawRectangle;
		}
	}
}