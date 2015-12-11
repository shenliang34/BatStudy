package com.gamehero.sxd2.util
{
	import flash.display.MovieClip;
	import flash.ui.Mouse;

	/**
	 * pk鼠标
	 * @author weiyanyu
	 * 创建时间：2015-9-2 16:25:23
	 * 
	 */
	public class MouseBattle
	{
		private static var _instance:MouseBattle;
		public static function getInstance():MouseBattle
		{
			if(_instance == null)
				_instance = new MouseBattle();
			return _instance;
		}
		public function MouseBattle()
		{
			if(_instance != null)
				throw "MouseBattle.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		private var _battleMc:MovieClip;
		
		public function setMc(mc:MovieClip):void
		{
			_battleMc = mc;
			_battleMc.mouseEnabled = false;
		}
		/**
		 * 隐藏默认鼠标 
		 * 
		 */		
		public function hide():void
		{
			App.ui.addChild(_battleMc);
			_battleMc.x = App.ui.mouseX;
			_battleMc.y = App.ui.mouseY;
			_battleMc.startDrag(true);
			Mouse.hide();
		}
		/**
		 * 显示默认鼠标 
		 * 
		 */		
		public function show():void
		{
			if(_battleMc.parent == App.ui)
			{
				Mouse.show();
				App.ui.removeChild(_battleMc);
				_battleMc.stopDrag();
			}
		}
	}
}