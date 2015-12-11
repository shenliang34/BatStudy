package com.gamehero.sxd2.world.sceneMap
{
	import com.gamehero.sxd2.event.NPCEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_TASK_EVENT_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.GameWorldItemType;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.item.InterActiveItem;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	
	import flash.geom.Rectangle;
	
	/**
	 * 普通场景的角色层
	 * @author weiyanyu
	 * 创建时间：2015-7-8 下午3:00:34
	 * 
	 */
	public class SceneRoleLayer extends RoleLayer
	{

		public function SceneRoleLayer()
		{
			super();
			
			this.addEventListener(MapEvent.MAP_ACTIVE_COLLIDE,mapActiveCollideHandle);
		}
		
		private var lastTime:int;
		
		private function mapActiveCollideHandle(e:MapEvent):void
		{
			var targe:InterActiveItem = e.data.targe;
			var role:InterActiveItem = e.data.role;
			if(targe.type == GameWorldItemType.SWITCH_MAP)//传送阵
			{
				var hurdleGuideObj:Object = new Object();
				hurdleGuideObj.chapterId = targe.mapData.ent;
				
				if(TaskManager.inst.hurdleId)
					hurdleGuideObj.hurdleId = TaskManager.inst.hurdleId;

				MainUI.inst.openWindow(WindowEvent.HURDLE_GUIDE_WINDOW,hurdleGuideObj);
				NoticeUI.inst.setPathingItem(false);
			}
			else if(targe.type == GameWorldItemType.NPC)//npc
			{

				var mapNpc:MapNPC = targe as MapNPC;
				var dx:Number = mapNpc.x - role.x;
				var dy:Number = mapNpc.y - role.y;
				var angle:Number = Math.atan2(dy,dx);
				mapNpc.setFace(angle);
				
				var rectangle:Rectangle = targe.activeRect;
				parent.dispatchEvent(new NPCEvent(NPCEvent.SHOW_BUBBLE,{x:targe.x,y:targe.y,h:rectangle.height,npcVo:mapNpc.npcVo,target:targe}));
				isDialogue = true;
			}
		}
		
		override public function onRenderFrame():void
		{
			super.onRenderFrame();
		}
		override public function gc(isCleanAll:Boolean=false):void
		{
			super.gc(isCleanAll);
			
			this.removeEventListener(MapEvent.MAP_ACTIVE_COLLIDE,mapActiveCollideHandle);
		}
		
	}
}