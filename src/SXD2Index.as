package {
	
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.URI;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	/** 
	 * Game Index
	 * @author xuwenyi
	 * @create 2013-12-19
	 */
	[SWF(frameRate="24", backgroundColor="#0")]
	public class SXD2Index extends Sprite
	{		
		private var GAME_URL:String = Version.CLIENT_VERSION + "SXD2Game.swf";
		static private var _instance:SXD2Index;
		// 加载游戏模块
		private var gameLoader:Loader;
		// IceFireSongGame加载完成
		private var isGameReady:Boolean = false;

		/**
		 * 构造函数
		 * */
		public function SXD2Index()
		{	
			_instance = this;
						 
			this.addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
		}
		
		static public function get instance():SXD2Index {
			
			return _instance;
		}
		
		/**
		 * 添加到场景时
		 * 
		 */
		private function onAddToStage(e:Event):void {
			
			this.removeEventListener(Event.ADDED_TO_STAGE , onAddToStage);
			
			this.stage.addEventListener(Event.RESIZE, onStageResize);
			
			// Set stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.mouseEnabled = false;
			this.tabEnabled = false;
			
			/** Read parameters */
			URI.params = stage.loaderInfo.parameters;
			URI.agent = URI.params.agent;
			/** TRICKY: 先加载策略文件，约定843外的策略文件端口为8843 */
			Security.loadPolicyFile("xmlsocket://" + URI.ip + ":8843");
			// 多语言选择
			switch(CONFIG::LANG)
			{
				case URI.TW:
					URI.lang = URI.TW;
					break;
			}
			GameConfig.init(URI.lang);
			// 初始化战斗资源配置
			BattleConfig.init();
			
			// 外部加载(build编译时会被替换成相应的hash文件名)
			//LOADER_SWF = GameConfig.LOGIN_URL + 'IndexLoading.swf';
			
			this.onStageResize();
			
			// 加载loading动画
			/*gameLoader = new Loader();
			gameLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			gameLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, init);
			gameLoader.load(new URLRequest(URI.cdn + LOADER_SWF));*/
			
			// 加载游戏模块
			this.init();
		}
		
		
		/**
		 * Stage Resize Handler 
		 */
		private function onStageResize(event:Event = null):void
		{	
			/*if(loaderTF)
			{	
				loaderTF.x = (this.stage.stageWidth - loaderTF.width) >> 1;
				loaderTF.y = (this.stage.stageHeight - loaderTF.height) >> 1;
			}
			
			if(loadingSWF)
			{	
				loadingSWF.x = (this.stage.stageWidth - 1920) >> 1;
				loadingSWF.y = (this.stage.stageHeight - 1080) >> 1;
			}*/
		}		
		
		
		
		
		/**
		 * 加载Loading素材完成
		 */
		private function init():void
		{	
			// 加载SXD2Game.swf
			gameLoader = new Loader();
			gameLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			gameLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameReady);
			
			// cdn context
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = gameLoader.contentLoaderInfo.applicationDomain;
			gameLoader.load(new URLRequest(URI.cdn + GAME_URL), context);
		}
		
		
		
		
		
		/**
		 * GAME_URL加载完成
		 */
		private function onGameReady(event:Event):void
		{	
			gameLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			gameLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onGameReady);
			
			isGameReady = true;
			
			this.startGame();
		}		
		
		
		
		
		
		
		
		/**
		 * 加载进度
		 */
		private function onProgress(e:ProgressEvent):void
		{	
			//percent = e.bytesLoaded / e.bytesTotal * 100;
		}		
		
		
		
		
		
		
		/**
		 * 更新loading bar进度
		 */
		private function updateLoadingBar():void
		{
			
		}
		
		
		
		
		
		
		/**
		 * 进入游戏登录界面
		 */
		private function startGame():void
		{
			// 初始化登录模块
			this.addChild(gameLoader.content);
		}
		
		
		
		/**
		 * 更新进度条 
		 */
		public function updateProgress(value:Number, loadingText:String = null):void 
		{
			
			
		}
		
		
		
		/**
		 * 更新加载文字
		 */
		public function updateProgressText(loadingText:String):void {
			
			
		}
		
		
		
		
		
		
		/**
		 * 是否显示loading画面
		 * */
		public function showLoading(value:Boolean):void
		{
			//loadingSWF.visible = value;
		}
		
		
		
		
		
		
		/**
		 * 清除GameIndex 
		 */
		public function gc():void {
			
			this.stage.removeEventListener(Event.RESIZE, onStageResize);
			
			// Set null
			GAME_URL = null;
			
			gameLoader = null;
		}
	}
}