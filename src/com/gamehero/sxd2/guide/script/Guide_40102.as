package com.gamehero.sxd2.guide.script
{
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 阵型6号位是否已激活
	 * @author xuwenyi
	 * @create 2014-09-03
	 **/
	public class Guide_40102 extends Guide
	{
		public function Guide_40102()
		{
			super();
		}
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			this.guideCompleteHandler();
		}
	}
}