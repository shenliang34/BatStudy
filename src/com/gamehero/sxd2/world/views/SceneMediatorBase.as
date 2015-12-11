package com.gamehero.sxd2.world.views
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.PlayerEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_MAP_MOVE_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.model.MapModel;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 场景media基类
	 * 包括主角位置同步，进出场景，玩家信息更新
	 * @author weiyanyu
	 * 创建时间：2015-7-21 上午11:50:32
	 * 
	 */
	public class SceneMediatorBase extends Mediator
	{
		/**
		 * 视图 
		 */		
		protected var viewbase:SceneViewBase;
		
		protected var gameService:GameService;
		/**
		 * 地图信息 
		 */		
		protected var model:MapModel;
		
		private var _gameData:GameData;
		
		
		public function SceneMediatorBase()
		{
			super();
			gameService = GameService.instance;
			model = MapModel.inst;
			
			_gameData = GameData.inst;
			
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addViewListener(RoleEvent.MOVE_EVENT,onPatchRoleLoc);
			
			addViewListener(MapEvent.MAP_NAME_LOAD_COMPLETE,mapNameLoadCompleteHandle);
			
			addContextListener(MainEvent.HIDEOTHERPLAYER,hideOtherPlayerHandle);
			
			addContextListener(PlayerEvent.LEVEL_UP,playerLevelUpHandle);
		}
		
		/**
		 *地图名称加载完成 
		 * @param e
		 * 
		 */		
		private function mapNameLoadCompleteHandle(e:MapEvent):void
		{
			this.dispatch(e.clone());
		}
		
		private function playerLevelUpHandle(e:PlayerEvent):void
		{
			viewbase.gameWorld.ROLE.upgradeItemPlayHandle();
		}
		
		private function hideOtherPlayerHandle(e:MainEvent):void
		{
			viewbase.gameWorld.roleLayer.setPlayerVisible(e.data);
		}
		
		/**
		 * 派发角色位置信息 
		 * @param event
		 * 
		 */		
		protected function onPatchRoleLoc(event:Event):void
		{
			var msgMapMove:MSG_MAP_MOVE_REQ = new MSG_MAP_MOVE_REQ();
			msgMapMove.map = _gameData.roleInfo.map;
			msgMapMove.isStop = !_gameData.isMove;
			GameService.instance.send(MSGID.MSGID_MAP_MOVE,msgMapMove);
		}
		
		override public function destroy():void
		{
			removeViewListener(RoleEvent.MOVE_EVENT,onPatchRoleLoc);
			
			viewbase = null;
		}
	}
}