package com.gamehero.sxd2.battle
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.gui.BattleChange;
	import com.gamehero.sxd2.battle.gui.BattleUI;
	import com.gamehero.sxd2.battle.layer.BattleEfCanvas;
	import com.gamehero.sxd2.battle.layer.BattleEfLayer;
	import com.gamehero.sxd2.event.BattleTipsEvent;
	import com.gamehero.sxd2.event.BattleUIEvent;
	import com.gamehero.sxd2.event.BattleWorldEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.GameTools;
	
	import br.com.stimuli.loading.BulkLoader;
	
	/**
	 * 战斗视图
	 * @author xuwenyi
	 * @create 2013-06-25
	 **/
	public class BattleView extends Sprite
	{
		// 战斗场景尺寸
		public static const MIN_WIDTH:int = 1200;
		public static const MIN_HEIGHT:int = 600;
		public static const MAX_WIDTH:int = 1920;
		public static const MAX_HEIGHT:int = 1080;
		
		/** 战斗通用部分代码 */
		include "logic/BattleUILogic.as";
		include "logic/BattleGameLogic.as";
		include "logic/BattleEffectLogic.as";
		include "logic/BattleNumberLogic.as";
		include "logic/BattleCommonLogic.as";
		//include "logic/BattleGuideLogic.as";
		
		// 保存当前战斗视图的宽高
		private var viewWidth:int;
		private var viewHeight:int;
		
		// UI层
		private var ui:BattleUI;
		// 效果层
		private var efCanvas:BattleEfCanvas;
		// 战斗渲染舞台
		private var world:BattleWorld;
		// 数据中心
		private var dataCenter:BattleDataCenter;
		// 效果层
		private var efLayer:BattleEfLayer;
		
		

		
		/**
		 * 构造函数
		 * */
		public function BattleView()
		{
			// 战斗舞台
			world = new BattleWorld(this , MIN_WIDTH , MIN_HEIGHT , false);
			world.stopRender();
			// 战斗特效层
			efCanvas = BattleEfCanvas.instance;
			this.addChild(efCanvas);
			// 战斗UI层
			ui = new BattleUI(this);
			ui.addEventListener(BattleUIEvent.LOADED , onBattleUI);
			ui.addEventListener(BattleUIEvent.OPENING_END , begin);
			this.addChild(ui);
			
			// 数据中心
			dataCenter = BattleDataCenter.instance;
			// 效果层
			efLayer = BattleEfLayer.instance;
			
			// 初始化各计时器
			this.initTimers();
			
			// 初始化新手引导参数
			//this.initGuide();
			
			// 加入移除场景时的事件
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		/**
		 * 加入场景
		 * */
		private function onAdd(e:Event):void
		{
			// 自适应
			stage.addEventListener(Event.RESIZE , resize);
		}
		
		
		
		
		
		/**
		 * 移除场景
		 * */
		private function onRemove(e:Event):void
		{
			// 自适应
			stage.removeEventListener(Event.RESIZE , resize);
			// 移除全屏点击事件
			//stage.removeEventListener(MouseEvent.CLICK , clickQuit);
		}
		
		
		
		
		
		
		/**
		 * 开始新战役
		 * */
		public function newGame():void
		{
			// 保存战斗视图
			dataCenter.battleView = this;
			
			// 启用鼠标事件
			this.mouseEnabled = true;
			this.mouseChildren = true;
			
			// 我方角色url
			var playersUrl:Array = dataCenter.getPlayersUrl(1);
			// 开始加载UI
			ui.load(playersUrl);
		}
		
		
		
		
		
		
		/**
		 * UI加载完成
		 * */
		private function onBattleUI(e:Event):void
		{
			// 事件
			world.addEventListener(BattleWorldEvent.PLAYER_MOVE_ARRIVE , onPlayerMoveArrive);
			world.addEventListener(BattleWorldEvent.PLAYER_MOVE_BACK , onPlayerMoveBack);
			world.addEventListener(BattleWorldEvent.PLAYER_MOVE_COMPLETE , onPlayerMoveComplete);
			
			// tips事件
			world.addEventListener(BattleTipsEvent.OPEN , onTipsOpen);
			world.addEventListener(BattleTipsEvent.UPDATE , onTipsUpdate);
			world.addEventListener(BattleTipsEvent.CLOSE , onTipsClose);
			
			// 开始渲染
			world.startRender();
			// 加载地图,玩家avatar
			world.loadBattleWorld();
			world.loadBattlePlayer();
			// 隐藏双方伙伴
			world.showHeros(1 , false);
			world.showHeros(2 , false);
			// 隐藏双方主角
			world.showLeader(1 , false);
			world.showLeader(2 , false);
			
			// 更新波数UI
			this.updateBoshuUI();
			// 显示boss信息
			this.showBossUI();
			// 更新UI
			this.updateUI();
			this.enabled = false;
			
			// 自适应
			this.resize();
			
			// 是否存在引导
			//this.check10002();
			//this.check10011();
			
			// 加载音乐
			this.playMusic();
			
			// 开始战斗
			BattleChange.inst.play(this , 21 , 40 , begin);
		}
		
		
		
		
		
		/**
		 * 正式开始战斗
		 * */
		private function begin():void
		{
			// 主角开场动画
			world.openingMove();
			
			// 若为pvp,则显示开场动画
			this.showPvpOpening();
			
			// 第一回合计时器
			this.startFirstRoundTimer();
		}
		
		
		
		
		
		
		/**
		 * 改变波数
		 * */
		private function changeBoshu():void
		{
			// 清除场上的怪物
			world.removePlayers(2);
			world.clearBlack();
			dataCenter.grid2.clear();
			
			// 清除资源缓存
			dataCenter.clearCampResource(2);
			
			
		}
		
		
		
		
		
		/**
		 * 自适应
		 * */
		private function resize(e:Event = null):void
		{
			if(stage)
			{
				// 计算战斗场景尺寸
				var w:int = Math.max(stage.stageWidth , MIN_WIDTH);
				w = Math.min(w , MAX_WIDTH);
				var h:int = Math.max(stage.stageHeight , MIN_HEIGHT);
				h = Math.min(h , MAX_HEIGHT);
				
				// 坐标
				this.x = (stage.stageWidth - w)>>1;
				this.y = (stage.stageHeight - h)>>1;
				
				// 特效层坐标
				var xx:int = (w - MAX_WIDTH) >> 1;
				var yy:int = (h - MAX_HEIGHT) >> 1;
				efCanvas.x = xx;
				efCanvas.y = yy;
				
				world.resize(w , h);
				ui.resize(w , h);
				
				viewWidth = w;
				viewHeight = h;
			}
		}
		
		
		
		
		/**
		 * 清空战斗数据等
		 */
		private function clear():void 
		{	
			// 清除当前正在加载的项
			var loader:BulkLoaderSingleton = dataCenter.loader;
			loader.pauseAndRemoveAllPaused();
			// 继续其他Loader的加载	
			BulkLoader.resumeAllLoaders();
			
			// 停止音乐播放
			//SoundManager.inst.stopAllSounds();
			
			// 清UI
			ui.clear();
			
			// 清传统特效层
			efCanvas.clear();
			
			// 清空战斗数据中心
			dataCenter.clear();
			
			// 清理计时器
			this.clearTimers();
			
			// 停止渲染
			world.stopRender();
			// 事件
			world.removeEventListener(BattleWorldEvent.PLAYER_MOVE_ARRIVE , onPlayerMoveArrive);
			world.removeEventListener(BattleWorldEvent.PLAYER_MOVE_BACK , onPlayerMoveBack);
			world.removeEventListener(BattleWorldEvent.PLAYER_MOVE_COMPLETE , onPlayerMoveComplete);
			// tips事件
			world.removeEventListener(BattleTipsEvent.OPEN , onTipsOpen);
			world.removeEventListener(BattleTipsEvent.UPDATE , onTipsUpdate);
			world.removeEventListener(BattleTipsEvent.CLOSE , onTipsClose);
			world.clear();
			
			// 移除全屏点击退出的事件
			/*if(stage)
			{
				stage.removeEventListener(MouseEvent.CLICK , clickQuit);
			}*/
			
			// 移除技能事件
			this.enabled = false;
			
			// 基础数据
			willSkill = null;
			skillUsed = false;
			turnList.clear();
			uaList.clear();
			rounds = [];
			lastRound = 0;
			curRound = 0;
			playSpeed = 0;
			isBattleEnd = false;
			
			// 新手引导
			//isPause = false;
			//resumeHandler = null;
			
			// 强制垃圾回收
			GameTools.forceGC();
		}
		
	}
}