package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.drama.base.BaseCmd;

	
	/**
	 * 嵌套播放剧情
	 */	
	public class PlayDramaCmd extends BaseCmd
	{
		private var _dramaId:uint;
		
		
		
		public function PlayDramaCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_dramaId = xml.@dramaId;
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			DramaManager.inst.playDrama(_dramaId,null,complete);
		}
	}
}