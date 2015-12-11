package com.gamehero.sxd2.world.HurdleMap
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.world.HurdleMap.components.MapPatrolMonster;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.GameWorldItemType;
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.item.InterActiveItem;
	import com.gamehero.sxd2.world.views.item.MapTrickBase;
	
	import flash.events.MouseEvent;
	
	
	
	/**
	 * 关卡角色层
	 * @author weiyanyu
	 * 创建时间：2015-7-7 下午8:39:38
	 * 
	 */
	public class HurdleRoleLayer extends RoleLayer
	{
		/**
		 * 关卡怪物 
		 */		
		private var _monsterArr:Vector.<Vector.<MapPatrolMonster>>;
		/**
		 * 当前波的怪物 
		 */		
		private var _curWaveMonster:Vector.<MapPatrolMonster> = new Vector.<MapPatrolMonster>();
		
		private var _battleIdList:Array;
		/**
		 * 当前波数 
		 */		
		public var curWaveNum:int = -1;
		// 当前关卡数据
		public var hurdleVo:HurdleVo;
		
		/**
		 * 机关 列表
		 */		
		private var _trickVec:Vector.<MapTrickBase> = new Vector.<MapTrickBase>();
		
		
		public function HurdleRoleLayer()
		{
			
		}
		
		public function init():void
		{
			this.addEventListener(MapEvent.MAP_ACTIVE_COLLIDE,mapActiveCollideHandle);
			_monsterArr = new Vector.<Vector.<MapPatrolMonster>>();
			
			hurdleVo = HurdlesManager.getInstance().getHurdleById(GameData.inst.curHurdleId);
			_battleIdList = hurdleVo.wave_num.concat();
			for(var i:int = _battleIdList.length; i > 0; i--)
			{
				_monsterArr.push(new Vector.<MapPatrolMonster>());
			}
		}
		
		private function mapActiveCollideHandle(e:MapEvent):void
		{
			var targe:InterActiveItem = e.data.targe;
			var role:InterActiveItem = e.data.role;
			if(targe.type == GameWorldItemType.SWITCH_MAP)//传送阵
			{
				NoticeUI.inst.setPathingItem(false);
			}
			else if(targe.type == GameWorldItemType.MONSTER)//类型是怪物的话开启战斗
			{
				parent.dispatchEvent(new MainEvent(MainEvent.SHOW_BATTLE));
			}
		}
		
		override public function onStageClicked(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			NoticeUI.inst.setPathingItem(false);
			super.onStageClicked(event);
		}
		
		
		override public function onRenderFrame():void
		{
			super.onRenderFrame();
			var hasAlert:Boolean;//是否有怪物处于警戒状态
			for each(var monster:MapPatrolMonster in _curWaveMonster)
			{
				monster.enterFrame();
				if(monster.isAlert)
				{
					hasAlert = true;
				}
			}
			(this.renderStage as HurdleGameWorld).dispatchEvent(new MapEvent(MapEvent.SET_ARROW_VISIBLE,!hasAlert));
			for each(var trick:MapTrickBase in _trickVec)
			{
				trick.enterframe();
			}
			
		}
		
		/**
		 * 添加下一波 
		 * 
		 */		
		public function nextWave():void
		{
			if(_curWaveMonster.length > 0)
			{
				for each(var monster:MapPatrolMonster in _curWaveMonster)
				{
					removeChild(monster);
				}
				_curWaveMonster.length = 0;
			}
			setWave(++curWaveNum);
		}
		/**
		 * 设置当前波数 
		 * 
		 */		
		private function setWave(num:int):void
		{
			if(_monsterArr.length > num)
			{
				_curWaveMonster = _monsterArr[num];
				for each(var monster:MapPatrolMonster in _curWaveMonster)
				{
					addChild(monster);
					monster.visible = true;
					monster.x = monster.mapData.x;
					monster.y = monster.mapData.y;
				}
				curWaveNum = num;
			}
		}
		
		override protected function initDeco():void
		{
			super.initDeco();
			nextWave();
		}
		
		
		/**
		 * 添加巡逻怪物 
		 * @param item
		 * @return 
		 * 
		 */		
		override protected function addHurdleMonster(deco:MapDecoVo):MapPatrolMonster
		{
			try
			{
				var _monster:MapPatrolMonster = new MapPatrolMonster();
				_monsterArr[deco.ent].push(_monster);
				_monster.visible = false;
				_monster.battleId = _battleIdList[deco.ent];//怪物的额外参数代表此怪物是第几波怪物
				return _monster;
			}
			catch(e:Error)
			{
				throw Error("副本配置的波数与当前怪物的波数不一致！")
				return null;
			}
		}
		
		override protected function addWuya(deco:MapDecoVo):InterActiveItem
		{
			var item:MapTrickBase = new MapTrickBase(GameConfig.SWF_FIGURE_URL + deco.url);
			_trickVec.push(item);
			return item;
		}
		
		public function get CurrentMonster():MapPatrolMonster
		{
			if(_curWaveMonster.length)
				return _curWaveMonster[0];
			else
				return null;
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			super.gc(true);
			_curWaveMonster = null;
			for each(var arr:Vector.<MapPatrolMonster> in _monsterArr)//移除所有怪物
			{
				for each(var monster:MapPatrolMonster in arr)
				{
					monster.gc(true);
					if(monster.parent)
						this.removeChild(monster);
					monster = null;
				}
				arr = null;
			}
			
			_monsterArr = null;
			curWaveNum = -1;
			hurdleVo = null;
			
			this.removeEventListener(MapEvent.MAP_ACTIVE_COLLIDE,mapActiveCollideHandle);
		}
	}
}