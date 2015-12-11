package com.gamehero.sxd2.drama.cmds.user
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.utils.setTimeout;
	
	
	/**
	 * 设置主角动作
	 * @author xuwenyi
	 * @create 2015-10-29
	 **/
	public class SetUserStatusCmd extends BaseCmd
	{
		private var status:String;
		private var face:String;
		private var duration:int;
		
		
		public function SetUserStatusCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			status = xml.@status;
			face = xml.@face;
			duration = xml.@duration;
		}
		
		
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void 
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.role.setStatus(status);
			
			if(face != "")
			{
				layer.role.avatar.face = face;
			}
			
			if(duration > 0)
			{
				setTimeout(complete , duration);
			}
			else
			{
				complete();
			}
		}
	}
}