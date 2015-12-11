package com.gamehero.sxd2.gui.main 
{	
    import com.gamehero.sxd2.drama.DramaManager;
    import com.gamehero.sxd2.event.MainEvent;
    import com.gamehero.sxd2.event.NPCEvent;
    import com.gamehero.sxd2.event.PlayerEvent;
    import com.gamehero.sxd2.event.TaskEvent;
    import com.gamehero.sxd2.event.WindowEvent;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.notice.NoticeUI;
    import com.gamehero.sxd2.manager.FunctionManager;
    import com.gamehero.sxd2.manager.TaskManager;
    import com.gamehero.sxd2.pro.MSGID;
    import com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_REQ;
    import com.gamehero.sxd2.pro.MSG_GM_EXECUTE_REQ;
    import com.gamehero.sxd2.pro.MSG_MAP_CITY_ACK;
    import com.gamehero.sxd2.pro.MSG_TASK_COMMIT_REQ;
    import com.gamehero.sxd2.pro.MSG_TASK_EVENT_REQ;
    import com.gamehero.sxd2.pro.MSG_TASK_START_REQ;
    import com.gamehero.sxd2.pro.PRO_PlayerBase;
    import com.gamehero.sxd2.services.GameService;
    import com.gamehero.sxd2.services.event.GameServiceEvent;
    import com.gamehero.sxd2.vo.FunctionVO;
    import com.gamehero.sxd2.vo.NpcVO;
    import com.gamehero.sxd2.vo.TaskInfoVo;
    import com.gamehero.sxd2.world.event.MapEvent;
    import com.gamehero.sxd2.world.model.MapConfig;
    import com.gamehero.sxd2.world.model.MapModel;
    import com.gamehero.sxd2.world.views.item.MapNPC;
    
    import flash.display.Bitmap;
    
    import bowser.logging.Logger;
    import bowser.remote.RemoteResponse;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	
	/**
	 * TopUI Mediator
	 * @author Trey
	 * @create-date 2013-8-8
	 */
	public class MainUIMediator extends Mediator {
		
		[Inject]
		public var view:MainUI;
		private var gameService:GameService;
		
		// 正在对话的npc
		private var gossipNpc:MapNPC;
		
		
		public function MainUIMediator()
		{	
			super();	
		}
		
		
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			super.initialize();
			
			gameService =  GameService.instance
			
			this.addViewListener(MainEvent.GM, onGMSend);
			this.addViewListener(WindowEvent.OPEN_WINDOW , onOpenWindow);
			this.addViewListener(TaskEvent.TASK_LINK, taskLinkHandle);
			this.addViewListener(TaskEvent.TASK_NPCSTATUS, taskNpcStatusHandle);
			this.addViewListener(TaskEvent.TASK_BATTLE, taskBattleHandle);
			this.addViewListener(TaskEvent.TASK_HURDLE, taskHurdleHandle);
			this.addViewListener(MainEvent.HIDEOTHERPLAYER,hideOtherPlayerHandle);
			this.addViewListener(MapEvent.ENTER_GOLBAL_WORLD,enterGolbalWorldHandle);
			this.addViewListener(PlayerEvent.LEVEL_UP,playerLevelUpHandle);
			
			this.addViewListener(TaskEvent.TASK_START,taskStartHandle);
			this.addViewListener(TaskEvent.TASK_COMPLETE,taskCompleteHandle);
			this.addViewListener(TaskEvent.TASK_MAP_MOVE,taskMapMoveHandle);
			
			this.addViewListener(MapEvent.HURDL_EMOVE,hurdleMoveHandle);
			
			this.addContextListener(NPCEvent.SHOW_BUBBLE, showBubbleHandle);
			this.addContextListener(NPCEvent.HIDE_BUBBLE, hideBubbleHandle);
			this.addContextListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			this.addContextListener(MapEvent.MAP_NAME_LOAD_COMPLETE,mapNameLoadCompleteHandle);

			gameService.addEventListener(MSGID.MSGID_MAP_CITY.toString(),displayCityListHandle);
			gameService.addEventListener(MSGID.MSGID_COMMON_BUY.toString(),commonButHandle);
				
		}
		
		/**
		 *购买返回 
		 * @param e
		 * 
		 */		
		private function commonButHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0")
			{
				view.leaderPanel.buyConutIncrease();
			}
			else
				view.leaderPanel.isBuy = false;
		}
		
		/**
		 * destroy
		 */
		override public function destroy():void 
		{
			super.destroy();
			
			this.removeViewListener(MainEvent.GM, onGMSend);
			this.removeViewListener(WindowEvent.OPEN_WINDOW , onOpenWindow);
			this.removeViewListener(TaskEvent.TASK_NPCSTATUS, taskNpcStatusHandle);
			this.removeViewListener(TaskEvent.TASK_LINK, taskLinkHandle);
			this.removeViewListener(TaskEvent.TASK_BATTLE, taskBattleHandle);
			this.removeViewListener(TaskEvent.TASK_HURDLE, taskHurdleHandle);
			this.removeViewListener(MainEvent.HIDEOTHERPLAYER,hideOtherPlayerHandle);
			this.removeViewListener(MapEvent.ENTER_GOLBAL_WORLD,enterGolbalWorldHandle);
			this.removeViewListener(PlayerEvent.LEVEL_UP,playerLevelUpHandle);
			this.removeViewListener(MapEvent.HURDL_EMOVE,hurdleMoveHandle);
			
			this.removeViewListener(TaskEvent.TASK_START,taskStartHandle);
			this.removeViewListener(TaskEvent.TASK_COMPLETE,taskCompleteHandle);
			this.removeViewListener(TaskEvent.TASK_MAP_MOVE,taskMapMoveHandle);
			
			this.removeContextListener(NPCEvent.SHOW_BUBBLE, showBubbleHandle);
			this.removeContextListener(NPCEvent.HIDE_BUBBLE, hideBubbleHandle);
			this.removeContextListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			this.removeContextListener(MapEvent.MAP_NAME_LOAD_COMPLETE,mapNameLoadCompleteHandle);
			
			gameService.removeEventListener(MSGID.MSGID_MAP_CITY.toString(),displayCityListHandle);
			
		}
		
		/**
		 * 接受任务
		 * */
		private function taskStartHandle(e:TaskEvent):void
		{
			
			var taskId:int = e.data.id;
			var taskVO:TaskInfoVo = TaskManager.inst.getTaskDataById(taskId);
			
			// 先执行剧情
			if(taskVO.drama1 != 0)
			{
				DramaManager.inst.playDrama(taskVO.drama1 , null , send);
			}
			else
			{
				// 没有剧情直接发送请求
				send();
			}
			
			// 剧情播放完后发送接收任务请求
			function send():void
			{
				var taskStart:MSG_TASK_START_REQ = new MSG_TASK_START_REQ();
				taskStart.id = taskId;
				GameService.instance.send(MSGID.MSGID_TASK_START,taskStart);
			}
		}
		
		/**
		 * 完成任务
		 * */
		private function taskCompleteHandle(e:TaskEvent):void
		{
			var taskId:int = e.data.id;
			var taskVO:TaskInfoVo = TaskManager.inst.getTaskDataById(taskId);
			
			// 先执行剧情
			if(taskVO.drama2 != 0)
			{
				DramaManager.inst.playDrama(taskVO.drama2 , null , send);
			}
			else
			{
				// 没有剧情直接发送请求
				send();
			}
			
			// 剧情播放完后发送完成任务请求
			function send():void
			{
				var taskComplete:MSG_TASK_COMMIT_REQ = new MSG_TASK_COMMIT_REQ();
				taskComplete.id = taskId;
				GameService.instance.send(MSGID.MSGID_TASK_COMMIT,taskComplete);
			}
		}
		
		private function hurdleMoveHandle(e:MapEvent):void
		{
			this.dispatch(e.clone());
		}
		
		private function playerLevelUpHandle(e:PlayerEvent):void
		{
			this.dispatch(e.clone());
		}
		
		private function hideOtherPlayerHandle(e:MainEvent):void
		{
			this.dispatch(e.clone());
		}
		
		private function taskLinkHandle(e:TaskEvent):void
		{
			this.dispatch(e.clone());
			NoticeUI.inst.setPathingItem(true);
		}
		
		private function taskMapMoveHandle(e:TaskEvent):void
		{
			this.dispatch(e.clone());
			NoticeUI.inst.setPathingItem(true);
		}
		
		private function taskNpcStatusHandle(e:TaskEvent):void
		{
			this.dispatch(e.clone());
		}
		
		private function taskHurdleHandle(e:TaskEvent):void
		{	
			this.dispatch(e.clone());
			NoticeUI.inst.setPathingItem(true);
		}
		
		private function taskBattleHandle(e:TaskEvent):void
		{
			var req:MSG_BATTLE_CREATE_REQ = new MSG_BATTLE_CREATE_REQ();
			req.battleId = e.data.id;
			gameService.send(MSGID.MSGID_BATTLE_CREATE , req);
		}
		
		private function enterGolbalWorldHandle(e:MapEvent):void
		{
			gameService.send(MSGID.MSGID_MAP_CITY , null);
		}
		
		private function displayCityListHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0" && remote.protoBytes!=null)
			{
				var ack:MSG_MAP_CITY_ACK = new MSG_MAP_CITY_ACK();
				ack.mergeFrom(remote.protoBytes);
				MapModel.inst.cityList = ack.cityId;
				
				SXD2Main.inst.changeView(MapConfig.GOLBALWORLDCODE);
			}
		}
		
		/**
		 * 显示NPC对话窗口 冒泡或者面板
		 */
		private function showBubbleHandle(e:NPCEvent):void
		{
			NoticeUI.inst.setPathingItem(false);
			var npcVo:NpcVO = e.data.npcVo;
			var npcTaskList:Array = TaskManager.inst.getNpcTasks(npcVo.id);//获取npc拥有的任务
			var eventTaskVo:TaskInfoVo = TaskManager.inst.getNpcEventTask(npcVo.id);//npc为任务目标
			
			var funcVo:FunctionVO = FunctionManager.inst.getFunctionVO(npcVo.funcId);
			var isOpen:Boolean
			if(funcVo)
				isOpen = FunctionManager.inst.isFuncOpen(funcVo.id);
			
			//如果是目标Npc 发送Event完成事件
			if(eventTaskVo)
			{
				var taskEvent:MSG_TASK_EVENT_REQ = new MSG_TASK_EVENT_REQ();
				taskEvent.type = eventTaskVo.goal_type;
				taskEvent.id = int(eventTaskVo.object_id);
				gameService.send(MSGID.MSGID_TASK_EVENT,taskEvent);
			}
			//有任务
			else if(npcTaskList.length != 0)
			{
				WindowManager.inst.closeAllWindow();
				TaskManager.inst.sortTasks(npcTaskList,2);
				if(!isOpen) 
					funcVo = null; //未开启 funvo置null
				view.taskWindow.initTaskInfo(npcTaskList,npcVo.id,funcVo);
			}
			//没有任务 有功能
			else if(isOpen)
			{
				MainUI.inst.openWindow(funcVo.name);
			}
			//都没有 显示对话
			else
			{
				/*view.npcDialogueView.x = e.data.x - 20;
				view.npcDialogueView.y = e.data.y - e.data.h - view.npcDialogueView.height;
				view.npcDialogueView.setText(npcVo.bubble_text);
				view.npcDialogueView.visible = true;*/
				gossipNpc = e.data.target;
				gossipNpc.gossip.showGossip(npcVo.bubble_text);
			}
		}
		
		private function hideBubbleHandle(e:NPCEvent):void
		{
			// 关闭所有闲话泡泡
			if(gossipNpc)
			{
				gossipNpc.gossip.hideGossip();
				gossipNpc = null;
			}
			
			// 关闭任务窗口
			if(view.taskWindow.visible == true)
			{
				view.taskWindow.visible = false;
			}
				
		}
		
		/**
		 * 更新客户端
		 */
		private function onUpdateClient(event:MainEvent):void
		{
			var cv:int = int(event.data);
			
			Logger.debug(MainUIMediator, "Update Client: " + cv);
			
			if(cv > Version.CV) {
				
				/*DialogManager.inst.show("", Lang.instance.trans("AS_783"), GlobalAlert.OK, 
					function onServerDisconnect(event:CloseEvent):void {
					
						JSManager.refreshGame();
					}
				);*/
			}
		}		
		
		/**
		 * 点击玩家
		 * */
		private function mapClickPlayerHandle(e:MapEvent):void{
			TaskManager.inst.colseAutoTaskHandle();
			
			var pos:Object = e.data;
			var playerInfo:PRO_PlayerBase = MapModel.inst.getPlayetInfo(pos.x,pos.y);
			if(playerInfo)
				view.leaderPanel.initOtherPlayerInfo(playerInfo);
			else
				view.leaderPanel.stageClickHandle();
		}
		
		/**
		 * 打开窗口
		 * */
		private function onOpenWindow(e:WindowEvent):void
		{
			if(view.taskWindow.visible)
				view.taskWindow.visible = false;
			this.dispatch(e.clone());
		}
		
		/**
		 * 发送GM指令 
		 */
		private function onGMSend(e:MainEvent):void 
		{
			var req:MSG_GM_EXECUTE_REQ = new MSG_GM_EXECUTE_REQ();
			req.command = e.data as String;
			
			gameService.send(MSGID.MSGID_GM_EXECUTE , req);
		}
		
		/**
		 *地图名称加载完成 
		 * @param e
		 * 
		 */		
		private function mapNameLoadCompleteHandle(e:MapEvent):void
		{
			view.miniFuncPanel.loadMapName(e.data as Bitmap);
		}
		
	}
}