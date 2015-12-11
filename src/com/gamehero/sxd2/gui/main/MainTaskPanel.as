package com.gamehero.sxd2.gui.main
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.TaskEvent;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.tree.TaskTree;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.tree.TaskTreeListObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.tips.TaskTips;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ErrcodeManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.ERRID;
	import com.gamehero.sxd2.pro.PRO_Task;
	import com.gamehero.sxd2.pro.TaskStatus;
	import com.gamehero.sxd2.vo.ErrcodeVO;
	import com.gamehero.sxd2.vo.TaskInfoVo;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.MapTypeDict;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import alternativa.gui.data.DataProvider;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * 任务追踪面板
	 * @author zhangxueyou
	 * @create 2015-08-21
	 **/
	public class MainTaskPanel extends Sprite
	{
		
		private static var _instance:MainTaskPanel;//单例对象
		
		private var domain:ApplicationDomain;//资源作用域
		
		private var taskTitleMc:MovieClip;//面板头部对象
		
		private var currentTaskBtn:SimpleButton;//当前任务按钮
		
		private var canTaskBtn:SimpleButton;//可接任务按钮
		
		private var expandBtn:SimpleButton;//面板展开按钮
		
		private var indentBtn:MovieClip;//面板缩进按钮
		
		private var currentBtn:SimpleButton;//当前面板缩放状态按钮
		
		private var titleMc:MovieClip;//可以切换的title对象
		
		private var currentStatus:int = 1;//当前面板数据源 1为当前任务 2为可接任务
		
		private var taskPanelBG:ScaleBitmap;//任务栏背景
		
		private var currentTaskSimplePanel:SimplePanel;//当前任务面板
		
		private var canTaskSimplePanel:SimplePanel;//可接任务面板
		
		private var currentTaskTree:TaskTree;//当前任务list
		
		private var currentTaskTreeDataProvider:DataProvider;//当前任务数据
		
		private var canTaskTree:TaskTree;//可接任务list
		
		private var canTaskTreeDataProvider:DataProvider;//可接任务数据
		
		private var taskDict:Dictionary;//任务字典
		
		private var taskList:Array = [];//任务数组
		
		private var currentPanel:SimplePanel; //当前显示的面板
		
		private var currentPanelStatus:int = 1; //当前面板状态 1为展开 2为缩放
		
		private var isMcPlay:Boolean;//mc是否在播放
		
		private var taskTips:TaskTips;//任务提示
		
		private var isFirstUpdata:Boolean = true;//第一次更新数据
		
		private var mainTask:TaskInfoVo;//主线任务 用于自动任务
		
		private var isCanTask:Boolean;//是否可进行任务
		
		/**
		 * 构造函数
		 * */
		public function MainTaskPanel():void
		{
		}
		
		/**
		 * 初始化
		 * */
		public function init(domain:ApplicationDomain):void
		{
			this.domain = domain;
			
			var global:Global = Global.instance;
			
			taskTips = new TaskTips();
			
			taskTitleMc = global.getRes(domain,"taskTitlePanel") as MovieClip;
			addChild(taskTitleMc);
			
			titleMc = taskTitleMc.getChildByName("titleMc") as MovieClip;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,panelMouseOverHandle);
			
			this.addEventListener(MouseEvent.MOUSE_OUT,panelMouseOUTHandle);
			
			initBtnHandle();

			initTaskPanel();
			
		}
		
		/**
		 * 鼠标移入显示按钮
		 * */
		private function panelMouseOverHandle(e:Event):void
		{
			setBtnVisible(true);
		}
		
		/**
		 * 鼠标移出隐藏按钮
		 * */
		private function panelMouseOUTHandle(e:Event):void
		{
			setBtnVisible(false);
		}
		
		/**
		 * 初始化任务面板
		 * */
		private function initTaskPanel():void
		{
			//任务框背景
			taskPanelBG = new ScaleBitmap(ChatSkin.CHAT_OUTPUT_BG_BD);
			taskPanelBG.scale9Grid = new Rectangle(0, 0, 200, 162);
			taskPanelBG.setSize(205, 162); 
			taskPanelBG.y = 24;
			this.addChild(taskPanelBG);

			currentTaskTreeDataProvider = new DataProvider();
			canTaskTreeDataProvider = new DataProvider();

			currentTaskTree = new TaskTree(TaskTreeListObject);
//			currentTaskTree.scrollBar.visible = false;
			currentTaskTree.dataProvider = currentTaskTreeDataProvider;
			currentTaskSimplePanel = new SimplePanel();
			currentTaskSimplePanel.padding = 0;
			currentTaskSimplePanel.content = currentTaskTree;
			currentTaskSimplePanel.y = 24;
			currentTaskSimplePanel.width = 200;
			currentTaskSimplePanel.height = 160;
			addChild(currentTaskSimplePanel);
			currentTaskSimplePanel.alpha = 0;
			
			canTaskTree = new TaskTree(TaskTreeListObject);
			canTaskTree.container.activate = false;
//			canTaskTree.scrollBar.visible = false;
			canTaskTree.dataProvider = canTaskTreeDataProvider;
			canTaskSimplePanel = new SimplePanel();
			canTaskSimplePanel.padding = 0;
			canTaskSimplePanel.content = canTaskTree;
			canTaskSimplePanel.y = 24;
			canTaskSimplePanel.width = 200;
			canTaskSimplePanel.height = 160;
			addChild(canTaskSimplePanel);
			canTaskSimplePanel.alpha = 0;
			
			addEventListener(TextEvent.LINK, taskTextLinkHandle);// 任务链接
			
			initTasksInfoHandle();
			
			setBtnVisible(false);

		}
		
		/**
		 * 更新任务列表 
		 */
		public function initTasksInfoHandle():void
		{
			if(currentTaskTree == null && canTaskTree == null) return;
			
			currentTaskTree.dataProvider.removeAll();
			currentTaskTreeDataProvider.removeAll();
			
			canTaskTree.dataProvider.removeAll();
			canTaskTreeDataProvider.removeAll();
			
			taskDict = TaskManager.inst.tasks;
			taskList = [];
			var taskInfo:TaskInfoVo
			var npcList:Array = [];
			for each(task in taskDict)
			{
				var task:PRO_Task = task;
				taskInfo = TaskManager.inst.getTaskDataById(task.id);;
				taskInfo.status = task.status;
				taskList.push(taskInfo);
				var npcId:int = TaskManager.inst.setNpcStatus(taskInfo);
				var obj:Object = new Object();
				obj.id = npcId;
				obj.status = taskInfo.status;
				npcList.push(obj);
			}
			
			dispatchEvent(new TaskEvent(TaskEvent.TASK_NPCSTATUS, {npcList:npcList})); //发送事件
			TaskManager.inst.sortTasks(taskList);
			var i:int;
			var len:int = taskList.length;
			var isMainTaskUpdata:Boolean;
			for(i;i<len;i++)
			{
				taskInfo = taskList[i];
				if(taskInfo.type == 1)
				{
					if(mainTask == null)
						mainTask = taskInfo;
					else
					{
						if(mainTask.status != taskInfo.status)
						{
							mainTask = taskInfo;
							isMainTaskUpdata = true;
						}
					}	
				}
					
				//(taskInfo.status == TaskStatus.MainLine && taskInfo.minlevel > GameData.inst.playerInfo.level))
				
				if((taskInfo.status == TaskStatus.Startable && taskInfo.type != 1) || taskInfo.status == TaskStatus.MainLine)
				{
					addTaskList(canTaskTreeDataProvider,taskInfo);
				}
				else
				{
					addTaskList(currentTaskTreeDataProvider,taskInfo);
				}	
			}
			
			if(currentTaskTreeDataProvider.length != 0)
				currentTaskTree.dataProvider = currentTaskTreeDataProvider;
			
			if(canTaskTreeDataProvider.length != 0)
				canTaskTree.dataProvider = canTaskTreeDataProvider;

			if(!currentTaskTreeDataProvider.length)
			{
				canTaskSimplePanel.alpha = 1;
				currentPanel = canTaskSimplePanel;
				currentBtn = currentTaskBtn;
				if(currentStatus == 1)
					setBtnState("canTaskBtn");
			}
			else
			{
				currentTaskSimplePanel.alpha = 1;
				currentPanel = currentTaskSimplePanel;
				currentBtn = canTaskBtn;
				if(currentStatus == 2)
					setBtnState("currentTaskBtn");
			}
			if(!isFirstUpdata && isMainTaskUpdata)
			{
				autoTaskHandle(mainTask,TaskEvent.TASK_LINK);
			}
			if(isFirstUpdata)
				isFirstUpdata = false
		}
		
		/**
		 * 添加至任务列表 
		 */
		private function addTaskList(dataProvider:DataProvider,taskInfo:TaskInfoVo):void {
			
			var params:String = taskInfo.taskId.toString(); 
			/** 任务标题 */
			var taskData:Object;
			taskData = {};
			taskData.parentId = null;
			if(taskInfo.status == TaskStatus.Finished)
			{
				taskData.opened = false;
				taskData.hasChildren = false;
			}
			else
			{
				taskData.opened = true;
				taskData.hasChildren = true;
			}
			taskData.canExpand = true;
			taskData.level = 0;
			taskData.label = TaskManager.inst.formatTaskLabel(taskInfo,taskInfo.title,true);
			taskData.label = TaskManager.inst.formatChatLink(TaskEvent.TASK_LINK,params,taskData.label);
			dataProvider.addItem(taskData);
			
			/** 任务内容 */
			taskData = {};
			taskData.parentId = 0;
			var str:String;
			var traceText:String = TaskManager.inst.getLinkText(taskInfo);
			var regStr:RegExp = /\^.+?\^/g;
			var matchList:Array = traceText.match(regStr);
			var len:int = matchList.length;
			for(var i:int = 0;i<len;i++)
			{
				traceText = traceText.replace(matchList[i], "<font size='12' face='宋体' color='#f6e33f'>" + matchList[i].split("^")[1] + "</font>" );
			}	
			taskData.label = TaskManager.inst.formatChatLink(TaskEvent.TASK_LINK,params,traceText);			
			taskData.opened = false;
			taskData.level = 1;
			taskData.hasChildren = false;
			taskData.canExpand = false;
			
			dataProvider.addItem(taskData);
		}
		
		/**
		 * 点击任务链接 
		 */
		private function taskTextLinkHandle(e:TextEvent):void 
		{
			if(e.target is TextField) return;
			
			var texts:Array = String(e.text).split("^");
			var type:String = texts[0];
			var params:String = texts[1];
			var taskVo:TaskInfoVo = getTaskDataById(int(params));
			
			if(isCanTask)
			{
				if(taskVo.goal_type != TaskManager.inst.TASK_LINK_HURDLE_CODE || int(taskVo.object_id) != GameData.inst.mapInfo.id)
				{
					var error:ErrcodeVO = ErrcodeManager.instance.getErrcode(ERRID.ERRID_FATE_NOT_ENOUGH_SOUL.toString());
					DialogManager.inst.showWarning(error.value);
				}
				else
				{
					dispatchEvent(new MapEvent(MapEvent.HURDL_EMOVE));
				}
			}
			else
			{
				autoTaskHandle(taskVo,type);
			}
			
		}
		
		/**
		 * 面板自动寻路时 如果npc面板或者对话存在 就关闭掉
		 * */
		private function closeMainTask():void
		{
			if(MainUI.inst.taskWindow)
			{
				if(MainUI.inst.taskWindow.visible)
					MainUI.inst.taskWindow.visible = false;
			}
		}

		/**
		 * 初始化按钮 添加监听
		 * */
		private function initBtnHandle():void
		{
			currentTaskBtn = taskTitleMc.getChildByName("currentTaskBtn") as SimpleButton;
			currentTaskBtn.visible = false;
			currentTaskBtn.addEventListener(MouseEvent.CLICK,titleBtnClickHandle);
			
			canTaskBtn = taskTitleMc.getChildByName("canTaskBtn") as SimpleButton;
			canTaskBtn.visible = false;
			canTaskBtn.addEventListener(MouseEvent.CLICK,titleBtnClickHandle);
			
			expandBtn = taskTitleMc.getChildByName("expandBtn") as SimpleButton;
			expandBtn.visible = false;
			expandBtn.addEventListener(MouseEvent.CLICK,titleBtnClickHandle);
			
			indentBtn = taskTitleMc.getChildByName("indentBtn") as MovieClip;
			indentBtn.buttonMode = true;
			indentBtn.visible = false;
			indentBtn.addEventListener(MouseEvent.CLICK,titleBtnClickHandle);
		}
		
		/**
		 * 按钮点击事件 
		 * */
		private function titleBtnClickHandle(e:MouseEvent):void
		{
			var name:String = e.currentTarget.name;
			setBtnState(name);
		}
		
		/**
		 * 设置按钮状态 
		 * */
		private function setBtnState(name:String):void
		{
			
			switch(name)
			{
				//当前任务
				case "currentTaskBtn":
				{
					currentStatus = 1;
					titleMc.gotoAndPlay(9);
					currentBtn = canTaskBtn;
					canTaskBtn.visible = true;
					currentTaskBtn.visible = false;
					TweenLite.to(currentTaskSimplePanel, 0.3, {x:0,alpha:1});
					TweenLite.to(canTaskSimplePanel, 0.3, {x:150, alpha:0});
					currentPanel = currentTaskSimplePanel;
					break;
				}
				//可接任务
				case "canTaskBtn":
				{
					currentStatus = 2;
					titleMc.gotoAndPlay(2);
					currentBtn = currentTaskBtn;
					canTaskBtn.visible = false;
					currentTaskBtn.visible = true;
					TweenLite.to(currentTaskSimplePanel, 0.3, {x:150,alpha:0});
					TweenLite.to(canTaskSimplePanel, 0.3, {x:0, alpha:1});
					currentPanel = canTaskSimplePanel;
					break;
				}
				//展开任务面板
				case "expandBtn":
				{
					currentPanelStatus = 1;
					expandBtn.visible = false;
					TweenLite.to(currentPanel, 0.3, {x:0,alpha:1});
					TweenLite.to(taskPanelBG, 0.3, {x: 0,alpha: 1});
					isMcPlay = true;
					mcEnterFrameHandle()
					break;
				}
				//收缩任务面板
				case "indentBtn":
				{
					currentPanelStatus = 2;
					TweenLite.to(currentPanel, 0.3, {x:200,alpha:0});
					TweenLite.to(taskPanelBG, 0.3, {x:200, alpha:0});
					titleMc.gotoAndPlay(16);
					
					if(canTaskBtn.visible) canTaskBtn.visible = false;
					if(currentTaskBtn.visible) currentTaskBtn.visible = false;
					
					expandBtn.visible = true;
					indentBtn.visible = false;
					
					break;
				}
			}
		}
		
		/**
		 * titleMc播放事件
		 * */
		private function mcEnterFrameHandle():void
		{
			var frameNum:int;
			if(currentStatus == 1)
			{
				frameNum = 23;
			}
			else
			{
				frameNum = 30;
			}
			titleMc.gotoAndPlay(frameNum);	
			titleMc.addEventListener(Event.ENTER_FRAME,titleMcEnterFrameHandle);
		}
		
		/**
		 * titleMc的帧监听事件，判断到达指定帧 显示对应按钮
		 * */
		private function titleMcEnterFrameHandle(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			var currentFrame:int = mc.currentFrame;
			if(currentFrame == 29 || currentFrame == 36)
			{
				indentBtn.visible = true;
				currentBtn.visible = true;
				mc.removeEventListener(Event.ENTER_FRAME,titleMcEnterFrameHandle);
				isMcPlay = false;
			}
				
		}
		
		/**
		 * 设置面板按钮显示
		 * */
		private function setBtnVisible(bool:Boolean):void
		{
			if(isMcPlay) return;
			taskPanelBG.visible = bool;
			//当前为展开状态	
			if(currentPanelStatus == 1)
			{
				indentBtn.visible = bool;
				currentBtn.visible = bool;
			}
			//当前为收缩状态
			else
			{
				expandBtn.visible = bool;
			}
		}
		
		/**
		 * 根据任务Id获取任务信息
		 * */
		public function getTaskDataById(taskId:int):TaskInfoVo
		{
			var len:int = taskList.length;
			var i:int;
			for(i;i<len;i++)
			{
				if(taskList[i].taskId == taskId)
				{
					return taskList[i];
				}
			}
			return null;
		}
		
		public function autoTaskHandle(taskVo:TaskInfoVo,type:String = null):void
		{
			closeMainTask();
			var id:int;
			var eventType:String;
			var target:int;
			var targetValue:String
			switch(taskVo.status)
			{
				//不可接
				case TaskStatus.MainLine:
				{
					return;
				}
				//未接
				case TaskStatus.Startable:
				{
					eventType = TaskEvent.TASK_START;
					switch(taskVo.receive_obj_type)
					{
						case 0:
						{
							id = taskVo.receive_obj_attr;
							break;
						}
						case 1:
						{
							
							break;
						}
						case 2:
						{
							
							break;
						}
						case 3:
						{
							
							break;
						}
						case 4:
						{
							type = null;
							id = taskVo.taskId;
							break;
						}	
						default:
						{
							break;
						}
					}
					break;
				}
				//进行中
				case TaskStatus.InProgress:
				{
					switch(taskVo.goal_type)
					{
						//进入副本
						case TaskManager.inst.TASK_LINK_HURDLE_CODE:
						{
							type = TaskEvent.TASK_HURDLE;
							break;
						}
						//地图寻Npc
						case TaskManager.inst.TASK_LINK_MAP_NPC:
						{
							type = TaskEvent.TASK_LINK;
							break;
						}
						//进入战斗
						case TaskManager.inst.TASK_LINK_BATTLE_CODE:
						{
							type = TaskEvent.TASK_BATTLE;
							break;
						}
						//地图移动
						case TaskManager.inst.TASK_LINK_MAP_MOVE:
						{
							type = TaskEvent.TASK_MAP_MOVE;
							targetValue = taskVo.object_id;
							break;
						}
					}
					id = int(taskVo.object_id);
					break;
				}
				//完成
				case TaskStatus.Finished:
				{
					eventType = TaskEvent.TASK_COMPLETE;
					
					switch(taskVo.finish_obj_type)
					{
						case 0:
						{
							id = taskVo.finish_obj_attr;
							break;
						}
						case 1:
						{
							
							break;
						}
						case 2:
						{
							
							break;
						}
						case 3:
						{
							
							break;
						}
						case 4:
						{
							type = null;
							id = taskVo.taskId;
							break;
						}	
						default:
						{
							break;
						}
					}
					break;
				}
			}
			if(type)
			{
				eventType = type;
			}
			else
			{
				id = taskVo.taskId;
			}
				
			var taskEvent:TaskEvent = new TaskEvent(eventType, {id:id,type:taskVo.goal_type,target:targetValue})
			
			//如果副本中 任务先存起来
			if(isCanTask)
				TaskManager.inst.curEvent = taskEvent;
			else
				dispatchEvent(taskEvent); //发送事件
		}
		
		public function changeView():void
		{
			switch(MapModel.inst.mapVo.type)
			{	
				// 场景地图
				case MapTypeDict.NORMAL_MAP:
					isCanTask = false;	
					break;
				case MapTypeDict.HURLDE_MAP:
				case MapTypeDict.FOG_LEVEL_MAP:
					isCanTask = true;
					if(NoticeUI.inst.pathingItem != null)
					{
						NoticeUI.inst.setPathingItem(false);
					}
					break;
			}
		}
		
		public function continueTaskHandle():void
		{
			if(MapModel.inst.mapVo.type == MapTypeDict.NORMAL_MAP)
			{
				var curEvent:TaskEvent = TaskManager.inst.curEvent;
				if(curEvent)
				{
					dispatchEvent(curEvent);
					TaskManager.inst.curEvent = null;
				}
			}
		}
		
		/**
		 * 获取单例
		 * */
		public static function get inst():MainTaskPanel
		{
			return _instance ||= new MainTaskPanel();
		}
	}
}