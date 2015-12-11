package com.gamehero.sxd2.world.views
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.gui.main.MainTaskPanel;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.MSG_MAP_UPDATE_ACK;
	import com.gamehero.sxd2.world.display.data.SwfAtalsCenter;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.views.item.MainRole;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import bowser.loader.BulkLoaderSingleton;
	
	
	/**
	 * 场景基本类，包括添加移除事件的监听<br>
	 * 场景就是一块画布；<br>
	 * 抽象类，不能直接实例化；
	 * @author weiyanyu
	 * 创建时间：2015-6-17 下午1:47:04
	 */
	public class SceneViewBase extends Sprite
	{
		protected var _loader:BulkLoaderSingleton;
		//场景 
		protected var _gameWorld:GameWorld;
		
		protected var _mapModel:MapModel;
		
		/**
		 * 地图名字 
		 */		
		private var _titleView:MapTitle;
		
		
		
		public function SceneViewBase()
		{
			super();
			_mapModel = MapModel.inst;
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		/**
		 * 加入场景
		 * */
		protected function onAdd(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdd);
			// 自适应
			stage.addEventListener(Event.RESIZE , resize);
			_loader = BulkLoaderSingleton.instance;
			init();
		}
		/**
		 * 设置场景名字 
		 * @param id 场景id
		 * 
		 */		
		protected function setName(id:int):void
		{
			_titleView = new MapTitle(GameConfig.MAP_DECO + id + ".swf");
			addChild(_titleView);
		}
		
		protected function onPatchRoleLoc(event:RoleEvent):void
		{
			dispatchEvent(new RoleEvent(RoleEvent.MOVE_EVENT));
		}
		
		/**
		 * 初始化 ,初始化的时候必须实例相应的GameWorld
		 * 
		 */		
		protected function init():void
		{
			_gameWorld.addEventListener(MapEvent.MAP_INIT , onInit);
			_gameWorld.addEventListener(RoleEvent.MOVE_EVENT , onPatchRoleLoc);
			
			// 加载地图
			_gameWorld.loadWorld(MapModel.inst.mapVo.mapId);
			// 设置地图名
			this.setName(MapModel.inst.mapVo.mapId);
		}
		
		/**
		 * gameworld初始化成功后响应
		 * */
		private function onInit(e:MapEvent):void
		{
			//播放场景音乐
			this.playMusic();
			// 播放剧情
			if(_mapModel.mapVo.drama)
			{
				DramaManager.inst.playDrama(_mapModel.mapVo.drama);
			}
			

			//自动移动到需要进入的地图
			if(TaskManager.inst.isGlobalMove)
			{
				var p:* = _gameWorld.roleLayer.getCityPos(TaskManager.inst.globalMove);
				if(p)
				{
					_gameWorld.roleLayer.goTarget(_gameWorld.ROLE,p.x,p.y,false);
					TaskManager.inst.isGlobalMove = false;
				}
				else
				{
					trace("cityId---" + TaskManager.inst.globalMove);
				}
				
			}
			//查看是否有任务需要继续进行
			else if(TaskManager.inst.curEvent)
				MainTaskPanel.inst.continueTaskHandle();	
			
//			resize(null);
		}
		
		
		
		/**
		 * 设置人物猪脚位置 
		 * @param px
		 * @param py
		 * 
		 */		
		public function setRolePoint(px:int,py:int):void
		{
			_gameWorld.ROLE.x = px;
			_gameWorld.ROLE.y = py;
			_gameWorld.adjustCamera();
			_gameWorld.moveWolrd();
		}
		/**
		 * 场景大小改变 
		 * @param event
		 * 
		 */		
		protected function resize(event:Event):void
		{
			var newWidth:int = stage.stageWidth;
			var newHeight:int = stage.stageHeight;
			if(newWidth > MapConfig.STAGE_MAX_WIDTH) newWidth = MapConfig.STAGE_MAX_WIDTH;
			if(newHeight > MapConfig.STAGE_MAX_HEIGHT) newHeight = MapConfig.STAGE_MAX_HEIGHT;
			
			if(_gameWorld)
				_gameWorld.resize(newWidth,newHeight);
			
			this.x = (stage.stageWidth - newWidth) >> 1;
			this.y = (stage.stageHeight - newHeight) >> 1;
		}
		/**
		 * 设置是否可见 
		 * @param v
		 * 
		 */		
		public function setVisible(v:Boolean):void
		{
			this.visible = v;
			if(v)
			{
				_gameWorld.startRender();
				_gameWorld.canInteractive = true;
				_gameWorld.isShow = true;
			}
			else
			{
				_gameWorld.stopRender();
				_gameWorld.canInteractive = false;
				_gameWorld.isShow = false;
			}
		}
		
		/**
		 * 移除场景
		 * */
		protected function onRemove(e:Event):void
		{
			gc();
		}
		
		
		
		
		/**
		 * 开始渲染 
		 */		
		public function startRender():void
		{
			_gameWorld.startRender();
		}
		
		
		
		/**
		 * 停止渲染 
		 */		
		public function stopRender():void
		{
			_gameWorld.stopRender();
		}
		
		
		
		
		/**
		 * 显示/隐藏其他玩家
		 * */
		public function setPlayersVisible(value:Boolean):void
		{
			
		}
		
		
		
		
		/**
		 * 显示/隐藏其他NPC
		 * */
		public function setNPCsVisible(value:Boolean):void
		{
			
		}
		
		
		
		
		/**
		 * 播放背景音乐
		 * */
		public function playMusic():void
		{
			//播放场景音乐
			if(_mapModel.mapVo && _mapModel.mapVo.sounds)
			{
				SoundManager.inst.stopAllSounds();
				SoundManager.inst.play(_mapModel.mapVo.sounds , 500);
			}
		}
		
		
		
		public function get gameWorld():GameWorld
		{
			return _gameWorld;
		}
		
		/**
		 * 人物相对屏幕的猪脚 
		 * @return 
		 * 
		 */		
		public function get rolePoint():Point
		{
			return _gameWorld.rolePoint;
		}
		/**
		 * 获得主角， 
		 * @return 
		 * （为了方便一些动画调位置）
		 */		
		public function get ROLE():MainRole
		{
			return _gameWorld.ROLE;
		}
		
		/**
		 * 玩家图层 
		 * @return 
		 * 
		 */		
		public function get roleLayer():RoleLayer
		{
			return _gameWorld .roleLayer;
		}
		
		
		/**
		 * 更新玩家信息 
		 * @param info
		 * 
		 */		
		public function updatePlayer(info:MSG_MAP_UPDATE_ACK):void
		{
			if(roleLayer)
				roleLayer.updatePlayer(info);
		}
		
		public function initPlayers():void
		{
			if(roleLayer)
				roleLayer.initPlayers();
		}
		
		
		public function gc():void
		{
			// 停止所有音乐
			SoundManager.inst.stopAllSounds();
			
			if(_titleView && this.contains(_titleView))
			{
				removeChild(_titleView);
				_titleView.gc();
				_titleView = null;
			}
			if(_gameWorld) _gameWorld.gc(true);
			
			_gameWorld.removeEventListener(MapEvent.MAP_INIT , onInit);
			_gameWorld.removeEventListener(RoleEvent.MOVE_EVENT , onPatchRoleLoc);
			this.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
			
			// 自适应
			stage.removeEventListener(Event.RESIZE , resize);
			SwfAtalsCenter.dispose();
		}
	}
}