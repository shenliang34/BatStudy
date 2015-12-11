package com.gamehero.sxd2.gui.fate
{
	import com.gamehero.sxd2.event.FateEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_UPDATE_FATE_ACK;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 命途窗口中介
	 * @author zhangxueyou
	 * @create 2015-11-4
	 **/
	public class FateWindowMediator extends Mediator
	{
		
		[Inject] 
		public var view:FateWindow;//窗口对象
		
		/**
		 *构造 
		 * 
		 */		
		public function FateWindowMediator()
		{
			super();	
		}
		
		/**
		 *窗口信息请求
		 * @param e
		 * 
		 */		
		private function fateInfoHandle(e:FateEvent):void
		{
			GameService.instance.send(MSGID.MSGID_FATE_INFO);
		}
		
		/**
		 *抽签请求
		 * @param e
		 * 
		 */
		private function fateRollHandle(e:FateEvent):void
		{
			GameService.instance.send(MSGID.MSGID_FATE_ROLL);
		}
		
		/**
		 *更新命途信息 
		 * @param e
		 * 
		 */		
		private function updateFateInfoHandle(e:GameServiceEvent):void
		{
			var respones:RemoteResponse = e.data as RemoteResponse;
			if(respones.errcode == "0")
			{
				var ack:MSG_UPDATE_FATE_ACK = new MSG_UPDATE_FATE_ACK();
				
				if(!respones.protoBytes) return;
				
				ack.mergeFrom(respones.protoBytes);
				view.initWindowInfo(ack.fate);
			}
		}
		
		/**
		 *销毁 
		 * 
		 */		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
			
			GameService.instance.removeEventListener(MSGID.MSGID_UPDATE_FATE.toString(), updateFateInfoHandle);
			
			view.removeEventListener(FateEvent.FATEINFO,fateInfoHandle);
			view.removeEventListener(FateEvent.FATEROLL,fateRollHandle);
		}
		
		/**
		 *初始化 
		 * 
		 */		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			
			GameService.instance.addEventListener(MSGID.MSGID_UPDATE_FATE.toString(), updateFateInfoHandle);
			
			view.addEventListener(FateEvent.FATEINFO,fateInfoHandle);
			view.addEventListener(FateEvent.FATEROLL,fateRollHandle);
		}
		
	}
}