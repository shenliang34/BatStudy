package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.gui.main.menuBar.MenuButton;

	public class FunctionVO
	{
		public var id:int;
		public var isMainUI:int;
		public var positionType:int;
		public var name:String;
		public var tab:int;
		public var tabWindow:String;
		public var buttonName:String;
		public var buttonIcon:String;
		public var position:int;
		public var hasMovie:int;
		public var funcName:String;
		
		// 对应的菜单按钮
		public var menuBtn:MenuButton;
		
		
		public function FunctionVO()
		{
		}
		
		
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			isMainUI = xml.@isMainUI;
			positionType = xml.@positionType;
			name = xml.@name;
			tab = xml.@tab;
			tabWindow = xml.@tabWindow;
			buttonName = xml.@buttonName;
			buttonIcon = xml.@buttonIcon;
			position = xml.@position;
			hasMovie = xml.@hasMovie;
			funcName = xml.@func_name;
			
		}
	}
}