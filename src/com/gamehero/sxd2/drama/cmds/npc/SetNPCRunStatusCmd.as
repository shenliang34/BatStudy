package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	
	
	/**
	 * 设置npc跑动动作
	 * @author xuwenyi
	 * @create 2015-11-16
	 **/
	public class SetNPCRunStatusCmd extends BaseCmd
	{
		private var npcId:int;
		private var status:String;
		
		public function SetNPCRunStatusCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			status = xml.@status;
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
				npc.moveStatus = status;
			}
			complete();
		}
	}
}