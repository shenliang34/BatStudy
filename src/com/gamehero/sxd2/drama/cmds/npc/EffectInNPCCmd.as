package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.display.GameRenderItem;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	
	import flash.utils.setTimeout;
	
	import bowser.loader.BulkLoaderSingleton;

	/**
	 * 在NPC容器内播放特效 
	 */
	public class EffectInNPCCmd extends BaseCmd
	{
		private var npcId:int;
		private var x:int;
		private var y:int;
		private var url:String;
		private var duration:int;
		

		public function EffectInNPCCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			x = xml.@x;
			y = xml.@y;
			url = GameConfig.DRAMA_EFFECT_URL + "png/" + xml.@url;
			duration = xml.@duration;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			var npc:MapNPC = layer.getMapNpc(npcId);
			if(npc)
			{
				var item:GameRenderItem = new GameRenderItem();
				item.load(url , BulkLoaderSingleton.instance);
				item.status = "effect_01_rr_";
				item.x = x;
				item.y = y;
				item.play(true);
				npc.addChild(item);
				
				setTimeout(over , duration);
				
				function over():void
				{
					item.stop();
					item.gc();
					
					npc.removeChild(item);
					
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