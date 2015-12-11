package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.cmds.user.LocalUserCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	

	
	
	
	/**
	 * 定位NPC对象
	 */	
	public class LocalNPCCmd extends LocalUserCmd
	{
		private var npcId:int;
		private var x:int;
		private var y:int;
		private var face:String;
		
		
		
		public function LocalNPCCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			x = xml.@x;
			y = xml.@y;
			face = xml.@face;
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
				npc.x = x;
				npc.y = y;
				npc.avatar.face = face;
			}
			
			complete();
		}
		
	}
}