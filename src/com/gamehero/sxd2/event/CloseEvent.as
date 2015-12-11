package com.gamehero.sxd2.event {
	
	import flash.events.Event;
	
	public class CloseEvent extends Event {
		
		public static const CLOSE:String = "close";

		public var detail:uint;
		public var input:String;
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function CloseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:int = -1, input:String = "") {
			
			super(type, bubbles, cancelable);
			
			this.detail = detail;
			this.input = input;
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PRIVATE
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * clone
		 */
		override public function clone():Event
		{
			return new CloseEvent(type, bubbles, cancelable, detail, input);
		}
	}
	
}
