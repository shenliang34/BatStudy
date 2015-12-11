package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.pro.GS_PopUp_Pro;
	
	import flash.utils.Dictionary;

	public class PopUpManager
	{
		private var allDataDic:Dictionary;
		static private var _instance:PopUpManager;
		
		public static function get instance():PopUpManager 
		{
			return _instance ||= new PopUpManager();
		}
		
		public function PopUpManager()
		{
			init(GameSettings.instance.settingsXML.popUp.popUp);
		}
		
		/**
		 * 加载配置表
		 * */
		public function init(xmlList:XMLList):void
		{
			allDataDic = new Dictionary();
			
			var info:GS_PopUp_Pro;
			var level:int;
			var xml:XML;
			
			for each(var x:XML in xmlList){
				info = new GS_PopUp_Pro();
				info.id = int(x.@id);
				info.popType = int(x.@type);
				
				xml = ItemManager.instance.getItemById(info.id);
				level = int(xml.@levelLimit);
				
				// 保存到数组中
				if(!(allDataDic[level] is Array)){
					allDataDic[level] = [];
				}
				(allDataDic[level] as Array).push(info);
			}
		}
		
		/**
		 * 获取一个等级段冒泡数组
		 * @param oldLevel
		 * @param newLevel
		 * @return Array
		 * */
		public function getPopUpArrByLevel(oldLevel:int, newLevel:int):Array
		{
			var arr:Array = [];
			for(var i:int=oldLevel+1; i<=newLevel; i++){
				if((allDataDic[i] is Array)){
					arr = arr.concat(allDataDic[i] as Array);
				}
			}
			return arr;
		}
		
	}
}