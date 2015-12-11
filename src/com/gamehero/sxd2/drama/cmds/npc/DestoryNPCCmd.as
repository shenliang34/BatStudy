package com.gamehero.sxd2.drama.cmds.npc
{
    import com.gamehero.sxd2.drama.base.BaseCmd;
    import com.gamehero.sxd2.world.views.GameWorld;
    import com.gamehero.sxd2.world.views.RoleLayer;
    import com.gamehero.sxd2.world.views.SceneViewBase;
    import com.gamehero.sxd2.world.views.item.MapNPC;
    import com.greensock.TweenLite;

	
	/**
	 * 移除NPC 
	 * @author wulongbin
	 * @modify Trey 2014-9-28
	 */
	public class DestoryNPCCmd extends BaseCmd
	{
		private var npcId:int;
		private var tween:Boolean;
		
		
		public function DestoryNPCCmd()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			tween = xml.@tween == "1" ? true : false;
		}
		
		
		override public function triggerCallBack(callBack:Function = null):void
		{ 
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			var npc:MapNPC = layer.getMapNpc(npcId);
			// 先渐隐
			if(npc)
			{
				if(tween == true)
				{
					TweenLite.to(npc , 0.5 , {alpha:0 , onComplete:over});
					
					function over():void
					{
						npc.alpha = 1;
						layer.destoryNpc(npcId);
						complete();
					}
				}
				else
				{
					layer.destoryNpc(npcId);
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