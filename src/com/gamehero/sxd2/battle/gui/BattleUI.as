package com.gamehero.sxd2.battle.gui
{
    import com.gamehero.sxd2.battle.BattleView;
    import com.gamehero.sxd2.battle.data.BattleConfig;
    import com.gamehero.sxd2.battle.data.BattleDataCenter;
    import com.gamehero.sxd2.battle.display.BPlayer;
    import com.gamehero.sxd2.core.GameConfig;
    import com.gamehero.sxd2.core.Global;
    import com.gamehero.sxd2.event.BattleEvent;
    import com.gamehero.sxd2.event.BattleUIEvent;
    import com.gamehero.sxd2.gui.SButton;
    import com.gamehero.sxd2.gui.progress.BattleLoadingUI;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
    import com.gamehero.sxd2.manager.BattleUnitManager;
    import com.gamehero.sxd2.manager.MonsterManager;
    import com.gamehero.sxd2.pro.PRO_BattlePlayer;
    import com.gamehero.sxd2.pro.PRO_PlayerBase;
    import com.gamehero.sxd2.vo.MonsterVO;
    import com.greensock.TweenLite;
    
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.system.ApplicationDomain;
    import flash.utils.setTimeout;
    
    import bowser.loader.BulkLoaderSingleton;
    
    import br.com.stimuli.loading.BulkLoader;
    import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	
	/**
	 * 战斗中的UI层
	 * @author xuwenyi
	 * @create 2013-08-09
	 **/
	public class BattleUI extends Sprite
	{	
		// 固定需要加载的资源数(UI,地图,2个主角上阵特效)
		private static const LOAD_ITEM_NUM:int = 4;
		
		
		// 资源
		private var resource:MovieClip;
		private var domain:ApplicationDomain;
		
		// 战斗ui资源地址
		private var UI_RES:String;
		
		// 加载状态
		private var loadTotal:int;
		private var loadStatus:int;
		// 预加载人物资源url
		private var playersUrl:Array = [];
		
		// 战斗主视图
		private var view:BattleView;
		// 战斗数据
		private var dataCenter:BattleDataCenter;
		// 是否已初始化UI
		public var hasInited:Boolean = false;
		// 是否播放过全屏泛红(上一次的主角血量)
		private var lastLeaderHP:int = 99999999;
		
		// 左上角组件
		private var roundPanel:BattleRoundPanel;
		
		// 战斗加速面板
		private var speedUpPanel:BattleSpeedUpPanel;
		
		// 跳过战斗按钮
		private var passBtn:SButton;
		
		// boss头像血条组件
		private var bossBloodBar:BattleBossBloodBar;
		// boss buff组件
		//private var bossBuffBar:BattleBuffBar;
		
		// 波数显示
		//private var boshuUI:BattleBoshuUI;
		// 角色tips组件
		public var tips:BattleRoleTips;
		// 聊天面板
		private var chatView:DisplayObject;
		
		
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleUI(view:BattleView)
		{
			UI_RES = GameConfig.GUI_URL + "BattleUI.swf";
			
			// 主视图
			this.view = view;
			// 战斗数据
			this.dataCenter = BattleDataCenter.instance;
			
			// 头像血条组件
			bossBloodBar = new BattleBossBloodBar();
			this.addChild(bossBloodBar);
			
			// 左上角组件
			roundPanel = new BattleRoundPanel();
			this.addChild(roundPanel);
			
			// 右下角的按钮
			speedUpPanel = new BattleSpeedUpPanel();
			this.addChild(speedUpPanel);
			
			// 波数组件
			/*boshuUI = new BattleBoshuUI();
			boshuUI.visible = false;
			this.addChild(boshuUI);*/
			
			// buff组件
			/*
			bossBuffBar = new BattleBuffBar();
			bossBuffBar.face = 1;
			bossBuffBar.limit = 8;
			this.addChild(bossBuffBar);*/
			
			// 人物tips
			tips = new BattleRoleTips();
		}
		
		
		
		
		
		
		
		
		/**
		 * 开始加载
		 * */
		public function load(playersUrl:Array):void
		{
			this.playersUrl = playersUrl;
			
			// 加载状态(剩余未加载完的item数量)
			loadTotal = LOAD_ITEM_NUM + playersUrl.length;
			loadStatus = loadTotal;
			
			// 先暂停所有加载
			BulkLoader.pauseAllLoaders();
			
			// 加载进度UI
			BattleLoadingUI.inst.percent = 0;
			BattleLoadingUI.inst.show();
			
			// 加载UI资源
			var loader:BulkLoaderSingleton = dataCenter.loader;
			loader.addWithListener(UI_RES , {priority:GameConfig.HIGHEST_LOAD_PRIORITY} , onLoaded , onProgress);
			loader.start();
		}
		
		
		
		
		/**
		 * 加载中
		 * */
		private function onProgress(e:ProgressEvent):void
		{
			var rate:Number = 100/loadTotal;
			var d:int = loadTotal - loadStatus;
			
			// 进度(每一个资源都会均分一个百分比)
			var progress:Number = e.bytesLoaded / e.bytesTotal;
			progress = rate * (d + progress);
			
			BattleLoadingUI.inst.updateProgress(Math.floor(progress));
		}
		
		
		
		
		/**
		 * 加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			// 移除事件
			var imageItem:LoadingItem = e.currentTarget as LoadingItem;
			imageItem.removeEventListener(Event.COMPLETE, onLoaded);
			imageItem.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			imageItem.removeEventListener(ErrorEvent.ERROR, onLoaded);
			
			// 状态-1
			loadStatus--;
			var loader:BulkLoaderSingleton = dataCenter.loader;
			
			// 继续加载战斗地图
			if(loadStatus == loadTotal - 1)
			{	
				// 保存UI资源
				if(resource == null)
				{
					resource = imageItem.content;
				}
				
				var battleID:int = dataCenter.battleID;
				var mapid:String = BattleUnitManager.inst.getMapID(battleID);
				// 战斗地图
				var bgURL:String = GameConfig.BATTLE_URL + "maps/" + mapid + ".swf";
				loader.addWithListener(bgURL , {priority:GameConfig.HIGHEST_LOAD_PRIORITY} , onLoaded , onProgress , onLoaded);
			}
			// 继续加载主角上阵特效1
			else if(loadStatus == loadTotal - 2)
			{
				loader.addWithListener(BattleConfig.LEADER_OPENING1 + ".swf" , {priority:GameConfig.HIGHEST_LOAD_PRIORITY} , onLoaded , onProgress , onLoaded);
			}
			// 继续加载主角上阵特效2
			else if(loadStatus == loadTotal - 3)
			{
				loader.addWithListener(BattleConfig.LEADER_OPENING2 + ".swf" , {priority:GameConfig.HIGHEST_LOAD_PRIORITY} , onLoaded , onProgress , onLoaded);
			}
			// 继续加载人物资源
			else if(loadStatus <= loadTotal - 4 && playersUrl.length > 0)
			{
				var figureURL:String = playersUrl.shift();
				loader.addWithListener(figureURL + ".swf" , {priority:GameConfig.HIGHEST_LOAD_PRIORITY} , onLoaded , onProgress , onLoaded);
			}
			// 全部加载完成,显示UI
			else
			{
				this.showUI();
			}
		}
		
		
		
		
		
		/**
		 * 开始显示UI
		 * */
		private function showUI():void
		{
			// 隐藏loading
			BattleLoadingUI.inst.hide();
			
			if(resource)
			{
				domain = resource.loaderInfo.applicationDomain;
				
				// 保存在战斗皮肤中
				BattleSkin.init(domain);
				
				// 固定UI布局
				this.initUI();
				
				// 通知BattleView战斗UI资源加载完成
				this.dispatchEvent(new BattleUIEvent(BattleUIEvent.LOADED));
				
				// 显示地图名(需要调用过resize后确定屏幕尺寸,所以必须在事件派发之后调用)
				this.showMapName();
			}
		}
		
		
		
		
		
		/**
		 * 固定UI布局
		 * */
		private function initUI():void
		{
			// 只执行一次
			if(hasInited == false)
			{
				var global:Global = Global.instance;
				
				// 左上角组件
				roundPanel.initUI();
				
				// boss头像血条
				bossBloodBar.initUI();
				
				// 波数组件
				//boshuUI.init(global.getClass(domain , "BOSHU_FIRE"));
				
				// 加速面板
				speedUpPanel.initUI();
				
				// 跳过战斗按钮
				passBtn = new SButton(BattleSkin.PASS_BTN);
				this.addChild(passBtn);
			}
			
			/** ==== 以下每次进战斗都要执行 ==== */
			
			// 加速面板
			speedUpPanel.init(dataCenter.playSpeed);
			speedUpPanel.addEventListener(BattleEvent.BATTLE_SPEED_UP_CLICK , speedup);
			
			// 跳过战斗按钮
			passBtn.addEventListener(MouseEvent.CLICK , pass);
			
			// 聊天模块
			if(dataCenter.inGame == true)
			{
				chatView = dataCenter.chatView;
				this.addChild(chatView);
			}
			
			// 改变标志
			hasInited = true;
		}
		
		
		
		
		
		
		
		
		
		/**
		 * 更新UI
		 * */
		public function update():void
		{
			// 回合数
			this.updateRound(1);
			
			// 是否有boss
			var boss:BPlayer = dataCenter.boss; 
			if(boss != null)
			{
				this.updateBossHP();
			}
		}
		
		
		
		
		
		/**
		 * 是否显示BOSS UI
		 * */
		public function showBossUI():void
		{
			// 是否有boss
			var boss:BPlayer = dataCenter.boss;
			if(boss)// 波数UI没有显示
			{
				var role:PRO_BattlePlayer = boss.role;
				var base:PRO_PlayerBase = role.base;
				if(base.hp > 0)
				{
					// 显示BOSS的信息(头像,名字,等级等)
					var monsterVO:MonsterVO = MonsterManager.instance.getMonsterByID(base.id.toString());
					bossBloodBar.initBossInfo(monsterVO);
					// BOSS等级(若有)
					if(base.level > 0)
					{
						
					}
					// BOSS血量
					var rate:Number = base.hp/base.maxhp;
					bossBloodBar.update(rate);
					bossBloodBar.visible = true;
					//bossBuffBar.visible = true;
				}
				else
				{
					bossBloodBar.visible = false;
					//bossBuffBar.visible = false;
				}
			}
			else
			{
				bossBloodBar.visible = false;
				//bossBuffBar.visible = false;
			}
		}
		
		
		
		
		/**
		 * 更新boss HP
		 * */
		public function updateBossHP():void
		{
			// boss数据
			var boss:BPlayer = dataCenter.boss;
			var role:PRO_BattlePlayer = boss.role;
			var base:PRO_PlayerBase = role.base;
			// BOSS血量
			if(base.hp > 0)
			{
				bossBloodBar.update(base.hp/base.maxhp);
			}
			else
			{
				bossBloodBar.visible = false;
				//bossBuffBar.visible = false;
			}
		}
		
		
		
		
		/**
		 * 更新BOSS BUFF状态
		 * */
		public function updateBossBuff():void
		{
			var boss:BPlayer = dataCenter.boss;
			var buffs:Array = boss.buffs;
			//bossBuffBar.update(buffs);
		}
		
		
		
		
		/**
		 * 更新波数
		 * */
		public function updateBoshu(curBoshu:int):void
		{
			// 波数最小为1
			/*var boshu:int = Math.max(curBoshu , 1);
			
			// 非保卫长城战斗
			if(dataCenter.battleType != GS_BattleType_Pro.BATTLE_WALL)
			{
				var boshuRemain:int = dataCenter.battleBoshu - boshu;
				if(boshuRemain >= 1 && dataCenter.boss == null)
				{
					boshuUI.update(boshu , dataCenter.battleBoshu);
					boshuUI.visible = true;
				}
				else
				{
					boshuUI.visible = false;
				}
			}
			else
			{
				boshuUI.visible = false;
			}*/
		}
		
		
		
		
		
		/**
		 * 更新当前回合数
		 * */
		public function updateRound(round:int):void
		{
			roundPanel.updateRound(round);
		}
		
		
		
		
		
		/**
		 * 显示地图名飘字
		 * */
		public function showMapName():void
		{
			var mapNameURL:String = BattleUnitManager.inst.getMapName(dataCenter.battleID);
			if(mapNameURL != "")
			{
				var mapName:BattleMapName = new BattleMapName();
				if(stage)
				{
					mapName.x = this.width >> 1;
					mapName.y = this.height * 0.18;
				}
				mapName.play(mapNameURL);
				this.addChild(mapName);
			}
		}
		
		
		
		
		
		
		/**
		 * 显示pvp对战开场动画
		 * */
		public function showPvpOpening(base1:PRO_PlayerBase , base2:PRO_PlayerBase):void
		{
			var mc:MovieClip = new BattleSkin.PVP_OPENING() as MovieClip;
			mc.x = width >> 1;
			mc.y = height >> 1;
			mc.gotoAndPlay(0);
			this.addChild(mc);
			setTimeout(over , 1650);
			
			// 人物数据
			mc.name1._text.text = base1.name;
			mc.shengwang1._text.text = "声望：";
			mc.level1._text.text = "等级：" + base1.level;
			mc.power1._text.text = "战力：" + base1.power;
			
			mc.name2._text.text = base2.name;
			mc.shengwang2._text.text = "声望：";
			mc.level2._text.text = "等级：" + base2.level;
			mc.power2._text.text = "战力：" + base2.power;
			
			// 人物头像
			var head1:Bitmap = new Bitmap(Global.instance.getBD(domain , "LEADER_HEAD"));
			head1.x = -812;
			head1.y = -382;
			head1.alpha = 0;
			mc.addChild(head1);
			var head2:Bitmap = new Bitmap(Global.instance.getBD(domain , "LEADER_HEAD"));
			head2.x = 812;
			head2.y = -382;
			head2.scaleX = -1;
			head2.alpha = 0;
			mc.addChild(head2);
			
			TweenLite.to(head1 , 0.2 , {x:"100",alpha:1,delay:0.15});
			TweenLite.to(head2 , 0.2 , {x:"-100",alpha:1,delay:0.15});
			
			function over():void
			{
				mc.stop();
				removeChild(mc);
			}
		}
		
		
		
		
		
		
		/**
		 * 显示技能飘字
		 * */
		/*public function showSkillText(skill:BattleSkill):void
		{
			var sktext:BattleSkText = new BattleSkText();
			if(stage)
			{
				sktext.x = stage.stageWidth >> 1;
				sktext.y = stage.stageHeight * 0.25 + 100;
			}
			sktext.play(skill);
			this.addChild(sktext);
		}*/
		
		
		
		
		
		
		
		/**
		 * 战斗加速
		 * */
		private function speedup(e:BattleEvent):void
		{
			var speed:Number = e.data as Number;
			view.savePlaySpeed(speed);
		}
		
		
		
		
		
		
		
		/**
		 * 跳过战斗
		 * */
		private function pass(e:MouseEvent):void
		{
			view.pass();
		}
		
		
		
		
		
		
		
		
		/**
		 * 自适应
		 * */
		public function resize(w:int , h:int):void
		{
			// 重新布局
			bossBloodBar.x = w - 500;
			speedUpPanel.x = w - 322;
			speedUpPanel.y = h - 55;
			passBtn.x = w - 153;
			passBtn.y = speedUpPanel.y;
			
			// 聊天面板
			if(chatView)
			{
				chatView.x = 0;
				chatView.y = h - 200;
			}
			
			this.width = w;
			this.height = h;
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{	
			// clear
			loadTotal = 0;
			loadStatus = 0;
			playersUrl = [];
			
			roundPanel.clear();
			bossBloodBar.clear();
			speedUpPanel.clear();
			
			speedUpPanel.removeEventListener(BattleEvent.BATTLE_SPEED_UP_CLICK , speedup);
			passBtn.removeEventListener(MouseEvent.CLICK , pass);
			
			if(tips && this.contains(tips) == true)
			{
				this.removeChild(tips);
			}
			if(chatView && this.contains(chatView) == true)
			{
				this.removeChild(chatView);
			}
			
			chatView = null;
			
			// clear
			/*leaderBuffBar.clear();
			bossBuffBar.clear();
			skillBar.clear();
			angerBall.clear();
			boshuUI.clear();
			
			// 关闭自动战斗引导
			this.stopAutoFightGuide();
			
			// 加载状态
			loadTotal = 0;
			loadStatus = 0;
			playersUrl = [];
			// 上一次的主角血量(全屏泛红效果用)
			lastLeaderHP = 99999999;
			
			chatPanel = null;
			hurdleNotePanel = null;
			boshuUI.visible = false;
			skillBar.visible = true;
			angerBall.visible = true;
			autoFightBtnPanel.hint = "";
			autoFightBtnPanel.visible = true;
			passBtn.visible = false;
			escapeBtnPanel.visible = false;
			restartBtnPanel.visible = false;
			watchReplayText.gotoAndStop(0);
			watchReplayText.visible = false;
			*/
		}
		
	}
}