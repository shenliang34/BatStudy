package com.gamehero.sxd2.gui.core
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 所有弹出窗口接口类 
	 * @author Trey
	 * 
	 */
	public interface IWindow extends IEventDispatcher {
		
		function show():void;
		function close():void;

		function get loaded():Boolean;
		
		function get modal():Boolean;
		function set modal(value:Boolean):void;

		function get position():int;
		function set position(value:int):void;

	}
}