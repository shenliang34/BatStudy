package com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList
{
	public class DropDownListVO
	{
		/**
		 * 列表标题
		 */
		public var title:String;
		/**
		 * 列表携带的数据
		 */
		public var data:*;
		
		public function DropDownListVO(title:String="", data:*=null)
		{
			this.title = title;
			this.data = data;
		}
		
	}
}