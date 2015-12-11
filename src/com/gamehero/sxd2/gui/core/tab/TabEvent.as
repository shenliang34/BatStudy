package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午10:39:54
	 * 
	 */
	public class TabEvent extends BaseEvent
	{
		/**
		 * 选中页签 
		 */		
		public static var SELECTED:String = "selected";
		public function TabEvent(type:String,data:Object)
		{
			super(type, data);
		}
	}
}