package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * 普通的文本飘字
	 * @author weiyanyu
	 * 创建时间：2015-8-26 下午4:45:40
	 * 
	 */
	public class FloatTips
	{
		/**
		 * 道具动画播放间隔控制Timer 
		 */
		private var _timer:Timer;
		
		private var _labelList:Vector.<String> = new Vector.<String>();
		private static var _instance:FloatTips;
		private var tipsObj:Object;
		
		
		public static function get inst():FloatTips
		{
			if(_instance == null)
			{
				_instance = new FloatTips();
			}
			return _instance;
		}
		
		public function FloatTips()
		{
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			if(_labelList.length > 0)
			{
				var text:String = _labelList.shift();
				var label:LabelTip = new LabelTip();
				var tipsX:int;
				var tipsY:int;
				var tipsStr:String;
				if(tipsObj)
				{
					label.x = tipsObj.x;
					label.y = tipsObj.y;
					tipsStr = tipsObj.tipsStr;
					tipsObj.displayer.addChild(label);
				}
				else
				{
					var currentView:SceneViewBase = SXD2Main.inst.currentView;
					if(currentView == null) return;
					try
					{//有时候场景没有初始化 或者 人物没有初始化的时候，无法获得主角的一些属性，会报错。
						var pt:Point = currentView.rolePoint;
						var rect:Rectangle = SXD2Main.inst.currentView.ROLE.activeRect;
						tipsX = pt.x + (rect.width - label.width >> 1);
						tipsY = pt.y - rect.height - MapConfig.ROLE_NAME_OFFSET;
						tipsStr = text;
						
						SXD2Main.inst.currentView.addChild(label);
					}
					catch(e:Error)
					{
						
					}	
				}
				
				label.x = tipsX;
				label.y = tipsY;
				try
				{
					label.text = tipsStr;
				} 
				catch(error:Error) 
				{
					trace(label + "---" + tipsStr);
				}
				
				
			}
			else
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,onTimer);
				_timer = null;
			}
			
		}
		/**
		 * 关闭头顶飘字 
		 * 
		 */		
		public function stop():void
		{
			if(_timer)
				_timer.stop();
		}
		/**
		 * 开启头顶飘字 
		 * 
		 */		
		public function start():void
		{
			if(_timer)
				_timer.start();
		}
		
		/**
		 *  
		 * @param text 文本
		 * 
		 */		
		public function show(text:String,obj:Object=null,delayTime:int = 100):void
		{
			tipsObj = obj;
			_labelList.push(text);
			
			if(!_timer)
			{
				_timer = new Timer(delayTime);
				_timer.addEventListener(TimerEvent.TIMER,onTimer);
				_timer.start();
			}
			
		}
	}
}
