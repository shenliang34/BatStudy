package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	public class NotificationEvent extends Event
	{
		public static const HERO_TRAIN_CHECK:String="heroTrainCheck";
		public static const HERO_TRAIN_FINISH:String="heroTrainFinish";
		public static const HERO_TRAIN_COMPLETE:String="heroTrainComplete";
		public function NotificationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}