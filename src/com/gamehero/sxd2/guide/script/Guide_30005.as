package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.gui.chess.ChessView;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * 巫师战旗引导(狼骑兵战败)
	 * @author xuwenyi
	 * @create 2014-06-03
	 **/
	public class Guide_30005 extends Guide
	{
		private var window:ChessView;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_30005()
		{
			super();
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object=null):void
		{
			super.playGuide(info, callBack, param);
			
			window = ChessView.instance;
			if(window && window.parent)
			{
				var stone:DisplayObject = window.nextStone;
				if(stone)
				{
					this.popupClickGuide(stone, false , Lang.instance.trans("AS_1417"), Guide.Direct_Down , finish);
				}
				else
				{
					this.finish();
				}
			}
			else
			{
				this.finish();
			}
		}
		
		
		
		
		
		private function finish(e:FormationEvent = null):void
		{
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			this.clear();
			
			super.guideCompleteHandler();
		}
		
		
		
		
		
		private function clear():void
		{
			window = null;
		}
	}
}