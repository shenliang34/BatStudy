package com.gamehero.sxd2.world.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-6-15 下午4:49:48
	 * 
	 */
	public class InteractiveItemEvent extends BaseEvent
	{
		/**
		 *  鼠标经过事件  
		 */
		public static const MOUSE_OVER:String="MOUSE_OVER";
		/**
		 * 鼠标移出事件  
		 */		
		public static const MOUSE_OUT:String="MOUSE_OUT";
		
		/**
		 *  
		 */		
		public static const MOUSE_DOWN:String="MOUSE_DOWN";
		public static const MOUSE_UP:String="MOUSE_UP";
		public static const MOUSE_CLICK:String="MOUSE_CLICK";
		
		public static const COLLISION:String = "collision";
		
		
		public function InteractiveItemEvent(type:String, data:Object = null)
		{
			super(type, data);
		}
	}
}