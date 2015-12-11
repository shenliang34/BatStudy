package com.gamehero.sxd2.gui
{
    import com.gamehero.sxd2.event.WindowEvent;
    import com.gamehero.sxd2.gui.HurdleReport.HurdleAwardWindow;
    import com.gamehero.sxd2.gui.HurdleReport.HurdleReportWindow;
    import com.gamehero.sxd2.gui.arena.ArenaBattleReportWindow;
    import com.gamehero.sxd2.gui.arena.ArenaRankWindow;
    import com.gamehero.sxd2.gui.bag.BagWindow;
    import com.gamehero.sxd2.gui.blackMarket.BlackMarketWindow;
    import com.gamehero.sxd2.gui.buyback.BuybackWindow;
    import com.gamehero.sxd2.gui.chat.ChatHistoryWindow;
    import com.gamehero.sxd2.gui.chat.ChatWindow;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.core.WindowPostion;
    import com.gamehero.sxd2.gui.equips.EquipWindow;
    import com.gamehero.sxd2.gui.fate.FateWindow;
    import com.gamehero.sxd2.gui.formation.FormationWindow;
    import com.gamehero.sxd2.gui.friend.AddFriendWindow;
    import com.gamehero.sxd2.gui.friend.AudienceTipBoxWindow;
    import com.gamehero.sxd2.gui.friend.FriendWindow;
    import com.gamehero.sxd2.gui.friend.HeadPortraitWindow;
    import com.gamehero.sxd2.gui.friend.MyAudienceWindow;
    import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookWindow;
    import com.gamehero.sxd2.gui.hurdleGuide.HurdleClearOutWindow;
    import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideWindow;
    import com.gamehero.sxd2.gui.mail.MailWindow;
    import com.gamehero.sxd2.gui.npc.NpcWindow;
    import com.gamehero.sxd2.gui.player.hero.HeroDetailWindow;
    import com.gamehero.sxd2.gui.player.hero.HeroWindow;
    import com.gamehero.sxd2.gui.takeCards.TakeCardsWindow;
    import com.gamehero.sxd2.guide.gui.ProduceGuideWindow;
    
    import flash.events.IEventDispatcher;
    
    import robotlegs.bender.bundles.mvcs.Command;
	
	
	/**
	 * 弹出窗口command
	 * @author xuwenyi
	 * @create 2013-08-15
	 **/
	public class WindowCommand extends Command
	{
		[Inject]
		public var windowEvent:WindowEvent;
		[Inject]
		public var eventDispatch:IEventDispatcher;
		[Inject]
		public var sxd2main:SXD2Main;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function WindowCommand()
		{
			super();
		}
		
		
		override public function execute():void 
		{
			var type:String = windowEvent.type;
			var windowName:String = windowEvent.windowName;
			var windowParam:Object = windowEvent.data;
			var isAutoClose:Boolean = windowEvent.isAutoClose;
			
			// 打开窗口指令
			if(type == WindowEvent.OPEN_WINDOW)
			{
				switch(windowName)
				{
					//竞技场
					case WindowEvent.ARENA_WINDOW:
						sxd2main.showFullScreenView(windowEvent.windowName);
						break;
					//主角技能
					case WindowEvent.ROLESKILL_VIEW:
						sxd2main.showFullScreenView(windowEvent.windowName);
						break;
					
					//打开伙伴面板
					case WindowEvent.HERO_WINDOW:
						WindowManager.inst.openWindow(HeroWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam,[BagWindow,HeroDetailWindow]);
						break;
					
					//伙伴详细信息面板
					case WindowEvent.PLAYER_STATS:
						WindowManager.inst.openWindow(HeroDetailWindow, WindowPostion.CENTER, false, true, isAutoClose, windowParam,[BagWindow,HeroWindow]);
						break;
					
					//背包
					case WindowEvent.BAG_WINDOW:
						WindowManager.inst.openWindow(BagWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[BuybackWindow,HeroDetailWindow,HeroWindow]);
						break;
					
					//布阵面板
					case WindowEvent.FORMATION_WINDOW:
						WindowManager.inst.openWindow(FormationWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					
					//剧情副本导航
					case WindowEvent.HURDLE_GUIDE_WINDOW:
						WindowManager.inst.openWindow(HurdleGuideWindow, WindowPostion.CENTER, false, false, isAutoClose, windowParam,[HurdleClearOutWindow]);
						break;
					
					//任务面板
					case WindowEvent.TASK_WINDOW:
						WindowManager.inst.openWindow(NpcWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//副本扫荡
					case WindowEvent.HURDLE_CLEAROUT_WINDOW:
						WindowManager.inst.openWindow(HurdleClearOutWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam,[HurdleGuideWindow]);
						break;
					//副本攻略
					case WindowEvent.HURDLE_REPORT_WINDOW:
						WindowManager.inst.openWindow(HurdleReportWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//副本奖励
					case WindowEvent.HURDLE_AWARD_WINDOW:
						WindowManager.inst.openWindow(HurdleAwardWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//装备面板
					case WindowEvent.EQUIP_WINDOW:
						WindowManager.inst.openWindow(EquipWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//回购店
					case WindowEvent.BUYBACK_WINDOW:
						WindowManager.inst.openWindow(BuybackWindow, WindowPostion.CENTER_RIGHT, false, false, isAutoClose, windowParam,[BagWindow]);
						break;
					//黑市
					case WindowEvent.BLACKMARKET_WINDOW:
						WindowManager.inst.openWindow(BlackMarketWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//竞技场战报
					case WindowEvent.ARENA_BATTLE_REPORT_WINDOW:
						WindowManager.inst.openWindow(ArenaBattleReportWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//竞技场排行榜
					case WindowEvent.ARENA_RANK_WINDOW:
						WindowManager.inst.openWindow(ArenaRankWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//邮件
					case WindowEvent.MAIL_WINDOW:
						WindowManager.inst.openWindow(MailWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//抽卡
					case WindowEvent.TAKE_CARDS_WINDOW:
						WindowManager.inst.openWindow(TakeCardsWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//命途
					case WindowEvent.FATE_WINDOW:
						WindowManager.inst.openWindow(FateWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//图鉴
					case WindowEvent.HERO_HANDBOOK_WINDOW:
						WindowManager.inst.openWindow(HeroHandbookWindow, WindowPostion.CENTER_ONLY, false, false, isAutoClose, windowParam);
						break;
					//道具产出
					case WindowEvent.PRODUCE_GUIDE_WINDOW:
						WindowManager.inst.openWindow(ProduceGuideWindow, WindowPostion.CENTER_ONLY, false, true, isAutoClose, windowParam);
						break;
					//私聊窗口
					case WindowEvent.CHAT_WINDOW:
						WindowManager.inst.openWindow(ChatWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam);
						break;
					//私聊聊天记录
					case WindowEvent.CHATHISTORY_WINDOW:
						WindowManager.inst.openWindow(ChatHistoryWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam);
						break;
					//好友列表
					case WindowEvent.FRIEND_WINDOW:
						WindowManager.inst.openWindow(FriendWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam ,[MyAudienceWindow,HeadPortraitWindow]);
						break;
					//听众窗口
					case WindowEvent.MY_AUDIENCE_WINDOW:
						WindowManager.inst.openWindow(MyAudienceWindow, WindowPostion.CENTER_RIGHT, false, true, isAutoClose, windowParam,[FriendWindow,AudienceTipBoxWindow]);
						break;
					//关注提示
					case WindowEvent.AUDIENCE_TIPBOX_WINDOW:
						WindowManager.inst.openWindow(AudienceTipBoxWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam,[FriendWindow,MyAudienceWindow]);
						break;
					//头像
					case WindowEvent.HEAD_PORTSIT_WINDOW:
						WindowManager.inst.openWindow(HeadPortraitWindow, WindowPostion.CENTER_LEFT, false, true, isAutoClose, windowParam,[FriendWindow]);
						break;
				}
			}
			// 关闭全屏玩法指令
			else if(type == WindowEvent.HIDE_FULLSCREEN_VIEW)
			{
				sxd2main.hideFullScreenView();
			}
		}
	}
}