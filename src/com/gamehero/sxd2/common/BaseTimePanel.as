package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.util.Time;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.utils.time.TimeTick;
	import bowser.utils.time.TimeTickData;
	
	
	/**
	 * 倒计时面板基类
	 * @author xuwenyi
	 * @create 2014-08-25
	 **/
	public class BaseTimePanel extends Sprite
	{
		// 倒计时文字
		private var timeNumber:BitmapNumber;
		// 倒计时控件
		private var timeTick:TimeTick;
		private var tickData:TimeTickData;
		
		
		/**
		 * 构造函数
		 * */
		public function BaseTimePanel()
		{
			// 时间数字
			timeNumber = new BitmapNumber();
			timeNumber.x = 0;
			timeNumber.y = 88;
			this.addChild(timeNumber);
			
			timeTick = new TimeTick();
			tickData = new TimeTickData(0 , 1000 , updateTime , completeTime);
		}
		
		
		
		
		
		/**
		 * 启动倒计时
		 * */
		public function startTime(duration:int):void
		{
			// 启动计时器
			tickData.duration = duration;
			timeTick.addListener(tickData);
			
			// 转化为"00:00"格式
			var timeStr:String = Time.getStringTime4(duration);
			// 显示
			timeNumber.updateString(BitmapNumber.L , timeStr);
		}
		
		
		
		
		
		
		/**
		 * 更新时间
		 * */
		protected function updateTime(data:TimeTickData):void
		{
			var remainTime:Number = data.remainTime;
			remainTime = Math.floor(remainTime*0.001);
			// 转化为"00:00"格式
			var timeStr:String = Time.getStringTime4(remainTime);
			// 显示
			timeNumber.updateString(BitmapNumber.L , timeStr);
		}
		
		
		
		
		/**
		 * 倒计时结束
		 * */
		protected function completeTime(data:TimeTickData):void
		{
			this.clear();
			
			// 发送完成事件
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			timeTick.removeListener(tickData);
			
			timeNumber.updateString(BitmapNumber.L , "");
		}
	}
}