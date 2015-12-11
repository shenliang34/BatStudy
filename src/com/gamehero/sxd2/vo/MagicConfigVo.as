package com.gamehero.sxd2.vo
{
	/**
	 * @author Wbin
	 * 创建时间：2015-11-19 下午3:57:26
	 * 
	 */
	public class MagicConfigVo extends BaseVO
	{
		public var id:int;
		public var type:int;
		public var name:String;
		public var open_type:int;
		public var open_lv:int;
		/**
		 * 升级属性
		 * */
		public var prop:Array;
		public var position:int;
		public function MagicConfigVo()
		{
			
		}
	}
}