package com.gamehero.sxd2.drama.cmds.dialog
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.DramaGossip;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.world.model.vo.RoleSkinVo;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.gamehero.sxd2.world.views.item.MapRoleBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * npc闲话指令
	 * @author xuwenyi
	 * @create 2015-11-04
	 **/
	public class GossipCmd extends BaseCmd
	{
		private var npcId:int;
		private var message:String;
		private var duration:int;
		private var direct:int;
		private var head:String;
		private var type:int;
		
		// 说话的人物对象
		private var player:MapRoleBase;
		private var dramaGossip:DramaGossip;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function GossipCmd()
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
			head = xml.@head;
			type = xml.@type;
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
				// 角色身高
				var roleSkinVo:RoleSkinVo = player.roleSkinVo;
				var playerHeight:int = roleSkinVo ? roleSkinVo.standHeight : player.avatar.itemHeight;
				
				// 带头像的冒泡
				if(type == 0)
				{
					var p:Point = world.getStagePoint(player.x , player.y);
					dramaGossip = new DramaGossip();
					dramaGossip.x = p.x;
					dramaGossip.y = p.y - 140 - playerHeight;
					dramaGossip.showGossip(message , head , duration , direct , onDramaGossipCallback);
					SXD2Main.inst.currentView.addChild(dramaGossip);
					
					GossipManager.inst.add(dramaGossip);
					
					App.stage.addEventListener(MouseEvent.CLICK , onClick);
					App.stage.addEventListener(Event.RESIZE , resize);
				}
				else
				{
					player.gossip.showGossip(message , duration , direct , complete);
				}
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
		private function onDramaGossipCallback(gossip:DramaGossip):void
		{
			if(gossip.parent)
			{
				gossip.parent.removeChild(gossip);
			}
			
			GossipManager.inst.remove(gossip);
			
			this.complete();
		}
		
		
		
		
		
		
		private function resize(e:Event = null):void
		{
			// 带头像的冒泡对话
			if(dramaGossip != null && player != null)
			{
				// 角色身高
				var roleSkinVo:RoleSkinVo = player.roleSkinVo;
				var playerHeight:int = roleSkinVo ? roleSkinVo.standHeight : player.avatar.itemHeight;
				
				var view:SceneViewBase = SXD2Main.inst.currentView;
				var world:GameWorld = view.gameWorld;
				var p:Point = world.getStagePoint(player.x , player.y);
				dramaGossip.x = p.x;
				dramaGossip.y = p.y - 140 - playerHeight;
			}
		}
		
		
		
		
		
		
		
		override protected function complete():void
		{
			player = null;
			dramaGossip = null;
			
			App.stage.removeEventListener(MouseEvent.CLICK , onClick);
			App.stage.removeEventListener(Event.RESIZE , resize);
			
			super.complete();
		}
		
		
	}
}