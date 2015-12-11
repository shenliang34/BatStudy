package com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	import com.riaidea.text.RichTextField;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.container.scrollPane.ScrollPane;
	import alternativa.gui.event.ScrollBarEvent;
	
	use namespace alternativagui;
	/**
	 * 普通自定义滚动面板
	 * @author xuwenyi
	 * @create 2013-10-23
	 **/
	public class NormalScrollPane extends ScrollPane
	{
		// 正常滚动条
		public static const SCROLL_BAR_NOMAL:int = 0;
		// 加粗滚动条
		public static const SCROLL_BAR_BOLD:int = 1;
		
		private var _mouseDelta:int;
		
		private var _stepScroll:int;
		
		
		/**
		 * 构造函数
		 * */
		public function NormalScrollPane(scrollBarType:int = SCROLL_BAR_NOMAL)
		{
			// 普通滚动条
			if(scrollBarType == SCROLL_BAR_NOMAL)
			{
				this.scrollBar = new ScrollBar();
			}
			/*
			else if(scrollBarType == SCROLL_BAR_BOLD)
			{
				this.scrollBar = new BoldScrollBar();
			}
			*/
			// 单次滚动量(像素)
			ScrollBar(scrollBar).mouseDelta = 50;
			ScrollBar(scrollBar).stepScroll = 20;
		}
		
		
		
		
		public function get stepScroll():int
		{
			return _stepScroll;
		}

		public function set stepScroll(value:int):void
		{
			_stepScroll = value;
			ScrollBar(scrollBar).stepScroll = value;
		}

		/**
		 * 鼠标 
		 */
		public function get mouseDelta():int
		{
			return _mouseDelta;
		}

		/**
		 * @private
		 */
		public function set mouseDelta(value:int):void
		{
			_mouseDelta = value;
			ScrollBar(scrollBar).mouseDelta = value;
		}

		/**
		 * 刷新
		 * */
		public function refresh():void
		{
			this.draw();
		}
		
		override protected function draw():void {
//			super.draw();
			
			var maxScroll:int = 0
			
			if (_content != null) {
				maxScroll = _content.height - _height + _padding * 2;
				if (_scrollBar != null) {
					_scrollBar.visible = maxScroll > 0;
					_scrollBar.maxScrollPosition = maxScroll;
				}
			}
			
			
			var contentWidth:int = _width - ((maxScroll && _scrollBar!=null) > 0 ? _scrollBar.width : 0) - _padding * (maxScroll > 0 ? 3 : 2)
			if (_scrollBar != null) {
				_scrollBar.x = contentWidth + _padding * 2;
				_scrollBar.y = _padding;
				_scrollBar.height = _height - _padding * 2;
				
				_contentScrollRect = new Rectangle(0, _scrollBar.scrollPosition, contentWidth, _height - _padding * 2);
				_contentContainer.scrollRect = _contentScrollRect;
				_contentContainer.x = _contentContainer.y = _padding;
//				_scrollBar.draw();
			}
			if (_background != null) {
				_background.width = _width;
				_background.height = _height;
			}
			
		}
	}
}