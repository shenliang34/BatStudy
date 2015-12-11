package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 创角3D面板事件
	 * @author xuwenyi
	 * @create 2014-04-02
	 **/
	public class CreateRoleEvent extends Event
	{
		public static const SELECT:String = "select";
		
		public var data:Object;
		
		public function CreateRoleEvent(type:String, data:Object=null)
		{
			this.data = data;
			
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new CreateRoleEvent(type , data);
		}
	}
}