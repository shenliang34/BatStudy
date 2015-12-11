package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	/**
	 * 显示/隐藏 npc
	 * @author xuwenyi
	 * @create 2015-09-14
	 **/
	public class SetNpcVisibleCmd extends BaseCmd
	{
		private var visible:Boolean;
		
		public function SetNpcVisibleCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			visible = (xml.@visible == "1");
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void { 
			
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.setNpcVisible(visible);
			
			this.complete();
		}
	}
}