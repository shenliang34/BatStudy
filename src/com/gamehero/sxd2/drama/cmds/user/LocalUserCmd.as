package com.gamehero.sxd2.drama.cmds.user
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MainRole;

	
	/**
	 * 定位玩家 
	 */
	public class LocalUserCmd extends BaseCmd
	{
		private var x:Number;
		private var y:Number;
		private var face:String;
		
		
		
		public function LocalUserCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			x = xml.@x;
			y = xml.@y;
			face = xml.@face;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			var role:MainRole = layer.role;
			
			role.x = x;
			role.y = y;
			role.avatar.face = face;
			
			complete();
		}
		
	}
}