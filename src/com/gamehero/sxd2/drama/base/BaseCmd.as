package com.gamehero.sxd2.drama.base
{
    
	
	
	
	/**
	 * 脚本命令基类 
	 */	
	public class BaseCmd
	{
		// 命令名称 
		public var name:String = "";
		// 延迟执行指令
		public var cmdDelay:Number;
		
		// 完成时的回调函数 
		private var completeCallBack:Function;
		
		protected var _script:BaseDrama;
		
		
		
		
		public function BaseCmd()
		{
			super();
		}
		
		
		/**
		 *解析脚本命令 
		 * @param data
		 * 
		 */		
		public function fromXML(xml:XML):void
		{
			name = xml.localName();
			cmdDelay = xml.@cmdDelay;
		}
		
		
		/**
		 *重置脚本播放器 
		 */		
		public function set script(value:BaseDrama):void
		{
			_script = value;
		}
		
		
		
		
		/**
		 *清除回调 
		 */		
		public function clear():void
		{
			completeCallBack = null;
		}
		
		
		
		
		
		/**
		 *命令触发器触发，执行脚本 
		 * 
		 */		
		public function triggerCallBack(callBack:Function = null):void
		{
			completeCallBack = callBack;
		}
		
		
		
		
		/**
		 *完成脚本命令 
		 */		
		protected function complete():void
		{
			if(completeCallBack)
			{
				completeCallBack();
			}
			
			this.clear();
		}
		
		
	}
}