package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	
	import bowser.utils.data.Vector2D;
	
	/**
	 * 角色移动动画信息
	 * @author xuwenyi
	 * @create 2013-07-11
	 **/
	public class BattleMoveData
	{
		// 移动目标
		public var target:BPlayer;
		// 起始点
		public var from:Vector2D;
		// 终点
		public var to:Vector2D;
		// 跑动还是跳跃(1 or 2)
		public var moveType:int;
		// 执行时间
		public var duration:Number;
		// 延迟时间
		public var delay:Number;
		// 本轮攻击数据
		public var turn:BattleTurn;
		
		/**
		 * 构造函数
		 * */
		public function BattleMoveData()
		{
		}
	}
}