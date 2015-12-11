package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.event.ArenaEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_RANKING_LIST_ACK;
	import com.gamehero.sxd2.pro.MSG_RANKING_LIST_REQ;
	import com.gamehero.sxd2.pro.PRO_RankingType;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 竞技场排行榜
	 * @author xuwenyi
	 * @create 2015-10-27
	 **/
	public class ArenaRankMediator extends Mediator
	{
		[Inject]
		public var view:ArenaRankWindow;
		
		
		
		public function ArenaRankMediator()
		{
			super();
		}
		
		
		
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			super.initialize();
			
			this.addViewListener(ArenaEvent.ARENA_RANKING_LIST , rankingList);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 移除事件
			this.removeViewListener(ArenaEvent.ARENA_RANKING_LIST , rankingList);
		}
		
		
		
		
		
		
		/**
		 * 获取排行榜数据
		 * */
		private function rankingList(e:ArenaEvent):void
		{
			var req:MSG_RANKING_LIST_REQ = new MSG_RANKING_LIST_REQ();
			req.type = PRO_RankingType.ARENA;
			
			GameService.instance.send(MSGID.MSGID_RANKING_LIST , req , onRankingList);
		}
		
		
		
		
		
		private function onRankingList(response:RemoteResponse):void
		{
			if(response.errcode == "0" && response.protoBytes)
			{
				var ack:MSG_RANKING_LIST_ACK = new MSG_RANKING_LIST_ACK();
				ack.mergeFrom(response.protoBytes);
				GameService.instance.debug(response , ack);
				
				view.updateRankList(ack);
			}
		}
		
	}
}