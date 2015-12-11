package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.PlayMovie;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	
	
	/**
	 * 场景动画播放
	 */
	public class GotoMovieCmd extends BaseCmd
	{
		private var _frame:int;
		private var _endFrame:int = -1;
		
		
		public function GotoMovieCmd()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_frame = int(xml.@frame);
			_endFrame = (xml.@endFrame != undefined) ? xml.@endFrame : -1;
		}
		
		
		override public function triggerCallBack(callBack:Function = null):void
		{
			super.triggerCallBack(callBack);
			
			PlayMovie.inst.gotoAndPlay(_frame, _endFrame, complete);
		}
	}
}