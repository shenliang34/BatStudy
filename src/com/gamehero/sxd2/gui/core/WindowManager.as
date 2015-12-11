 package com.gamehero.sxd2.gui.core {
	
	import com.gamehero.sxd2.event.PopUpEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.IAlert;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.greensock.TweenLite;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	
	
	/**
	 * 窗口弹出管理类
	 * @author Trey
	 * @modified by xuwenyi 2011-4-19 增加新特性:可以支持多窗口同时存在并且有优先级关系 
	 * @modified by Trey 2012-2-22：修正窗口排列Bug：无需排列的窗口关闭时，不需要重排所有窗口
	 * @ReCreate by Trey, 2012-10-17, 重写窗口管理类
	 * @modified by zhangxueyou 2015-9-9 窗口打开或关闭缓动
	 */
	// Modify by Trey, 2013-11-30, 优化
	public class WindowManager extends EventDispatcher {
		
		// Modal Window Alpha
		static public var MODAL_WINDOW_ALPHA:Number = 0.7;
		static public var MODAL_WINDOW_COLOR:uint = 0x000000;
		// 窗口动画移动时间
		static public const WINDOW_MOVE_DURATION:Number = 0.5;
		static private var _instance:WindowManager;
		// 窗口间间隙
		static private const WINDOW_GAP:int = 0;
		// 已实例化窗口
		private var _windows:Dictionary;
		// 已打开窗口
		private var _openedWindows:Vector.<BaseWindow>;
		// 将要关闭的窗口
		private var _willCloseWindows:Vector.<BaseWindow>;
		// 菊花加载
		private var _mumLoading:MovieClip;
		// 将打开的窗口
		private var _willOpenWindow:BaseWindow;
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function WindowManager(enforcer:SingletonEnforcer) {
		
			if(App.windowUI) {
				if(App.windowUI.stage)
					App.windowUI.stage.addEventListener(Event.RESIZE, onWindowUIResize);
			}
			
			_windows = new Dictionary();
			_openedWindows = new Vector.<BaseWindow>();
			_willCloseWindows = new Vector.<BaseWindow>();
		}
		
		
		/**
		 * Get Instance(singleton);
		 * @return 
		 * 
		 */
		public static function get inst():WindowManager {
			
			return _instance ||= new WindowManager(new SingletonEnforcer())
		}		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PUBLIC
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 手动Add Window Instance，在openWindow前外部已实例化window时使用
		 * @param window
		 * 
		 */
		public function getWindowInstance(windowClass:Class, windowPosition:int):BaseWindow {
			
			/** 窗口初始化 */
			var windowClassName:String = getWindowClassName(windowClass);
			windowClassName = windowClassName.replace("::", ".");
			
			var window:BaseWindow = _windows[windowClassName];
			if(!window) {
				
				var ClassReference:Class = getDefinitionByName(windowClassName) as Class;
				window = new ClassReference(windowPosition) as BaseWindow;
				window.windowName = windowClassName.substr(windowClassName.lastIndexOf(".") + 1);

				_windows[windowClassName] = window;
			}
			
			return window;
		}
		
		
		
		/**
		 * 打开窗口<br/>
		 * 并返回窗口实例
		 * @param windowClass
		 * @param windowPosition
		 * @param modal
		 * @param isMultiWindow	是否多窗口共存（已打开的窗口不关闭）
		 * @param selfAutoClose	若窗口已打开，是否关闭
		 * @param windowParam	窗口打开参数
		 * @param relateWindows 相关窗口
		 * @return 
		 * 
		 */
		public function openWindow(windowClass:Class, 
								   windowPosition:int, 
								   modal:Boolean = false, 
								   isMultiWindow:Boolean = true, 
								   selfAutoClose:Boolean = true,
								   windowParam:Object = null,
								   relatedWindows:Array = null
		):BaseWindow {
			
			// 窗口初始化
			var window:BaseWindow = getWindowInstance(windowClass, windowPosition);
			
			// 如果窗口已经打开
			if(isWindowOpened(windowClass)) {
				
				// 若设置为自动关闭、且不是全局提示窗口就关闭它
				if(selfAutoClose && !(window is IAlert)) {
					
					window.close();
				}
			}
			else {
				
				// 设置窗口属性
				window.position = windowPosition;
				window.modal = modal;
				window.windowParam = windowParam;
				
	
				// 关闭其他窗口判断：非多窗口 或 有相关窗口
				if(isMultiWindow == false || relatedWindows != null) {
//				if(windowPosition != WindowPostion.CENTER_ONLY && (isMultiWindow == false || relatedWindows != null) ) {
					
					_willOpenWindow = window;
					closeAllWindow(relatedWindows);
				}
				else {
					
					onOpenWindowAction(window);
				}
			}
			
			return window;
		}
		
		
		/**
		 * Open Window Action 打开窗口Action
		 * @param param
		 * 
		 */
		private function onOpenWindowAction(param:BaseWindow = null):void {
			
			var window:BaseWindow = param ? param : _willOpenWindow;
			
			// 监视加载窗口处理
			if(window) {
				
				if(window.loaded == false) {
					
					// TRICKY: WaitingWindow不能使用加载等待窗口，否则导致死循环
					if(!(window is IAlert)) {
						
						// 菊花加载
						if(!_mumLoading) {
							
							_mumLoading = new (MainSkin.getSwfClass("MUM_LOADING"));
						}
						
						App.windowUI.stage.addChild(_mumLoading);
						_mumLoading.gotoAndStop(1);
						_mumLoading.x = int((App.windowUI.stage.stageWidth - _mumLoading.width) / 2);
						_mumLoading.y = int((App.windowUI.stage.stageHeight - _mumLoading.height) / 2) - 100;
					}
					
					window.addEventListener(ProgressEvent.PROGRESS, onWindowProgress, false, 0, true);
				}
				
				// 窗口准备好事件
				window.addEventListener(Event.COMPLETE, onWindowReady, false, 0, true);
				
				// 显示窗口，必须调用，否则接收不到窗口准备好事件
				window.show();
			
				
				if(param == null) {
					
					_willOpenWindow = null;
				}
			}
		}
		
		
		/**
		 * Close Window
		 * @param window	需要关闭的窗口
		 * @param isCallClose	是否要主动调用window.close()方法（若由GameWindow触发，不需要调用close）
		 * 
		 */
		public function closeWindow(window:BaseWindow, isCallClose:Boolean = true,isTween:Boolean = true):void
		{	
			/** 移除、删除窗口 */
			// 删除窗口对象
			var idx:int;
			if(!(window is IAlert) && (idx = _openedWindows.indexOf(window)) >= 0 ) {
				
				_openedWindows.splice(idx, 1);
			}
			
			if(window != null && App.windowUI.contains(window) == false)	return;
			
			
			
			// 关闭窗口
			var windowIndex:int = App.windowUI.getChildIndex(window);
			
			
			// 关闭动画
			var buttonPoint:Point = getPlayerPoint(window.windowName,"close");
			
			// 动画关闭
			if(window.canOpenTween == true && buttonPoint) {
				
				if(window.alpha == 1) {
					
					window.scaleX = window.scaleY = 1;
					window.alpha = 1;
				}
				TweenLite.to(window, WindowManager.WINDOW_MOVE_DURATION, 
					{x: buttonPoint.x, y: buttonPoint.y, scaleX: 0, scaleY: 0, alpha: 0, 
						onComplete: function():void {App.windowUI.removeChild(window as DisplayObject);} }	// 动画完成后才removeChild
				);
			}
			// 直接关闭
			else {
				App.windowUI.removeChild(window as DisplayObject);
			}
			
			
			// Comment by Trey, 不再调用close()方法，改由GameWindow自行调用
			//window.close();
			// Modify by Trey, 通过参数来调用
			if(isCallClose) {
				
				window.close();
			}
			
			
			// Remove Modal Layer
			if(window.modal && windowIndex > 0) {
				
				App.windowUI.removeChildAt(windowIndex - 1);
			}
			
			
			
			/** 排列其他窗口 */
			if(window.position != WindowPostion.CENTER_ONLY) {
				
				reArrange();
			}
			
			
			
			// 无窗口，清楚键盘事件
			if(_openedWindows.length == 0) {
				
				/*ESCKeyEventListener(false);*/
			}
				// IMPORTANT: 下一窗口获取焦点，否则不会触发
			else 
			{	
				/*var openedWindow:IPopUpWindow = openedWindows.getChildAt(openedWindows.length - 1) as IPopUpWindow;
				setFocusWindow(openedWindow);
				
				// 排列剩余窗口，若关闭窗口为无需排列的窗口，则无需重排
				if(popUpWindow.isArrange) {
				
				sortWindows();
				}*/
			}
			
			
			/* 判断是否需要关闭自定义Modal窗口
			if(window.isModal) {
			
			// 窗口准备就绪，抛出事件
			var popupEvent:PopUpEvent = new PopUpEvent(PopUpEvent.HIDE_MODAL_WINDOW_EVENT);
			popupEvent.window = window;
			instance.dispatchEvent(popupEvent);
			}*/
			
			
			// 抛出关闭事件
			var popupEvent:PopUpEvent = new PopUpEvent(PopUpEvent.WINDOW_CLOSE_EVENT);
			popupEvent.window = window;
			dispatchEvent(popupEvent);
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PRIVATE
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 通过Window Class获得路径名 
		 * @param windowClass
		 * @return 
		 * 
		 */
		private function getWindowClassName(windowClass:Class):String {
			
			return getQualifiedClassName(windowClass).replace("::", ".");
		}
		
		
		/**
		 * Window Ready Handler
		 * @param event
		 * 
		 */
		private function onWindowReady(event:Event):void {
			
			var window:BaseWindow = event.target as BaseWindow;
			
			
			/** 移除加载菊花 */
			if(!(window is IAlert) && _mumLoading && App.windowUI.stage.contains(_mumLoading) ) {
					
				App.windowUI.stage.removeChild(_mumLoading);
			}
			
			
			
			/** 移除事件 */
			window.removeEventListener(Event.COMPLETE, onWindowReady);
			if(window.hasEventListener(ProgressEvent.PROGRESS)) {
				
				window.removeEventListener(ProgressEvent.PROGRESS, onWindowProgress);
			}
			
			
			/** Modal Layer */
			if(window.modal) {
				
				var modalSprite:Sprite;

				// 处理GlobalAlert的modal
				var windowIndex:int = App.windowUI.contains(window) ? App.windowUI.getChildIndex(window) : -1;
				if(window is IAlert && windowIndex >= 0 && window.modal) {
					
					modalSprite = App.windowUI.getChildAt(windowIndex - 1) as Sprite;
				}
				else {
					
					modalSprite = new Sprite();
					modalSprite.tabEnabled = false;
					
					modalSprite.graphics.clear();
					modalSprite.graphics.beginFill(MODAL_WINDOW_COLOR, window.modalAlpha);
					modalSprite.graphics.drawRect(0, 0, App.stage.stageWidth, App.stage.stageHeight);
					modalSprite.graphics.endFill();
					
				}
				
				App.windowUI.addChild(modalSprite);
			}
			

			/** AddChild Window */
			App.windowUI.addChild(window as DisplayObject);
			
			
			/** 安排窗口初始位置 */
			arrageWindow(window);
			
			
			/** 打开动画起始位置 */
			var buttonPoint:Point = getPlayerPoint(window.windowName,"open");
			
			/** 添加数据至_openedWindows */
			if(!(window is IAlert)) {
				_openedWindows.push(window);
			}

			
			/** 重排窗口 */
			if(window.position != WindowPostion.CENTER_ONLY && window.position != WindowPostion.BOTTOM_RIGHT) {
				
				reArrange(window);
			}
			
			
			/** 打开动画播放 */
			if(window.canOpenTween == true && buttonPoint) {
				
				var xx:Number = window.x;
				var yy:Number = window.y;

				window.x = buttonPoint.x;
				window.y = buttonPoint.y;
				window.scaleX = window.scaleY = 0;
				window.alpha = 0;
				TweenLite.to(window, WINDOW_MOVE_DURATION, {x: xx, y: yy, scaleX: 1, scaleY: 1, alpha: 1
					, onComplete:
						function():void {
							window.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
						}
				}); 
			}
			
			/** 将GlobalAlert置于最上层 */
			// 打开的window不是IAlert
			if(!(window is IAlert)) {
				
				for(var i:int = 0; i < App.windowUI.numChildren; i++) {
					
					var displayObject:DisplayObject = App.windowUI.getChildAt(i);
					if(displayObject is IAlert) {
						
						// 处理modal层：若GlobalAlert是modal窗口，将modal层也一并置于最上层
						if((displayObject as GameWindow).modal && i > 0) {
							
							App.windowUI.addChild(App.windowUI.getChildAt(i -1));
						}
						
						App.windowUI.addChild(displayObject);
						break;
					}
				}
			}
			
			
			
			// Do something After Window show
			// Comment by Trey, 不再在此处调用onShow()
//			window.onShow();
			
			
			/** 抛出窗口准备就绪事件 */
			var popupEvent:PopUpEvent = new PopUpEvent(PopUpEvent.WINDOW_READY_EVENT);
			popupEvent.window = window;
			dispatchEvent(popupEvent);
			
			
			/*ESCKeyEventListener(true);*/
		}	
		
		
		/**
		 * 获取上一个窗口 
		 * @param window
		 * @return 
		 * 
		private function getPreviousWindow(window:BaseWindow):BaseWindow {
			
			var previousWindow:BaseWindow;
			
			// 当前一个窗口情况
			if(_openedWindows.length == 1) {
				
				previousWindow = _openedWindows[0];
			}
			// 当前两个窗口情况
			if(_openedWindows.length == 2) {
				
				for(var i:int; i < _openedWindows.length; i++) {
					
					if(_openedWindows[i].position == -window.position) {
						
						previousWindow = _openedWindows[i];
					}
					else if(_openedWindows[i].position == window.position) {
						
						//							needCloseWindow = _openedWindows[i];
						previousWindow = _openedWindows[i];
					}
				}
			}
			
			return previousWindow;
		}
		 */
		
		
		
		
		/**
		 * Window Load Progress Handler 
		 * @param event
		 * 
		 */
		private function onWindowProgress(event:ProgressEvent):void {
			var percent:int = int(event.bytesLoaded / event.bytesTotal * 100);
			_mumLoading.gotoAndStop(percent);
//			WaitingManager.instance.waitingText = percent  + "%";
//			WaitingManager.instance.progress(percent);
			
//			Logger.debug(WindowManager, "Window Loading: " + percent  + "%");
			
		}		
		
		
		private var isEscKeyListened:Boolean = false;
		/**
		 * Add Stage Key Listener<br/>
		 * 监听ESC键
		 * 
		 */
		private function ESCKeyEventListener(addKey:Boolean):void {
			
			if(App.windowUI == null) return;
			
			if(addKey) {
				
				if(!isEscKeyListened) {
				
					App.windowUI.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
					isEscKeyListened = true;
				}
			}
			else {
				
				App.windowUI.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				isEscKeyListened = false;
			}
		}
	
		
		/**
		 * 通过ESC键关闭窗口
		 * @param e
		 */
		private function keyDownHandler(event:KeyboardEvent):void {
				
			// TRICKY: GlobalAlert无法使用ESC键关闭，必须由用户操作关闭
			if(event.charCode == Keyboard.ESCAPE && 
				_openedWindows.length > 0 
				&&
				(App.windowUI.getChildAt(App.windowUI.numChildren -1) as IAlert) == null
			) {
				
				// Modify by Trey, ESC直接关闭改为调用窗口的close()方法
				//closeWindow(openedWindows[openedWindows.length - 1]);
				_openedWindows[_openedWindows.length - 1].close();
			}
		}
		
		
		
		/**
		 * Close All Windows 
		 * 
		 */
		public function closeAllWindow(relatedWindows:Array = null):void 
		{	
			_willCloseWindows.length = 0;
			
			var $window:BaseWindow;
			for(var i:int = _openedWindows.length - 1; i >= 0 ; i--) {
				
				$window = _openedWindows[i];
				
				if(relatedWindows == null || isRelatedWindow($window, relatedWindows) == false)
				{	
					if(_willOpenWindow) 
					{	
						$window.addEventListener(WindowEvent.CLOSE_WINDOW, onWindowClose);
					}
					
					_willCloseWindows.push($window);
				}
			}
			
			// edit by xuwenyi 2015-08-31 _willCloseWindows会随着close的调用越来越少
			var windows:Vector.<BaseWindow> = _willCloseWindows.concat();
			if(windows.length > 0) 
			{
				for(i=0;i<windows.length;i++)
				{
					windows[i].close();
				}
			}
			else 
			{	
				onOpenWindowAction();
			}
		}
		
		
		/**
		 * 是否是相关窗口 
		 * @param window
		 * @param relateWindows
		 * @return 
		 * 
		 */
		private function isRelatedWindow(window:BaseWindow, relateWindows:Array):Boolean {
			
			for (var i:int = relateWindows.length - 1; i >= 0; i--) {
				
				if(window is relateWindows[i]) {
					
					return true;
				}
			}
			
			return false;
		}
		
		
		/**
		 * One Window Close Handler 
		 * @param event
		 * 
		 */
		private function onWindowClose(event:WindowEvent):void {
			
			var closedWindow:BaseWindow = event.target as BaseWindow;
//			event.target.removeEventListener(WindowEvent.CLOSE_WINDOW, onWindowClose);
			closedWindow.removeEventListener(WindowEvent.CLOSE_WINDOW, onWindowClose);
			
			_willCloseWindows.splice(_willCloseWindows.indexOf(closedWindow), 1);
			
			// NEW MODIFY
//			if(_openedWindows.length == 0) {
			if(_willCloseWindows.length == 0) {
				
				onOpenWindowAction();
			}
		}
		
		
		
//		/**
//		 * 获得一个关闭前需要询问或处理东西的窗口
//		 */
//		public function getWinAskBeforeClose():BaseWindow 
//		{
//			var i:int;
//			var len:int = _openedWindows.length;
//			var win:BaseWindow;
//			for(i=0; i<len; i++) 
//			{
//				win = _openedWindows[i] as BaseWindow;
//				if(win && win.askBeforeClose)
//				{
//					return win;
//				}
//			}
//			return null;
//		}
		
		
		/**
		 * 安排窗口位置
		 * @param window
		 * @param isAnimation
		 * 
		 */
		private function arrageWindow(window:BaseWindow, isAnimation:Boolean = false):void  
		{

			var _x:Number = (App.stage.stageWidth - window.width) >> 1;
			var _y:Number = (App.stage.stageHeight - window.height) >> 1;
			
			
			// 底部居中
			if(window.position == WindowPostion.BOTTOM_CENTER) {
			
				_x = (App.stage.stageWidth - window.width) >> 1;
				_y = App.stage.stageHeight - window.height;
			}
			// 底部居左
			else if(window.position == WindowPostion.BOTTOM_LEFT) {
				
				_x = 0;
				_y = App.stage.stageHeight - window.height;
			}
			// 底部居右
			else if(window.position == WindowPostion.BOTTOM_RIGHT) {
				
				_x = App.stage.stageWidth - window.width;
				_y = App.stage.stageHeight - window.height;
			}
			// 中央居中
			else {
				
				_x = (App.stage.stageWidth - window.width) >> 1;
				_y = (App.stage.stageHeight - window.height) >> 1;
			}
			
			
			if(isAnimation) {
				
				TweenLite.to(window, WINDOW_MOVE_DURATION, {x: _x, y:_y});
			}
			else {
				
				window.x = _x;
				window.y = _y;
			}
		}
		
		
		/**
		 * Is Window Opened
		 * @param windowClass
		 * @return 
		 * 
		 */
		public function isWindowOpened(windowClass:Class):Boolean {
			
			/** 窗口初始化 */
			var windowClassName:String = getWindowClassName(windowClass);
			
			var window:BaseWindow = _windows[windowClassName];
			
			// Modify by Trey, 修改判断窗口打开逻辑，因为增加了窗口打开/关闭动画，因此并不能通过原方法来判断打开与否
			return (window != null && _openedWindows.indexOf(window) >= 0);
		}
		
		/**
		 * 关闭界面 
		 * @param windowClass 需要关闭的界面类
		 * 
		 */		
		public function closeGeneralWindow(windowClass:Class):void
		{
		
			/** 窗口初始化 */
			var windowClassName:String = getWindowClassName(windowClass);
			
			var window:BaseWindow = _windows[windowClassName];
			if(window)
			{
				window.close();
			}
		}
			
		
		
		/**
		 * 通过Window Name来判断Is Window Opend
		 * @param windowName（不包含报名，纯类名）
		 * @return 
		 * 
		 */
		public function isWindowOpenedByWindowName(windowName:String):Boolean {
			
			var isOpened:Boolean = false;
			var window:BaseWindow;
			for (var name:String in _windows) {
				
				if(name.indexOf(windowName) >= 0) {
					
					window = _windows[name];
					break;
				}
			}
			
			if(window) {
				
				isOpened = _openedWindows.indexOf(window) >= 0
			}
			
			
			return isOpened;
			
		}
		
		
		
		/**
		 * 重新排列当前窗口(居中) 
		 * @param window 当前窗口，不需要动画
		 * 
		 */
		public function reArrange(currWindow:BaseWindow = null):void {
			
			_openedWindows.sort(sortWindowFunc);
			
			var sumWidth:Number = 0;
			for each (var window:BaseWindow in _openedWindows) {
				
				// 过滤CENTER_ONLY窗口
				if(window.position != WindowPostion.CENTER_ONLY) {
					
					sumWidth += window.width;
				}
				
			}
			
			var beginX:Number = (App.stage.stageWidth - sumWidth) >> 1;
			var beginY:Number;
			for each (window in _openedWindows) {
				
				// 过滤CENTER_ONLY窗口
				if(window.position != WindowPostion.CENTER_ONLY) {
					
					beginY = (App.stage.stageHeight - window.height) >> 1
					if(window != currWindow) {
						
						TweenLite.to(window, WINDOW_MOVE_DURATION, {x: beginX, y: beginY});
					}
					else {
						
						window.x = beginX;
						window.y = beginY;
					}
					
					beginX += window.width;
				}
				else {
					
					// CENTER_ONLY窗口居中
					arrageWindow(window, window != currWindow);
				}
			}
			
		}
		
		
		/**
		 * 根据X排序 
		 * @param window1
		 * @param window2
		 * @return 
		 * 
		 */
		private function sortWindowFunc(window1:BaseWindow, window2:BaseWindow):Number {
			
//			return window1.x > window2.x ? 1 : -1;
			
			if(window1.position < window2.position) {
				
				return 1;
			}
			else {
				
//				return window1.x > window2.x ? 1 : -1;
				
				// 先添加的排在左侧
				return _openedWindows.indexOf(window1) > _openedWindows.indexOf(window2) ? 1 : -1;
			}
		}
		
		
		
		/**
		 * 通过坐标获得打开窗口 
		 * @param stagePoint
		 * @return 
		 * 
		 */
		public function getWindowByStagePoint(stagePoint:Point):BaseWindow {
			
			stagePoint = App.windowUI.globalToLocal(stagePoint);
			
			var window:BaseWindow;
			
			for each (var aWindow:BaseWindow in _openedWindows) {
				
				if(stagePoint.x >= aWindow.x && stagePoint.x <= aWindow.x + aWindow.width &&
					stagePoint.y >= aWindow.y && stagePoint.y <= aWindow.y + aWindow.height) {
					
					return aWindow;
				}
			}
			
			return window;
		}
		
		/**
		 *获取缓动初始位置，如未找到默认居中 
		 * @param name
		 * @param op
		 * @return 
		 * 
		 */		
		private function getPlayerPoint(name:String,op:String):Point
		{
			var button:* = FunctionManager.inst.getFuncBtn2(name);
			var buttonPoint:Point;
			if(button != null && button.parent != null)
			{
				buttonPoint = new Point(button.x + button.width * .5, button.y + button.height * .5);
				buttonPoint = button.parent.localToGlobal(buttonPoint);
			}
			else
			{
				if(op == "open")
					buttonPoint = new Point(App.windowUI.stage.stageWidth/2,App.windowUI.stage.stageHeight/2);
			}
			return buttonPoint;
		}
		
		/**
		 *获取打开窗口 
		 * @param windowName
		 * @return 
		 * 
		 */		
		public function getOpenWindow(windowName:String):Boolean
		{
			for each (var item:BaseWindow in _openedWindows) 
			{
				if(windowName == item.windowName)
					return true;
			}
			
			
			return false;
		}
		
		/**
		 * Resize Handler 
		 * @param event
		 * 
		 */
		private function onWindowUIResize(event:Event):void {
			
			reArrange();
		}
		
	}
}

class SingletonEnforcer {}