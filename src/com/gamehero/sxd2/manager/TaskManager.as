package com.gamehero.sxd2.manager
{
    import com.gamehero.sxd2.core.GameSettings;
    import com.gamehero.sxd2.event.TaskEvent;
    import com.gamehero.sxd2.gui.main.MainTaskPanel;
    import com.gamehero.sxd2.gui.main.core.TaskType;
    import com.gamehero.sxd2.gui.notice.NoticeUI;
    import com.gamehero.sxd2.local.Lang;
    import com.gamehero.sxd2.pro.PRO_Task;
    import com.gamehero.sxd2.pro.TaskStatus;
    import com.gamehero.sxd2.vo.TaskInfoVo;
    
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

	/**
	 * 任务工具类
	 * @author zhangxueyou
	 * @create-date 2015-8-25
	 */
	public class TaskManager extends EventDispatcher {
		
		public var TASK_LINK_DIALOGUE:String = "TaskDialogue";//点击任务对话
		public var TASK_LINK_DIALOGUE_CODE:int = 0;//对话
		public var TASK_LINK_MAP_NPC:int = 1;//寻找npc
		public var TASK_LINK_BATTLE_CODE:int = 2;//战斗
		public var TASK_LINK_HURDLE_CODE:int = 3;//寻找副本
		public var TASK_LINK_MAP_MOVE:int = 4; //自动移动

		static private var _instance:TaskManager;//单例

		private var taskList:Dictionary;//任务集合
		
		private var isFirstUpdata:Boolean;//是否第一次加载标记
	
		private var items:Vector.<String> = new Vector.<String>;//任务字典

		public var npcObjectList:Array = []; //npc列表
	
		public var curEvent:TaskEvent;//切换场景时 保存的任务事件对象
		
		public var moveObj:Object //任务自动移动对象
		
		public var isGlobalMove:Boolean;//是否世界移动
		
		public var globalMove:int;//世界地图自动移动标记 城市Id

		public var hurdleId:int;//任务副本标示
		
		public var isAutoTask:Boolean;//是否自动任务
		/**
		 *构造
		 */
		public function TaskManager(singleton:Singleton) {
			init();
		}
		
		
		public static function get inst():TaskManager {
			
			return _instance ||= new TaskManager(new Singleton());;
		}
		
		/** 
		 * 更新任务数据
		 * */
		public function updataTaskList(list:Array):void
		{
			var id:String;
			var index:int;
			var task:PRO_Task
			if(!isFirstUpdata)
			{
				for each(task in list)
				{
					id = task.id.toString();
					taskList[id] = task;
				}
				isFirstUpdata = true;
			}
			else
			{
				for each(task in list)
				{
					id = task.id.toString();
					index = items.indexOf(id);
					
					if(task.status == 4)
					{
						taskList[id] = null;
						delete taskList[id];
					}
					else
					{
						taskList[id] = task;
						if(index == -1)
						{
							items.push(id);
						}
					}
				}
			}
		}
		
		public function setNpcStatus(task:TaskInfoVo):int
		{
			var id:int;
			switch(task.status)
			{
				case TaskStatus.Startable:
				case TaskStatus.InProgress:
				{
					id = task.receive_obj_attr;
					break;
				}
				case TaskStatus.Finished:
				{
					id = task.finish_obj_attr
					break;
				}
			}
			return id;
		}
		
		/**
		 * 初始化 
		 * 
		 */
		private function init():void {
			moveObj = new Object();
			taskList = new Dictionary()
		}
		
		
		public function get tasks():Dictionary {
			return taskList;
		}
		
		public function set tasks(value:Dictionary):void {
			taskList = value;
		}

		
		
		/**
		 * 获得NPC拥有的任务 
		 */
		public function getNpcTasks(npcId:int):Array 
		{
			var list:Array = [];
			for each(var task:PRO_Task in taskList)
			{
				var taskVo:TaskInfoVo = MainTaskPanel.inst.getTaskDataById(task.id);
				if(taskVo.status == TaskStatus.Startable)
				{
					if(taskVo.receive_obj_attr == npcId)
					{
						list.push(taskVo);
					}
				}
				if(taskVo.status == TaskStatus.InProgress)
				{
					if(int(taskVo.object_id) == npcId)
					{
						list.push(taskVo);
					}
				}
				if(taskVo.status == TaskStatus.Finished)
				{
					if(taskVo.finish_obj_attr == npcId)
					{
						list.push(taskVo);
					}
				}
			}
			return list;
		}
		
		/**
		 * 获得NPC拥有的任务目标
		 */
		public function getNpcEventTask(npcId):TaskInfoVo
		{
			var list:Array = [];
			for each(var task:PRO_Task in taskList)
			{
				var taskVo:TaskInfoVo = getTaskDataById(task.id);
				if(taskVo.object_id == npcId && task.status == TaskStatus.InProgress && taskVo.goal_type == 1)
				{
					taskVo.status = task.status;
					return taskVo;
				}
			}
			return null;
		}
		
		/**
		 * 通过taskid获得task 
		 */
		public function getTaskDataById(taskId:int):TaskInfoVo 
		{
			var taskXML:XML = getTaskInfo(taskId);	
			var taskInfo:TaskInfoVo = new TaskInfoVo();
			taskInfo.taskId = taskId;
			taskInfo.title = Lang.instance.trans(taskXML.@title);
			taskInfo.name = Lang.instance.trans(taskXML.@title);
			taskInfo.type = taskXML.@type
			taskInfo.minlevel = taskXML.@minlevel;
			taskInfo.maxlevel = taskXML.@maxlevel;
			taskInfo.tracer_recieve_text = Lang.instance.trans(taskXML.@tracer_recieve_text);
			taskInfo.tracer_goal_text = Lang.instance.trans(taskXML.@tracer_goal_text);
			taskInfo.tracer_finish_text = Lang.instance.trans(taskXML.@tracer_finish_text);
			taskInfo.receive_obj_type = taskXML.@receive_obj_type;
			taskInfo.receive_obj_attr = taskXML.@receive_obj_attr;
			taskInfo.goal_type = taskXML.@goal_type;
			taskInfo.object_id = taskXML.@object_id;
			taskInfo.object_num = taskXML.@object_num;
			taskInfo.finish_obj_type = taskXML.@finish_obj_type;
			taskInfo.finish_obj_attr = taskXML.@finish_obj_attr;
			taskInfo.details = Lang.instance.trans(taskXML.@details);
			taskInfo.npc_recieve_text = Lang.instance.trans(taskXML.@npc_recieve_text);
			taskInfo.npc_goal_text = Lang.instance.trans(taskXML.@npc_goal_text);
			taskInfo.npc_finish_text = Lang.instance.trans(taskXML.@npc_finish_text);
			taskInfo.player_recieve_text = Lang.instance.trans(taskXML.@player_recieve_text);
			taskInfo.player_goal_text = Lang.instance.trans(taskXML.@player_goal_text);
			taskInfo.player_finish_text = Lang.instance.trans(taskXML.@player_finish_text);
			taskInfo.gold = taskXML.@gold;
			taskInfo.EXP = taskXML.@EXP;
			taskInfo.boxId = taskXML.@boxid;
			taskInfo.drama1 = taskXML.@drama1;
			taskInfo.drama2 = taskXML.@drama2;
			return taskInfo;
		}
		
		/**
		 * 根据任务ID获得任务详细信息
		 * */
		public function getTaskInfo(id:int):XML
		{
			var taskXMLList:XMLList = GameSettings.instance.settingsXML.tasks.task;
			var i:int;
			var len:int = taskXMLList.length();
			for(i;i<len;i++)
			{
				var xml:XML = taskXMLList[i];
				if(xml.@taskid == id)
				{
					return xml;
				}
			}
			return null
		}
		
		/**
		 * 任务排序 type 1为追踪面板 2为npc面板
		 */
		public function sortTasks(list:Array,type:int = 1):void {
			if(type == 1)
				list.sort(mainTaskSortHandle);
			else
				list.sort(npcWindowSortHandle);
		}
		
		/**
		 * npc任务面板 排序规则：按任务状态 已完成>可接取>已接取
		 */
		private function npcWindowSortHandle(task1:TaskInfoVo , task2:TaskInfoVo):int
		{
			if(task1.status == task2.status)
				return task1.taskId > task2.taskId ? 1 : -1;
			else
			{
				if(task1.status == 1 && task2.status == 2)
					return -1;
				else if(task1.status == 1 && task2.status == 3)
					return 1;
				else if(task1.status == 2 && task2.status == 3)
					return 1;
				else if(task1.status == 2 && task2.status == 1)
					return -1;
				else if(task1.status == 3 && task2.status == 1)
					return -1;
				else if(task1.status == 3 && task2.status == 2)
					return -1;
			}
			return 1;
		}
		
		/**
		 * 任务追踪栏 排序规则：按任务类型、任务状态、任务id排序
		 */
		private function mainTaskSortHandle(task1:TaskInfoVo , task2:TaskInfoVo):int 
		{
			var taskType1:int = int(String(task1.taskId).substr(0, 1));
			var taskType2:int = int(String(task2.taskId).substr(0, 1));
			
			if(taskType1 < taskType2) {
				
				return -1;
			}
			else if(taskType1 > taskType2) {
				
				return 1;
			}
			else {
				
				if(task1.status > task2.status) {
					
					return -1;
				}
				else if(task1.status < task2.status) {
					
					return 1;
				}
				else {
					
					return task1.taskId > task2.taskId ? 1 : -1;
				}

			}
		}

		/**
		 * 可点链接
		 * */
		public function formatChatLink(type:String, params:String, content:String):String
		{
			var str:String = "";
			str = "<a href='event:" + type + "^" + params + "'>" + content + "</a>";
			return  str;
		}

		/**
		 * 获取任务链接文本 
		 */
		public function getLinkText(taskInfo:TaskInfoVo):String 
		{
			var str:String;
			/** 任务类型状态 */
			switch(taskInfo.status)
			{
				case TaskStatus.MainLine:
				{
					str = Lang.instance.trans("task_receive_text");
					break;
				}
				case TaskStatus.Startable:
				{
					str = Lang.instance.trans(taskInfo.tracer_recieve_text);
					break;
				}
				case TaskStatus.InProgress:
				{
					str = Lang.instance.trans(taskInfo.tracer_goal_text);
					break;
				}
				case TaskStatus.Finished:
				{
					str = Lang.instance.trans(taskInfo.tracer_finish_text);
					break;
				}
			}
			return str;
		}
		
		/**
		 * 格式化任务描述
		 */
		public function formatTaskLabel(taskInfo:TaskInfoVo, labelStr:String,isType:Boolean):String {
			
			var str1:String = "<font size='12' face='宋体' color='#2ce80e'>";//任务完成
			var str2:String = "<font size='12' face='宋体' color='#f6e33f'>";//其他所有
			var str3:String = "<font size='12' face='宋体' color='#f78c2d'>";//奖励
			var str4:String = "<font size='12' face='宋体' color='#d7deed'>";//内容
			var str5:String = "<font size='12' face='宋体' color='#ec2727'>";//不可接
			
			//任务追踪面板
			if(isType)
			{
				// 任务类型
				switch(taskInfo.type)
				{
					case TaskType.TASK_TRUNK:
					{
						labelStr = "[" + Lang.instance.trans("task_zhu") + "]" + labelStr;
						break;
					}
					case TaskType.TASK_BRANCH:
					{
						labelStr = "[" + Lang.instance.trans("task_zhi") + "]" + labelStr;
						break;
					}
					default:
					{
						break;
					}
				}
				// 任务状态
				switch(taskInfo.status)
				{
					case TaskStatus.MainLine:
					{
						labelStr = labelStr + str5 + "["+ taskInfo.minlevel + Lang.instance.trans("task_receive_level") +"]";
						break;
					}
					case TaskStatus.Startable:
					{
						labelStr = labelStr + str2 + "[" + Lang.instance.trans("task_kejie") + "]";
						break;
					}
					case TaskStatus.InProgress:
					{
						labelStr = labelStr + str2 + "[" + Lang.instance.trans("task_jixing") + "]";
						break;
					}
					case TaskStatus.Finished:
					{
						labelStr = str1 + labelStr + "[" + Lang.instance.trans("task_wancheng") + "]";
						break;
					}
				}
			}
			//Npc面板
			else
			{
				// 任务状态
				switch(taskInfo.status)
				{
					case TaskStatus.Startable:
					{
						labelStr = str2 + labelStr + "[" + Lang.instance.trans("task_kejie") + "]";
						break;
					}
					case TaskStatus.InProgress:
					{
						labelStr = str2 + labelStr + "[" + Lang.instance.trans("task_jixing") + "]";
						break;
					}
					case TaskStatus.Finished:
					{
						labelStr = str1 + labelStr + "[" + Lang.instance.trans("task_wancheng") + "]";
						break;
					}
				}
			}
			
			return labelStr;
		}
		
		/**
		 *停止自动寻路 
		 * 
		 */		
		public function colseAutoTaskHandle():void
		{
			TaskManager.inst.hurdleId = 0;
			NoticeUI.inst.setPathingItem(false);
			moveObj.isMove = false;
		}
	}
}

class Singleton{}