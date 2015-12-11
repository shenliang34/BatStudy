package com.gamehero.sxd2.gui.core {
	
	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.GText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HintLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.GameTools;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	[Event(name="complete", type="flash.events.Event")]
	
	
	/**
	 * Game Window
	 * @author Trey
	 * @create-date: 2013-8-8
	 */
	// Modify by Trey, 2014-2-25, 优化getSwfBD()方法，使用Dictionary保存已经new的BitmapData（避免重复new）
	public class GameWindow extends BaseWindow {
		
		private var bitmapDataDict:Dictionary = new Dictionary(); 

		protected var resourceURL:String;
		
		protected var loader:BulkLoaderSingleton;

		protected var windowResource:MovieClip;
		
		private var _uiResDomain:ApplicationDomain;

		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////


		public function GameWindow(position:int, resourceURL:String = null, width:Number = 0, height:Number = 0)
		{	
			super(position);
			
			this.width = width;
			this.height = height;
			
			this.modalAlpha = WindowManager.MODAL_WINDOW_ALPHA;
			
			
			//如果资源路径为空 ，则视为已经加载完成
			if(resourceURL) {
				
				this.resourceURL = GameConfig.GUI_URL + resourceURL;
			}
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PUBLIC
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Show Window<br/>
		 * 每次窗口打开都会调用此方法
		 * 
		 */
		override public function show():void {
			
			// 窗口资源已加载
			if(_loaded) 
			{
				super.show();
				
				this.onShow();
			}
			// 加载窗口资源
			else 
			{
				// 资源路径为空的情下（无需加载），则直接调用加载完成Func
				if(resourceURL)
				{
					// TRICKY: 窗口资源加载优先级最高
					if(loader == null) {
						
						loader = BulkLoaderSingleton.createUniqueNamedLoader();
					}
					
					var loadingItem:LoadingItem = loader.add(resourceURL, {priority: GameConfig.HIGHEST_LOAD_PRIORITY});
				
					if(!loadingItem.isLoaded) {
						
						loadingItem.addEventListener(ProgressEvent.PROGRESS, onWindowResourceProgress);
						loadingItem.addEventListener(Event.COMPLETE, onWindowResourceLoaded);
						
						loader.start();
					}
					else
					{
						onWindowResourceLoaded();
					}
				}
				else
				{
					onWindowResourceLoaded();
				}
			}
		}

		
		
		/**
		 * Init Window<br/>
		 * Run Only Once
		 * 
		 */
		protected function initWindow():void {
			
		}
		
		
		/**
		 * Swf Resource Complete Handler 
		 * @param event 
		 */
		protected function onWindowResourceLoaded(e:Event = null):void
		{

			
			_loaded = true;
			
			if(resourceURL)
			{
				var imageItem:ImageItem = e.currentTarget as ImageItem;
				imageItem.removeEventListener(ProgressEvent.PROGRESS, onWindowResourceProgress);
				imageItem.removeEventListener(Event.COMPLETE, onWindowResourceLoaded);
				
				windowResource = imageItem.content;
				
				_uiResDomain = windowResource.loaderInfo.applicationDomain;
			}
			
			initWindow();
			
			// 增加100ms延迟，防止窗口打开时有卡顿的感觉
			setTimeout(show, 100);
		}
		
		
		/**
		 * Window Resource Progress Handler
		 * @param event
		 * 
		 */
		protected function onWindowResourceProgress(event:ProgressEvent):void {
			
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			progressEvent.bytesLoaded = event.bytesLoaded;
			progressEvent.bytesTotal = event.bytesTotal;
			
			this.dispatchEvent(progressEvent);
		}		
		
		
		/**
		 * Close Button Click Handler 
		 * @param event
		 * 
		 */
		override public function close():void
		{	
			WindowManager.inst.closeWindow(this, false);
			
			this.dispatchEvent(new WindowEvent(WindowEvent.CLOSE_WINDOW));
			
			/** 暂停加载并移除未加载项 */
			if(loader) {
				
				loader.pauseAndRemoveAllPaused();
			}
			
			
			super.close();
			
			
			GameTools.forceGC();
		}
		
		
		
		
		/**
		 * 设置是否允许鼠标事件
		 * */
		public function set enabled(value:Boolean):void
		{
			this.mouseChildren = value;
		}
		
		
		
		/**
		 * 设置是否允许鼠标事件
		 * */
		public function get enabled():Boolean
		{
			return this.mouseChildren;
		}
		
		
		
		/**
		 * 创建通用label
		 * */
		protected function createCommonLabel(text:String , color:uint = GameDictionary.WHITE):Label
		{
			var label:Label = new Label(false);
			label.text = text;
			label.width = 200;
			label.height = 20;
			label.size = 12;
			label.color = color;
			return label;
		}
		
		
		/**
		 * 创建通用hintLabel
		 * */
		protected function createCommonHintLabel(text:String , color:uint):HintLabel
		{
			var label:HintLabel = new HintLabel(false);
			label.text = text;
			label.width = 200;
			label.height = 20;
			label.size = 12;
			label.color = color;
			return label;
		}
		
		
		/**
		 * 创建通用GText
		 * */
		protected function createCommonGText(text:String):GText
		{
			var gtext:GText = new GText();
			gtext.text = text;
			gtext.width = 200;
			gtext.height = 20;
			gtext.align = TextFormatAlign.CENTER;
			return gtext;
		}
		
		
		/**
		 * 创建通用九宫格图
		 * */
		protected function createCommonScaleBitmap(bmd:BitmapData , rect:Rectangle , w:int , h:int):ScaleBitmap
		{
			var bmp:ScaleBitmap = new ScaleBitmap(bmd);
			bmp.scale9Grid = rect;
			bmp.setSize(w , h);
			return bmp;
		}
		
		
		/**
		 * 加载的swf的导出类得到BitmapData 
		 * @param className
		 * @return 
		 * 
		 */
		protected function getSwfBD(className:String):BitmapData {
			
			if(!windowResource)	return null;
			
			try {
				
				if(bitmapDataDict[className] == undefined) {
					
					bitmapDataDict[className] = new (uiResDomain.getDefinition(className) as Class)() as BitmapData;
				}
				
				return bitmapDataDict[className];
			}
			catch(e:Error) {
				
				return null;
			}
		}
		
		
		/**
		 * 销毁位图 
		 * @param className
		 * 
		 */		
		protected function deleteSwfBD(className:String):void
		{
			if(bitmapDataDict[className]) {
				
				(bitmapDataDict[className] as BitmapData).dispose();
				
				delete bitmapDataDict[className];
			}
			
		}
		
		
		/**
		 * 加载的swf的导出类
		 * @param className
		 * @return 
		 * 
		 */
		protected function getSwfClass(className:String):Class {
			
			return uiResDomain.getDefinition(className) as Class;
		}
		
		
		/**
		 * 获得导出类实例 
		 * @param className
		 * @return 
		 * 
		 */
		protected function getSwfInstance(className:String):* {
			
			var clazz:Class = getSwfClass(className);
			
			return new clazz();
		}

		
		protected function get uiResDomain():ApplicationDomain {
			
			if(!_uiResDomain) {
				
				_uiResDomain = windowResource.loaderInfo.applicationDomain;
			}
			
			return _uiResDomain;
		}
		

		/**
		 * 设置打开时选中的页签
		 */
		public function setTabIndex(value:int):void
		{
		}
		
	}
}