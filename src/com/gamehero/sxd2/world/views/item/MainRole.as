package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 主角
	 * @author weiyanyu
	 * 创建时间：2015-7-20 上午11:55:03
	 * 
	 */
	public class MainRole extends MapRunRoleBase
	{
		/**
		 * 角色的计时器，每100ms向服务器报一下自己的位置 
		 */		
		private var _timer:Timer;
		
		private var _gameData:GameData;
		
		private var upgradeItem:SwfRenderItem; //角色升级动画
		
		private var isJumpSpot:Boolean; //是否处于传送点
		private var _syncLoc:Boolean = true;//同步位置 
		
		/**
		 * 构造函数
		 * */
		public function MainRole()
		{
			super();
			
			_gameData = GameData.inst;
			
			initUpgradeRes();
		}
		
		
		
		/**
		 * 同步位置 
		 */
		public function get syncLoc():Boolean
		{
			return _syncLoc;
		}

		/**
		 * @private
		 */
		public function set syncLoc(value:Boolean):void
		{
			_syncLoc = value;
		}

		override protected function avatarLoaded(e:Event):void
		{
			super.avatarLoaded(e);
			setName(_gameData.playerInfo.name);
		}
		
		
		
		override public function set isMoving(isMove:Boolean):void
		{
			super.isMoving = isMove;
			_gameData.isMove = isMove;
			if(_syncLoc)
			{
				if(isMove)
				{
					if(_timer == null) _timer = new Timer(MapConfig.ROLE_MOVE_TIME);
					if(!_timer.hasEventListener(TimerEvent.TIMER))
					{
						_timer.addEventListener(TimerEvent.TIMER,onPatchLoc);
						_timer.start();
					}
				}
				else
				{
					if(_timer && _timer.hasEventListener(TimerEvent.TIMER))
					{
						_timer.removeEventListener(TimerEvent.TIMER,onPatchLoc);
						_timer.stop();
						dispatchEvent(new RoleEvent(RoleEvent.MOVE_EVENT));
					}
				}
			}
		
		}
		
		
		
		override public function enterFrame():void
		{
			super.enterFrame();
			if(	_gameData.roleInfo.map)
			{
				_gameData.roleInfo.map.x = this.x;
				_gameData.roleInfo.map.y = this.y;
			}
		}

		
		
		/**
		 * 向服务器发送角色位置 
		 * @param event
		 * 
		 */		
		protected function onPatchLoc(event:TimerEvent):void
		{
			dispatchEvent(new RoleEvent(RoleEvent.MOVE_EVENT));
		}
		
		
		
		/**
		 * 加载角色升级动画
		 */
		private function initUpgradeRes():void
		{
			var url:String = GameConfig.NPC_FIGURE_URL + MapConfig.UPGRADE_URL;		
			upgradeItem = new SwfRenderItem(url);
			upgradeItem.addEventListener(SwfRenderEvent.ISOVER,upgradeItemPlayCompleteHandle);	
		}
		
		
		
		/**
		 * 播放升级动画
		 */
		public function upgradeItemPlayHandle():void
		{
			upgradeItem.y = 10;
			upgradeItem.isOverEvent = true;
			this.addChildAt(upgradeItem,0);
		}
		
		
		
		/**
		 * 升级动画播放完成
		 */
		private function upgradeItemPlayCompleteHandle(e:Event):void
		{
			this.removeChild(upgradeItem);
		}
		
		
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			if(_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER,onPatchLoc);
				_timer.stop();
				_timer = null;
			}
			
			if(upgradeItem)
				upgradeItem.gc();
			
			super.gc();
		}
	}
}