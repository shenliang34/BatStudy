package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.pps.ifs.gui.temple.TempleWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 暗影神殿引导
	 * @author xuwenyi
	 * @create 2015-02-04
	 **/
	public class Guide_13001 extends Guide
	{
		private var window:TempleWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_13001()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 暗影神殿面板
			window = WindowManager.inst.getWindowInstance(TempleWindow,WindowPostion.CENTER) as TempleWindow;
			this.popupClickGuide(window.btnArr[0], false, Lang.instance.trans("AS_1405"), Direct_Down, next3);
		}
		
		
		
		
		
		/**
		 * 指向金币收集
		 * */
		private function next3():void
		{
			if(GameData.inst.getMoneyNum(1002) >= 50000)
			{
				window.coinCheck = true;//默认勾选今日不在提示
				this.popupClickGuide(window.btn2, false, Lang.instance.trans("AS_1406"), Direct_Down, next4);
			}
			else
			{
				this.finish();
			}
		}
		
		
		
		
		
		/**
		 * 再次指向金币收集
		 * */
		private function next4():void
		{
			if(GameData.inst.getMoneyNum(1002) >= 50000)
			{
				window.coinCheck = true;//默认勾选今日不在提示
				this.popupClickGuide(window.btn2, false, Lang.instance.trans("AS_1407"), Direct_Down, next5);
			}
			else
			{
				this.finish();
			}
		}
		
		
		
		
		
		/**
		 * 再次指向金币收集
		 * */
		private function next5():void
		{
			this.popupClickGuide(window.getSoulBtn, false, Lang.instance.trans("AS_1408"), Direct_Down, finish);
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