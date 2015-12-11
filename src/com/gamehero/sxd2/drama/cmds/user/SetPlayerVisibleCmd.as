package com.gamehero.sxd2.drama.cmds.user
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	
	/**
	 * 设置玩家显示/隐藏
	 * @author xuwenyi
	 * @create 2015-09-16
	 **/
	public class SetPlayerVisibleCmd extends BaseCmd
	{	
		private var visible:Boolean;
		
		
		public function SetPlayerVisibleCmd()
		{
			
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			visible = (xml.@visible == "1");
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void 
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.setPlayerVisible(visible);
			
			this.complete();
		}
	}
}