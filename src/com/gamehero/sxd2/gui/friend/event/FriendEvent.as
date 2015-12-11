package com.gamehero.sxd2.gui.friend.event
{
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-19 下午4:30:17
	 * 
	 */
	public class FriendEvent extends Event
	{
		private static const CLASS_PATH:String = getQualifiedClassName(FriendEvent).replace(new RegExp(/::/g),".");
		
		/**
		 *刷新我的听众 
		 */		
		public static const REFRESH_AUDIENCE_LIST:String = CLASS_PATH + ".refresh_audience_list";
		/**
		 *刷新我的听众 
		 */		
		public static const REFRESH_FRIEND_LIST:String = CLASS_PATH + ".refresh_friend_list";
		/**
		 *我的听众 
		 */		
		public static const GET_AUDIENCE_LIST:String = CLASS_PATH + ".get_audience_list";
		/**
		 * 获得好友数据
		 */		
		public static const GET_FRIEND_LIST:String = CLASS_PATH + ".get_friend_list";
		
		/**
		 *移除好友 
		 */		
		public static const REMOVE_FRIEND_SUCCESS:String = CLASS_PATH + ".remove_friend_success"
			
		public static const SELECT_CLICK_ITEM:String = CLASS_PATH + "select_click_item";
		/**
		 *修改图标 
		 */		
		public static const CHANGE_ICON:String = CLASS_PATH + "change_icon";
		
		private var _params:Object;
		public function FriendEvent(type:String,params:Object = null)
		{
			_params = params;
			super(type, false, false);
		}

		public function get params():Object
		{
			return _params;
		}

	}
}