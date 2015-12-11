package com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar
{
	import flash.events.MouseEvent;
	
	/**
	 * 聊天框滚动条
	 * @author xuwenyi
	 * @create 2013-10-24
	 **/
	public class ChatScrollBar extends ScrollBar
	{
		
		/**
		 * 构造函数
		 * */
		public function ChatScrollBar()
		{
			super();
		}
		
		
		
		/**
		 * 复写滚动函数
		 * */
		override public function onMouseWheel(e:MouseEvent):void
		{	
			var value:int = Math.floor(Math.abs(e.delta*2));
			var delta:int = (e.delta < 0 ? -1 : 1) * (value > 0 ? value : 1);
			offsetScrollPosition = delta * _mouseDelta;
			timer.stop();
			timer.start();
		}
	}
}