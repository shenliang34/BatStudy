package com.gamehero.sxd2.common
{
	
	import flash.display.Sprite;
	
	/**
	 * 首字大写的位图数字 
	 * @author xuqiuyang
	 * 2014-6-4
	 */	
	public class SpecialBitmapNumber extends Sprite
	{
		private var _battleEfNumLb:BitmapNumber;
		private var _battleEfNumHeadLb:BitmapNumber;
		
		public var indentX:int;
		
		private var _num:Number = 0;
		
		public function SpecialBitmapNumber(num:int = 0)
		{
			_num = num;
			
			_battleEfNumLb = new BitmapNumber(BitmapNumber.B);
			_battleEfNumLb.indentX = 2;
			addChild(_battleEfNumLb);
			
			_battleEfNumHeadLb = new BitmapNumber(BitmapNumber.BT);
			addChild(_battleEfNumHeadLb);
			
			indentX = 2;
			
			update(num);
		}
		
		/**
		 * 更新 
		 * @param num
		 * 
		 */		
		public function update(num:int):void
		{
			_num = num;
			
			var battleEF:String = num + "";
			var firstNum:String = battleEF.substr(0,1);
			battleEF = battleEF.substr(1);
			
			_battleEfNumLb.updateString(BitmapNumber.B, battleEF);
			_battleEfNumHeadLb.updateString(BitmapNumber.BT, firstNum);
			
			_battleEfNumLb.x = _battleEfNumHeadLb.width - indentX;
			_battleEfNumLb.y = _battleEfNumHeadLb.height - _battleEfNumLb.height;
		}
		
		public function get number():Number
		{
			return _num;
		}
	}
}