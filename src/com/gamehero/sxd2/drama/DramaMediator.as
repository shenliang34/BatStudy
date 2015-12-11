package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.event.MainEvent;
	import com.pps.ifs.event.TaskEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.pro.GS_TaskAction_Pro;
	import com.gamehero.sxd2.task.TaskProxy;
	import com.gamehero.sxd2.world.SceneWorldView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class DramaMediator extends Mediator
	{
		[Inject]
		public var taskProxy:TaskProxy;
		
		protected var _dramaManager:DramaManager;
		public function DramaMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			_dramaManager=DramaManager.instance;
			
			//剧情通知外界
			_dramaManager.addEventListener(BattleEvent.BATTLE_CONTINUE,sendToGlobal);
			_dramaManager.addEventListener(MainEvent.SHOW_GLOBAL_WORLD,sendToGlobal);
			_dramaManager.addEventListener(TaskEvent.TASK_ACTION_E,onTaskAction);
			_dramaManager.addEventListener(MainEvent.CHANGE_MAP, sendToGlobal);
			
			//外界通知剧情
			eventDispatcher.addEventListener(BattleEvent.BATTLE_LOADED,sendToDrama);
			eventDispatcher.addEventListener(MainEvent.BATTLE_END,sendToDrama ,false, -1);
//			eventDispatcher.addEventListener(BattleEvent.QUIT, sendToDrama, false, -1);
			
		}
		
		/**
		 *等待场景初始化完成抛出 
		 */		
		private var _cacheEvent:Event;
		private function onBattleQuit(e:Event):void
		{
			SceneWorldView.instance.addEventListener(Event.INIT, onSceneInit);
			_cacheEvent = e;
		}
		
		/**
		 *场景初始化完成，将战斗结束事件抛出
		 * @param event
		 * 
		 */		
		protected function onSceneInit(event:Event):void
		{
			SceneWorldView.instance.removeEventListener(Event.INIT, onSceneInit);
			if(_cacheEvent)
			{
				_dramaManager.dispatchEvent(_cacheEvent);
				_cacheEvent = null;
			}
		}
		
		
		private function onTaskAction(event:TaskEvent):void {
			
			taskProxy.taskAction(event.data as GS_TaskAction_Pro);
		}	
		
		
		/**
		 * 告知外界
		 * @param event
		 * 
		 */		
		private function sendToGlobal(event:Event):void
		{
			eventDispatcher.dispatchEvent(event);
		}		
		
		
		/**
		 *告知剧情
		 * @param e
		 * 
		 */		
		private function sendToDrama(e:Event):void
		{
			_dramaManager.dispatchEvent(e);
		}
		
		
		
	}
}