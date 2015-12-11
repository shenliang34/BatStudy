package com.gamehero.sxd2.world.globolMap
{
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.GameWorldItemType;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.item.InterActiveItem;
	
	import alternativa.gui.mouse.CursorManager;

	public class GlobalRoleLayer extends RoleLayer
	{
		public function GlobalRoleLayer()
		{
			super();
			
			this.addEventListener(MapEvent.MAP_ACTIVE_COLLIDE,mapActiveCollideHandle);
			
		}
		
		private function mapActiveCollideHandle(e:MapEvent):void
		{
			var targe:InterActiveItem = e.data.targe;
			var role:InterActiveItem = e.data.role;
			if(targe.type == GameWorldItemType.CITY)//传送阵
			{	
				var mapInfo:PRO_Map = new PRO_Map();
				mapInfo.id = int(targe.mapData.ent);
				SXD2Main.inst.enterMap(mapInfo);
				
				MainUI.inst.visible = true;
				
				CursorManager.cursorType = CursorManager.ARROW;
			}
		}
		
		override public function onRenderFrame():void
		{
			setPlayerVisible(false);
			
			super.onRenderFrame();
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			super.gc(isCleanAll);
		}
		
	}
}