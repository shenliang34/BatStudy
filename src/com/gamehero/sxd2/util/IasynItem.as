package com.gamehero.sxd2.util
{

	/**
	 *延迟中心 
	 * @author wulongbin
	 * 
	 */	
	public interface IasynItem 
	{		
		/**
		 *添加一次性延迟 ，延时函数运行后会自动删除，如果需要提前移除，请调用removeFuncByTimer
		 * @param func
		 * @param frame 延时帧数 至少延迟一帧回调
		 * 
		 */		
		function addFuncByTimer(func:Function,frame:uint=1):void;
		/**
		 *手动移除一次性延长 
		 * @param func
		 * @param frame 延时帧数
		 * 
		 */		
		function removeFuncByTimer(func:Function):void;
		/**
		 *作用类似addFuncByTimer，区别在于该回调函数是在当前该帧回调 
		 * @param func
		 * 
		 */		
		function addFuncToEnd(func:Function):void;
		function removeFuncToEnd(func:Function):void;		
		
		
		/**
		 *添加轮询函数 
		 * @param func
		 * @param groupName
		 * 
		 */		
		function addFuncByFrame(func:Function,frame:uint=1):void;
		/**
		 *移除轮询函数 
		 * @param func
		 * @param groupName
		 * 
		 */		
		function removeFuncByFrame(func:Function):void;
		
		function renderFrame():void;
		
		function set running(value:Boolean):void;
		function get running():Boolean;
		function disposeAsynItem():void;
		
	}
}