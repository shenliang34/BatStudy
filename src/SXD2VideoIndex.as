package
{
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.URI;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	/**
	 * 用于加载录像swf
	 * @author xuwenyi
	 * @create 2015-09-01
	 **/
	[SWF(frameRate="24", backgroundColor="#0")]
	public class SXD2VideoIndex extends Sprite
	{
		// 录像swf
		private var VIDEO_URL:String;
		// 加载游戏模块
		private var gameLoader:Loader;
		
		
		
		/**
		 * 构造函数
		 * */
		public function SXD2VideoIndex()
		{
			this.addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
		}
		
		
		
		
		
		private function onAddToStage(e:Event):void 
		{	
			this.removeEventListener(Event.ADDED_TO_STAGE , onAddToStage);
			
			// Set stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, resize);
			
			this.mouseEnabled = false;
			this.tabEnabled = false;
			
			// 网页外部参数
			URI.params = stage.loaderInfo.parameters;
			GameConfig.init(URI.CN);
			// 初始化战斗资源配置
			BattleConfig.init();
			
			// 资源路径
			VIDEO_URL = Version.CLIENT_VERSION + "SXD2VideoMain.swf";
			
			// 开始加载
			this.load();
			
			this.resize();
		}
		
		
		
		
		private function load():void
		{
			gameLoader = new Loader();
			//gameLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			gameLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameReady);
			
			// cdn context
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = gameLoader.contentLoaderInfo.applicationDomain;
			gameLoader.load(new URLRequest(URI.cdn + VIDEO_URL), context);
		}
		
		
		
		
		/**
		 * GAME_URL加载完成
		 */
		private function onGameReady(e:Event):void
		{	
			//gameLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			gameLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onGameReady);
			
			this.addChild(gameLoader.content);
			this.clear();
		}
		
		
		
		
		
		private function resize(e:Event = null):void
		{	
			
		}
		
		
		
		
		
		/**
		 * 清除GameIndex 
		 */
		public function clear():void
		{	
			stage.removeEventListener(Event.RESIZE, resize);
		}
	}
}