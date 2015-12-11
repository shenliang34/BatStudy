package com.gamehero.sxd2.world.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * 角色相关事件
	 * @author weiyanyu
	 * 创建时间：2015-6-29 下午6:03:36
	 * 
	 */
	public class RoleEvent extends BaseEvent
	{
		/**
		 * 移动结束 
		 */		
		public static var MOVE_END:String = "move_end";
		/**
		 * 移动时（派发给服务器位置数据） 
		 */		
		public static var MOVE_EVENT:String = "move_event";
		
		public function RoleEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}