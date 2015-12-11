package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.pps.ifs.gui.equip.StrengthenWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.events.Event;
	
	
	
	/**
	 * 强化引导 
	 * @author wulongbin
	 */	
	public class Guide_50001 extends Guide
	{
		protected var window:StrengthenWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_50001()
		{
			super();
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			window = WindowManager.inst.getWindowInstance(StrengthenWindow,WindowPostion.CENTER) as StrengthenWindow;
			if(window.loaded)
			{
				this.next1();
			}
			else
			{
				window.addEventListener(Event.COMPLETE , next1);
			}
		}
		
		
		
		
		/**
		 * 指向强化按钮
		 * */
		private function next1(e:Event = null):void
		{
			window.removeEventListener(Event.COMPLETE , next1);
			
			this.popupClickGuide(window.strengthenBt, true, Lang.instance.trans("AS_1422"), Guide.Direct_Up, next2);
		}
		
		
		
		
		/**
		 * 再次点击强化
		 * */
		private function next2(e:Event = null):void
		{	
			this.popupClickGuide(window.strengthenBt, true, Lang.instance.trans("AS_1422"), Guide.Direct_Up, next3);
		}
		
		
		
		
		/**
		 * 指向关闭按钮
		 * */
		private function next3():void
		{
			popupClickGuide(window.getCloseBtn(), true, Lang.instance.trans("AS_1412"), Guide.Direct_Right, finish);
		}
		
		
		
		
		/**
		 * 结束引导
		 * */
		private function finish():void
		{
			this.guideCompleteHandler();
			
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				window.removeEventListener(Event.COMPLETE , next1);
				window = null;
			}
			
			super.guideCompleteHandler(e);
		}
	}
}