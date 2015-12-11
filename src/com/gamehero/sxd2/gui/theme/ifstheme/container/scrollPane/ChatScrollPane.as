package com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane {
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ChatScrollBar;
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
	 * 聊天用滚动面板
	 * @author xuwenyi
	 * @date 2013-10-21
	 */	
	public class ChatScrollPane extends ScrollPane
	{
		private var _scrollbar:ChatScrollBar;
		private var type:String;	
		
		/**
		 * 构造函数
		 * */
		public function ChatScrollPane(type:String = "left")
		{
			super();
			
			// 滚动条在左边还是右边
			this.type = type;
			
			// 滚动条
			this.scrollBar = new ScrollBar();
		}

		
		
		
		
		/**
		 * 刷新
		 * */
		public function refresh():void
		{
			this.draw();
		}
		
		
		
		
		
		/**
		 * 改变滚动区域
		 * */
		override public function changeScrollRect():void
		{
			// 不做任何改变
		}
		
		
		
		
		
		/**
		 * 拖拽滚动条
		 * */
		override protected function redraw(e:Event = null):void
		{
			switch (e.type)
			{
				case ScrollBarEvent.SCROLL_CHANGE:
					// 滚动文本
					if(_content is RichTextField)
					{
						var rtf:RichTextField = RichTextField(_content);
						var tf:TextField = rtf.textfield;
						var scrollV:int = Math.ceil((scrollBar.scrollPosition/scrollBar.maxScrollPosition) * tf.maxScrollV);
						tf.scrollV = scrollV;
						//如果不在最后一行,则取消自动滚动
						rtf.autoScroll = tf.scrollV == tf.maxScrollV ? true : false;
					}
					break;
				case ScrollBarEvent.SCROLL_START:
					//_content.cacheAsBitmap = true;
					break;
				case ScrollBarEvent.SCROLL_STOP:
					//_content.cacheAsBitmap = false;
					break;
			}
		}
		
		
		
		
		/**
		 * 重绘
		 * */
		override protected function draw():void
		{
			var maxScroll:int = 0;
			var rtf:RichTextField;
			
			if (_content != null) {
				
				// 文本光标的垂直位置
				var scrollHeight:int = _content.height;
				if(_content is RichTextField)
				{
					rtf = RichTextField(_content);
					scrollHeight = (rtf.textfield.maxScrollV-1) * 14 + rtf.viewHeight;
				}
				// 计算最大滚动距离
				maxScroll = scrollHeight - _height + _padding * 2;
				if (_scrollBar != null)
				{
					_scrollBar.visible = maxScroll > 0;
					_scrollBar.maxScrollPosition = maxScroll;
					//若文本允许自动滚动
					if(_content is RichTextField)
					{
						rtf = RichTextField(_content);
						if(rtf.autoScroll == true)
						{
							_scrollBar.scrollPosition = maxScroll;
						}
					}
					else
					{
						_scrollBar.scrollPosition = maxScroll;
					}
				}
			}
			
			
			var contentWidth:int = _width - ((maxScroll && _scrollBar!=null) > 0 ? _scrollBar.width : 0) - _padding * (maxScroll > 0 ? 3 : 2)
			if (_scrollBar != null) 
			{
				// 滚动条在左边
				if(type == "left")
				{
					_scrollBar.x = _padding * 2 - 5;
					// 若出现滚动条
					if(_scrollBar.visible == true)
					{
						_contentContainer.x = 10;
					}
					else
					{
						_contentContainer.x = 0;
					}
				}
				// 滚动条在右边
				else
				{
					_scrollBar.x = contentWidth - _padding * 2;
				}
				_scrollBar.height = _height - _padding * 2;
			}
		}
		
	}
}