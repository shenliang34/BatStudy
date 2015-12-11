package com.gamehero.sxd2.event
{
	import com.gamehero.sxd2.event.BaseEvent;
	import flash.events.Event;
	
	/**
	 * 任务相关事件
	 * @author Trey
	 * @create 2013-09-16
	 **/
	public class TaskEvent extends BaseEvent {
		public static var TASK_START:String = "TaskStart";//任务开始
		public static var TASK_COMPLETE:String = "TaskComplete";//任务开始
		public static var TASK_UPDATE_E:String = "taskUpdatenEvent";			// 更新任务
		public static var TASK_LINK:String = "TaskLinkEvent";				// 点击任务
		public static var TASK_NPCSTATUS:String = "TaskNpcStatus";			// npc状态更新
		public static var TASK_BATTLE:String = "TaskBattle";			// npc状态更新
		public static var TASK_HURDLE:String = "TaskHurdle";			// 进入副本
		public static var TASK_MAP_MOVE:String = "TaskMapMove";			// 进入副本
		
		public function TaskEvent(type:String, data:Object = null) {
			
			super(type, data);
		}
		
		
		override public function clone():Event {
			
			return new TaskEvent(type , data);
		}
	}
}