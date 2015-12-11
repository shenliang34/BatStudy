package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.event.BaseEvent;
	
	import flash.events.Event;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-2 下午9:57:22
	 * 
	 */
	public class HeroHandbookEvent extends BaseEvent
	{
		/**
		 * 图鉴分解
		 * */
		public static const MSGID_PHOTO_APPRAISAL_BREAK:String = "MSGID_PHOTO_APPRAISAL_BREAK";
		/**
		 *领奖
		 * */
		public static const MSGID_PHOTO_APPRAISAL_RWD:String = "MSGID_PHOTO_APPRAISAL_RWD";
		/**
		 * 激活伙伴
		 * */
		public static const MSGID_PHOTO_APPRAISAL_ENABLE:String = "MSGID_PHOTO_APPRAISAL_ENABLE";
		/**
		 * 打开伙伴详情面板
		 * */
		public static const OPEN_FIGURE:String = "OPEN_FIGURE";
		/**
		 * 返回伙伴列表
		 * */
		public static const BACK:String = "BACK";
		
		public function HeroHandbookEvent(type:String, data:Object = null)
		{
			super(type , data);
		}
		
		
		override public function clone():Event
		{
			return new HeroHandbookEvent(type , data);
		}
	}
}