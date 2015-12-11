package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.event.ChatEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 
	 * @author cuixu
	 * @create：2015-11-24
	 **/
	public class ChatHistoryWindowMediator extends Mediator
	{
		[Inject] 
		public var historyView:ChatHistoryWindow;
		
		public function ChatHistoryWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			addContextListener(ChatEvent.CHAT_HISTORY_UPDATE, chatHistoryUpdate);
		}
		
		override public function destroy():void
		{
			super.destroy();
			removeContextListener(ChatEvent.CHAT_HISTORY_UPDATE, chatHistoryUpdate);
		}
		
		private function chatHistoryUpdate(e:ChatEvent):void
		{
			historyView.showChatHistory();
		}
	}
}