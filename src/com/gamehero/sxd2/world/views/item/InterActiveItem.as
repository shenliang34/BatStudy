package com.gamehero.sxd2.world.views.item
{
	
	
	
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.geom.Rectangle;
	
	import bowser.render.display.SpriteItem;
	
	/**
	 * 支持交互的显示对象
	 * @author weiyanyu
	 * 创建时间：2015-6-15 下午5:14:51
	 * 
	 */
	public class InterActiveItem extends SpriteItem
	{
		/**
		 * 类型 
		 */		
		public var type:String;
		
		private var _mapData:MapDecoVo;
		
		public function InterActiveItem()
		{
			super();
		}
		
		/**
		 *  挂件的鼠标交互区域 
		 * @return
		 * 
		 */		
		public function get activeRect():Rectangle
		{
			return null;
		}
		public function enterFrame():void
		{
			
		}
		/**
		 * 鼠标移出 
		 * @param event
		 * 
		 */		
		public function onMouseOutHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 鼠标松起 
		 * @param event
		 * 
		 */		
		public function onMouseUpHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 点击 
		 * @param event
		 * 
		 */		
		public function onClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 划过 
		 * @param event
		 * 
		 */		
		public function onMouseOverHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 按下 
		 * @param event
		 * 
		 */		
		public function onMouseDownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 设置滤镜 
		 * @param filters
		 * 
		 */		
		public function set filters(filters:Vector.<BitmapFilter>):void
		{
			
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			super.gc(isCleanAll);
		}
		
		/**
		 * 设置地图配置 
		 * @param value
		 * 
		 */		
		public function set mapData(value:MapDecoVo):void
		{
			_mapData = value;
		}
		
		public function get mapData():MapDecoVo
		{
			return _mapData;
		}
		
	}
}