package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	
	import flash.geom.Rectangle;

	/**
	 * 普通单帧挂件
	 * @author weiyanyu
	 * 创建时间：2015-7-29 下午3:53:58
	 * 
	 */
	public class MapDecoItem extends InterActiveItem
	{
		
		private var _item:SwfRenderItem;
		/**
		 * 
		 * @param url
		 * @param isback 是否是背景
		 * 
		 */		
		public function MapDecoItem(url:String,isback:Boolean = false)
		{
			super();
			_item = new SwfRenderItem(url);
			_item.isBackground = isback;
			addChild(_item);
		}
		
		override public function get activeRect():Rectangle
		{
			return _item.drawRectangle;
		}
	}
}