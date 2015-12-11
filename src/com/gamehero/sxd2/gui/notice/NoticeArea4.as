package com.gamehero.sxd2.gui.notice
{
	import com.gamehero.sxd2.gui.quickUse.QuickUseManager;
	import com.gamehero.sxd2.gui.quickUse.QuickUseWindow;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class NoticeArea4 extends Sprite
	{
		
		private var _quickUseWindow:QuickUseWindow;
		
		private var _tween:TweenMax;
		
		private var _quickUseWinIsShow:Boolean;
		
		public function NoticeArea4()
		{
			super();
		}
		
		public function initUI():void
		{
			
		}
		
		
		/**
		 * 快速购买窗口是否正在显示 
		 * @return 
		 * 
		 */		
		public function get quickUseWinIsShow():Boolean
		{
			if(_quickUseWindow == null) return false;
			return _quickUseWindow.parent ? true : false;
		}

		public function set quickUseWinIsShow(value:Boolean):void
		{
			_quickUseWinIsShow = value;
		}
		/**
		 * 展示快速购买界面 
		 * @param pro
		 * 
		 */
		public function showQuickUse(pro:PRO_Item):void
		{
			if(_quickUseWindow == null)
			{
				_quickUseWindow = new QuickUseWindow();
			}
			addChild(_quickUseWindow);
			_quickUseWindow.x = width;
			_quickUseWindow.y = height - _quickUseWindow.height;
			_tween = TweenMax.to(_quickUseWindow , .2 , {x:width - _quickUseWindow.width, onComplete:stopTween});
			_quickUseWindow.onShow(pro);
			
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			
			if(value)
			{
				QuickUseManager.inst.start();
			}
			else
			{
				QuickUseManager.inst.stop();
			}
		}
		
		
		private function stopTween():void
		{
			if(_tween) 
			{
				stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));//强制鼠标来个move事件,方便连续点击
				_tween.kill();
				_tween = null;
			}
		}
		/**
		 * 必须给定一个固定的宽高，否则动态添加组件的时候无法准确对位。 
		 * @return 
		 * 
		 */		
		override public function get width():Number
		{
			return 200;
		}
		
		
		override public function get height():Number
		{
			return 200;
		}
	}
}