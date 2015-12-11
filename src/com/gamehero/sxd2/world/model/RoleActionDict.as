package com.gamehero.sxd2.world.model
{
	/**
	 * 人物动作字典
	 * @author weiyanyu
	 * 创建时间：2015-7-30 上午11:30:16
	 * 
	 */
	public class RoleActionDict
	{
		/**
		 * 站立 
		 */		
		public static var STAND:String = "stand";
		/**
		 * 走动
		 */		
		public static var WALK:String = "walk";
		/**
		 * 跑动 
		 */		
		public static var RUN:String = "run";
		/**
		 *跳跃 
		 */		
		public static var JUMP:String = "jump";
		/**
		 * 朝向左边 
		 */		
		public static var LL:String = "ll";
		/**
		 * 朝向右边 
		 */		
		public static var RR:String = "rr";
		
		public static var MOVESTATUS:String = "moveStatus";
		
		
		public function RoleActionDict()
		{
		}
	}
}