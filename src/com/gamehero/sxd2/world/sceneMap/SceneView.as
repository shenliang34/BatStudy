package com.gamehero.sxd2.world.sceneMap
{
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.NPCEvent;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.MSG_MAP_UPDATE_ACK;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-6-17 下午1:42:23
	 * 场景
	 */
	public class SceneView extends SceneViewBase
	{
		
		public function SceneView()
		{
			super();
		}
		
		override protected function init():void
		{
			_gameWorld = new SceneGameWorld(this,stage.stageWidth,stage.stageHeight,false,17);
			
			_gameWorld.addEventListener(MainEvent.SHOW_BATTLE,onPk);
			
			_gameWorld.addEventListener(NPCEvent.SHOW_BUBBLE,showBubbleHandle);
			
			_gameWorld.addEventListener(NPCEvent.HIDE_BUBBLE,hideBubbleHandle);
			
			_gameWorld.addEventListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			
			_gameWorld.addEventListener(MapEvent.MAP_MOVE_COMPLETE,mapMoveCompleteHandle);
			super.init();
			
			resize(null);
		}
		
		private function showBubbleHandle(e:NPCEvent):void
		{
			dispatchEvent(new NPCEvent(NPCEvent.SHOW_BUBBLE,e.data));
		}
		
		private function hideBubbleHandle(e:NPCEvent):void
		{
			dispatchEvent(new NPCEvent(NPCEvent.HIDE_BUBBLE));
		}
		
		protected function onPk(event:Event):void
		{
			dispatchEvent(new MainEvent(MainEvent.SHOW_BATTLE));
		}
		
		private function mapClickPlayerHandle(e:MapEvent):void
		{
			dispatchEvent(new MapEvent(MapEvent.MAP_CLICK_PLAYER,e.data));
		}
		
		private function mapMoveCompleteHandle(e:MapEvent):void
		{
			dispatchEvent(new MapEvent(MapEvent.MAP_MOVE_COMPLETE));
		}
		
		override public function setVisible(v:Boolean):void
		{
			this.visible = v;
			v ? _gameWorld.startRender(): _gameWorld.stopRender();
		}
		
		/**
		 * 移除场景
		 * */
		override protected function onRemove(e:Event):void
		{
			super.onRemove(e);
			_gameWorld.removeEventListener(MainEvent.SHOW_BATTLE,onPk);
			_gameWorld.removeEventListener(NPCEvent.SHOW_BUBBLE,showBubbleHandle);
			_gameWorld.removeEventListener(NPCEvent.HIDE_BUBBLE,hideBubbleHandle);
			_gameWorld.removeEventListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			_gameWorld.removeEventListener(MapEvent.MAP_MOVE_COMPLETE,mapMoveCompleteHandle);
			
			_gameWorld.gc(true);
		}
	}
}