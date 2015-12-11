package com.gamehero.sxd2.event
{
	import flash.events.Event;

	public class RoleSkillEvent extends BaseEvent
	{
		
		public static const SET_SKILL:String = "setSkill";
		
		public function RoleSkillEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new ArenaEvent(type , data);
		}
	}
}