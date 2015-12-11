package  com.gamehero.sxd2.gui.friend {
	
	
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_FRIEND_CHAT_REQ;
	import com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_FRIEND_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import flash.events.Event;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * FriendWindow Mediator
	 * @author Trey
	 * @create-date 2013-10-25
	 */
	public class FriendWindowMediator extends Mediator {
		
		
		[Inject]
		public var view:FriendWindow;
		
		
		private var gameService:GameService;
		/**
		 * Constructoer
		 *
		 */
		public function FriendWindowMediator() {
			
			super();
			
		}
		
		override public function set viewComponent(view:Object):void
		{
			super.viewComponent=view;
		}
		
		
		/**
		 * initialize
		 * 
		 */
		override public function initialize():void {
			
			super.initialize();
			gameService = GameService.instance;
			
			this.addViewListener(FriendEvent.GET_FRIEND_LIST,onGetFriendHandle);
			this.addContextListener(FriendEvent.REMOVE_FRIEND_SUCCESS,onRemoveFriendHandle);
			this.addContextListener(FriendEvent.CHANGE_ICON,onChangeIcon);
			
			this.addContextListener(FriendEvent.REFRESH_FRIEND_LIST,onRefreshFriendList);
			
		}
		
		private function onRefreshFriendList(event:FriendEvent):void
		{
			// TODO Auto Generated method stub
			view.updateRelationList();
		}
		/**
		 *修改头像 
		 * @param event
		 * 
		 */		
		private function onChangeIcon(event:Event):void
		{
			// TODO Auto Generated method stub
			var myId:int = FriendModel.inst.myIconId;
			view._playerIcon._iconImage.iconId = myId;
		}		
		/**
		 *成功移除好友 
		 * @param event
		 * 
		 */		
		private function onRemoveFriendHandle(event:FriendEvent):void
		{
			// TODO Auto Generated method stub
			view.removeFriend(event.params);
		}
		
		
		private function onGetFriendHandle(event:FriendEvent):void
		{
//			gameService.send(MSGID.MSGID_ITEM_USE);
		}
		
		/**
		 * destroy
		 * 
		 */
		override public function destroy():void {
			
			super.destroy();
		}
		
		/**
		 * 获得关系列表 
		 * @param relationType
		 * @param page
		 * 
		 */
		private function onGetRelationList(event:*):void {
		}	
		
		
		/**
		 * 获得关系列表返回 
		 * @param event
		 * 
		 */
		private function onGetRelationListOK(event:*):void {
			
		}		
		
		
		/**
		 * 获得关系列表返回 
		 * @param event
		 * 
		 */
		private function onGetRelationInfoOK(event:*):void {
			
		}		
		
		
		/**
		 * 更新关系列表 
		 * @param event
		 * 
		 */
		private function onUpdateRelationList(event:*):void {
		}		
		
		
		/**
		 * 打开窗口
		 * */
		private function onOpenWindow(e:WindowEvent):void {
			
			this.dispatch(e.clone());
		}
	}
}