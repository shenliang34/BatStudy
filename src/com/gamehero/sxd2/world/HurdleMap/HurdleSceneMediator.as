package com.gamehero.sxd2.world.HurdleMap
{
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.NPCEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_AWARD_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.views.SceneMediatorBase;
	
	import flash.events.Event;
	
	import bowser.remote.RemoteResponse;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-7 下午1:59:16
	 * 
	 */
	public class HurdleSceneMediator extends SceneMediatorBase
	{
		[Inject]
		public var view:HurdleSceneView;
		
		private var _gameService:GameService;
		
		public function HurdleSceneMediator()
		{
			super();
			_gameService = GameService.instance;
		}
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			viewbase = view;
			super.initialize();
			view.addEventListener(MainEvent.SHOW_BATTLE,onPk);
			_gameService.addEventListener(MSGID.MSGID_INSTANCE_AWARD.toString(),onInstanceAward);
			
			this.addViewListener(MapEvent.HURDL_EMOVE, hurdleMoveHandle);
			this.addContextListener(MapEvent.HURDL_EMOVE, hurdleMoveHandle);
		}
		protected function onInstanceAward(event:GameServiceEvent):void
		{
			var remote:RemoteResponse = event.data as RemoteResponse;
			if(remote.errcode == "0")
			{
				var award:MSG_INSTANCE_AWARD_ACK = new MSG_INSTANCE_AWARD_ACK();
				award.mergeFrom(remote.protoBytes);
				view.award = award;
			}
		}
		protected function onPk(event:Event):void
		{
			eventDispatcher.dispatchEvent(new MainEvent(MainEvent.SHOW_BATTLE));
		}
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			view.removeEventListener(MainEvent.SHOW_BATTLE,onPk);
			_gameService.removeEventListener(MSGID.MSGID_INSTANCE_AWARD.toString(),onInstanceAward);
			
			this.removeContextListener(MapEvent.HURDL_EMOVE, hurdleMoveHandle);
		}
		
		private function hurdleMoveHandle(e:MapEvent):void
		{
			view.hurdleMoveHandle();
		}
	}
}