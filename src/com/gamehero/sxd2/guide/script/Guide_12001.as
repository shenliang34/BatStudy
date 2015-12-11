package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.event.GuideEvent;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.core.WindowPostion;
    import com.pps.ifs.gui.fishing.FishingEvent;
    import com.pps.ifs.gui.fishing.FishingWindow;
    import com.gamehero.sxd2.guide.Guide;
    import com.gamehero.sxd2.guide.GuideArrow;
    import com.gamehero.sxd2.guide.GuideVO;
    import com.gamehero.sxd2.local.Lang;
    
    import flash.events.Event;
	
	
	/**
	 * 钓鱼第一次引导
	 * @author xuwenyi
	 * @create 2014-09-03
	 **/
	public class Guide_12001 extends Guide
	{
		// 钓鱼面板
		private var window:FishingWindow;
		// 箭头
		private var arrow:GuideArrow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_12001()
		{
			super();
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 钓鱼面板
			window = WindowManager.inst.getWindowInstance(FishingWindow, WindowPostion.CENTER) as FishingWindow;
			window.addEventListener(FishingEvent.FISH_CLICK , finish);
			
			// 箭头指向钓鱼转盘
			arrow = new GuideArrow();
			arrow.x = -115;
			arrow.y = 150;
			var text:String = Lang.instance.trans("10419").replace(/\\n/gi,"\n");
			arrow.setLabel(text , Guide.Direct_Up);
			window.addChild(arrow);
		}
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish(e:Event):void
		{	
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				if(arrow && window.contains(arrow) == true)
				{
					window.removeChild(arrow);
				}
				window.removeEventListener(FishingEvent.FISH_CLICK , finish);
			}
			arrow = null;
			window = null;
			
			super.guideCompleteHandler(e);
		}
	}
}