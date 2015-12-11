package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.gui.arena.ArenaView;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * 点击机器人进入竞技场战斗
	 * @author xuwenyi
	 * @create 2014-06-05
	 **/
	public class Guide_11002 extends Guide
	{
		private var window:ArenaView;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_11002()
		{
			super();
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			window = ArenaView.instance;
			var robot:DisplayObject = window.getRobot();
			if(robot)
			{
				this.popupClickGuide(robot , true, Lang.instance.trans("AS_1402"), Direct_Down , finish);
			}
			else
			{
				this.finish();
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
			window = null;
			
			super.guideCompleteHandler(e);
		}
	}
}