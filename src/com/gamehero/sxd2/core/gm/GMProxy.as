package com.gamehero.sxd2.core.gm {
	
	import com.gamehero.sxd2.pro.GS_GMData_Pro;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.Interface;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import bowser.logging.Logger;
	import bowser.remote.RemoteResponse;
	
	public class GMProxy extends EventDispatcher {
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		
		/**
		 * Constructor 
		 * 
		 */
		public function GMProxy() {
			
			super();
		}
		
		
		
		/**
		 * Send GM Command 
		 * @param command
		 * 
		 */
		public function sendGM(command:String):void {
			
			var gmData:GS_GMData_Pro = new GS_GMData_Pro();
			gmData.command = command;
			
			GameService.instance.send(Interface.GS_GM, gmData, onGM);
		}
		
		
		/**
		 * Send GM Command Return 
		 * @param response
		 * 
		 */
		private function onGM(response:RemoteResponse):void {
			
			Logger.debug(GMProxy, "onGM:" + response.errcode);
		}	
	}
}