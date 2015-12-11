package com.gamehero.sxd2.world.HurdleMap.components
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.manager.HurdleMonsterManager;
	import com.gamehero.sxd2.vo.HurdleMonsterVo;
	import com.gamehero.sxd2.world.HurdleMap.HurdleRoleLayer;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.RoleActionDict;
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	import com.gamehero.sxd2.world.views.item.MapRunRoleBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import alternativa.gui.mouse.CursorManager;
	
	import bowser.iso.pathfinding.navmesh.geom.Vector2f;

	/**
	 * 带有巡逻功能的关卡怪物
	 * @author weiyanyu
	 * 创建时间：2015-7-7 下午2:32:38
	 * 
	 */
	public class MapPatrolMonster extends MapRunRoleBase
	{
		/**
		 * 巡逻范围 
		 */		
		private var _patrolRect:Rectangle;
		/**
		 * 追击区域 
		 */		
		private var _pursuitRect:Point;
		/**
		 * 感叹号 
		 */		
		private var _spam:SwfRenderItem;
		/**
		 * 是否在警戒中 
		 */		
		private var _isAlert:Boolean;
		
		private var _gameData:GameData;
		/**
		 * 警戒半径 
		 */		
		public var _alertRadius:int;
		/**
		 * 配置总表中的数据 
		 */		
		private var monsterVO:HurdleMonsterVo;
		
		private var _battleId:int;
		
		/**
		 *  怪物巡逻间隔时间 id
		 */		
		private var PATROL_TIME_ID:int;
		/**
		 *  怪物发言间隔时间 id
		 */		
		private var BUBLE_TIME_ID:int;
		/**
		 * 巡逻时间上下浮动 比例
		 */		 
		private const PATROL_TIME_PERCENT:Number = .2;
		/**
		 *  冒泡时间上下浮动 
		 */		
		private const BUBLE_TIME_PERCENT:Number = .5;
		
		public function MapPatrolMonster()
		{
			super();
			speed = MapConfig.LEVEL_MONSTER_SPEED;
			_gameData = GameData.inst;
		}
		
		
		/**
		 * 设置战斗id 
		 * @param value
		 * 
		 */		
		public function set battleId(value:int):void
		{
			_battleId = value;
		}
		
		// 临时战斗id,之后删除
		override public function enterFrame():void
		{
			super.enterFrame();
			var roleX:int = _gameData.roleInfo.map.x;
			if(roleX > _pursuitRect.x && roleX < _pursuitRect.y)
			{
				if(Math.abs(this.x - roleX) < _alertRadius)
				{
					showAlert();
					setTarget(roleX,_gameData.roleInfo.map.y);
//					trace("enterFrame:", !GameData.inst.isBattle);
					if(activeRect.intersects((this.parent as HurdleRoleLayer).role.activeRect) && !GameData.inst.isBattle)
					{
						// 进入战斗
						SXD2Main.inst.createBattle(_battleId);
						// 清除剑型鼠标
						CursorManager.cursorType = CursorManager.ARROW;
						return;
					}
				}
			}
			else
			{
				hideAlert();
			}
		}
		
		override protected function avatarLoaded(e:Event):void
		{
			super.avatarLoaded(e);	
		}
		override public function set mapData(value:MapDecoVo):void
		{
			super.mapData = (value);
			monsterVO = HurdleMonsterManager.instance.getMonsterByID(value.id);
			setAvatar(monsterVO.url);//
			setPatrolRect();
			startTimer();
			setName(monsterVO.name);
		}
		/**
		 * 初始化怪物配置
		 */		
		public function setPatrolRect():void
		{

			avatar.face = RoleActionDict.LL;
			avatar.status = RoleActionDict.STAND;
			
			if(_patrolRect == null) _patrolRect = new Rectangle();
			_patrolRect.width = monsterVO.patralRect.x;
			_patrolRect.height = monsterVO.patralRect.y;
			_patrolRect.x = mapData.x - (_patrolRect.width >> 1);
			_patrolRect.y = mapData.y - (_patrolRect.height >> 1);
			
			if(_pursuitRect == null) _pursuitRect = new Point();
			_pursuitRect.x = mapData.x - monsterVO.followRadius;
			_pursuitRect.y = mapData.x +　monsterVO.followRadius;
			
			_alertRadius = monsterVO.alertRadius;
			
		}
		/**
		 * 开始走路，说话 
		 */		
		private function startTimer():void
		{
			
			var patrolTime:int = Math.random() * monsterVO.time * PATROL_TIME_PERCENT * 2 + monsterVO.time *(1 - PATROL_TIME_PERCENT);
			var bubleTime:int = Math.random() * monsterVO.time * BUBLE_TIME_PERCENT * 2 + monsterVO.time * (1 - BUBLE_TIME_PERCENT);
			
			clearTimer();
			BUBLE_TIME_ID = setInterval(onShowTips,bubleTime);
			PATROL_TIME_ID = setInterval(onPatrol,patrolTime);
			function onShowTips():void//显示说的话
			{
				if(gossip)
					gossip.showGossip(monsterVO.bubble,2000);
			}
			function onPatrol():void//巡逻
			{
				if(_isAlert) return;
				setTarget(Math.random() * _patrolRect.width + _patrolRect.x,Math.random() * _patrolRect.height + _patrolRect.y);
			}
			

		}
		
		private function clearTimer():void
		{
			if(BUBLE_TIME_ID > 0)
			{
				clearInterval(BUBLE_TIME_ID);
				BUBLE_TIME_ID = 0;
			}
			if(PATROL_TIME_ID > 0)
			{
				clearInterval(PATROL_TIME_ID);
				PATROL_TIME_ID = 0;
			}
		}
		
		//每固定时间给一个目标
		protected function onTimer(event:TimerEvent):void
		{

		}
		/**
		 * 设置怪物的追踪目标 
		 * 
		 */		
		public function setTarget(tx:int,ty:int):void
		{
			var tg:Vector2f = new Vector2f();
			tg.x = tx;
			tg.y = ty;
			path = new Vector.<Vector2f>();
			path.push(tg);
		}
		/**
		 * 显示警告 
		 * 
		 */		
		private function showAlert():void
		{
			if(_spam == null)
			{
				_spam = new SwfRenderItem(GameConfig.SWF_FIGURE_URL + "spam.swf");
				this.addChild(_spam);
				if(roleSkinVo)
				{
					_spam.x = this.roleSkinVo.standWidth >> 1;
					_spam.y = -this.roleSkinVo.standHeight;
				}
			}
			_spam.visible = true;
			_isAlert = true;
		}
		/**
		 * 隐藏警告 
		 * 
		 */		
		private function hideAlert():void
		{
				if(_spam) _spam.visible = false;
				_isAlert = false;
		}
		
		public function get isAlert():Boolean
		{
			return _isAlert;
		}
		
		override public function onMouseOverHandler(event:MouseEvent):void
		{
			CursorManager.cursorType = CursorManager.SWORD;
			
			this.filters = new <BitmapFilter>[new ColorMatrixFilter([1,1,1,0,40,0,1,0,0,40,0,0,1,0,40,0,0,0,1,0])];
		}
		
		override public function onMouseOutHandler(event:MouseEvent):void
		{
			this.filters = null;
			CursorManager.cursorType = CursorManager.ARROW;
		}
		
		
		override public function set filters(filters:Vector.<BitmapFilter>):void
		{
			super.filters = filters;
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			clearTimer();
			if(_spam) 
			{
				_spam.gc(true);
				this.removeChild(_spam);
				_spam = null;
			}
			if(_patrolRect != null)
			{
				_patrolRect.setEmpty();
				_patrolRect = null;
			}
			super.gc(true);
		}
	}
}