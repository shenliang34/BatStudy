package com.gamehero.sxd2.world.globolMap
{
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.views.SceneMediatorBase;
	
	public class GlobalSceneMediator extends SceneMediatorBase
	{
		[Inject]
		public var view:GlobalSceneView;
		
		public function GlobalSceneMediator()
		{
			super();
		}
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			viewbase = view;
			this.addViewListener(MapEvent.RETURN_SCENE_MAP,returnSceneMapHandle);
			super.initialize();
			super.removeViewListener(RoleEvent.MOVE_EVENT,onPatchRoleLoc);
		}
		
		
		private function returnSceneMapHandle(e:MapEvent):void
		{
			MainUI.inst.visible = true;
			var mapInfo:PRO_Map = new PRO_Map();
			mapInfo.id = e.data.id;
			SXD2Main.inst.enterMap(mapInfo);
		}
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			this.removeViewListener(MapEvent.RETURN_SCENE_MAP,returnSceneMapHandle);
			super.destroy();
		}
	}
}