package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
	import bowser.logging.Logger;
	import bowser.utils.MovieClipPlayer;
	
	
	
	
	/**
	 * 布阵引导 
	 * @author wulongbin
	 */	
	public class Guide_40002 extends Guide
	{
		private var rightBtn:DisplayObject;
		private var leftBtn:DisplayObject;
		private var window:FormationWindow;
		
		// 拖拽动画
		private var mp:MovieClipPlayer;
		private var fx6:MovieClip;
		private var maskSprite:Sprite;
		
		// 拖拽动画timer
		private var timer:Timer;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_40002()
		{
			super();
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			var funcInfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.FORMATION_WINDOW);
			popupClickGuide(funcInfo.button , true , Lang.instance.trans("AS_1420"), Guide.Direct_Down, next1);
		}
		
		
		
		
		/**
		 * 点击队伍菜单按钮后打开队伍面板
		 * */
		private function next1():void
		{
			// 队伍面板
			window = WindowManager.inst.getWindowInstance(FormationWindow, WindowPostion.CENTER) as FormationWindow;
			window.addEventListener(FormationEvent.ON_FORMATION_INFO , next2);
		}
		
		
		
		
		
		private function next2(e:FormationEvent):void
		{
			e.currentTarget.removeEventListener(FormationEvent.ON_FORMATION_INFO , next2);
			
			if(window)
			{	
				timer = new Timer(1000 , 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE , drag);
				timer.start();
			}
		}
		
		
		
		
		
		/**
		 * 开始播放拖拽动画
		 * */
		private function drag(e:TimerEvent):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE , drag);
			timer = null;
			
			// 播放拖拽动画
			var global:Global = Global.instance;
			fx6 = global.getRes(FormationWindow.DOMAIN , "FX6") as MovieClip;
			fx6.x = -2;
			fx6.y = -2;
			window.addChild(fx6);
			
			// 播放
			mp = new MovieClipPlayer();
			mp.play(fx6 , 2 , 0 , fx6.totalFrames);
			mp.addEventListener(Event.COMPLETE , next3);
			
			// 添加遮罩,在拖拽动画播放时不允许玩家拖拽伙伴
			maskSprite = new Sprite();
			maskSprite.graphics.beginFill(0,0);
			maskSprite.graphics.drawRect(0,0,window.width,window.height);
			maskSprite.graphics.endFill();
			window.addChild(maskSprite);
		}
		
		
		
		
		
		/**
		 * 拖拽动画播放完毕后调用
		 * */
		private function next3(e:Event):void
		{
			mp.removeEventListener(Event.COMPLETE , next3);
			if(fx6 && window.contains(fx6) == true)
			{
				window.removeChild(fx6);
			}
			if(maskSprite && window.contains(maskSprite) == true)
			{
				window.removeChild(maskSprite);
			}
			
			fx6 = null;
			maskSprite = null;
			mp = null;
			
			rightBtn = window.rightBtns[0];
			leftBtn = window.leftBtns[1];
			
			if(rightBtn && leftBtn)
			{
				this.popupDragGuide(rightBtn, leftBtn, true ,  Lang.instance.trans("AS_475") , Guide.Direct_Down);
				
				mask.resetTargetMask(58,58, 10,10);
				mask.resetToDisplayMask(100,110,20,10);
				rightBtn.addEventListener(MouseEvent.MOUSE_DOWN , onDown);
			}
			else
			{
				// 结束引导
				this.guideCompleteHandler();
				
				Logger.debug(Guide_40002 , "无法引导布阵,找不到伙伴组件!");
			}
		}
		
		
		
		
		
		protected function onDown(event:Event):void
		{
			leftBtn.filters = [new GlowFilter(0xcc2233, 1, 6, 6, 4)];
			leftBtn.addEventListener(MouseEvent.MOUSE_UP, onLeftBtnUp);
			
			// 监听拖动
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageUp);
		}
		
		
		
		protected function onStageUp(event:MouseEvent = null):void
		{
			leftBtn.filters = null;
			leftBtn.removeEventListener(MouseEvent.MOUSE_UP, onLeftBtnUp);
			
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageUp);
		}		
		
		
		
		
		protected function onLeftBtnUp(event:Event):void
		{
			rightBtn.removeEventListener(MouseEvent.MOUSE_DOWN , onDown);
			onStageUp();
			
			// 结束引导
			this.finish();
		}
		
		
		
		
		
		private function finish():void
		{
			if(window)
			{
				window.close();
			}
			
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				if(fx6 && window.contains(fx6) == true)
				{
					window.removeChild(fx6);
				}
				if(maskSprite && window.contains(maskSprite) == true)
				{
					window.removeChild(maskSprite);
				}
				
				window.removeEventListener(FormationEvent.ON_FORMATION_INFO , next2);
				window = null;
			}
			if(rightBtn)
			{
				rightBtn.removeEventListener(MouseEvent.MOUSE_DOWN , onDown);
				rightBtn = null;
			}
			if(leftBtn)
			{
				leftBtn.removeEventListener(MouseEvent.MOUSE_UP, onLeftBtnUp);
				leftBtn = null;
			}
			if(mp)
			{
				mp.removeEventListener(Event.COMPLETE , next3);
				mp.stop();
			}
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE , drag);
				timer = null;
			}
			
			mp = null;
			fx6 = null;
			maskSprite = null;
			
			// 开启自动 任务
			//TaskManager.instance.autoTaskSwitch = true;
			
			super.guideCompleteHandler();
		}
		
	}
}