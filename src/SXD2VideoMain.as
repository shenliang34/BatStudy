package
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.core.URI;
	import com.gamehero.sxd2.gui.theme.ifstheme.Gametheme;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.VideoHint;
	import com.gamehero.sxd2.pro.PRO_BattleDetail;
	import com.gamehero.sxd2.robotlegs.AppConfigVideo;
	import com.gamehero.sxd2.robotlegs.MVCSBundle;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	
	import alternativa.gui.layout.LayoutManager;
	import alternativa.gui.mouse.CursorDelay;
	import alternativa.gui.mouse.CursorManager;
	import alternativa.gui.mouse.MouseManager;
	import alternativa.gui.theme.defaulttheme.skin.Cursors;
	import alternativa.init.GUI;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.remote.RemoteHttp;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	
	
	/**
	 * 战斗录像入口
	 * @author xuwenyi
	 * @create 2015-09-01
	 **/
	[SWF(frameRate="24", backgroundColor="#0")]
	public class SXD2VideoMain extends Sprite
	{
		// Hash XML 文件
		[Embed(source="/assetsembed/xml/hashes.xml",mimeType="application/octet-stream")]
		private var hashXmlClass:Class;
		
		// 主UI
		private var MAIN_UI_URL:String;
		// 配置表url
		private var SETTINGS_URL:String;
		
		// 游戏加载状态(1:主游戏,2:ui资源,3:配置表)
		private var loadStatus:int = 0;
		
		// View UI
		private var viewUI:Sprite;
		// 视图列表
		private var battleView:BattleView;	// 战斗场景视图
		
		
		/**
		 * 构造函数
		 * */
		public function SXD2VideoMain()
		{
			this.addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
		}
		
		
		
		
		/**
		 * Add to Stage Handler 
		 */
		private function onAddToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			/** TRICKEY: 不设置会导致DragDrop出问题 */
			this.mouseEnabled = false;
			this.tabEnabled = false;
			
			/** 右键菜单 */
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			this.contextMenu.builtInItems.quality = true;
			
			/** 客户端版本号 */
			Version.CV = int(Version.CLIENT_VERSION.replace("/", ""));
			this.contextMenu.customItems.push(new ContextMenuItem("Client: " + Version.CV));
			
			/** 初始化hash配置（必须放在所有加载之前）*/
			BulkLoaderSingleton.init(XML(new hashXmlClass()), URI.cdn);
			hashXmlClass = null;
			
			// 开始加载MainUI和配置表
			MAIN_UI_URL = GameConfig.GUI_URL + "MainUI.swf";
			SETTINGS_URL = GameConfig.RESOURCE_URL + "xml/settings.gh";
			this.load();
		}
		
		
		
		
		
		/**
		 * 初始化游戏 
		 */
		private function initGame():void
		{
			/** 初始化GameSettings */
			GameSettings.instance.init();
			
			/** robotelegs注册游戏模块相关类 */
			this.initRobotlegs();
			
			/** 初始化皮肤 */
			MainSkin.init(App.mainUIRes);
			
			// 初始化UI框架
			this.initGUI();
			
			/** 场景层(最低) */
			viewUI = new Sprite();
			this.addChildAt(viewUI, 0);
			
			stage.addEventListener(Event.RESIZE, resize);
			this.resize();
			
			// 战斗视图
			BattleDataCenter.instance.inGame = false;
			var battleView:BattleView = new BattleView();
			viewUI.addChild(battleView);
			
			// 战报地址
			var reportURL:String = ExternalInterface.call("getReportURL");
			if(reportURL == null)
			{
				reportURL = "http://10.1.29.86/sxd2/beta/sxd2_get_report.php?zoneid=1&blid=2";
			}
			new RemoteHttp(reportURL , URLLoaderDataFormat.BINARY , null , callback);
			
			function callback(data:Object):void
			{
				var bytes:ByteArray = data as ByteArray;
				var detail:PRO_BattleDetail = new PRO_BattleDetail();
				detail.mergeFrom(bytes);
				BattleDataCenter.instance.saveDetailInfo(detail);
				
				// 进入战斗
				battleView.newGame();
			}
		}
		
		
		
		
		
		/**
		 * alternativaGUI 框架初始化
		 */
		private function initGUI():void
		{
			// Container with objects
			App.ui.mouseEnabled = false;
			App.ui.tabEnabled = false;
			addChild(App.ui);
			
			/** 主UI层 */
			var ui:DisplayObjectContainer = App.ui;
			/** 弹出窗口层 */
			// Init Window UI---窗口UI层必须保证在最上层
			ui.addChild(App.windowUI);
			/** UI最顶层 */
			ui.addChild(App.topUI);
			
			// Hint container
			App.hintUI.mouseEnabled = false;
			App.hintUI.tabEnabled = false;
			addChild(App.hintUI);
			
			// AlternativaGUIDefaultTheme initialization
			Gametheme.init();	
			
			// AlternativaGUI initialization
			GUI.init(stage, false);
			
			// LayoutManager initialization
			LayoutManager.init(stage, [App.ui, App.hintUI]);
			
			// Set Stage
			App.stage = stage;
			
			// 鼠标相关
			CursorDelay.SHOW_HINT_DELAY = 100;	// 设置显示hint的时间
			CursorDelay.HINT_TIMEOUT = 0;		// 设置hint消失的时间
			MouseManager.setHintImaging(App.hintUI, new VideoHint());
			// CursorManager initialization
			CursorManager.init(Cursors.createCursors());
		}
		
		
		
		
		
		/**
		 * Robotelegs初始化
		 */
		private function initRobotlegs():void
		{
			// robotlegs
			var context:Context = new Context();
			context.install(MVCSBundle);
			context.configure(AppConfigVideo);
			context.configure(new ContextView(this));
			context.injector.map(SXD2VideoMain).toValue(this);
		}
		
		
		
		
		
		/**
		 * 加载Loading素材完成
		 */
		private function load(loadStatus = 1):void
		{
			this.loadStatus = loadStatus;
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			switch(loadStatus)
			{
				// 加载UI资源
				case 1:
					loader.addWithListener(MAIN_UI_URL , null , onLoadComplete , onLoadProgress);
					break;
				
				// 加载配置表
				case 2:
					loader.addWithListener(SETTINGS_URL , { type:BulkLoader.TYPE_BINARY} , onLoadComplete , onLoadProgress);
					break;
				
			}
		}
		
		
		
		
		
		
		/**
		 * 显示主游戏界面
		 * 
		 */
		private function onLoadComplete(e:Event):void
		{
			var loadingItem:LoadingItem = e.currentTarget as LoadingItem;
			
			// 移除事件
			loadingItem.removeEventListener(Event.COMPLETE , onLoadComplete);
			loadingItem.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			switch(loadStatus)
			{
				// 保存UI资源
				case 1:
					App.mainUIRes = ImageItem(loadingItem).content;
					break;
				
				// 保存配置表
				case 2:
					App.settingsBinary = ByteArray(loadingItem.content);
					break;
			}
			
			// 加载下一个资源
			loadStatus++;
			
			if(loadStatus <= 2)
			{
				// 继续加载
				this.load(loadStatus);
			}
			else
			{
				// 显示主游戏
				this.initGame();
			}
		}
		
		
		
		
		
		/**
		 * 加载进度
		 */
		private function onLoadProgress(e:ProgressEvent):void
		{
			
		}
		
		
		
		
		
		
		/**
		 * resize
		 */
		private function resize(e:Event = null):void
		{	
			App.ui.width = App.windowUI.width = stage.stageWidth;
			App.ui.height = App.windowUI.height = stage.stageHeight;
			
			if(e)
			{	
				App.ui.dispatchEvent(e.clone());
			}
		}
	}
}