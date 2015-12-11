package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.gui.arena.ArenaView;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 退出竞技场引导
	 * @author xuwenyi
	 * @create 2014-06-05
	 **/
	public class Guide_11003 extends Guide
	{
		private var window:ArenaView;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_11003()
		{
			super();
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			window = ArenaView.instance;
			this.popupClickGuide(window.closeBtn , true , Lang.instance.trans("AS_1403"), Guide.Direct_Right , finish);
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
			window = null;
			
			super.guideCompleteHandler(e);
		}
	}
}


