package com.gamehero.sxd2.world.model
{
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-29 下午5:19:09
	 * 
	 */
	public class MapTrickerType
	{
		public function MapTrickerType()
		{
		}
		//========触发条件枚举===================
		/**
		 * 检查玩家位置 
		 */		
		public static var TRIG_PLAYERLOC:int = 1;
		/**
		 * 动作是否播放结束 
		 */		
		public static var TRIG_ISLOOPOVER:int = 2;
		
		
		//========处理方式枚举===================
		/**
		 * 播放下一个动作 
		 */		
		public static var RES_NEXTACTION:int = 1;
		/**
		 * 从舞台上移除掉 
		 */		
		public static var RES_REMOVESTAGE:int = 2;
	}
}