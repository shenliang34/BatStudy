package com.gamehero.sxd2.gui.HurdleReport
{
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleGuideEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_REPORT_ACK;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_REPORT_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.model.MapModel;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午4:26:44
	 * 
	 */
	public class HurdleReportMedia extends Mediator
	{
		[Inject]
		public var view:HurdleReportWindow;
		
		public function HurdleReportMedia()
		{
			super();
		}
		override public function initialize():void
		{
			super.initialize();
			addViewListener(HurdleGuideEvent.REPORT,report);
		}
		
		private function report(e:HurdleGuideEvent):void
		{
			var req:MSG_INSTANCE_REPORT_REQ = new MSG_INSTANCE_REPORT_REQ();
			req.instanceId = e.id;
			GameService.instance.send(MSGID.MSGID_INSTANCE_REPORT,req,reportReq);
		}
		
		private function reportReq(remote:RemoteResponse):void
		{
			// TODO Auto Generated method stub
			if(remote.errcode == "0"&&remote.protoBytes)
			{
				var mesage:MSG_INSTANCE_REPORT_ACK = new MSG_INSTANCE_REPORT_ACK();
				GameService.instance.mergeFrom(mesage, remote.protoBytes);
				GameService.instance.debug(remote, mesage);
				view.updata(mesage);
			}
		}
		override public function destroy():void
		{
			super.destroy();
			removeViewListener(HurdleGuideEvent.REPORT,report);
		}
	}
}