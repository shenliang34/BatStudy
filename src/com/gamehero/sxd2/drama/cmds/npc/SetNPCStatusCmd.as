package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	
	import flash.utils.setTimeout;
	
	
	/**
	 * 设置npc动作
	 * @author xuwenyi
	 * @create 2015-10-29
	 **/
	public class SetNPCStatusCmd extends BaseCmd
	{
		private var npcId:int;
		private var status:String;
		private var face:String;
		private var duration:int;
		
		
		public function SetNPCStatusCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			status = xml.@status;
			face = xml.@face;
			duration = xml.@duration;
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
				npc.setStatus(status);
				
				if(face != "")
				{
					npc.avatar.face = face;
				}
				
				if(duration > 0)
				{
					setTimeout(complete , duration);
				}
				else
				{
					complete();
				}
			}
			else
			{
				complete();
			}
		}
	}
}