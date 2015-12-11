package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.formation.FormationButton2;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideArrow;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	import com.gamehero.sxd2.manager.GuideManager;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	
	/**
	 * 巫师战棋战败引导布阵
	 * @author xuwenyi
	 * @create 2014-09-03
	 **/
	public class Guide_40004 extends Guide
	{
		// 箭头
		private var arrow:GuideArrow;
		
		private var leftBtn0:FormationButton2;
		private var leftBtn1:FormationButton2;
		private var leftBtn2:FormationButton2;
		private var leftBtn3:FormationButton2;
		private var leftBtn4:FormationButton2;
		private var leftBtn5:FormationButton2;
		private var leftBtn6:FormationButton2;
		private var window:FormationWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_40004()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			var funcInfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.FORMATION_WINDOW);
			popupClickGuide(funcInfo.button , false , Lang.instance.trans("AS_1420"), Guide.Direct_Down, next1);
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
				// 伙伴数量是否超过2个
				var heroList:Array = GameData.inst.heroList;
				if(heroList && heroList.length >= 2)
				{
					// 发绿光
					leftBtn0 = window.leftBtns[0];
					leftBtn2 = window.leftBtns[2];
					leftBtn3 = window.leftBtns[3];
					
					FiltersUtil.playGlowFilterMovie(leftBtn0, GameDictionary.GREEN);
					FiltersUtil.playGlowFilterMovie(leftBtn2, GameDictionary.GREEN);
					FiltersUtil.playGlowFilterMovie(leftBtn3, GameDictionary.GREEN);
					
					// 发红光
					leftBtn1 = window.leftBtns[1];
					
					FiltersUtil.playGlowFilterMovie(leftBtn1, GameDictionary.RED);
					
					arrow = new GuideArrow();
					arrow.x = 470;
					arrow.y = 260;
					arrow.setLabel("调整布阵“前排一名，中排两名”\n以抵御史塔克的溅射伤害", Guide.Direct_Left);
					window.addChild(arrow);
					
					mask.resetTargetMask(58,58, 10,10);
					mask.resetToDisplayMask(100,110,20,10);
					
					window.addEventListener(FormationEvent.ON_FORMATION_UPDATE , next3);
				}
				else
				{
					// 关闭面板
					this.next4();
				}
			}
		}
		
		
		
		
		
		private function next3(e:FormationEvent):void
		{
			var successNum:int = 0;
			
			// 判断4个格子里是否都有人
			if(window.checkHasPlayer(0) == true)
			{
				leftBtn0.playDragSuccess();
				successNum++;
			}
			if(window.checkHasPlayer(2) == true)
			{
				leftBtn2.playDragSuccess();
				successNum++;
			}
			if(window.checkHasPlayer(3) == true)
			{
				leftBtn3.playDragSuccess();
				successNum++;
			}
			
			// 3个格子都有人,引导成功
			if(successNum >= 3)
			{
				// 关闭面板
				this.next4();
			}
		}
		
		
		
		
		
		/**
		 * 关闭面板
		 * */
		private function next4():void
		{
			if(window && window.closeButton)
			{
				if(arrow && window.contains(arrow) == true)
				{
					window.removeChild(arrow);
				}
				arrow = null;
				
				popupClickGuide(window.closeButton , true , Lang.instance.trans("AS_1412"), Guide.Direct_Right);
			}
			else
			{
				this.guideCompleteHandler();
			}
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			this.clear();
			
			super.guideCompleteHandler();
			
			// 播放巫师战旗引导
			var mgr:GuideManager = GuideManager.instance;
			if(mgr.hasPlayedByClass(Guide_30005) == false)
			{
				mgr.playGuideByCla(Guide_30005);
			}
		}
		
		
		
		
		
		private function clear():void
		{
			if(arrow && window)
			{
				if(window.contains(arrow) == true)
				{
					window.removeChild(arrow);
				}
			}
			arrow = null;
			if(window)
			{
				window.removeEventListener(FormationEvent.ON_FORMATION_INFO , next2);
				window.removeEventListener(FormationEvent.ON_FORMATION_UPDATE , next3);
				window = null;
			}
			if(leftBtn0)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn0);
				leftBtn0 = null;
			}
			if(leftBtn1)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn1);
				leftBtn1 = null;
			}
			if(leftBtn2)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn2);
				leftBtn2 = null;
			}
			if(leftBtn3)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn3);
				leftBtn3 = null;
			}
			if(leftBtn4)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn4);
				leftBtn4 = null;
			}
			if(leftBtn5)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn5);
				leftBtn5 = null;
			}
			if(leftBtn6)
			{
				FiltersUtil.stopGlowFilterMovie(leftBtn6);
				leftBtn6 = null;
			}
		}
	}
}