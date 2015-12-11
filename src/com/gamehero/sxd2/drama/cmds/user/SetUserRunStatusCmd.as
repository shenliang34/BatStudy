package com.gamehero.sxd2.drama.cmds.user
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	
	/**
	 * 设置主角跑动动作
	 * @author xuwenyi
	 * @create 2015-11-16
	 **/
	public class SetUserRunStatusCmd extends BaseCmd
	{
		private var status:String;
		
		
		public function SetUserRunStatusCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			status = xml.@status;
		}
		
		
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void 
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.role.moveStatus = status;
			
			complete();
		}
	}
}