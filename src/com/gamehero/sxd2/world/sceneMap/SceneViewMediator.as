package com.gamehero.sxd2.world.sceneMap
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.NPCEvent;
	import com.gamehero.sxd2.event.TaskEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.manager.NPCManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_MAP_UPDATE_ACK;
	import com.gamehero.sxd2.pro.MSG_TASK_EVENT_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.gamehero.sxd2.vo.NpcVO;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneMediatorBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import bowser.remote.RemoteResponse;
	
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-6-17 下午2:42:50
	 * 
	 */
	public class SceneViewMediator extends SceneMediatorBase
	{
		[Inject]
		public var view:SceneView;
		
		
		public function SceneViewMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			viewbase = view;
			super.initialize();
			
			addContextListener(TaskEvent.TASK_LINK, taskLinkHandle);
			addContextListener(TaskEvent.TASK_HURDLE, taskHurdleHandle);
			addContextListener(TaskEvent.TASK_NPCSTATUS, taskNpcStatusHandle);
			addContextListener(TaskEvent.TASK_MAP_MOVE, taskMapMoveHandle);
			
			addViewListener(MainEvent.SHOW_BATTLE,onPk);
			addViewListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			addViewListener(MapEvent.MAP_MOVE_COMPLETE,mapMoveCompleteHandle);
			addViewListener(NPCEvent.SHOW_BUBBLE,showBubbleHandle);
			addViewListener(NPCEvent.HIDE_BUBBLE,hideBubbleHandle);
			
			gameService.addEventListener(MSGID.MSGID_MAP_UPDATE.toString(),onPlayerUpdate);
		}
		
		/**
		 * 显示npc对话 
		 */
		private function showBubbleHandle(e:NPCEvent):void
		{
			var p:Point = viewbase.gameWorld.getStagePoint(e.data.x , e.data.y);
			e.data.x = p.x;
			e.data.y = p.y;
			
			dispatch(new NPCEvent(NPCEvent.SHOW_BUBBLE,e.data));
		}
		
		/**
		 * 隐藏npc对话 
		 */
		private function hideBubbleHandle(e:NPCEvent):void
		{
			dispatch(new NPCEvent(NPCEvent.HIDE_BUBBLE));
		}
		
		/**
		 *移动到指定npc  
		 * @param e
		 * 
		 */		
		private function taskLinkHandle(e:TaskEvent):void
		{
			var npcId:int = e.data.id;
			var npcVo:NpcVO = NPCManager.instance.getNpcData(npcId);
			mapMoveHandle(npcVo.mapId, npcVo.x, npcVo.y,e);
		}
		
		/**
		 *移动到指定地点 
		 * @param e
		 * 
		 */		
		private function taskMapMoveHandle(e:TaskEvent):void
		{
			var npcId:int =  e.data.id;
			var value:String = e.data.target;
			var list:Array = value.split("^");
			mapMoveHandle(list[0], list[1],list[2],e,true);
		}
		
		/**
		 *移动到传送阵  
		 * @param e
		 * 
		 */		
		private function taskHurdleHandle(e:TaskEvent):void
		{
			var vo:HurdleVo = HurdlesManager.getInstance().getHurdleById(e.data.id);
			TaskManager.inst.hurdleId = vo.id;
			var layer:RoleLayer = viewbase.gameWorld.roleLayer;
			mapMoveHandle(int(vo.entrance_id), layer.getTeleportInfo().x , layer.getTeleportInfo().y,e);
		}
		
		/**
		 *地图移动 
		 * @param id
		 * @param x
		 * @param y
		 * @param e
		 * 
		 */		
		private function mapMoveHandle(id:int,x:int,y:int,e:TaskEvent,bool:Boolean = false):void
		{
			if(bool)
			{
				TaskManager.inst.moveObj = new Object();
				TaskManager.inst.moveObj.isMove = true;
				TaskManager.inst.moveObj.x = x;
				TaskManager.inst.moveObj.y = y;
			}
			
			if(id == GameData.inst.mapInfo.id)
			{
				var layer:RoleLayer = viewbase.gameWorld.roleLayer;
				layer.isDialogue = false;
				layer.goTarget(layer.role , x, y,false);
			}
			else
			{
				TaskManager.inst.curEvent = e;
				TaskManager.inst.globalMove = id;
				TaskManager.inst.isGlobalMove = true;
				gameService.send(MSGID.MSGID_MAP_CITY , null);
				
				/*
				var mapInfo:PRO_Map = new PRO_Map();
				mapInfo.id = id;
				SXD2Main.inst.enterMap(mapInfo);
				*/
			}
		}
		
		/**
		 * 设置npc状态 
		 */
		private function taskNpcStatusHandle(e:TaskEvent):void
		{
			viewbase.gameWorld.roleLayer.setMapNpcStatus();
			var npcList:Array = e.data.npcList;
			npcList.sort(npcListSort);
			var len:int = npcList.length;
			var i:int;
			var mapNpc:MapNPC
			var oldNpcIdList:Array = new Array();
			for(i = 0;i<len;i++)
			{
				mapNpc = viewbase.gameWorld.roleLayer.getMapNpc(npcList[i].id);
				
				if(mapNpc != null)
				{
					var bool:Boolean;
					for(var j:int = 0;j < oldNpcIdList.length; j++)
					{
						if(mapNpc.npcVo.id == oldNpcIdList[j]) 
						{
							bool = true;
						}
					}
					if(!bool)
					{
						mapNpc.setNpcTaskStatus(npcList[i].status);
						oldNpcIdList.push(mapNpc.npcVo.id);
					}	
				}				
			}
		}
		
		/**
		 * npc状态排序 
		 */
		private function npcListSort(obj1:Object,obj2:Object):int
		{
			if(obj1.status > obj2.status)
				return 1;
			else
				return -1;
		}
		
		/**
		 * 地图点击
		 */	
		private function mapClickPlayerHandle(e:MapEvent):void
		{
			eventDispatcher.dispatchEvent(new MapEvent(MapEvent.MAP_CLICK_PLAYER,e.data));
		}
		
		/**
		 * 战斗 
		 * @param event
		 * 
		 */		
		protected function onPk(event:Event):void
		{
			eventDispatcher.dispatchEvent(new MainEvent(MainEvent.SHOW_BATTLE));
		}
		
		/**
		 * 玩家数据刷新 
		 * @param event
		 * 
		 */		
		protected function onPlayerUpdate(event:GameServiceEvent):void
		{
			var remote:RemoteResponse = event.data as RemoteResponse;
			if(remote.errcode == "0" && event.data.protoBytes!=null)
			{
				var info:MSG_MAP_UPDATE_ACK = new MSG_MAP_UPDATE_ACK();
				gameService.mergeFrom(info, event.data.protoBytes);
				// 打印此次数据
				gameService.debug(event.data as RemoteResponse, info);
				
				model.upDatePlayer(info);
				if(model.isLoaded)
				{
					view.updatePlayer(info);
				}
			}
		}
		
		/**
		 *移动到指定地点 通知服务器端验证
		 * @param e
		 * 
		 */		
		private function mapMoveCompleteHandle(e:MapEvent):void
		{
			var taskEvent:MSG_TASK_EVENT_REQ = new MSG_TASK_EVENT_REQ();
			taskEvent.type = TaskManager.inst.TASK_LINK_MAP_MOVE;
			GameService.instance.send(MSGID.MSGID_TASK_EVENT,taskEvent);
			TaskManager.inst.moveObj.isMove = false;
			TaskManager.inst.colseAutoTaskHandle();
		}
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			removeContextListener(TaskEvent.TASK_LINK, taskLinkHandle);
			removeContextListener(TaskEvent.TASK_NPCSTATUS, taskNpcStatusHandle);
			
			this.removeViewListener(MainEvent.SHOW_BATTLE,onPk);
			this.removeViewListener(NPCEvent.SHOW_BUBBLE,showBubbleHandle);
			this.removeViewListener(NPCEvent.HIDE_BUBBLE,hideBubbleHandle);

		}
	}
}