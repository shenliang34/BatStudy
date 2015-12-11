package com.gamehero.sxd2.gui.hurdleGuide.components
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import alternativa.gui.base.GUIobject;
	
	/**
	 * 控制连线的动画播放
	 * @author weiyanyu
	 * 创建时间：2015-8-30 下午8:44:28
	 * 
	 */
	public class HurdleGuideLine extends GUIobject
	{
		/**
		 * 连线mc 
		 */		
		private var _lineMc:MovieClip;
		
		private var _endFrame:int;
		
		public function HurdleGuideLine()
		{
			super();
		}
		/**
		 * 设置需要控制的连线 
		 * @param mc
		 * 
		 */		
		public function setMc(mc:MovieClip):void
		{
			_lineMc = mc;
		}
		
		protected function onFrame(event:Event):void
		{
			if(_lineMc.currentFrame >= _endFrame)
			{
				_lineMc.gotoAndStop(_endFrame);
				_lineMc.removeEventListener(Event.ENTER_FRAME,onFrame);
			}
		}
		
		/**
		 * 设置显示节点 
		 * 
		 */		
		public function setLevel(value:int):void
		{
			if(value == 0)
			{
				_lineMc.gotoAndStop(1);
			}
			else
			{
				var fl:FrameLabel = _lineMc.currentLabels[value];
				if(fl == null)
				{
					fl = _lineMc.currentLabels[_lineMc.currentLabels.length - 1];
				}
				if(!_lineMc.hasEventListener(Event.ENTER_FRAME))
					_lineMc.addEventListener(Event.ENTER_FRAME,onFrame);
				_lineMc.gotoAndPlay(1);
				
				_endFrame = fl.frame;
			}
		}
		
		public function clear():void
		{
			if(_lineMc != null)
			{
				_lineMc.removeEventListener(Event.ENTER_FRAME,onFrame);
				_lineMc.stop();
				_lineMc = null;
			}

		}
	}
}