package com.gamehero.sxd2.manager {
	
    import com.gamehero.sxd2.event.CloseEvent;
    import com.gamehero.sxd2.gui.GlobalAlert;
    import com.gamehero.sxd2.gui.GlobalPrompt;
    import com.gamehero.sxd2.gui.IAlert;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.core.WindowPostion;
    import com.gamehero.sxd2.vo.ErrcodeVO;
    
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.net.SharedObject;
	
	
	
	/**
	 * 提示框Manager 
	 * @author Trey
	 */
	public class DialogManager extends EventDispatcher 
	{
		static private var _instance:DialogManager;
		
		private var globalAlert:GlobalAlert;
		private var globalPrompt:GlobalPrompt;
		private var _nowDate:String;
		private var _markLocalData:SharedObject;
		private var _markData:Object;
		
		static public var ONCE:String = "ONCE";	
		static public var CURRENT:String = "CURRENT";	
		static public var GO_FUBEN:String = "GO_FUBEN";
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////

		
		/**
		 * Constructor(Singleton)
		 */
		public function DialogManager(enforcer:SingletonEnforcer)
		{
			_nowDate = new Date().toDateString();
			_markLocalData = SharedObject.getLocal("CostTipMark");
			_markData = _markLocalData.data.markData;
			var lastDate:String = _markLocalData.data.lastDate;
			if(lastDate != _nowDate)
			{
				_markLocalData.data.lastDate = _nowDate;
				_markLocalData.data.markData = _markData = {};
			}
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PUBLIC
		///////////////////////////////////////////////////////////////////////////////
		
		
		public static function get inst():DialogManager 
		{	
			if(_instance == null)
			{
				_instance = new DialogManager(new SingletonEnforcer());
			}
			return _instance as DialogManager;
		}
		
		
		
		
		/**
		 * 显示警告信息
		 * @param errcode
		 */
		public function showWarning(errcode:String):void 
		{	
			var text:String = errcode;
			var err:ErrcodeVO = ErrcodeManager.instance.getErrcode(errcode);
			if(err)
			{
				text = err.value;
			}
			this.showPrompt(text);
		}
		
		
		/**
		 * 显示提示信息(2秒后消失)
		 * @param text
		 */
		public function showPrompt(text:String = ""):IAlert
		{	
			globalPrompt = WindowManager.inst.openWindow(GlobalPrompt, WindowPostion.CENTER_ONLY, false, true) as GlobalPrompt;
			globalPrompt.setMessage(text);
			
			return globalPrompt;
		}
		
		
		
		/**
		 * Show Dialog
		 * @param text
		 * @param text2
		 * @param flags
		 * @param closeHandler
		 * @param maxChars
		 * @param duration 倒计时(秒)
		 */
		public function show(text2:String = "", flags:uint = 4, closeHandler:Function = null, btnSytle:String = GlobalAlert.BLUE , icon:BitmapData = null, 
							 width:Number = 250, height:Number = 130, duration:int = 30, leading:Number = .5):GlobalAlert
		{	
			globalAlert = WindowManager.inst.getWindowInstance(GlobalAlert, WindowPostion.CENTER_ONLY) as GlobalAlert;
			globalAlert.width = width;
			globalAlert.height = height;
			
			if(globalAlert.isShow)
			{
				globalAlert.close();
			}
			WindowManager.inst.openWindow(GlobalAlert, WindowPostion.CENTER_ONLY, true, true) as GlobalAlert;
			
			globalAlert.setMessage(text2, flags, btnSytle , icon, duration, leading);
			
			// Close Handler
			if(closeHandler != null) {
				
				globalAlert.addEventListener(CloseEvent.CLOSE, closeHandler);
			}
			
			return globalAlert;
		}
		
		
		/**
		 * 显示付费提示框 
		 * @param key 是否今日不再提示  属性名称
		 * @param content 提示内容
		 * @param okCallBack 确定回调
		 * @param title 标题
		 * 
		 */		
		public function showCost(key:String, content:String, okCallBack:Function):void
		{
			var isShield:Boolean = _markData.hasOwnProperty(key);
			if(isShield == false)
			{
				GlobalAlert.checkSelected = false;
				GlobalAlert.checkLabel = "不再提示";
				
				this.show(content, GlobalAlert.OK | GlobalAlert.CANCEL | GlobalAlert.CHECK, 
					function(e:CloseEvent):void
					{
						if(GlobalAlert.checkSelected)
						{
							_markData[key] = true;
							_markLocalData.flush();
						}
						
						if(e.detail == GlobalAlert.OK)
						{
							okCallBack();
						}
					}
				);
			}
			else
			{
				okCallBack();
			}
		}
		
		
		
		/**
		 * Close 
		 */
		public function close():void
		{	
			if(globalAlert)
			{	
				globalAlert.close();
			}
		}
		
	}
}

class SingletonEnforcer {}