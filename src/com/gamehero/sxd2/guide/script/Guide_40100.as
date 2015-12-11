package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 阵型链激活引导
	 * @author xuwenyi
	 * @create 2014-09-03
	 **/
	public class Guide_40100 extends Guide
	{
		private var window:FormationWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_40100()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 布阵面板
			window = WindowManager.inst.getWindowInstance(FormationWindow,WindowPostion.CENTER) as FormationWindow;
			window.addEventListener(FormationEvent.ON_FORMATION_INFO , next1);
		}
		
		
		
		
		protected function next1(e:FormationEvent):void
		{
			e.currentTarget.removeEventListener(FormationEvent.ON_FORMATION_INFO , next1);
			
			if(window)
			{
				this.popupClickGuide(window.activateChainBtn,false,Lang.instance.trans("AS_1421"),Direct_Left,guideCompleteHandler);
			}
			else
			{
				this.guideCompleteHandler();
			}
		}
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{	
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				window.removeEventListener(FormationEvent.ON_FORMATION_INFO , next1);
				window = null;
			}
			
			super.guideCompleteHandler(e);
		}
	}
}