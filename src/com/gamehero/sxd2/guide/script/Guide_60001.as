package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.event.HeroEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.hero.HeroWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.events.Event;
	
	/**
	 * 圣器引导 
	 * @author xuwenyi
	 * @create 2014-05-16
	 */	
	public class Guide_60001 extends Guide
	{
		private var window:HeroWindow;
		
		// 需要点击的次数
		public var requiredClickNum:int;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_60001()
		{
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 需要达到的圣器等级
			requiredClickNum = int(info.param2) - 1;
			
			// 引导打开伙伴面板
			var funcInfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.HERO_WINDOW);
			this.popupClickGuide(funcInfo.button, true , Lang.instance.trans("AS_1423") , Guide.Direct_Down, next);
		}
		
		
		
		
		private function next():void
		{
			window = WindowManager.inst.getWindowInstance(HeroWindow, WindowPostion.CENTER) as HeroWindow;
			if(window.loaded)
			{
				this.next1();
			}
			else
			{
				window.addEventListener(Event.COMPLETE , next1);
			}
		}
		
		
		
		
		
		private function next1(e:Event = null):void
		{
			window.removeEventListener(Event.COMPLETE , next1);
			
			this.popupClickGuide(window.tab2, true, Lang.instance.trans("AS_1424"), Guide.Direct_Up, next2);
		}
		
		
		
		
		
		private function next2():void
		{
			window.addEventListener(HeroEvent.ON_HERO_UPDATE , next3);
//			this.popupClickGuide(window.normalTrainBtn, true, "点击培养圣器", Guide.Direct_Up);
			this.popupClickGuide(window.diamondTrainBtn, false, Lang.instance.trans("AS_1425"), Guide.Direct_Up);
		}
		
		
		
		
		private function next3(e:HeroEvent = null):void
		{
			window.removeEventListener(HeroEvent.ON_HERO_UPDATE , next3);
			
			// 判断伙伴圣器有没有到达5级的
			/*var heroList:Array = GameData.instance.heroList;
			for(var i:int=0;i<heroList.length;i++)
			{
				var vo:HeroVO = heroList[i];
				var info:GS_HeroInfo_Pro = vo.info;
				var relics:GS_HeroRelics_Pro = info.relicsInfo;
				if(relics.relicsLevel >= requiredRelicsLevel)
				{
					// 下一步
					this.next4();
					return;
				}
			}*/
			
			// 有没有点击5次
			if(requiredClickNum > 0)
			{
				// 继续引导培养
				this.next2();
				
				requiredClickNum--;
			}
			else
			{
				// 下一步
				this.next4();
			}
		}
		
		
		
		private function next4():void
		{
			this.popupClickGuide(window.closeBtn, false, Lang.instance.trans("AS_1426"), Guide.Direct_Right , finish);
		}
		
		
		
		protected function finish():void
		{
			this.guideCompleteHandler();
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent = null):void
		{
			if(window)
			{
				window.removeEventListener(HeroEvent.ON_HERO_UPDATE , next3);
				window.removeEventListener(Event.COMPLETE , next1);
				window = null;
			}
			
			super.guideCompleteHandler();
		}
	}
}