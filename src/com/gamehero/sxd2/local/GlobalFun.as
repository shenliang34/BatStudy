package com.gamehero.sxd2.local {
	
	import com.gamehero.sxd2.core.GameSettings;
	
	import flash.utils.Dictionary;
	
	
	
	/**
	 * 全局工具类
	 * @author zhangxueyou
	 * @create-date 2015-7-20
	 */
	public class GlobalFun {
		
		static private var _instance:GlobalFun;
		
		private var _data:Dictionary = new Dictionary(); 
		
		private var globalFunXMLList:XMLList;
		
		
		
		/**
		 * Constructor
		 * @param singleton
		 * 
		 */
		public function GlobalFun(singleton:Singleton) {
			
			init();
		}
		
		
		static public function get instance():GlobalFun {
			
			return _instance ||= new GlobalFun(new Singleton());
		}
		
		
		/**
		 * 初始化 
		 * @param langXML 
		 */
		private function init():void 
		{	
			globalFunXMLList = GameSettings.instance.settingsXML.global_param.StaminaMAX;
			// TRICKY:直接将数据一次放入_data，这样比每次访问时放入要效率高很多
			var iLen:int = globalFunXMLList.length();
			var xml:XML;
			for(var i:int = 0;i < iLen; i++)
			{
				xml = globalFunXMLList[i]
				_data[String(xml.@name)] = String(xml.@value);
			}
		}
		
		/**
		 * 查找Key 
		 * @param key
		 * @return 
		 * 
		 */
		public function trans(name:String):String {
			
			var value:String = _data[name];
			
			if(!value || value == "")
			{	
				value = name;
			}
			
			return value;
		}
	}
}

class Singleton{}