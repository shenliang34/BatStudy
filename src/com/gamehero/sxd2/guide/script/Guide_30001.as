package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.display.DisplayObject;
	
	
	
	
	/**
	 *巫师战旗首次进入引导 
	 * @author xuwenyi
	 */	
	public class Guide_30001 extends Guide
	{
		
		/**
		 * 构造函数
		 * */
		public function Guide_30001()
		{
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			if(param)
			{
				this.popupClickGuide(param as DisplayObject, false , Lang.instance.trans("AS_1402"), Guide.Direct_Down , finish);
				
				//_mask.resetTargetMask(param.width,param.height);
				//_mask.stopResize();
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