package com.gamehero.sxd2.gui.hurdleGuide.event
{
	import flash.events.Event;
	
	/**
	 * 章节事件
	 * @author weiyanyu
	 * 创建时间：2015-9-1 下午1:59:17
	 * 
	 */
	public class HurdleGuideEvent extends Event
	{
		/**
		 * 更新章节数据 
		 */		
		public static var UPDATE:String = "update";
		/**
		 * 请求进入副本 
		 */		
		public static var ENTER_INSTANCE:String = "enter_instance";
		/**
		 * 领取奖励 
		 */		
		public static var ACCEPT:String = "accept";
		/**
		 * 获取战报 
		 */		
		public static var REPORT:String = "report";
		/**
		 */		
		public var id:int;
		/**
		 * 额外参数，如奖励宝箱索引 
		 */		
		public var ent:int;
		
		public function HurdleGuideEvent(type:String, id:int)
		{
			super(type, bubbles, cancelable);
			this.id = id;
		}
	}
}