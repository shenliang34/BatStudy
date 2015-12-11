package com.gamehero.sxd2.vo
{
	import com.greensock.easing.Ease;
	
	import flash.geom.Point;
	
	/**
	 * 壳动画数据
	 * @author xuwenyi
	 * @create 2015-06-19
	 **/
	public class BattleSkillMove
	{
		public var id:String;
		public var delay:Number;
		public var duration:Number;
		public var move:Point;
		public var curve:Point;
		public var angle:Number;
		public var scale:Number;
		public var mirror:Number;
		public var hit:String;
		public var ease:Ease;
		
		public function BattleSkillMove()
		{
		}
	}
}