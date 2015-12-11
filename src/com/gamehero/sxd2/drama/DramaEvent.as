package com.gamehero.sxd2.drama
{
	import flash.events.Event;
	
	public class DramaEvent extends Event
	{
		public static const GOTO_SCENE:String="goto_scene";
		
		public static const DRAMA_STATUS_CHANGE:String="drama_status_change";
		
		public var data:Object;
		public function DramaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}