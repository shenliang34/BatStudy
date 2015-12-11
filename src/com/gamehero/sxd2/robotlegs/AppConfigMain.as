package com.gamehero.sxd2.robotlegs
{
	import com.gamehero.sxd2.battle.BattleMediator;
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.gui.BattleReportMediator;
	import com.gamehero.sxd2.battle.gui.BattleReportWindow;
	import com.gamehero.sxd2.battle.gui.BattleResultMediator;
	import com.gamehero.sxd2.battle.gui.BattleResultWindow;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.WindowCommand;
	import com.gamehero.sxd2.gui.HurdleReport.HurdleAwardMedia;
	import com.gamehero.sxd2.gui.HurdleReport.HurdleAwardWindow;
	import com.gamehero.sxd2.gui.HurdleReport.HurdleReportMedia;
	import com.gamehero.sxd2.gui.HurdleReport.HurdleReportWindow;
	import com.gamehero.sxd2.gui.arena.ArenaMediator;
	import com.gamehero.sxd2.gui.arena.ArenaRankMediator;
	import com.gamehero.sxd2.gui.arena.ArenaRankWindow;
	import com.gamehero.sxd2.gui.arena.ArenaView;
	import com.gamehero.sxd2.gui.bag.BagMediator;
	import com.gamehero.sxd2.gui.bag.BagWindow;
	import com.gamehero.sxd2.gui.blackMarket.BlackMarketMedia;
	import com.gamehero.sxd2.gui.blackMarket.BlackMarketWindow;
	import com.gamehero.sxd2.gui.buyback.BuybackMedia;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.chat.ChatHistoryWindow;
	import com.gamehero.sxd2.gui.chat.ChatHistoryWindowMediator;
	import com.gamehero.sxd2.gui.chat.ChatMediator;
	import com.gamehero.sxd2.gui.chat.ChatView;
	import com.gamehero.sxd2.gui.chat.ChatWindow;
	import com.gamehero.sxd2.gui.chat.ChatWindowMediator;
	import com.gamehero.sxd2.gui.equips.EquipMedia;
	import com.gamehero.sxd2.gui.equips.EquipWindow;
	import com.gamehero.sxd2.gui.fate.FateWindow;
	import com.gamehero.sxd2.gui.fate.FateWindowMediator;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.gui.formation.FormationWindowMediator;
	import com.gamehero.sxd2.gui.friend.FriendWindow;
	import com.gamehero.sxd2.gui.friend.FriendWindowMediator;
	import com.gamehero.sxd2.gui.friend.HeadPortraitWindow;
	import com.gamehero.sxd2.gui.friend.HeadPortraitWindowMediator;
	import com.gamehero.sxd2.gui.friend.MyAudienceWindow;
	import com.gamehero.sxd2.gui.friend.MyAudienceWindowMediator;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookWindow;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookWindowMediator;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleClearOutMedia;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleClearOutWindow;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideMediater;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideWindow;
	import com.gamehero.sxd2.gui.mail.MailWindow;
	import com.gamehero.sxd2.gui.mail.MailWindowMediator;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.main.MainUIMediator;
	import com.gamehero.sxd2.gui.menu.MenuMediator;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.notice.NoticeUIMediator;
	import com.gamehero.sxd2.gui.npc.NpcWindow;
	import com.gamehero.sxd2.gui.npc.NpcWindowMediator;
	import com.gamehero.sxd2.gui.player.hero.HeroWindow;
	import com.gamehero.sxd2.gui.player.hero.HeroWindowMediator;
	import com.gamehero.sxd2.gui.roleSkill.RoleSkillMediator;
	import com.gamehero.sxd2.gui.roleSkill.RoleSkillView;
	import com.gamehero.sxd2.gui.takeCards.TakeCardsMedia;
	import com.gamehero.sxd2.gui.takeCards.TakeCardsWindow;
	import com.gamehero.sxd2.world.HurdleMap.HurdleSceneMediator;
	import com.gamehero.sxd2.world.HurdleMap.HurdleSceneView;
	import com.gamehero.sxd2.world.globolMap.GlobalSceneMediator;
	import com.gamehero.sxd2.world.globolMap.GlobalSceneView;
	import com.gamehero.sxd2.world.sceneMap.SceneView;
	import com.gamehero.sxd2.world.sceneMap.SceneViewMediator;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	
	
	
	
	/**
	 * robotlegs主游戏配置类
	 * @author xuwenyi
	 * @create 2013-07-29
	 **/
	public class AppConfigMain implements IConfig
	{
		[Inject]
		public var context:IContext;
		[Inject]
		public var commandMap:IEventCommandMap;
		[Inject]
		public var mediatorMap:IMediatorMap;
		[Inject]
		public var contextView:ContextView;
		
		
		
		/**
		 * 构造函数
		 * 
		 */
		public function AppConfigMain()
		{
		}
		
		
		
		/**
		 * 注册MVC各组件
		 * */
		public function configure():void
		{	
			
			/** model层 */
			var injector:IInjector = context.injector;
			
			//proxy
			
			/** commond层 */
			commandMap.map(MainEvent.SHOW_BATTLE , MainEvent).toCommand(MainCommand);
			commandMap.map(MainEvent.BATTLE_END , MainEvent).toCommand(MainCommand);
			
			// Window
			commandMap.map(WindowEvent.OPEN_WINDOW, WindowEvent).toCommand(WindowCommand);
			commandMap.map(WindowEvent.HIDE_FULLSCREEN_VIEW, WindowEvent).toCommand(WindowCommand);
			
			/** mediator层 */
			mediatorMap.map(SXD2Main).toMediator(SXD2MainMediater);
			mediatorMap.map(BattleView).toMediator(BattleMediator);
			mediatorMap.map(BattleResultWindow).toMediator(BattleResultMediator);
			mediatorMap.map(BattleReportWindow).toMediator(BattleReportMediator);
			mediatorMap.map(SceneView).toMediator(SceneViewMediator);//游戏场景
			mediatorMap.map(HurdleSceneView).toMediator(HurdleSceneMediator);//副本
			mediatorMap.map(GlobalSceneView).toMediator(GlobalSceneMediator);//世界地图
			mediatorMap.map(HurdleGuideWindow).toMediator(HurdleGuideMediater);//章节/剧情副本/副本导航
			mediatorMap.map(HurdleClearOutWindow).toMediator(HurdleClearOutMedia);//扫荡
			mediatorMap.map(HurdleReportWindow).toMediator(HurdleReportMedia);//扫荡
			mediatorMap.map(HurdleAwardWindow).toMediator(HurdleAwardMedia);//副本奖励
			mediatorMap.map(EquipWindow).toMediator(EquipMedia);//装备面板
			mediatorMap.map(BuybackWindow).toMediator(BuybackMedia);//回购
			mediatorMap.map(BlackMarketWindow).toMediator(BlackMarketMedia);//黑市
			mediatorMap.map(TakeCardsWindow).toMediator(TakeCardsMedia);//抽卡
			
			// 全屏玩法
			mediatorMap.map(ArenaView).toMediator(ArenaMediator);//竞技场
			mediatorMap.map(RoleSkillView).toMediator(RoleSkillMediator);//英雄技能
			
			// UI
			mediatorMap.map(MainUI).toMediator(MainUIMediator);//主UI
			mediatorMap.map(ChatView).toMediator(ChatMediator);//聊天
			mediatorMap.map(BagWindow).toMediator(BagMediator);//背包
			mediatorMap.map(FormationWindow).toMediator(FormationWindowMediator);//布阵
			mediatorMap.map(MenuPanel).toMediator(MenuMediator);//菜单面板
			mediatorMap.map(HeroWindow).toMediator(HeroWindowMediator);//伙伴面板
			mediatorMap.map(NpcWindow).toMediator(NpcWindowMediator);//nop面板
			mediatorMap.map(NoticeUI).toMediator(NoticeUIMediator);//提示层
			mediatorMap.map(MailWindow).toMediator(MailWindowMediator);//邮件窗口
			mediatorMap.map(ArenaRankWindow).toMediator(ArenaRankMediator);//竞技场排行榜
			mediatorMap.map(HeroHandbookWindow).toMediator(HeroHandbookWindowMediator);//伙伴图鉴
			mediatorMap.map(FateWindow).toMediator(FateWindowMediator);//命途窗口
			mediatorMap.map(FriendWindow).toMediator(FriendWindowMediator);//好友列表
			mediatorMap.map(MyAudienceWindow).toMediator(MyAudienceWindowMediator);//我的关注
			mediatorMap.map(HeadPortraitWindow).toMediator(HeadPortraitWindowMediator);//头像
			mediatorMap.map(ChatWindow).toMediator(ChatWindowMediator);//好友私聊
			mediatorMap.map(ChatHistoryWindow).toMediator(ChatHistoryWindowMediator);//好友私聊
		}
		
	}
}