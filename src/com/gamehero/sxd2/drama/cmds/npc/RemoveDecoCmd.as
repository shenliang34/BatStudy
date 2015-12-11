package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	/**
	 * 移除地图中装饰（根据id）
	 * @author xuwenyi
	 * @date 2015-11-03
	 */
	public class RemoveDecoCmd extends BaseCmd {
		
		private var id:int;
		private var isTween:Boolean;
		
		
		public function RemoveDecoCmd() {
			
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			id = xml.@id;
			isTween = (xml.@isTween == "1");
		}
		
		
		override public function triggerCallBack(callBack:Function = null):void
		{	
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.destoryDeco(id);
			
			complete();
		}
		
		
	}
}