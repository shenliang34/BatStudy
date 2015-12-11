package com.gamehero.sxd2.core {
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	
	/**
	 * 游戏全局变量 
	 * @author Trey
	 * @create-date 2013-7-3
	 */
	public class Global
	{	
		private static var _instance:Global;
		
		private var _globalXML:XML;
		
		// flash 版本
		private var flashPlayerVersion:String;
		// 是否支持2880以上的bitmap
		public var isSupport2880BD:Boolean = true;
		

		/**
		 * 构造函数
		 * */
		public function Global(singleton:Singleton) {
		
			init();
		}
		
		
		public static function get instance():Global {	
			
			return _instance ||= new Global(new Singleton());
		}
		
		
		/**
		 * 初始化全局配置表
		 * */
		private function init():void
		{
			// 判断当前环境是否支持2880以上的位图
			try
			{
				var bd:BitmapData = new BitmapData(4200,4000);
				isSupport2880BD = true;
			}
			catch(e:Error)
			{
				isSupport2880BD = false;
			}
		}
		
		
		
		/**
		 * 获取某类
		 * */
		public function getClass(domain:ApplicationDomain , className:String):Class
		{	
			var cls:Class;
			try
			{
				cls = domain.getDefinition(className) as Class;
			}
			catch(e:Error){}
			
			return cls;
		}
		
		
		/**
		 * 获取对应BitmapData 
		 */
		public function getBD(domain:ApplicationDomain , className:String):BitmapData
		{	
			var cls:Class = this.getClass(domain, className);
			if(cls)
			{
				return new cls() as BitmapData;
			}
			return null;
		}
		
		
		/**
		 * 获取某类的对象
		 * */
		public function getRes(domain:ApplicationDomain , className:String):Object
		{	
			var cls:Class = this.getClass(domain, className);
			if(cls)
			{
				return new cls();
			}
			return null;
		}
		
		
		
		/**
		 * 移除某显示对象所有子对象(flashplayer10.1没有removeChildren方法)
		 * */
		public function removeChildren(target:DisplayObjectContainer):void
		{
			while(target.numChildren > 0)
			{
				target.removeChildAt(0);
			}
		}
		
		
		
		/**
		 * 获取flashplayer版本
		 * */
		public function getFlashVersion():String
		{
			if(flashPlayerVersion == null || flashPlayerVersion == "")
			{
				var version:String = Capabilities.version;
				version = version.replace(/[a-zA-Z]+\s/gi , "");
				version = version.replace("," , "");
				version = version.substr(0,3);
				flashPlayerVersion = version;
			}
			return flashPlayerVersion;
		}
		
		
		
		
		
		/**
		 * 复制二进制数据
		 * */
		public function cloneByteArray(bytes:ByteArray):ByteArray
		{
			var copy:ByteArray = new ByteArray();
			bytes.readBytes(copy , 0 , bytes.length);
			bytes.position = 0;
			copy.position = 0;
			return copy;
		}
		
		
		
		
		
		/**
		 * 获取一条具体数据
		 * @return String
		 */		
		public function getData(str:String):String
		{
			if(_globalXML.child(str)) {
				
				return _globalXML.child(str)[0].@value;
			}
			
			return null;
		}
		
		
		
		
	}
}

class Singleton{}