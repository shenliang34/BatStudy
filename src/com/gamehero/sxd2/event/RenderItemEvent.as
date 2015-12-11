package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 渲染物件的事件
	 * @author xuwenyi
	 * @create 2013-12-25
	 **/
	public class RenderItemEvent extends BaseEvent
	{
		public static const RESOURCE_LOADED:String = "resourceloaded";// GameRenderData加载完成时会派发
		public static const LOADED:String = "loaded";// GameRenderItem派发
		public static const FIRST_RENDER:String = "firstRender";
		public static const PLAY_UPDATE:String = "playUpdate";
		public static const PLAY_COMPLETE:String = "playComplete";
		public static const SET_RENDER_POSITION:String = "setRenderPostion";
		
		
		
		/**
		 * 构造函数
		 * */
		public function RenderItemEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new RenderItemEvent(type , data);
		}
	}
}