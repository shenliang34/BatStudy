package com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar {
	
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.scrollBar.ScrollBar;
	import alternativa.gui.event.ScrollBarEvent;
	import alternativa.gui.mouse.MouseManager;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 * 自定义ScorlBar 
	 * @author Trey
	 * @create-date 2013-9-7
	 */
	public class ScrollBar extends alternativa.gui.controls.scrollBar.ScrollBar {

		// 滚动条宽度
		static public const SCROLL_BAR_WIDTH:int = 16;
		
		
        // EN: button "up"
		protected var upButton:Button;

        // EN: button "down"
		protected var downButton:Button;

        // EN: shift value on mouse wheel scroll (pixels)
		protected var _mouseDelta:int = 15;

        // EN: shift value on button up/down click (pixels)
		protected var _stepButtonScroll:int = 15;

        // EN: scroll up flag (when you press the up/down button)
		protected var scrollUp:Boolean = false;

        // EN: delay timer on mouse wheel scroll
		protected var timer:Timer;

        // EN: shift of scroll position
		protected var offsetScrollPosition:Number = 0;

        // EN: distance between buttons and the scroller
//		private var space:int = 1;
		protected var space:int = 0;

        // EN: wait a timer for subsequent scroll (when you press the up/down button)
		protected var stepTimer:Timer;

        // EN: scroll holding the up/down button
		protected var stepStopTimer:Timer;

		
		
		/**
		 * Constructor 
		 * 
		 */
		public function ScrollBar() {

			timer = new Timer(2);
			timer.addEventListener(TimerEvent.TIMER, updateScrollPosition);

			stepTimer = new Timer(145);
			stepStopTimer = new Timer(50);
			stepTimer.addEventListener(TimerEvent.TIMER, startStepScroll);
			stepStopTimer.addEventListener(TimerEvent.TIMER, updateStepScroll);

			super();
			
			setSkin();
		}
		
		/**
		 * 设置皮肤
		 */
		protected function setSkin():void
		{
			/*
			// EN: scroller
			var scroller:ScrollButton = new ScrollButton(MainSkin.CHAT_THUMB_UP, 
				MainSkin.CHAT_THUMB_DOWN, MainSkin.CHAT_THUMB_OVER, null, new Rectangle(5, 9, 4, 26));
			scroller.autoHeight = false;
			//			scroller.autoHeight = true;
			//			scroller.icon = new Bitmap(ScrollBarSkin.iconLineBD);
			scroller.mouseEnabled = true;
			thumb = scroller;
			
			//			this.track = new Track();
			this.track = new Track(MainSkin.CHAT_TRACK_SKIN);
			_track.mouseEnabled = true;
			
			// EN: button "up"
			upButton = new Button(MainSkin.CHAT_UPBTN_UP, MainSkin.CHAT_UPBTN_UP, MainSkin.CHAT_UPBTN_OVER);
			//			upButton.icon = new Bitmap(ScrollBarSkin.iconUpBD);
			upButton.mouseEnabled = true;
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			upButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(upButton);
			
			// EN: button "down"
			downButton = new Button(MainSkin.CHAT_DOWNBTN_UP, MainSkin.CHAT_DOWNBTN_DOWN, MainSkin.CHAT_DOWNBTN_OVER);
			//			downButton.icon = new Bitmap(ScrollBarSkin.iconDownBD);
			downButton.mouseEnabled = true;
			downButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			downButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(downButton);
			*/
			// EN: set the width
			
			var scroller:ScrollButton = new ScrollButton(CommonSkin.scbThumbUpSkin, 
				CommonSkin.scbThumbDownSkin, CommonSkin.scbThumbOverSkin, null, new Rectangle(5, 6, 15, 18),CommonSkin.scbTrackIconSkin);
			scroller.autoHeight = false;
			//			scroller.autoHeight = true;
			//			scroller.icon = new Bitmap(ScrollBarSkin.iconLineBD);
			scroller.mouseEnabled = true;
			thumb = scroller;
			
			//			this.track = new Track();
			this.track = new Track(CommonSkin.scbTrackSkin);
			_track.mouseEnabled = true;
			
			// EN: button "up"
			upButton = new Button(CommonSkin.scbUpButtonUpSkin, CommonSkin.scbUpButtonDownSkin, CommonSkin.scbUpButtonOveSkin);
			//			upButton.icon = new Bitmap(ScrollBarSkin.iconUpBD);
			upButton.mouseEnabled = true;
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			upButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(upButton);
			
			// EN: button "down"
			downButton = new Button(CommonSkin.scbDownButtonUpSkin, CommonSkin.scbDownButtonDownSkin, CommonSkin.scbDownButtonOveSkin);
			//			downButton.icon = new Bitmap(ScrollBarSkin.iconDownBD);
			downButton.mouseEnabled = true;
			downButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			downButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(downButton);
			
			_width = calculateWidth(_width);
		}
		
		public function get stepScroll():int {
			
			return _stepButtonScroll;
		}
		

		public function set stepScroll(value:int):void {
			
			_stepButtonScroll = value;
		}

		
		override public function onMouseWheel(e:MouseEvent):void {
			
			var value:int = Math.floor(Math.abs(e.delta)/2);
			var delta:int = (e.delta < 0 ? -1 : 1) * (value > 0 ? value : 1);
			offsetScrollPosition = delta * _mouseDelta;
			timer.stop();
			timer.start();
		}

		
		public function get mouseDelta():int {
			
			return _mouseDelta;
		}

		
		public function set mouseDelta(value:int):void {
			
			_mouseDelta = value;
		}

		
		protected function updateScrollPosition(e:Event):void {
			
			timer.stop();

			_scrollPosition -= offsetScrollPosition;
			if (_maxScrollPosition > 0)
				generateChangePositionEvent();
			MouseManager.update();
		}
		

        // EN: return fixed width
		override protected function calculateWidth(value:int):int {
			
			return NumericConst.scrollBarWidth;
		}

		
        // EN: if height value is less than the specified value, then return minimal height value
		override protected function calculateHeight(value:int):int {
			
			if (value < 60) {
				
				return 60;
			} else {
				
				return value;
			}
		}
		
		
		override protected function generateChangePositionEvent():void {
			
			if (_scrollPosition < 1)
				_scrollPosition = 0;

			if (_scrollPosition > _maxScrollPosition)
				_scrollPosition = _maxScrollPosition;

//			trace("_scrollPosition:", _scrollPosition, "_thumb.height:", _thumb.height, "thumbMaxSize:", thumbMaxSize, "_maxScrollPosition:", _maxScrollPosition); 
			_thumb.y = space + upButton.height + _padding + int(_scrollPosition * (thumbMaxSize - _thumb.height) / _maxScrollPosition);

			if (_scrollPosition != _oldScrollPosition) {
				
				dispatchEvent(new Event(ScrollBarEvent.SCROLL_CHANGE));
				_oldScrollPosition = _scrollPosition;
			}
		}

		
		/**
         *
         * EN: Draw
         *
		 */
		override protected function draw():void {
			
			// 上、下按钮
			upButton.y = _padding;
			upButton.x = 2;
			downButton.y = _height - _padding - downButton.height;
			downButton.x = 2;
			
			thumbMaxSize = _height - space * 2 - _padding * 2 - upButton.height - downButton.height;
			ratio = (_maxScrollPosition + (_height - space * 2 - upButton.height - downButton.height)) / thumbMaxSize;

			
			// Thumb
			_thumb.width = _width - _padding * 2;
			_thumb.x = _padding;
			
			// Add by Trey
			var autoHeight:Boolean = (_thumb as ScrollButton).autoHeight;

			var thumbHeight:int = int(thumbMaxSize / ratio);
			// Add by Trey
			if(!autoHeight) {
				
				if (thumbHeight < NumericConst.scrollBarWidth) {
					
					_thumb.height = NumericConst.scrollBarWidth;
				} 
				else {
					
					_thumb.height = thumbHeight;
				}
			}
			
			// Add by Trey 
			// TRCKIY: 若_thumb固定大小，
			if(autoHeight ==  false) {
				
//				_maxScrollPosition -= (thumbHeight - _thumb.height);
			}
			
			
			_thumb.y = space + upButton.height + _padding + int(_scrollPosition * (thumbMaxSize - _thumb.height) / _maxScrollPosition);

			
			// Track
			_track.height = _height - downButton.height - 18;
			
			
			
			_pageScrollSize = _thumb.height * ratio + _padding * 2;
//			trace("_pageScrollSize:", _pageScrollSize, _thumb.height, ratio);

			generateChangePositionEvent();
			
			
			// 微调
			_track.x += 1;
			_track.y = (_height - _track.height) >> 1;
			
			_thumb.x = 1.4;
		}

		
		protected function onMouseDown(e:MouseEvent):void {
			
			if (e.currentTarget == upButton) {
				scrollUp = true;
			} else {
				scrollUp = false;
			}
			
            // EN update scrollBar position
			updateStepScroll();
			
            // EN: start a timer. While the button is pressed, scrolling occurs until the key up
			stepTimer.start();
		}

		
		protected function onMouseUp(e:MouseEvent):void {
			
			stepTimer.stop();
			stepStopTimer.stop();
		}
		
		
        // EN: start a timer when pressed scrolling up/down button
		protected function startStepScroll(e:Event):void {
			
			stepTimer.stop();
			stepStopTimer.stop();
			stepStopTimer.start();
		}
		
		
        // EN: scrolling when pressed scrolling up/down button
		protected function updateStepScroll(e:Event = null):void {
			
			if (scrollUp) {
				_scrollPosition -= _stepButtonScroll;
			} else {
				_scrollPosition += _stepButtonScroll;
			}
			
//			trace("_scrollPosition:", _scrollPosition);
			
			generateChangePositionEvent();
		}
	}
}
