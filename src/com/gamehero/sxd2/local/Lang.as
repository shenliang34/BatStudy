package com.gamehero.sxd2.local {
	
	import com.gamehero.sxd2.core.GameSettings;
	
	import flash.utils.Dictionary;
	
	
	
	/**
	 * 多语言工具类
	 * @author Trey
	 * @create-date 2013-8-29
	 */
	public class Lang {
		
		static private var _instance:Lang;
		
		private var _data:Dictionary = new Dictionary(); 
		
		private var _langXMLList:XMLList;
		
		
		
		/**
		 * Constructor
		 * @param singleton
		 * 
		 */
		public function Lang(singleton:Singleton) {
			
			init();
		}
		
		
		static public function get instance():Lang {
			
			return _instance ||= new Lang(new Singleton());
		}
		
		
		/**
		 * 初始化 
		 * @param langXML 
		 */
		private function init():void 
		{	
			_langXMLList = GameSettings.instance.settingsXML.language.language;
			
			// TRICKY:直接将数据一次放入_data，这样比每次访问时放入要效率高很多
			var iLen:int = _langXMLList.length();
			var xml:XML;
			for(var i:int = 0;i < iLen; i++)
			{
				xml = _langXMLList[i];
				var str:String = String(xml.@value);
				str = str.replace(/\\n/gi , "\n");// language中的\n没法直接在游戏里用,需要替换一下
				_data[String(xml.@key)] = str;
			}
		}
		
		
		/**
		 * 查找Key 
		 * @param key
		 * @return 
		 * 
		 */
		public function trans(key:String):String {
			
			var value:String = _data[key];
			
			/*if(!value || value == "")
			{	
				var x:XML;
				var iLen:int = _langXMLList.length();
				for(var i:int = 0;i < iLen; i++)
				{
					if(_langXMLList[i].@key == key)
					{
						x = _langXMLList[i];
						break;
					}
				}
				if(x)
				{
					value = x.@value;
					_data[key] = value;
				}
			}*/
			
			if(!value || value == "")
			{	
				value = key;
			}
			
			return value;
		}
		
		
		/**
		 * 查找Key，并替换 
		 * @param key
		 * @param strs
		 * @return 
		 * 
		 */
		public function trans2(key:String, strs:Array):String {
			
			var value:String = "";
			
			value = trans(key);
			var values:Array = value.split("{str}");
			
			value = "";
			for (var i:int = 0; i < values.length - 1; i++) {
				
				value += values[i] + strs[i];
			}
			value += values[i]
			
			return value;
		}
		
		
	}
	
}

class Singleton{}