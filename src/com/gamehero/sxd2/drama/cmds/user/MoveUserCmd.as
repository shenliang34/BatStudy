package com.gamehero.sxd2.drama.cmds.user
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MainRole;

	/**
	 *移动玩家 
	 */
	public class MoveUserCmd extends BaseCmd
	{
		private var x:Number;
		private var y:Number;
		private var face:String;
		
		
		
		public function MoveUserCmd()
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
			var leader:MainRole = layer.role;
			
			// 不需要移动
			if(leader.x == x && leader.y == y)
			{
				complete();
			}
			else
			{
				leader.addEventListener(MapEvent.ROLE_STOP , stop);
				layer.goTarget(leader , x , y , false);
				
				function stop(e:MapEvent):void
				{
					if(e.target == leader)
					{
						leader.removeEventListener(MapEvent.ROLE_STOP , stop);
						if(face != "")
						{
							leader.avatar.face = face;
						}
						
						complete();
					}
				}
			}
			
		}
		
		
		
	}
}