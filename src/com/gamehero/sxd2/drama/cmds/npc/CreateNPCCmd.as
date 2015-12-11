package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	import com.greensock.TweenLite;
	
	import flash.geom.Point;

	
	/**
	 * 创建NPC 
	 */	
	public class CreateNPCCmd extends BaseCmd
	{
		private var npcId:int;
		private var x:Number;
		private var y:Number;
		private var face:String;
		private var tween:Boolean;
		
		
		
		
		public function CreateNPCCmd()
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
			tween = xml.@tween == "1" ? true : false;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			var npc:MapNPC = layer.createNpc(npcId , new Point(x , y) , face);
			
			// npc渐显
			if(tween == true)
			{
				npc.alpha = 0;
				TweenLite.to(npc , 0.5 , {alpha:1 , onComplete:complete});
			}
			else
			{
				complete();
			}
		}
	}
}