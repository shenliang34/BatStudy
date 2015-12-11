package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * 人物头顶普通的文本飘字
	 * @author weiyanyu
	 * 创建时间：2015-8-26 下午4:45:40
	 * 
	 */
	public class GameTips
	{
		/**
		 * 道具动画播放间隔控制Timer 
		 */
		private var _timer:Timer;
		
		private var _labelList:Vector.<String> = new Vector.<String>();
		private static var _instance:GameTips;
		
		public static function getInstance():GameTips
		{
			if(_instance == null)
			{
				_instance = new GameTips();
			}
			return _instance;
		}
		
		public function GameTips()
		{
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.start();
		}
		protected function onTimer(event:TimerEvent):void
		{
			if(_labelList.length > 0)
			{
				var text:String = _labelList.shift();
				var label:LabelTip = new LabelTip();
				var currentView:* = SXD2Main.inst.currentView;
				if(currentView == null) return;
				try
				{
					var pt:Point = currentView.rolePoint;
					var rect:Rectangle = SXD2Main.inst.currentView.ROLE.activeRect;
					label.x = pt.x + (rect.width - label.width >> 1);
					label.y = pt.y - rect.height - MapConfig.ROLE_NAME_OFFSET;
					SXD2Main.inst.currentView.addChild(label);
					label.text = text;
				}
				catch(e:Error)
				{
					
				}
		
			}
			
		}
		/**
		 * 关闭头顶飘字 
		 * 
		 */		
		public function stop():void
		{
			_timer.stop();
		}
		/**
		 * 开启头顶飘字 
		 * 
		 */		
		public function start():void
		{
			_timer.start();
		}

		/**
		 *  
		 * @param text 文本
		 * 
		 */		
		public function show(text:String):void
		{
			_labelList.push(text);
		}
	}
}