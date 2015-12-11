package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
    
	
	
	
	/**
	 *移动NPC 
	 */
	public class MoveNPCCmd extends BaseCmd
	{
		private var npcId:int;
		private var x:int;
		private var y:int;
		private var face:String;
		private var speed:Number;
		
		
		
		public function MoveNPCCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			x = xml.@x;
			y = xml.@y;
			speed = xml.@speed;
			face = xml.@face;
			
			if(speed == 0)
			{
				speed = MapConfig.RUN_SPEED_MILLISENDS;
			}
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void
		{ 
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			var npc:MapNPC = layer.getMapNpc(npcId);
			if(npc)
			{
				// 不需要移动
				if(npc.x == x && npc.y == y)
				{
					complete();
				}
				else
				{
					npc.addEventListener(MapEvent.ROLE_STOP , stop);
					layer.goTarget(npc , x , y , false);
					npc.speed = speed;
					
					function stop(e:MapEvent):void
					{
						if(e.target == npc)
						{
							npc.removeEventListener(MapEvent.ROLE_STOP , stop);
							if(face != "")
							{
								npc.avatar.face = face;
							}
							
							complete();
						}	
					}
				}
			}
			else
			{
				complete();
			}
			
		}
		
		
		
		
		override public function clear():void
		{
			super.clear();
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
		}
	}
}