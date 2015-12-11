package com.gamehero.sxd2.drama.cmds.dialog
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.DramaThink;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapRoleBase;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * 角色内心思考
	 * @author xuwenyi
	 * @create 2015-11-10
	 **/
	public class ThinkCmd extends BaseCmd
	{
		private var npcId:int;
		private var message:String;
		private var duration:int;
		private var direct:int;
		
		// 说话的人物对象
		private var player:MapRoleBase;
		
		
		
		public function ThinkCmd()
		{
			super();
		}
		
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			npcId = xml.@npcId;
			message = Lang.instance.trans(xml.@message);
			message = message.replace("{me}" , GameData.inst.roleInfo.base.name);
			
			duration = xml.@duration;
			direct = xml.@direct == "-1" ? -1 : 1;
			
			duration += 3000;
		}
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			// npcId若为0,则取主角
			player = npcId == 0 ? layer.role : player = layer.getMapNpc(npcId);
			
			if(player)
			{
				var p:Point = world.getStagePoint(player.x , player.y);
				var think:DramaThink = new DramaThink();
				think.x = p.x;
				think.y = p.y - 280;
				think.showThink(message , duration , direct , onDramaThinkCallback);
				SXD2Main.inst.currentView.addChild(think);
				
				GossipManager.inst.add(think);
				
				App.stage.addEventListener(MouseEvent.CLICK , onClick);
			}
			else
			{
				complete();
			}
		}
		
		
		
		
		
		private function onClick(e:MouseEvent):void
		{
			if(player)
			{
				GossipManager.inst.stop();
			}
		}
		
		
		
		
		/**
		 * 带头像的冒泡回调
		 * */
		private function onDramaThinkCallback(think:DramaThink):void
		{
			if(think.parent)
			{
				think.parent.removeChild(think);
			}
			
			GossipManager.inst.remove(think);
			
			this.complete();
		}
		
		
		
		
		override protected function complete():void
		{
			player = null;
			App.stage.removeEventListener(MouseEvent.CLICK , onClick);
			
			super.complete();
		}
	}
}