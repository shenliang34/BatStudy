package com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;
	
	use namespace alternativagui;

	public class BoldScrollBar extends ScrollBar
	{
		/**
		 * 加粗版的ScorlBar 
		 * @author Trey
		 * @create-date 2013-9-7
		 */
		public function BoldScrollBar()
		{
			super();
		}
		
		override protected function setSkin():void
		{
			// EN: scroller
			var scroller:ScrollButton = new ScrollButton(MainSkin.bScbThumbUpSkin, MainSkin.bScbThumbDownSkin, 
				MainSkin.bScbThumbOverSkin, null, new Rectangle(5, 9, 4, 26), MainSkin.bScbThumbIconSkin);
			scroller.autoHeight = false;
			//			scroller.autoHeight = true;
			//			scroller.icon = new Bitmap(ScrollBarSkin.iconLineBD);
			scroller.mouseEnabled = true;
			thumb = scroller;
			
			//			this.track = new Track();
			this.track = new Track(MainSkin.bScbTrackSkin);
			_track.mouseEnabled = true;
			
			// EN: button "up"
			upButton = new Button(MainSkin.bScbUpButtonUpSkin, MainSkin.bScbUpButtonDownSkin, MainSkin.bScbUpButtonOveSkin);
			//			upButton.icon = new Bitmap(ScrollBarSkin.iconUpBD);
			upButton.mouseEnabled = true;
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			upButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(upButton);
			
			// EN: button "down"
			downButton = new Button(MainSkin.bScbDownButtonUpSkin, MainSkin.bScbDownButtonDownSkin, MainSkin.bScbDownButtonOveSkin);
			//			downButton.icon = new Bitmap(ScrollBarSkin.iconDownBD);
			downButton.mouseEnabled = true;
			downButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			downButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(downButton);
			
			// EN: set the width
			_width = calculateWidth(_width);
		}
		
		override protected function draw():void 
		{
			// 上、下按钮
			upButton.y = _padding;
			
			downButton.y = _height - _padding - downButton.height;
			
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
			_track.x = -1;
			_track.y = (_height - _track.height) >> 1;
			
			_thumb.x = 0.4;
		}
		
		// EN: return fixed width
		override protected function calculateWidth(value:int):int 
		{
			return NumericConst.scrollBarWidth;
		}
		
	}
}