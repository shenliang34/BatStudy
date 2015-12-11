package com.gamehero.sxd2.util
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 * 全局异步器
	 * @inheritDoc
	 * @author wulongbin
	 */
	public class WasynManager extends WasynItem
	{
		protected static var _instance:WasynManager;
		public static function get instance():WasynManager
		{
			return _instance||new  WasynManager;
		}
		public static const RunType_EnterFrame:String="EnterFrame";
		public static const RunType_Timer:String="Timer";
		
		//=============================================================================
		
		protected var _running:Boolean;
		protected var _stage:Stage;
		protected var _timer:Timer;
		public function WasynManager()
		{
			_instance=this;
			super();
			init();
		}
		
		override protected function init():void
		{
			super.init();
			_lastTime=0;
			_stage=App.stage;
			super.running=true;
			
			_timer=new Timer(1000/_stage.frameRate);
			runType=RunType_EnterFrame;
		}
		
		private function renderFrameHd(e:Event=null):void
		{
			renderFrame();
		}
		/**
		 *全局异步管理不可中断 
		 * @param value
		 * 
		 */		
		override public function set running(value:Boolean):void
		{
		}
		
		override public function get running():Boolean
		{
			return _running;
		}
		
		public function set runType(value:String):void
		{
			if(value==RunType_EnterFrame)
			{
				_stage.addEventListener(Event.ENTER_FRAME,renderFrameHd);
				_timer.removeEventListener(TimerEvent.TIMER,renderFrameHd);
				_timer.stop();
			}
			else
			{
				_stage.removeEventListener(Event.ENTER_FRAME,renderFrameHd);
				_timer.delay=1000/_stage.frameRate;
				_timer.addEventListener(TimerEvent.TIMER,renderFrameHd);
				_timer.start();
				
			}
		}
		
	}
}