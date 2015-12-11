package com.gamehero.sxd2.vo
{
	/**
	 * 掉落物品数据
	 * @author weiyanyu
	 * 创建时间：2015-8-28 下午3:51:19
	 * 
	 */
	public class GiftBoxItemVo
	{
		public function GiftBoxItemVo()
		{
		}
		
		/**
		 * 掉落的物品 
		 */		
		public var dropId:int;
		
		public var min:int;
		
		public var max:int;
		
		public function get num():String
		{
			var str:String = "";
			if(min == max)
			{
				if(min == 1)
				{
					str = "1";
				}
				else
				{
					str = "" + min;
				}
			}
			else
			{
				str = min + "~" + max;
			}
			return str;
		}
		/**
		 * 生成 x 后缀 
		 * 
		 */		
		public function getNumString():String
		{
			var str:String = "";
			if(min == max)
			{
				if(min == 1)
				{
					str = "";
				}
				else
				{
					str = "x" + min;
				}
			}
			else
			{
				str = "x" + min + "~" + max;
			}
			return str;
		}
	}
}