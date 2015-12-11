package com.gamehero.sxd2.gui.npc
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.TaskEvent;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.main.MainTaskPanel;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.GiftBoxManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.NPCManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.TaskStatus;
	import com.gamehero.sxd2.vo.FunctionVO;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	import com.gamehero.sxd2.vo.TaskInfoVo;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import alternativa.gui.mouse.CursorManager;
	
	import bowser.loader.BulkLoaderSingleton;

	/**
	 * Npc对话窗口
	 * @author zhangxueyou
	 * @create-date 2015-8-25
	 */
	public class NpcWindow extends Sprite
	{
		private static var _instance:NpcWindow;//单例对象
		private var textList:Array = [];//文本对象数组
		private var npcDialogue:Bitmap;//对话面板
		private var npcDialogueText:TextField;//对话文本
		private var npcDialogurList:Array;//npc对话数组
		private var playerDialogurList:Array;//玩家对话数组
		private var dialogurCount:int;//对话计数
		private var taskList:Array = [];//任务信息数组
		private var awardTitleText:TextField;//奖励title文本对象
		private var awardText:TextField;//任务奖励内容
		private var awardBg:Bitmap;//奖励背景
		private var npcFaceSp:Sprite;//npc头像
		private var npcFaceImg:Bitmap;//npc头像图片
		private var SENDEVENTTIMER:int = 1000;
		/**
		 * 构造
		 * */
		public function NpcWindow()
		{
		}

		/**
		 * 初始化任务UI
		 * */
		public function init():void
		{
			var npcBg:Bitmap = new Bitmap(MapSkin.NPC_BG);
			npcBg.x = 5;
			npcBg.y = 15;
			addChild(npcBg);
			npcFaceSp = new Sprite();
			addChild(npcFaceSp);
			
			npcDialogue = new Bitmap(MapSkin.NPC_DIALOGUE_1);
			npcDialogue.x = 210;
			addChild(npcDialogue);

			npcDialogueText = new TextField();
			npcDialogueText.width = 180;
			npcDialogueText.x = npcDialogue.x + 20;
			npcDialogueText.y = npcDialogue.y + 30;
			npcDialogueText.wordWrap = true; 
			npcDialogueText.multiline = true;
			npcDialogueText.selectable = false;
			addChild(npcDialogueText);
			
			addEventListener(TextEvent.LINK, taskTextLinkHandle);
			
			for(var i:int;i<3;i++)
			{
				var text:HtmlText = new HtmlText();
				text.isClickActive = true;
				
				text.setTextWidth(200);
				text.width = 200;
				text.height = 16;
				text.x = 280;
				text.y = 167 + i * 22;
				text.visible = false;
//				text.selectable = false;
				addChild(text);
//				text.filters = [new GlowFilter(GameDictionary.STROKE, 1.0, 2.0, 2.0, 10, 1, false, false)];
				textList.push(text);
			}
			
			awardBg = new Bitmap(MapSkin.TASK_AWARD_BG);
			awardBg.visible = false;
			awardBg.x = 240;
			awardBg.y = 100;
			addChild(awardBg);
			
			awardTitleText = new TextField();
			awardTitleText.width = 200;
			awardTitleText.height = 18;
			awardTitleText.x = 290;
			awardTitleText.y = 105;
			awardTitleText.selectable = false;
			awardTitleText.visible = false;
			awardTitleText.filters = [new GlowFilter(GameDictionary.STROKE, 1.0, 2.0, 2.0, 10, 1, false, false)];
			addChild(awardTitleText);
			
			awardText = new TextField();
			awardText.width = 400;
			awardText.height = 36;
			awardText.x = 290;
			awardText.y = 122;
			awardText.selectable = false;
			awardText.visible = false;
			awardText.filters = [new GlowFilter(GameDictionary.STROKE, 1.0, 2.0, 2.0, 10, 1, false, false)];
			addChild(awardText);
			
			var closeBtn:Button = new Button(MapSkin.TASK_CLOSE_BTN_UP,MapSkin.TASK_CLOSE_BTN_DOWN,MapSkin.TASK_CLOSE_BTN_OVER);
			closeBtn.x = 480;
			closeBtn.y = 145;
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnClickHandle);
			addChild(closeBtn);
		}
		/**
		 * 窗口关闭按钮点击事件
		 * */
		private function closeBtnClickHandle(e:Event):void
		{
			this.visible = false;
		}
		
		/**
		 * 初始化任务信息
		 * */
		public function initTaskInfo(list:Array,npcId:int,funcVo:FunctionVO):void
		{
			initTaskWindowInfo();
			taskList = list;
			var len:int = taskList.length;
			var i:int;
			for(i;i<len;i++)
			{
				var task:TaskInfoVo = taskList[i];
				textList[i].visible = true;
				if(task.status != 0)
				{
					var textStr:String = ">> " + Lang.instance.trans(task.title);
					textStr = TaskManager.inst.formatTaskLabel(task,textStr,false);
					textList[i].text = TaskManager.inst.formatChatLink(TaskManager.inst.TASK_LINK_DIALOGUE,task.taskId.toString(),textStr);		
				}		
			}
			
			if(funcVo)
			{
				textStr = "<font size='12' face='宋体' color='#2ce80e'>" + ">> " + Lang.instance.trans(funcVo.funcName);
				textList[len].text = TaskManager.inst.formatChatLink(NPCManager.instance.NPC_LINK_FUNC,funcVo.name,textStr);
				textList[len].visible = true;
			}
			
			if(npcFaceImg != null)
			{
				try
				{
					npcFaceSp.removeChild(npcFaceImg);	
				} 
				catch(error:Error) 
				{
					
				}
			}
			var url:String =  GameConfig.NPCFACE_URL + npcId + ".png";
			BulkLoaderSingleton.instance.addWithListener(url,null,npcFaceLoadComplete);
			BulkLoaderSingleton.instance.start();
		}
		
		private function npcFaceLoadComplete(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, npcFaceLoadComplete);
			npcFaceImg = e.currentTarget.content;
			npcFaceImg.x = -200;
			npcFaceImg.y = -190;
			npcFaceSp.addChild(npcFaceImg);
			this.visible = true;
		}
		
		/**
		 * 文本点击事件
		 * */
		private function taskTextLinkHandle(e:TextEvent):void
		{
			if(e.target is TextField) return;

			initTaskWindowUI();//初始化窗口UI
			var texts:Array = String(e.text).split("^");
			var type:String = texts[0]; //点击类型
			var params:String = texts[1];//对应的数据 任务为taskID

			//根据类型判断是功能还是任务 任务都是对话开始
			switch(type)
			{
				case TaskManager.inst.TASK_LINK_DIALOGUE:
				{
					var task:TaskInfoVo = getTaskDataById(int(params)); //根据id获取详细的任务信息
					if(task == null) return;//没有任务数据返回

					//根据任务类型获取对应的对话
					switch(task.status)
					{
						//未接
						case TaskStatus.Startable:
						{
							setDialogurInfo(task,task.player_recieve_text,task.npc_recieve_text);
							break;
						}
						//进行中
						case TaskStatus.InProgress:
						{
							setDialogurInfo(task,task.player_goal_text,task.npc_goal_text);
							break;
						}
						//完成
						case TaskStatus.Finished:
						{
							setDialogurInfo(task,task.player_finish_text,task.npc_finish_text);
							break;
						}
					}
					break;
				}
				case NPCManager.instance.NPC_LINK_FUNC:
					MainUI.inst.openWindow(params);
					this.visible = false;
					break;
				
			}
		}
		
		private var sendTimer:int;
		private var npcStr:String;
		/**
		 * 任务的对话与事件
		 * */
		private function setDialogurInfo(task:TaskInfoVo,pStr:String,nStr):void
		{
			npcDialogurList = Lang.instance.trans(nStr).split(";");//分隔符获取npc对话数组
			playerDialogurList = Lang.instance.trans(pStr).split(";");//分隔符获取玩家对话数组
			
			if(dialogurCount < playerDialogurList.length) //当前如果不是最后一组对话
			{
				CursorManager.cursorType = CursorManager.BUTTON;
				var playerStr:String = playerDialogurList[dialogurCount];//根据对象计数器 获取当前玩家对话
				npcStr = npcDialogurList[dialogurCount];		 //根据对象计数器 获取当前npc对话
				var playerFormatStr:String = "<font size='12' face='宋体' color='#f6e33f'>";//玩家内容样式
				var npcFormatStr:String = "<font size='12' face='宋体' color='#568dfe'>";//npc内容样式
				var awardFormatStr:String = "<font size='12' face='宋体' color='#f6e33f'>";//奖励样式
				var awardExpFormatStr:String = "<font size='12' face='宋体' color='#2ce80e'>";//奖励经验
				var awardGoldFormatStr:String = "<font size='12' face='宋体' color='#f78c2d'>";//奖励金币
				playerStr = playerFormatStr + ">> " + playerStr;
				//设置玩家对象文本
				textList[0].visible = true;
				textList[0].text = TaskManager.inst.formatChatLink(TaskManager.inst.TASK_LINK_DIALOGUE,task.taskId.toString(),playerStr);
				
				npcDialogue.visible = true; //npc对面面板
				npcDialogueText.visible = true;//npc对面文本
				var timer:Timer = new Timer(30,npcStr.length);
				timer.addEventListener(TimerEvent.TIMER,timerHandle);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandle);
				timer.start();
//				npcDialogueText.htmlText = npcStr;//设置npc对象文本
				dialogurCount ++ //计数
				var isAeard:Boolean; //显示奖励标记
				if(dialogurCount == playerDialogurList.length)
				{
					isAeard = true;
				}
				if(isAeard)	
				{
					awardTitleText.visible = true;
					awardTitleText.htmlText = awardFormatStr + "<b>" + Lang.instance.trans("task_reward_text") + "</b>" + "</font>";
					awardText.visible = true;
					awardText.htmlText = awardExpFormatStr + Lang.instance.trans("exp_text") + "+" + task.EXP + "</font>" + "  " + awardGoldFormatStr + Lang.instance.trans("gold_text") + "+" + task.gold;
					
					if(task.boxId != "")
					{
						var awardStr:String = task.boxId
						var list:Array = awardStr.split("^");
						var len:int = list.length;
						for(var i:int;i<len;i++){
							var box:GiftBoxVo = GiftBoxManager.instance.getBoxById(list[i]);
							var boxId:int = box.itemArr[0];
							var item:PropBaseVo = ItemManager.instance.getPropById(boxId);
							if(item)
							{
								awardText.htmlText += "  " + awardGoldFormatStr + item.name;
								var awardCount:String;
								if(box.maxNumArr[0] == box.minNumArr[0])
									awardCount = "*" + box.maxNumArr;
								else
									awardCount = "*" + box.minNumArr + "~" + box.maxNumArr;
								
								awardText.htmlText += awardCount;
							}
							
						}
					}	
					awardBg.visible = true;
				}
			}
			else 
			{
				this.visible = false;
				if(getTimer() - sendTimer < SENDEVENTTIMER) return;
				
				MainTaskPanel.inst.autoTaskHandle(task);
				
				/*
				//如果对象已结束 根据对应状态 发送事情
				switch(task.status)
				{
					case TaskStatus.Startable:
					{
						dispatchEvent(new TaskEvent(TaskEvent.TASK_START,{id:task.taskId})); //任务接取
						break;
					}
					case TaskStatus.InProgress:
					{
						switch(task.goal_type)
						{
							//地图寻路
							case TaskManager.inst.TASK_LINK_MAP_CODE:
							{
								dispatchEvent(new TaskEvent(TaskEvent.TASK_LINK,{type:task.goal_type,id:task.object_id}));//寻路任务	
							}
							break;
							//发起战斗
							case TaskManager.inst.TASK_LINK_BATTLE_CODE:
							{
								dispatchEvent(new TaskEvent(TaskEvent.TASK_BATTLE,{id:task.object_id}));//战斗任务
							}
							break;
							//进入副本
							case TaskManager.inst.TASK_LINK_HURDLE_CODE:
							{
								dispatchEvent(new TaskEvent(TaskEvent.TASK_HURDLE,{id:task.object_id}));//副本
							}	
							break;
							
						}
						break;
					}
					case TaskStatus.Finished:
					{
						dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETE,{id:task.taskId}));//任务完成
						break;
					}
				}
				*/
				sendTimer = getTimer();
			}
		}
		
		/**
		 * 根据任务Id获取任务信息
		 * */
		private function getTaskDataById(taskId:int):TaskInfoVo
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
		
		/**
		 * 初始化窗口UI
		 * */
		private function initTaskWindowUI():void
		{
			timerCount = 0;
			npcDialogueText.text = "";
			CursorManager.cursorType = CursorManager.ARROW;
			for(var i:int;i<textList.length;i++)
			{
				textList[i].visible = false;
//				cancelMouseEvent(textList[i]);
			}	
			awardBg.visible = false;
			awardTitleText.visible = false;
			awardText.visible = false;
		}
		
		/**
		 * 初始化窗口数据和UI
		 * */
		private function initTaskWindowInfo():void
		{
			npcDialogurList = [];
			playerDialogurList = [];
			dialogurCount = 0;
			npcDialogue.visible = false;
			npcDialogueText.visible = false;
			initTaskWindowUI();
		}
		
		private var timerCount:int;
		/**
		 * 定时器进行中
		 * */
		private function timerHandle(e:Event):void
		{
			npcDialogueText.text += npcStr.charAt(timerCount);
			timerCount ++;
		}	
		
		/**
		 * 定时器完成
		 * */
		private function timerCompleteHandle(e:Event):void
		{
			e.currentTarget.removeEventListener(TimerEvent.TIMER,timerHandle);
			e.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandle);
		}

		/**
		 * 获取单例
		 * */
		static public function get inst():NpcWindow {
			
			return _instance ||= new NpcWindow();
		}
	}
}