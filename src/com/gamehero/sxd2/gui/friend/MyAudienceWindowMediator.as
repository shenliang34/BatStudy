package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_LISTENERS_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import flash.events.Event;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-18 下午12:45:03
	 * 
	 */
	public class MyAudienceWindowMediator extends Mediator
	{
		[Inject]
		public var view:MyAudienceWindow;
		
		private var gameService:GameService;
		
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}
		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			gameService = GameService.instance;
			
			this.addViewListener(FriendEvent.GET_FRIEND_LIST,onGetFriendHandle);
			addViewListener(FriendEvent.GET_AUDIENCE_LIST,onGetAudienceHandler);
			view.updateListener();
			dispatch(new FriendEvent(FriendEvent.REFRESH_FRIEND_LIST));
			gameService.addEventListener(MSGID.MSG_FRIEND_LISTENERS.toString(),onUpdateAudienceHandler);
		}
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onGetFriendHandle(event:FriendEvent):void
		{
			
		}
		/**
		 *获取我的听众列表 
		 * @param event
		 * 
		 */		
		private function onGetAudienceHandler(event:FriendEvent):void
		{
			// TODO Auto Generated method stub
			gameService.send(MSGID.MSG_FRIEND_LISTENERS);
		}
		
		private function onUpdateAudienceHandler(event:GameServiceEvent):void
		{
			// TODO Auto Generated method stub
			var respones:RemoteResponse = event.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				var ack:MSG_LISTENERS_ACK = new MSG_LISTENERS_ACK();
				if(!respones.protoBytes) return ;
				ack.mergeFrom(respones.protoBytes);
				
				FriendModel.inst.listeners = ack.listeners;
				
				view.updateListener(ack.listeners);
			}
		}
		
		private function onRefreshAudienceHandler(event:FriendEvent):void
		{
			// TODO Auto-generated method stub
			view.initPage();
		}
		
	}
}