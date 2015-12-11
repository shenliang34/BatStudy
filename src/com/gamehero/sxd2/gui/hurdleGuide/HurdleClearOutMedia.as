package com.gamehero.sxd2.gui.hurdleGuide
{
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleClearOutEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_CLEANUP_ACK;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_ENTER_REQ;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-6 上午11:16:48
	 * 
	 */
	public class HurdleClearOutMedia extends Mediator
	{
		[Inject]
		public var view:HurdleClearOutWindow;
		
		private var gs:GameService;
		
		public function HurdleClearOutMedia()
		{
			super();
			gs = GameService.instance;
		}
		
		override public function initialize():void
		{
			super.initialize();
			addViewListener(HurdleClearOutEvent.CLEAR_OUT,onClearOut);
		}
		/**
		 * 点击扫荡 
		 * @param e
		 */		
		private function onClearOut(e:HurdleClearOutEvent):void
		{
			var req:MSG_INSTANCE_ENTER_REQ = new MSG_INSTANCE_ENTER_REQ();
			req.instanceId = e.id;
			gs.send(MSGID.MSGID_INSTANCE_CLEANUP,req,clearOutReq);
		}
		/**
		 * 服务器扫荡返回 
		 * @param event
		 */		
		private function clearOutReq(remote:RemoteResponse):void
		{
			if(remote.errcode == "0"&&remote.protoBytes)
			{
				var award:MSG_INSTANCE_CLEANUP_ACK = new MSG_INSTANCE_CLEANUP_ACK();
				GameService.instance.mergeFrom(award, remote.protoBytes);
				GameService.instance.debug(remote, award);
				view.addReport(award.item);
			}
			else//当无缘故请求扫荡时候停止掉,如体力不足
			{
				view.stopClearOut();//
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			removeViewListener(HurdleClearOutEvent.CLEAR_OUT,onClearOut);
		}
	}
}