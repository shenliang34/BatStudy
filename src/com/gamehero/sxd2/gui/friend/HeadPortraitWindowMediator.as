package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午12:09:20
	 * 
	 */
	public class HeadPortraitWindowMediator extends Mediator
	{
		[Inject]
		public var view:HeadPortraitWindow;
		public function HeadPortraitWindowMediator()
		{
			
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}
		protected function onSelectIcon(event:Event):void
		{
			// TODO Auto-generated method stub
			var index:int = view.iconListGrid.selectIndex;
			FriendModel.inst.myIconId = view.iconList[index];
			dispatch(new Event(FriendEvent.CHANGE_ICON));
			//eventDispatcher.dispatchEvent(new Event(FriendEvent.CHANGE_ICON));
		}
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			view.iconListGrid.addEventListener(Event.SELECT,onSelectIcon);
		}
		
	}
}