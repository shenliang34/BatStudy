package com.gamehero.sxd2.gui.theme.ifstheme.controls.slider
{
	import flash.events.Event;
	
	public class SliderEvent extends Event
	{
		public static const SLIDER_CHANGE:String = "SliderChange";
		
		public function SliderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}