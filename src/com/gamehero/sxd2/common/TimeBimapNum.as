package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.util.Time;

	/**
	 *时间显示 
	 * @author wulongbin
	 * 
	 */	
	public class TimeBimapNum extends BitmapNumber
	{
		private var _time:uint;
		private var _timeStr:String;
		
		private var _isShowMode1:Boolean = false; 
		
		
		public function TimeBimapNum(type:String = Y, isShowMode1:Boolean = false, indentX:int = 5)
		{
			super(type);
			
			this._isShowMode1 = isShowMode1;
			
			this.indentX = indentX;
		}
		
		
		public function get time():uint
		{
			return _time;
		}
		
		
		public function set time(value:uint):void
		{
			_time = value;
			
			if(_isShowMode1) {

				timeStr = Time.getStringTime1(_time);
			}
			else {
				
				timeStr = Time.getStringTime4(_time);
			}
		}
		
		public function get timeStr():String
		{
			return _timeStr;
		}
		
		public function set timeStr(value:String):void
		{
			_timeStr = value;
			
			updateString(_type, _timeStr);
		}
	}
}