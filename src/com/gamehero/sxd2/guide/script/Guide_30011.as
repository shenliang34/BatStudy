package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * 巫师战旗第一次遇见第二个boss
	 * @author xuwenyi
	 * @create 2015-01-21
	 **/
	public class Guide_30011 extends Guide
	{
		public function Guide_30011()
		{
			isForceGuide = false;
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			if(param)
			{
				this.popupClickGuide(param as DisplayObject, false , Lang.instance.trans("AS_1402"), Guide.Direct_Down , finish);
			}
		}
		
		
		
		
		/**
		 * 结束引导
		 * */
		private function finish():void
		{
			this.guideCompleteHandler();
		}
	}
}