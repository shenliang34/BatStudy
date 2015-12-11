package com.gamehero.sxd2.world.globolMap
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	import com.gamehero.sxd2.world.views.GameWorld;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class GlobalGameWorld extends GameWorld
	{
		public var isMove:Boolean;//是否移动标记
		private var mouseEvent:Event;//鼠标事件
		private var mouseDownTimer:Timer;//鼠标移动定时器
		private var mouseUpTimer:Timer;//鼠标抬起定时器
		
		/**
		 *构造 
		 * @param canvas
		 * @param width
		 * @param height
		 * @param transparent
		 * @param renderTime
		 * 
		 */		
		public function GlobalGameWorld(canvas:Sprite, width:Number, height:Number, transparent:Boolean=true, renderTime:int=33)
		{
			super(canvas, width, height, transparent, renderTime);
			
			mouseDownTimer = new Timer(100);
			mouseDownTimer.addEventListener(TimerEvent.TIMER,moveTimerCompleteHandle);
			
			mouseUpTimer = new Timer(100);
			mouseUpTimer.addEventListener(TimerEvent.TIMER,outTimerTimerCompleteHandle);
			
		}
		
		/**
		 *移动事件 
		 * 
		 */		
		override public function moveWolrd():void
		{
			super.moveWolrd();
			
			if(_roleLayer)
			{
				_roleLayer.initLoc(-_camera.x,-_camera.y);
			}
			
		}
		
		/**
		 *复写鼠标按下 
		 * @param event
		 * 
		 */		
		override protected function onGameWorldMouseDown(event:MouseEvent):void
		{
			mouseEvent = event
			mouseDownTimer.start();
		}
		
		/**
		 *鼠标移动定时器 
		 * @param e
		 * 
		 */		
		private function moveTimerCompleteHandle(e:Event):void
		{
			mouseDownTimer.stop();
			if(!isMove)
			{
				// TODO Auto Generated method stub
				super.onGameWorldMouseDown(mouseEvent);	
			}
		}
		
		/**
		 *复写鼠标抬起事件 
		 * @param e
		 * 
		 */
		override protected function onGameWorldMouseUp(event:MouseEvent):void
		{
			mouseEvent = event;
			mouseUpTimer.start();
		}
		
		/**
		 *鼠标抬起定时器 
		 * @param e
		 * 
		 */				
		private function outTimerTimerCompleteHandle(e:Event):void
		{
			super.onGameWorldMouseUp(mouseEvent);
		}
		
		/**
		 *初始化 
		 * 
		 */		
		override public function initRoleLayer():void
		{
			
			_roleLayer = new GlobalRoleLayer();
			_roleLayer.navTri = _model.sceneVo.tri;
			
			if(!isMask)
			{	
				_roleLayer.addChild(maskRenderItem);
			}
			
			this.addChildAt(_roleLayer,_roleLayerVo.index);
			
			_roleLayer.initMap(_roleLayerVo);
			
			var map:MapDecoVo = _roleLayerVo.getMapVo(GameData.inst.mapInfo.id);
			_roleLayer.setRoleLoc(map.x + 40,map.y - 20);	
			
			resize(width,height);
			canInteractive = true;
			MapModel.inst.isLoaded = true;
//			(canvas as GlobalSceneView).initPlayers();
			
		}
		
		/**
		 *清理 
		 * @param isCleanAll
		 * 
		 */		
		override public function gc(isCleanAll:Boolean=false):void
		{
			super.gc(isCleanAll);
			
			mouseDownTimer.stop();
			mouseDownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,moveTimerCompleteHandle);
			mouseDownTimer = null;
			
			mouseUpTimer.stop();
			mouseUpTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,outTimerTimerCompleteHandle);
			mouseUpTimer = null;
		}
		
	}
}