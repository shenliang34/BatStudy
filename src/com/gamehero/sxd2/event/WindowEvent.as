package com.gamehero.sxd2.event
{
	import com.gamehero.sxd2.gui.core.BaseWindow;
	
	import flash.events.Event;
	
	/**
	 * 弹出窗口事件
	 * @author xuwenyi
	 * @create 2013-08-15
	 **/
	public class WindowEvent extends BaseEvent
	{	
		// Open Event Type
		public static const OPEN_WINDOW:String = "openWindow";
		public static const CLOSE_WINDOW:String = "closeWindow";
		public static const HIDE_FULLSCREEN_VIEW:String = "hide_fullscreen_view";
//		public static const ALL_WINDOW_CLOSE:String = "allWindowClose";		// 所以窗口关闭
		
		// 全屏玩法
		public static const ARENA_WINDOW:String = "ArenaView";// 竞技场
		public static const ROLESKILL_VIEW:String = "RoleSkillView";// 主角技能
		
		
		
		/* 伙伴 */
		public static const HERO_WINDOW:String = "HeroWindow";
		public static const FORMATION_WINDOW:String = "FormationWindow";
		public static const TASK_WINDOW:String = "TaskWindow";

		public static const PLAYER_STATS:String = "PlayerStats";

		/** 背包 */
		public static const BAG_WINDOW:String = "BagWindow";
		/** 剧情副本导航界面 */		
		public static var HURDLE_GUIDE_WINDOW:String = "HurdleGuideWindow";
		/** 副本扫荡 */		
		public static var HURDLE_CLEAROUT_WINDOW:String = "HurdleClearoutWindow";
		/** 副本攻略 */		
		public static var HURDLE_REPORT_WINDOW:String = "HurdleReportWindow";
		/** 副本奖励界面 */		
		public static var HURDLE_AWARD_WINDOW:String = "HurdleAwardWindow";
		/** 装备面板 */		
		public static var EQUIP_WINDOW:String = "EquipWindow";
		/** 当铺 */		
		public static var BUYBACK_WINDOW:String = "BuybackWindow";
		/** 黑市 */		
		public static var BLACKMARKET_WINDOW:String = "BlackMarketWindow";
		/** 图鉴 */		
		public static var HERO_HANDBOOK_WINDOW:String = "HeroHandbookWindow";
		// 竞技场战报
		public static var ARENA_BATTLE_REPORT_WINDOW:String = "ArenaBattleReportWindow";
		// 竞技场排行榜
		public static var ARENA_RANK_WINDOW:String = "ArenaRankWindow";
		// 邮件
		public static var MAIL_WINDOW:String = "MailWindow";
		/** 抽卡		 */		
		public static var TAKE_CARDS_WINDOW:String = "TakeCardsWindow";
		//命途窗口
		public static var FATE_WINDOW:String = "FateWindow";
		/**产出引导*/
		public static var PRODUCE_GUIDE_WINDOW:String = "ProduceGuideWindow";
		/**好友窗口*/
		public static var FRIEND_WINDOW:String = "FriendWindow";
		/**私聊窗口*/
		public static var CHAT_WINDOW:String = "ChatWindow";
		/**私聊记录*/
		public static const CHATHISTORY_WINDOW:String = "ChatHistoryWindow";
		/**听众窗口*/
		public static var MY_AUDIENCE_WINDOW:String = "MyAudienceWindow";
		/**关注提示*/
		public static var AUDIENCE_TIPBOX_WINDOW:String = "audienceTipboxWindow";
		/**头像*/
		public static var HEAD_PORTSIT_WINDOW:String = "headPortsitWindow";
		
		// 窗口参数
		public var windowName:String;
		public var isAutoClose:Boolean = true;
		
		public var window:BaseWindow;
		
		/**
		 * 构造函数
		 * */
		public function WindowEvent(type:String, windowName:String = "", data:Object = null)
		{
			this.windowName = windowName;
			super(type, data);
		}
		
		
		override public function clone():Event
		{
			var e:WindowEvent = new WindowEvent(type , windowName, data);
			e.isAutoClose = isAutoClose;
			
			return e;
		}
	}
}