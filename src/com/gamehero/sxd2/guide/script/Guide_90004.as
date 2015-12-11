package com.gamehero.sxd2.guide.script
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	
	/**
	 * 梦魇副本介绍引导
	 * @author xuwenyi
	 * @create 2014-06-13
	 **/
	public class Guide_90004 extends Guide
	{
		/**
		 * 构造函数
		 * */
		public function Guide_90004()
		{
			super();
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			// 引导打开梦魇介绍面板
			MainUI.inst.openWindow(WindowEvent.INCUBUS_INTOR_WINDOW);
		}
		
	}
}