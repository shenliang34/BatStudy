 package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ArenaEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK;
	import com.gamehero.sxd2.pro.PRO_PlayerExtra;
	import com.gamehero.sxd2.util.Time;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.time.TimeTick;
	import bowser.utils.time.TimeTickData;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 竞技场视图
	 * @author xuwenyi
	 * @create 2015-09-29
	 **/
	public class ArenaView extends Sprite
	{
		private static var _instance:ArenaView;
		// 资源
		private var domain:ApplicationDomain;
		
		// 背景图
		private var bg:Bitmap;
		
		// 铜钱和元宝
		private var moneyPanel:ActiveObject;
		private var moneyLabel:Label;
		private var goldPanel:ActiveObject;
		private var goldLabel:Label;
		
		// 玩家姓名
		private var nameLabel:Label;
		// 玩家战力
		private var powerLabel:BitmapNumber;
		// 门票数
		private var ticketLabel:Label;
		// 胜利数
		private var winLabel:Label;
		// 门票刷新倒计时
		private var timeLabel:Label;
		private var tick:TimeTick;
		
		// 战报按钮
		private var battleReportBtn:SButton;
		// 排行榜按钮
		private var rankBtn:SButton;
		// 退出按钮
		private var quitBtn:SButton;
		
		// 人物模型面板
		private var figurePanel:ArenaFigurePanel;
		
		// 右上星级面板
		private var levelPanel:ArenaLevelPanel;
		
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaView()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		public static function get inst():ArenaView
		{
			return _instance ||= new ArenaView();
		}
		
		
		
		
		private function onAdd(e:Event):void
		{
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.GUI_URL + "ArenaView.swf" , null , onShow);
		}
		
		
		
		
		private function onRemove(e:Event):void
		{
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.remove(GameConfig.GUI_URL + "ArenaView.swf");
		}
		
		
		
		
		
		/**
		 * 初始化
		 * */
		private function initWindow():void
		{	
			var global:Global = Global.instance;
			
			// 背景图
			bg = new Bitmap();
			this.addChild(bg);
			
			// 标题
			var bmp:Bitmap = new Bitmap(global.getBD(domain , "TITLE"));
			bmp.x = 0;
			bmp.y = 30;
			this.addChild(bmp);
			
			// 元宝
			goldPanel = new ActiveObject();
			goldPanel.x = 20;
			goldPanel.y = 4;
			this.addChild(goldPanel);
			
			bmp = new Bitmap(ItemSkin.YUANBAO);
			goldPanel.addChild(bmp);
			
			goldLabel = new Label(false);
			goldLabel.x = 26;
			goldLabel.y = 7;
			goldLabel.width = 120;
			goldPanel.addChild(goldLabel);
			
			// 铜钱
			moneyPanel = new ActiveObject();
			moneyPanel.x = 109;
			moneyPanel.y = 4;
			this.addChild(moneyPanel);
			
			bmp = new Bitmap(ItemSkin.TONGQIAN);
			moneyPanel.addChild(bmp);
			
			moneyLabel = new Label(false);
			moneyLabel.x = 24;
			moneyLabel.y = 7;
			moneyLabel.width = 120;
			moneyPanel.addChild(moneyLabel);
			
			
			// 左上角信息面板
			var mc:MovieClip = global.getRes(domain , "INFO_PANEL") as MovieClip;
			mc.x = 0;
			mc.y = 127;
			this.addChild(mc);
			
			// 玩家姓名
			nameLabel = new Label();
			nameLabel.x = 20;
			nameLabel.y = 98;
			nameLabel.width = 120;
			nameLabel.bold = true;
			nameLabel.size = 14;
			nameLabel.text = GameData.inst.roleInfo.base.name;
			this.addChild(nameLabel);
			
			// 战力
			powerLabel = new BitmapNumber();
			powerLabel.x = 95;
			powerLabel.y = 132;
			this.addChild(powerLabel);
			
			// 固定文字
			var label:Label = new Label();
			label.x = 19;
			label.y = 170;
			label.width = 200;
			label.text = "试炼场门票：";
			this.addChild(label);
			
			label = new Label();
			label.x = 19;
			label.y = 195;
			label.width = 200;
			label.text = "总胜利场数：";
			this.addChild(label);
			
			// 门票数
			ticketLabel = new Label();
			ticketLabel.x = 126;
			ticketLabel.y = 170;
			ticketLabel.width = 60;
			ticketLabel.color = GameDictionary.ORANGE;
			this.addChild(ticketLabel);
			
			// 胜利数
			winLabel = new Label();
			winLabel.x = 100;
			winLabel.y = 195;
			winLabel.width = 60;
			winLabel.color = GameDictionary.ORANGE;
			this.addChild(winLabel);
			
			// 门票刷新倒计时
			timeLabel = new Label(false);
			timeLabel.x = 160;
			timeLabel.y = 170;
			timeLabel.width = 100;
			timeLabel.color = GameDictionary.RED;
			this.addChild(timeLabel);
			
			tick = new TimeTick();
			
			// 顶部按钮
			battleReportBtn = new SButton(global.getRes(domain , "BATTLE_REPORT_BTN") as SimpleButton);
			this.addChild(battleReportBtn);
			
			rankBtn = new SButton(global.getRes(domain , "RANK_BTN") as SimpleButton);
			this.addChild(rankBtn);
			
			quitBtn = new SButton(global.getRes(domain , "QUIT_BTN") as SimpleButton);
			this.addChild(quitBtn);
			
			// 右上等级面板
			levelPanel = new ArenaLevelPanel(domain);
			this.addChild(levelPanel);
			
			// 人物面板
			figurePanel = new ArenaFigurePanel(domain);
			this.addChild(figurePanel);
		}
		
		
		
		
		
		/**
		 * 加载完成
		 * */
		private function onShow(e:Event):void
		{
			if(domain == null)
			{
				var imageItem:ImageItem = e.currentTarget as ImageItem;
				imageItem.removeEventListener(Event.COMPLETE , onShow);
				
				domain = imageItem.loader.contentLoaderInfo.applicationDomain;
				
				this.initWindow();
			}
			
			this.clear();
			
			stage.addEventListener(Event.RESIZE , resize);
			this.resize();
			
			// 按钮事件
			battleReportBtn.addEventListener(MouseEvent.CLICK , onBattleReportClick);
			rankBtn.addEventListener(MouseEvent.CLICK , onRankClick);
			quitBtn.addEventListener(MouseEvent.CLICK , onQuitClick);
			
			// 初始化背景图
			bg.bitmapData = Global.instance.getBD(domain , "BG");
			
			// 请求数据
			this.arenaInfo();
			
			// 测试数据
			/*var data:MSG_UPDATE_ARENA_ACK = new MSG_UPDATE_ARENA_ACK();
			data.star = 3;
			data.level = 13;
			data.round = 2;
			
			var b1:PRO_PlayerBase = new PRO_PlayerBase();
			b1.name = "哼哼";
			b1.power = 10000;
			
			var b2:PRO_PlayerBase = new PRO_PlayerBase();
			b2.name = "哈哈";
			b2.power = 20000;
			
			data.target = [b1,b2];
			
			var log:PRO_ArenaLog = new PRO_ArenaLog();
			log.base = b1;
			log.win = true;
			log.time = 10000000;
			
			var log2:PRO_ArenaLog = new PRO_ArenaLog();
			log2.base = b2;
			log2.win = false;
			log2.time = 10000000;
			
			data.logs = [log , log2];
			this.updateUI(data);*/
		}
		
		
		
		
		
		
		
		
		/**
		 * 更新面板信息
		 * */
		public function updateUI(data:MSG_UPDATE_ARENA_ACK):void
		{
			// 保存此次数据
			ArenaModel.inst.data = data;
			
			// 铜钱元宝
			var playExtraInfo:PRO_PlayerExtra = GameData.inst.playerExtraInfo;
			moneyLabel.text = playExtraInfo.coin + "";
			goldLabel.text = playExtraInfo.gold + "";
			
			// tips
			goldPanel.hint = "元宝：" + playExtraInfo.gold;
			moneyPanel.hint = "铜钱：" + playExtraInfo.coin;
			
			// 战力
			powerLabel.update(BitmapNumber.WINDOW_S_YELLOW , GameData.inst.roleInfo.base.power + "");
			
			ticketLabel.text = data.freeNum + "/3";
			winLabel.text = data.totalWinNum + "";
			
			figurePanel.update(data.target);
			levelPanel.update(data.star , data.level , data.rank);
			
			// 门票刷新倒计时
			tick.clear();
			timeLabel.text = "";
			
			// 少于三张门票才需要显示刷新时间
			if(data.freeNum < 3)
			{
				var time:Number = data.nextRefreshTime - int(TimeTick.inst.getCurrentTime()*0.001);
				if(time > 0)
				{
					tick.addListener(new TimeTickData(time , 1000 , updateTime , endTime));
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 更新倒计时
		 * */
		private function updateTime(data:TimeTickData):void
		{
			timeLabel.text = Time.getStringTime1(int(data.remainTime*0.001)) + "后恢复";
		}
		
		
		
		
		
		/**
		 * 倒计时结束
		 * */
		private function endTime(data:TimeTickData):void
		{
			timeLabel.text = "";
			
			//重新请求数据
			this.arenaInfo();
		}
		
		
		
		
		
		
		/**
		 * 查看英雄榜
		 * */
		private function onRankClick(e:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.ARENA_RANK_WINDOW);
		}
		
		
		
		
		
		/**
		 * 查看战报
		 * */
		private function onBattleReportClick(e:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.ARENA_BATTLE_REPORT_WINDOW);
		}
		
		
		
		
		
		/**
		 * 退出
		 * */
		private function onQuitClick(e:MouseEvent):void
		{
			this.close();
		}
		
		
		
		
		
		
		
		/**
		 * resize
		 * */
		private function resize(e:Event = null):void
		{
			if(stage)
			{
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				// 背景图
				bg.x = (w/1920 - 1) * 960;
				bg.y = (h/1080 - 1) * 633;
				
				// 右上按钮
				rankBtn.x = w - 373;
				rankBtn.y = 15;
				
				battleReportBtn.x = w - 303;
				battleReportBtn.y = 15;
				
				quitBtn.x = w - 236;
				quitBtn.y = 15;
				
				// 右上等级面板
				levelPanel.x = w - 182;
				
				// 中间人物层
				figurePanel.x = w >> 1;
				figurePanel.y = h * 0.586;
			}
			
		}
		
		
		
		
		
		
		
		/** ================================================== ↓接口 =========================================================*/
		
		
		
		
		
		
		/**
		 * 获取面板信息
		 * */
		private function arenaInfo():void
		{
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_INFO));
		}
		
		
		
		
		
		
		/**
		 * 开始竞技
		 * */
		private function arenaStartFight(e:MouseEvent):void
		{
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_START_FIGHT));
		}
		
		
		
		
		
		
		
		/**
		 * 购买门票
		 * */
		private function arenaBuyTicket(e:MouseEvent):void
		{
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_BUY_TICKET));
		}
		
		
		
		
		
		
		
		/** ================================================== ↑接口 =========================================================*/
		
		
		
		
		
		
		
		
		
		
		/**
		 * 关闭窗口
		 * */
		private function close():void
		{	
			stage.removeEventListener(Event.RESIZE , resize);
			
			battleReportBtn.removeEventListener(MouseEvent.CLICK , onBattleReportClick);
			rankBtn.removeEventListener(MouseEvent.CLICK , onRankClick);
			quitBtn.removeEventListener(MouseEvent.CLICK , onQuitClick);
			
			this.clear();
			
			// 关闭其他关联窗口
			WindowManager.inst.closeGeneralWindow(ArenaBattleReportWindow);
			
			this.dispatchEvent(new WindowEvent(WindowEvent.HIDE_FULLSCREEN_VIEW , WindowEvent.ARENA_WINDOW));
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			bg.bitmapData = null;
			
			timeLabel.text = "";
			tick.clear();
			
			moneyPanel.hint = "";
			goldPanel.hint = "";
			
			figurePanel.clear();
			GameRenderCenter.instance.clearData(BattleConfig.LEADER_FIGURE_URL);
		}
	}
}