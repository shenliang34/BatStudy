package com.gamehero.sxd2.event
{
	public class FateEvent extends BaseEvent
	{
		public static const FATEROLL:String = "fateRoll";//命途抽签
		public static const FATEINFO:String = "fateInfo";//命途信息
		
		/**
		 * 命途事件
		 * @author zhangxueyou
		 * @create 2015-11-4
		 **/
		public function FateEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
	}
}