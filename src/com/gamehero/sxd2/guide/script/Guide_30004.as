package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.gui.chess.ChessView;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.util.WasynManager;
	
	/**
	 *巫师战旗 
	 * @author wulongbin
	 * 
	 */	
	public class Guide_30004 extends Guide
	{
		private var window:ChessView;
		
		
		public function Guide_30004()
		{
			super();
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			window = ChessView.instance;
			WasynManager.instance.addFuncByFrame(checkChessView);
		}
		
		
		
		
		private function checkChessView():void
		{
			if(window && window.visible)
			{
				WasynManager.instance.removeFuncByFrame(checkChessView);
				popupClickGuide(window.closeBtn, false, Lang.instance.trans("AS_1416"), Guide.Direct_Right, guideCompleteHandler);
			}
		}
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent = null):void
		{
			window = null;
			
			super.guideCompleteHandler(e);
		}
	}
}