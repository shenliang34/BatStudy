package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	
	import flash.geom.Rectangle;

	public class MapJumpSpotItem extends InterActiveItem
	{
		
		public var isJump:int;//0为可逆 1为不可逆
		private var _item:SwfRenderItem;
		/**
		 *构造 
		 * @param url
		 * @param type
		 * 
		 */		
		public function MapJumpSpotItem(url:String,type:int)
		{
			super();
			_item = new SwfRenderItem(url);
			isJump = type;
			addChild(_item);
		}
		
		/**
		 * 交互区域
		 * @return 
		 * 
		 */		
		override public function get activeRect():Rectangle
		{
			// TODO Auto Generated method stub
			return super.activeRect;
		}
		
	}
}