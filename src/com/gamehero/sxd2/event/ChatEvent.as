package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 聊天事件
	 * @author xuwenyi
	 * @create 2013-10-14
	 **/
	public class ChatEvent extends BaseEvent
	{
		// 通信
		public static const CHAT:String = "chat";
		public static const CHAT_PUSH:String = "chatPush";
		public static const CHAT_HISTORY:String = "chatHistory";
		
		// 选择表情
		public static const FACE_SELECT:String = "faceSelect";
		// 移除私聊成员
		public static const REMOVE_MEMBER:String = "removeMember";
		// 私聊窗口添加新联系人
		public static const ADD_NEW_CHATER:String = "addNewChater";
		// 聊天记录更新
		public static const CHAT_HISTORY_UPDATE:String = "chatHistoryUpdate";
		// 点击系统公告关闭按钮
		public static const NOTICE_CLOSE_CLICK:String = "noticeCloseClick";
		// 点击查看其它玩家信息
		public static const ANOTHER_PLAYER_INFO_CLICK:String = "anotherPlayerInfoClick";
		//展示道具
		public static const CHATSHOWITEMTIPS:String = "chatShowItemTipsHandle";
		
		
		
		public function ChatEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		override public function clone():Event
		{
			return new ChatEvent(type , data);
		}
	}
}