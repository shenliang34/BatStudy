package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;

	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午6:50:16
	 * 
	 */
	public class FriendSkin
	{
		/**
		 *滑过选中 
		 */		
		static public var SLIDER:BitmapData;
		public function FriendSkin()
		{
			
		}
		
		public static function init(domain:ApplicationDomain):void
		{
			var global:Global = Global.instance;
			SLIDER = global.getBD(domain,"Slider");
		}
	}
}