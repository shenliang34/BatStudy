package com.gamehero.sxd2.gui.menu
{
	/**
	 * 菜单选项
	 * @author xuwenyi
	 * @create 2013-10-24
	 **/
	public class OptionData
	{
		public var id:String;
		public var label:String;
		public var params:Object;
		
		
		/**
		 * 构造函数
		 * */
		public function OptionData(id:String, label:String,data:Object = null)
		{
			this.id = id;
			this.label = label;
			params = data;
		}
	}
}