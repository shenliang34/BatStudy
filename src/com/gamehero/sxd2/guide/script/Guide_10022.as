package com.gamehero.sxd2.guide.script
{
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 逃跑引导
	 * @author xuwenyi
	 * @create 2014-10-08
	 **/
	public class Guide_10022 extends Guide
	{
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10022()
		{
			super();
		}
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function = null , param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 完成引导
			this.guideCompleteHandler();
		}
	}
}