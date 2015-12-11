package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.display.DisplayObject;
	
	import bowser.logging.Logger;
	
	/**
	 * 巫师战棋点击宝箱引导 
	 * @author xuwenyi
	 */	
	public class Guide_30002 extends Guide
	{
		protected var box:DisplayObject;
		protected var closeBtn:DisplayObject;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_30002()
		{
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			var arr:Array = param as Array;
			if(arr && arr.length >= 2)
			{
				box = arr[0] as DisplayObject;
				closeBtn = arr[1] as DisplayObject;
				
				popupClickGuide(box , false , Lang.instance.trans("AS_1413"), Guide.Direct_Down , finish);
			}
			else
			{
				Logger.debug(Guide_30002 , "数据异常,结束巫师战棋的引导!");
				
				this.guideCompleteHandler();
			}
		}
		
		
		
		
		private function finish():void
		{
			popupClickGuide(closeBtn , false , Lang.instance.trans("AS_1414") , Guide.Direct_Right , guideCompleteHandler);
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			box = null;
			closeBtn = null;
			
			super.guideCompleteHandler(e);
		}
	}
}