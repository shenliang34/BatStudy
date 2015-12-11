package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.util.WasynManager;
	import com.gamehero.sxd2.drama.base.BaseCmd;

	/**
	 *等待 
	 * @author wulongbin
	 * 
	 */	
	public class WaitCmd extends BaseCmd
	{
		private var _time:int;
		public function WaitCmd()
		{
			super();
		}
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_time=xml.@time;
		}
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			WasynManager.instance.addFuncByTimer(complete,_time);
		}
	}
}