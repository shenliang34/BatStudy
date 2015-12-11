package
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.URI;
	import com.gamehero.sxd2.event.LoginEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.Gametheme;
	import com.gamehero.sxd2.login.LoginMediator;
	import com.gamehero.sxd2.login.LoginView;
	import com.gamehero.sxd2.manager.JSManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.layout.LayoutManager;
	import alternativa.init.GUI;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.logging.Logger;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	
	
	/**
	 * 游戏登录、选择角色模块
	 * @author xuwenyi
	 * @create 2013-07-26
	 **/
	[SWF(frameRate="24", backgroundColor="#0")]
	public class SXD2Game extends Sprite
	{
		// Hash XML 文件
		[Embed(source="/assetsembed/xml/hashes.xml",mimeType="application/octet-stream")]
		private var hashXmlClass:Class;
		
		static private var _instance:SXD2Game;
		
		
		// 登录UI
		private var loginView:LoginView;
		private var loginMediator:LoginMediator;
		
		// 主游戏
		private var mainView:DisplayObjectContainer;
		private const mainViewURL:String = Version.CLIENT_VERSION + "SXD2Main.swf";
		
		// 主UI
		private var mainUIURL:String;
		// 配置表url
		private var settingsURL:String;
		
		// 是否已经登录,并创建好角色准备进入游戏
		private var logined:Boolean = false;
		// 游戏加载状态(1:主游戏,2:ui资源,3:配置表)
		private var loadStatus:int = 0;
		
		
		public var existCharList:Array;	// 已创建角色列表
		
		
		public function SXD2Game()
		{
			_instance = this;
			
			// 资源路径
			mainUIURL = GameConfig.GUI_URL + "MainUI.swf";
			settingsURL = GameConfig.RESOURCE_URL + "xml/settings.gh";
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		
		static public function get instance():SXD2Game {
			
			return _instance;
		}
		
		
		/**
		 * Add to Stage Handler 
		 * @param event
		 * 
		 */
		private function onAddToStage(event:Event):void
		{	
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			/** Stage Setting */
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			
			this.mouseEnabled = false;
			this.tabEnabled = false;

			/** 右键菜单 */
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			this.contextMenu.builtInItems.quality = true;
			
			/** 客户端版本号 */
			Version.CV = int(Version.CLIENT_VERSION.replace("/", ""));
			this.contextMenu.customItems.push(new ContextMenuItem("Client: " + Version.CV));
			
			/** 设置日志级别 */
			Logger.logLevel = LogSetupLevel.ERROR;
			
			CONFIG::DEBUG 
			{
				if(JSManager.isDebug()) 
				{
					Logger.logLevel = LogSetupLevel.DEBUG;
				}
				else {
					
					Logger.logLevel = LogSetupLevel.INFO;
				}
			}
					
			/** Init UI */
			this.initGUI();
	
			/** 初始化hash配置（必须放在所有加载之前）*/
			BulkLoaderSingleton.init(XML(new hashXmlClass()), URI.cdn);
			hashXmlClass = null;
			
			/** 创建login界面 */
			loginView = new LoginView();
			loginView.addEventListener(LoginEvent.ENTER_SXD2_MAIN, enterSXD2Main);
			App.ui.addChild(loginView);
			
			// 创建login的mediator
			loginMediator = new LoginMediator(loginView);
			loginMediator.initialize();
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
		}
		
		
		
		
		/**
		 * 进入主游戏
		 */
		private function enterSXD2Main(e:LoginEvent):void
		{
			existCharList = e.data as Array;
			
			// 已登录游戏
			logined = true;
			this.load();
		}
		
		
		
		
		/**
		 * 加载资源
		 */
		public function load(loadStatus = 1):void
		{	
			this.loadStatus = loadStatus;
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			switch(loadStatus)
			{
				// 加载主游戏
				case 1:
					// 监听Module加载事件
					loader.addWithListener(mainViewURL , null, onLoadComplete , onLoadProgress);
					Logger.info(SXD2Index, "[SXD2Game] add", mainViewURL);
					break;
				
				// 加载UI资源
				case 2:
					loader.addWithListener(mainUIURL , null , onLoadComplete , onLoadProgress);
					Logger.info(SXD2Index, "[SXD2Game] add", mainUIURL);
					break;
				
				// 加载配置表
				case 3:
					loader.addWithListener(settingsURL , { type:BulkLoader.TYPE_BINARY} , onLoadComplete , onLoadProgress);
					Logger.info(SXD2Index, "[SXD2Game] add", settingsURL);
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
				// 保存主游戏视图
				case 1:
					mainView = loadingItem.content as DisplayObjectContainer;
					loader.remove(mainViewURL);
					
					Logger.info(SXD2Index, "Main Load Complete!");
					break;
				
				// 保存UI资源
				case 2:
					App.mainUIRes = loadingItem.content;
					
					Logger.info(SXD2Index, "MainUI Load Complete!");
					break;
				
				// 保存配置表
				case 3:
					App.settingsBinary = ByteArray(loadingItem.content);
					
					Logger.info(SXD2Index, "Settings Load Complete!");
					break;
			}
			
			// 加载下一个资源
			loadStatus++;
			
			if(loadStatus <= 3)
			{
				// 继续加载
				this.load(loadStatus);
			}
			else
			{
				// 显示相应的UI
				this.checkLoadingStatus();
			}
		}
		
		
		
		/**
		 * 加载进度
		 */
		private function onLoadProgress(e:ProgressEvent):void
		{
			
			var loadingText:String;
			switch(loadStatus)
			{
				// 保存主游戏视图
				case 1:
					
					//loadingText = SXD2Index.instance.languageXML.s.(@key == "3003").@value;
					break;
				
				// 保存UI资源
				case 2:
					
					//loadingText = SXD2Index.instance.languageXML.s.(@key == "3004").@value;
					break;
				
				// 保存配置表
				case 3:
					
					//loadingText = SXD2Index.instance.languageXML.s.(@key == "3005").@value;
					break;
			}
			
			//SXD2Index.instance.updateProgress( Math.ceil( e.bytesLoaded / e.bytesTotal * 100), loadingText + "  " + int(e.bytesLoaded / 1024) + "K/" + int(e.bytesTotal / 1024) + "K");
		}
		
		
		
		
		
		/**
		 * 检测当前加载状态,进入主游戏or显示加载进度
		 */
		private function checkLoadingStatus():void 
		{	
			// 用户是否已登录
			if(logined == true) 
			{
				// 加载完成
				if(loadStatus > 3)
				{
					// 显示主游戏
					this.showMainGame();
					
					Logger.info(SXD2Index, "All Loaded!");
				}
			}
		}
		
		
		
		
		/**
		 * 显示主游戏
		 */
		private function showMainGame():void
		{
			// 添加main模块
			if(mainView)
			{			
				this.clear();
				
				// FORTEST: MEMORY TEST
				mainView.addChild(App.ui);
				mainView.addChild(App.hintUI);
				this.addChild(mainView);
			}
			else
			{
				Logger.error(SXD2Index, "IceFireSongMain load failed!");
			}
		}
		
		/**
		 * 清空登录模块
		 * 
		 */
		public function clear():void
		{	
			var ui:GUIobject = App.ui;
			
			// 移除事件
			if(loginView)
			{
				loginView.clear();
				loginView.removeEventListener(LoginEvent.ENTER_SXD2_MAIN , enterSXD2Main);
				loginView = null;
			}
			loginMediator.destroy();
			
			// 移除login模块
			while(ui.numChildren > 0) 
			{	
				ui.removeChildAt(0);
			}
		}
		
		
	}
}