package com.gamehero.sxd2.drama.cmds.scene
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_ENTER_REQ;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	
	/**
	 * 进入剧情副本指令
	 * @author xuwenyi
	 * @create 2015-11-09
	 **/
	public class EnterHurdleCmd extends BaseCmd
	{
		private var hurdleId:int;
		
		
		/**
		 * 构造函数
		 **/
		public function EnterHurdleCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			hurdleId = xml.@hurdleId;
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var req:MSG_INSTANCE_ENTER_REQ = new MSG_INSTANCE_ENTER_REQ();
			req.instanceId = hurdleId;
			GameService.instance.send(MSGID.MSGID_INSTANCE_ENTER , req , enterInstanceCallBack);
		}
		
		
		
		
		//请求进入副本 返回
		private function enterInstanceCallBack(remote:RemoteResponse):void
		{
			if(remote.errcode == "0")
			{
				GameData.inst.curHurdleId = hurdleId;
			}
			
			complete();
		}
	}
}