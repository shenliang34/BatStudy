package com.gamehero.sxd2.world.HurdleMap
{
	import com.gamehero.sxd2.common.GameMovie;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_AWARD_ACK;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.mouse.CursorManager;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * 关卡场景
	 * @author weiyanyu
	 * 创建时间：2015-7-7 下午1:44:12
	 * 
	 */
	public class HurdleSceneView extends SceneViewBase
	{
		//箭头指引
		public var isShowArrow:Boolean = true;
		private var _arrowMc:MovieClip;
		//通关奖励 
		private var _award:MSG_INSTANCE_AWARD_ACK;
		
		
		
		/**
		 * 构造函数
		 * */
		public function HurdleSceneView()
		{
			super();
		}
		
		

		/**
		 * 通关奖励 
		 */
		public function set award(value:MSG_INSTANCE_AWARD_ACK):void
		{
			_award = value;
			FloatTips.inst.stop();
		}

		override protected function init():void
		{
			var sp:Sprite = new Sprite();
			addChild(sp);
			_gameWorld = new HurdleGameWorld(sp,stage.stageWidth,stage.stageHeight,false,17);
			_gameWorld.addEventListener(MainEvent.SHOW_BATTLE,onPk);
			_gameWorld.addEventListener(MapEvent.SET_ARROW_VISIBLE,setArrowVisble);
			resize(null);
			super.init();
			_loader.addWithListener(GameConfig.SWF + "arrow.swf", null, onArrowLoaded);
			_loader.start();
		}
		
		private function onArrowLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onArrowLoaded);
			_arrowMc = imageItem.content;
			addChild(_arrowMc);
			_arrowMc.addEventListener(MouseEvent.CLICK,arrowMcClickHandle);
			resize(null);
		}		
		
		protected function onPk(event:Event):void
		{
			dispatchEvent(new MainEvent(MainEvent.SHOW_BATTLE));
		}
		
		
		
		override public function setVisible(v:Boolean):void
		{
			super.setVisible(v);
		}
		
		/**
		 * 播放命魂
		 * @param value
		 * 
		 */		
		public function playSoul(callback:Function = null):void
		{
			var effectItem:GameMovie = new GameMovie();
			effectItem.load(GameConfig.SWF + "lifeSoul.swf" , "EFFECT" , BulkLoaderSingleton.instance);
			effectItem.addEventListener(Event.COMPLETE , playerOvered);
			
			effectItem.x = rolePoint.x;
			effectItem.y = rolePoint.y;
			effectItem.play();
			this.addChild(effectItem);
			
			function playerOvered(event:Event):void
			{
				effectItem.clear();
				removeChild(effectItem);
				
				if(callback != null)
				{
					callback();
				}
			}
		}
		
		
		
		public function setNextWave(isPlaySoul:Boolean = false):void
		{
			var world:HurdleGameWorld = (_gameWorld as HurdleGameWorld);
			world.nextWave();
			
			// 判断是否触发剧情
			var dramaID:int;
			var hurdleVO:HurdleVo = HurdleRoleLayer(world.roleLayer).hurdleVo;
			if(hurdleVO.drama)
			{
				var dramas:Array = hurdleVO.drama;
				dramaID = dramas[HurdleRoleLayer(world.roleLayer).curWaveNum - 1];
			}
			
			// 有剧情优先播放剧情
			if(dramaID > 0)
			{
				// 有奖励说明是最后一波
				if(_award)
				{
					DramaManager.inst.playDrama(dramaID , null , end);
					
					function end():void
					{
						openHurdleAwardWindow();
						FloatTips.inst.start();
					}
				}
				else
				{
					DramaManager.inst.playDrama(dramaID);
					FloatTips.inst.start();
				}
			}
			// 么有剧情 但关卡结束了
			else if(_award)
			{
				this.openHurdleAwardWindow();
				FloatTips.inst.start();
			}
			else
			{
				if(isPlaySoul == true)
				{
					playSoul();
				}
				FloatTips.inst.start();
			}
			
			
		}
		
		
		
		
		
		/**
		 * 打开剧情副本结算面板
		 * */
		private function openHurdleAwardWindow():void
		{
			if(_award)
			{
				MainUI.inst.openWindow(WindowEvent.HURDLE_AWARD_WINDOW,_award);
				SoundManager.inst.play("20009");
				_award = null;
				clearArrowMc();
			}
		}
		
		
		
		
		/**
		 * 设置go图标可见与否 
		 * @param value
		 * 
		 */		
		public function setArrowVisble(e:MapEvent):void
		{
			if(_arrowMc)
			{
				var bool:Boolean = Boolean(e.data);
				
				// 允许显示箭头才能显示(剧情需要隐藏箭头)
				if(bool == true && isShowArrow == true)
				{
					_arrowMc.visible = true;
				}
				else
				{
					_arrowMc.visible = false;
				}
			}
		}
		
		private function clearArrowMc():void
		{
			if(_arrowMc)
			{
				_arrowMc.gotoAndStop(0);
				removeChild(_arrowMc);
				_arrowMc = null;
			}
		}
		override protected function resize(event:Event):void
		{
			if(_gameWorld)
				_gameWorld.resize(stage.stageWidth,stage.stageHeight);
			
			var newWidth:int = stage.stageWidth;
			var newHeight:int = stage.stageHeight;
			if(newWidth > MapConfig.STAGE_MAX_WIDTH) newWidth = MapConfig.STAGE_MAX_WIDTH;
			if(newHeight > MapConfig.STAGE_MAX_HEIGHT) newHeight = MapConfig.STAGE_MAX_HEIGHT;
			this.x = (stage.stageWidth - newWidth) >> 1;
			this.y = (stage.stageHeight - newHeight) >> 1;
			
			if(_arrowMc)
			{
				_arrowMc.x = newWidth - MapConfig.HURDLE_GUIDE_ARROW_DISTANCE;
				_arrowMc.y = newHeight - _arrowMc.height >> 1;
			}
		}
		
		private function arrowMcClickHandle(e:MouseEvent):void
		{
			dispatchEvent(new MapEvent(MapEvent.HURDL_EMOVE));
//			hurdleMoveHandle();
		}
		
		/**
		 *副本内自动寻路 
		 * 
		 */		
		public function hurdleMoveHandle():void
		{
			var layer:HurdleRoleLayer = _gameWorld.roleLayer as HurdleRoleLayer;
			//优先查找地图的传送
			if(layer.getTeleportInfo())
			{
				layer.goTarget(layer.role , layer.getTeleportInfo().x, layer.getTeleportInfo().y , false);
			}
			//移动到当前波怪物
			else
			{
				if(layer.CurrentMonster)
					layer.goTarget(layer.role ,layer.CurrentMonster.x,layer.CurrentMonster.y , false);
			}
			NoticeUI.inst.setPathingItem(true);
		}
		
		override public function gc():void
		{
			super.gc();
			
			// 向右箭头go图标
			clearArrowMc();
			
			// 清除剑型鼠标
			CursorManager.cursorType = CursorManager.ARROW;
			_gameWorld.removeEventListener(MainEvent.SHOW_BATTLE,onPk);
			_gameWorld.removeEventListener(MapEvent.SET_ARROW_VISIBLE,setArrowVisble);
		}
		
	}
}