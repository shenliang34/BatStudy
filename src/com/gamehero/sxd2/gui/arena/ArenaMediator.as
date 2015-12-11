package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.event.ArenaEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 竞技场mediator
	 * @author xuwenyi
	 * @create 2015-09-29
	 **/
	public class ArenaMediator extends Mediator
	{
		[Inject]
		public var view:ArenaView;
		
		
		
		public function ArenaMediator()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			super.initialize();
			
			this.addViewListener(ArenaEvent.ARENA_INFO , arenaInfo);
			this.addViewListener(ArenaEvent.ARENA_START_FIGHT , arenaStartFight);
			this.addViewListener(ArenaEvent.ARENA_BUY_TICKET , arenaBuyTicket);
			this.addViewListener(WindowEvent.HIDE_FULLSCREEN_VIEW , close);
			
			GameService.instance.addEventListener(MSGID.MSGID_UPDATE_ARENA.toString() , onUpdateArena);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 移除事件
			this.removeViewListener(ArenaEvent.ARENA_INFO , arenaInfo);
			this.removeViewListener(ArenaEvent.ARENA_START_FIGHT , arenaStartFight);
			this.removeViewListener(ArenaEvent.ARENA_BUY_TICKET , arenaBuyTicket);
			this.removeViewListener(WindowEvent.HIDE_FULLSCREEN_VIEW , close);
			
			GameService.instance.removeEventListener(MSGID.MSGID_UPDATE_ARENA.toString() , onUpdateArena);
		}
		
		
		
		
		
		
		/**
		 * 获取竞技场面板信息
		 * */
		private function arenaInfo(e:ArenaEvent):void
		{
			GameService.instance.send(MSGID.MSGID_ARENA_INFO);
		}
		
		
		
		
		
		
		/**
		 * 开始竞技
		 * */
		private function arenaStartFight(e:ArenaEvent):void
		{
			GameService.instance.send(MSGID.MSGID_ARENA_START_FIGHT);
		}
		
		
		
		
		
		/**
		 * 购买门票
		 * */
		private function arenaBuyTicket(e:ArenaEvent):void
		{
			GameService.instance.send(MSGID.MSGID_ARENA_BUY_TICKET);
		}
		
		
		
		
		
		/**
		 * 竞技场面板信息响应
		 * */
		private function onUpdateArena(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes)
			{
				var ack:MSG_UPDATE_ARENA_ACK = new MSG_UPDATE_ARENA_ACK();
				ack.mergeFrom(response.protoBytes);
				GameService.instance.debug(response , ack);
				
				view.updateUI(ack);
			}
		}
		
		
		
		
		
		/**
		 * 退出竞技场
		 * */
		private function close(e:WindowEvent):void
		{
			this.dispatch(e);
		}
		
	}
}