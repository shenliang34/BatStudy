package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.base.BaseCmd;

	/**
	 *播放引导 
	 */	
	public class PlayGuideCmd extends BaseCmd
	{
		protected var _guideId:uint;
		
		
		public function PlayGuideCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_guideId = xml.@guideId;
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			//GuideManager.instance.playGuide(_guideId,complete);
		}
	}
}