package
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.SXD2MainEvent;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.exampleGUI.ExampleWindow;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.logging.PBEConsoleLogTarget;
	import com.gamehero.sxd2.manager.JSManager;
	import com.gamehero.sxd2.manager.Js2AsManager;
	import com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_REQ;
	import com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_REQ;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.robotlegs.AppConfigMain;
	import com.gamehero.sxd2.robotlegs.MVCSBundle;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.HurdleMap.HurdleSceneView;
	import com.gamehero.sxd2.world.globolMap.GlobalSceneView;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.sceneMap.SceneView;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.netease.protobuf.UInt64;
	import com.pblabs.PBE;
	import com.pblabs.debug.Console;
	import com.pblabs.input.KeyboardManager;
	import com.pblabs.property.PropertyManager;
	import com.pblabs.time.TimeManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import alternativa.gui.mouse.CursorDelay;
	import alternativa.gui.mouse.CursorManager;
	import alternativa.gui.mouse.MouseManager;
	import alternativa.gui.theme.defaulttheme.skin.Cursors;
	
	import bowser.logging.Logger;
	import bowser.utils.time.TimeTick;
	import bowser.utils.time.TimeTickEvent;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	
	
	/**
	 * 游戏主模块
	 * @author xuwenyi
	 * @create 2013-07-26
	 **/
	public class SXD2Main extends Sprite
	{
		include "SceneLogic.as";
		
		// View UI
		private var viewUI:Sprite;
		
		// 地图类视图列表
		private var sceneView:SceneView;						// 普通场景视图
		private var hurdleMapView:HurdleSceneView;				// 关卡场景
		private var golbalMapView:GlobalSceneView				// 世界地图
		public var currentView:SceneViewBase;					//当前场景
		
		// 战斗视图
		private var battleView:BattleView;						// 战斗场景视图
		
		// 全屏玩法类视图
		private var fullScreenView:Sprite;
		
		// 全局GameHint 		
		private var _gameHint:GameHint;
		
		private var _mapModel:MapModel;
		
		
		
		
		static private var _instance:SXD2Main;
		/**
		 * 获取单例
		 * */
		static public function get inst():SXD2Main {
			
			return _instance;
		}
		
		/**
		 * 构造函数
		 */
		public function SXD2Main()
		{
			_instance = this;
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
		}
		
		
		
		
		
		/**
		 * Add to Stage Handler 
		 */
		private function onAddToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			// Set 24 fps
			stage.frameRate = 24;
			
			// 请求用户信息
			GameProxy.inst.enterGame(this.initGame);
		}
			
		
		
		
		
		
		/**
		 * 初始化游戏 
		 */
		private function initGame():void
		{
			/** TRICKEY: 不设置会导致DragDrop出问题 */
			this.mouseEnabled = false;
			this.tabEnabled = false;
			
			/**  不允许使用输入法 */
			IME.enabled = false;
			// 焦点事件
			stage.addEventListener(MouseEvent.CLICK , onStageClick);
			
			/** 先用客户端的时间作为标准时间 */
			// 等validate之后向服务器端获取当前时间
			TimeTick.inst.setClientTime(new Date().getTime()*0.001);
			// 监听时间异常事件
			TimeTick.inst.addEventListener(TimeTickEvent.ON_TIME_EXCEPTION_E , onTimeException);
			
			// 注册js调用as的方法
			ExternalInterface.addCallback("leaveGame" , Js2AsManager.leaveGame);
			

			/** DEBUG Stats */
			CONFIG::DEBUG 
			{
				if(JSManager.isDebug()) 
				{
					// Init PBE2
					PBE._rootGroup.registerManager(Stage, stage);
					PBE._rootGroup.registerManager(PropertyManager, new PropertyManager());
					PBE._rootGroup.registerManager(TimeManager, new TimeManager());
					PBE._rootGroup.registerManager(KeyboardManager, new KeyboardManager());
					PBE._rootGroup.registerManager(Console, new Console());
					
					// 添加PBE Console为LogTarget
					Logger.addLogTarget(new PBEConsoleLogTarget());
				}
			}
			
			
			/** 初始化GameSettings */
			GameSettings.instance.init();
			
			/** robotelegs注册游戏模块相关类 */
			this.initRobotlegs();
			
			/** 初始化皮肤 */
			MainSkin.init(App.mainUIRes);
			
			/** 初始化视图层 */
			CursorDelay.SHOW_HINT_DELAY = 100;	// 设置显示hint的时间
			CursorDelay.HINT_TIMEOUT = 0;		// 设置hint消失的时间
			_gameHint = new GameHint();
			MouseManager.setHintImaging(App.hintUI, _gameHint);
			
			// CursorManager initialization
			CursorManager.init(Cursors.createCursors());
			
			/** 场景层(最低) */
			viewUI = new Sprite();
			this.addChildAt(viewUI, 0);

			/** 主UI层 */
			var ui:DisplayObjectContainer = App.ui;
			// 将MainUI添加到场景
			ui.addChild(MainUI.inst);
			
			/** 弹出窗口层 */
			// Init Window UI---窗口UI层必须保证在最上层
			ui.addChild(App.windowUI);
			/** UI最顶层 */
			
			App.topUI.addChild(NoticeUI.inst);
			ui.addChild(App.topUI);
			
			/** 调试开关 */
			stage.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			// UI Resize Add Listener
			stage.addEventListener(Event.RESIZE, resize);
			this.resize();
			// TRICKY:打开帧频开关
			//FPSSwitch.isOpen = true;
			
			_mapModel = MapModel.inst;

			/* Comment by Trey, 新的处理方式进入游戏后Server主动发送进入地图(0x1101)消息，不用客户端再发送
			// 临时 显示场景地图
			enterMap(GameData.inst.mapInfo);
			*/
		}
		
		
		
		
		
		/**
		 * 进入地图
		 * */
		public function enterMap(mapInfo:PRO_Map):void
		{
//			dispatchEvent(new SXD2MainEvent(SXD2MainEvent.LEAVE_MAP,mapInfo));
			dispatchEvent(new SXD2MainEvent(SXD2MainEvent.ENTER_MAP,mapInfo));
		}
		
		
		
		
		/**
		 * 发起一场战斗
		 */
		public function createBattle(battleId:int , playerID:UInt64 = null):void
		{
			if(GameData.inst.isBattle == false)
			{
				GameData.inst.isBattle = true;
				
				var req:MSG_BATTLE_CREATE_REQ = new MSG_BATTLE_CREATE_REQ();
				req.battleId = battleId;
				req.playerId = playerID;
				this.dispatchEvent(new SXD2MainEvent(SXD2MainEvent.BATTLE_CREATE , req));
			}
		}
		
		
		
		
		/**
		 * 观看一场战斗录像
		 */
		public function battleReport(reportId:UInt64):void
		{
			var req:MSG_BATTLE_REPORT_REQ = new MSG_BATTLE_REPORT_REQ();
			req.reportId = reportId;
			this.dispatchEvent(new SXD2MainEvent(SXD2MainEvent.BATTLE_REPORT , req));
		}
		
		
		
		
		/**
		 * Stage Resize Handler 
		 */
		private function resize(e:Event = null):void
		{	
			var w:int = Math.min(stage.stageWidth , MapConfig.STAGE_MAX_WIDTH);
			var h:int = Math.min(stage.stageHeight , MapConfig.STAGE_MAX_HEIGHT);
			
			App.ui.width = App.windowUI.width = w;
			App.ui.height = App.windowUI.height = h;
			
			if(e)
			{	
				App.ui.dispatchEvent(e.clone());
			}
		}
		
		
		
		
		
		/**
		 * Robotelegs初始化
		 */
		private function initRobotlegs():void
		{
			// robotlegs
			var context:Context = new Context();
			context.install(MVCSBundle);
			context.configure(AppConfigMain);
			context.configure(new ContextView(this));
			context.injector.map(SXD2Main).toValue(this);
		}
		
		
		
		
		
		
		/**
		 * 焦点事件
		 */
		private function onStageClick(e:MouseEvent):void
		{
			var target:Object = e.target;
			
			// 点击文本框或表情框需要开启输入法
			if(target is TextField)
			{
				IME.enabled = true;
			}
			else
			{
				IME.enabled = false;
			}
		}
		
		
		
		

		/**
		 * 加速外挂检测
		 */
		private function onTimeException(e:TimeTickEvent):void
		{
			// 记录日志
			var data:Object = e.data;
			if(data)
			{
				//ClientLog.debug("TIME_ERR:"+data.clientTime+","+data.serverTime+","+data.lastServerTime+","+data.intertime);
				Logger.error(SXD2Main , "系统时间异常 --- clientTime:" 
					+ data.clientTime 
					+ ",serverTime:" + data.serverTime 
					+ ",lastServTime:" + data.lastServerTime
					+ ",intertime:" + data.intertime);
			}
			
			// 断开连接
			setTimeout(function():void
			{
				GameService.instance.disconnect();
			},1);
			
			//DialogManager.inst.show("", "系统时间出现异常了", GlobalAlert.OK, refreshGame);
			
			function refreshGame():void
			{
				JSManager.refreshGame();
			}
		}
		
		
		
		
		
		
		////////////////////////////////////////////////////////// 测试 //////////////////////////////////////////////////////////
		/**
		 * 快捷键
		 */
		private function onKeyDown(e:KeyboardEvent):void
		{
			// 测试窗口
			/*if(e.ctrlKey && e.shiftKey && e.keyCode == Keyboard.ENTER) {
				
				DebugWindow.inst.show();				
				
				return;
			}*/
			
			
			CONFIG::DEBUG 
			{
				if(JSManager.isDebug()) {
					
					// Ctrl作为测试键标志
					if(e.ctrlKey && e.shiftKey) {
						
						// 测试战斗
						if(e.keyCode == Keyboard.F2)
						{
							//DramaManager.inst.playDrama(1001);
							MainUI.inst.openWindow(WindowEvent.ARENA_WINDOW);
						}
						// 测试
						if(e.keyCode == Keyboard.F3)
						{
							this.createBattle(1);
						}
						// 测试
						if(e.keyCode == Keyboard.F4)
						{
							this.createBattle(2);
						}
						// 测试
						if(e.keyCode == Keyboard.F5)
						{
							this.createBattle(3);
						}
					}
					else if(e.keyCode == Keyboard.E && e.shiftKey)
					{
						WindowManager.inst.openWindow(ExampleWindow, WindowPostion.CENTER_LEFT, false, true, true);
					}
				}
			}
		}
		
	}
}

