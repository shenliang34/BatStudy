package com.gamehero.sxd2.event
{
	import com.gamehero.sxd2.gui.core.BaseWindow;
	
	import flash.events.Event;
	
	
	
	/**
	 * 弹出窗口 Event<br/>
	 * 
	 * @author Trey
	 * 
	 */
	public class PopUpEvent extends Event {
		
		// 窗口弹出事件
		public static const POPUP_WINDOW_EVENT:String = "popUpWindowEvent";
		
		// 弹出窗口准备就绪（即渲染完成、数据都已经准备好）
		public static const WINDOW_READY_EVENT:String = "windowReadyEvent";
		
		// 关闭窗口
		public static const WINDOW_CLOSE_EVENT:String = "windowCloseEvent";
		
		// 显示自定义Modal窗口
		public static const SHOW_MODAL_WINDOW_EVENT:String = "showModalWindowEvent";
		// 隐藏自定义Modal窗口
		public static const HIDE_MODAL_WINDOW_EVENT:String = "hideModalWindowEvent";
		
		
		// 弹出窗口名
//		public var windowName:String;
		
		// 弹出的窗口实例
		public var window:BaseWindow;
		
		// 携带的额外信息
		public var data:Object;
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PopUpEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Clone 
		 * @return 
		 * 
		 */
		override public function clone():Event {
			
			var e:PopUpEvent = new PopUpEvent(type, bubbles, cancelable);
			e.window = this.window;
//			e.windowName = this.windowName;
			e.data = this.data;
			return e;
		}
	}
}