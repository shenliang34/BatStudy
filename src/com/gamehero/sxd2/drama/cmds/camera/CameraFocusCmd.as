package com.gamehero.sxd2.drama.cmds.camera
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;

	/**
	 *设置镜头跟随对象 
	 */
	public class CameraFocusCmd extends BaseCmd
	{
		private var npcId:int;
		
		
		
		public function CameraFocusCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			
			if(npcId > 0)
			{
				var npc:MapNPC = world.roleLayer.getMapNpc(npcId);
				if(npc != null)
				{
					world.cameraFocusTarget = npc;
					world.setCameraFocus(npc.x , npc.y);
				}
			}
			else
			{
				world.cameraFocusTarget = world.ROLE;
				world.setCameraFocus(world.ROLE.x , world.ROLE.y);
			}
			this.complete();
		}
	}
}