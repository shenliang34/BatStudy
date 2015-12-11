package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.pps.ifs.event.BarEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.pps.ifs.gui.bar.BarHeroCard;
	import com.pps.ifs.gui.bar.BarWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.events.Event;
	
	import bowser.logging.Logger;
	
	
	
	/**
	 *酒馆引导 
	 * @author wulongbin
	 * 
	 */	
	public class Guide_40001 extends Guide
	{
		private var window:BarWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_40001()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			var funcinfo:FunctionInfo = FunctionsManager.instance.getFuncInfoByName(WindowEvent.BAR_WINDOW);
			this.popupClickGuide(funcinfo.button , false , Lang.instance.trans("AS_1418"), Guide.Direct_Down, next1);
			
			// 关闭自动 任务
			//TaskManager.instance.autoTaskSwitch = false;
		}
		
		
		
		
		/**
		 * 打开酒馆面板
		 * */
		protected function next1():void
		{
			window = WindowManager.inst.getWindowInstance(BarWindow, WindowPostion.CENTER) as BarWindow;
			// 监听酒馆数据是否加载完
			window.addEventListener(BarEvent.ON_HERO_BAR_INFO , next3);
		}
		
		
		
		
		
		/*private function next2(e:Event = null):void
		{
			window.removeEventListener(Event.COMPLETE, next2);
		}*/
		
		
		
		
		protected function next3(e:BarEvent = null):void
		{
			window.removeEventListener(BarEvent.ON_HERO_BAR_INFO , next3);
			
			// 精灵王子伙伴卡牌
			var heroID:String = guideInfo.param1 as String;
			var card:BarHeroCard = window.getCard(heroID);
			if(card && card.canInvite == true)
			{
				this.popupClickGuide(card.inviteBtn, false , Lang.instance.trans("AS_1419"), Guide.Direct_Up);
				window.addEventListener(BarEvent.ON_HERO_INVITE , next4);
			}
			else
			{
				Logger.debug(Guide_40001 , "找不到可招募的伙伴!");
				this.guideCompleteHandler();
			}
		}
		
		
		
		
		
		/**
		 * 关闭窗口,播放卡牌特效
		 * */
		private function next4(e:Event):void
		{
			window.removeEventListener(BarEvent.ON_HERO_INVITE , next4);
			WindowManager.inst.closeWindow(window);
			
			this.finish();
		}
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{	
			//this.removeGuide();
			
			// 布阵引导
			//GuideManager.instance.playGuide(40002 , guideCompleteHandler);
			
			this.guideCompleteHandler();
		}
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				window.removeEventListener(BarEvent.ON_HERO_BAR_INFO , next3);
				window.removeEventListener(BarEvent.ON_HERO_INVITE , next4);
				window = null;
			}
			
			super.guideCompleteHandler(e);
		}
		
	}
}