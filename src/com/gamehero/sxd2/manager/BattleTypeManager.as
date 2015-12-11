package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.BattleTypeVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 战斗类型相关配置
	 * @author xuwenyi
	 * @create 2015-01-22
	 **/
	public class BattleTypeManager
	{
		private static var _instance:BattleTypeManager;
		
		private var BATTLE_TYPE:Dictionary = new Dictionary();
		private var battleTypeXMLList:XMLList;
		
		
		
		public function BattleTypeManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			battleTypeXMLList = settingsXML.battle_type.type;
		}
		
		
		
		
		public static function get instance():BattleTypeManager {
			
			return _instance ||= new BattleTypeManager();
		}
		
		
		
		
		/**
		 * 根据伙伴id获取此伙伴在酒馆中的配置
		 * */
		public function getBattleType(type:String):BattleTypeVO
		{
			var vo:BattleTypeVO = BATTLE_TYPE[type];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(battleTypeXMLList , "type" , type);
				if(x)
				{
					vo = new BattleTypeVO();
					vo.type = type;
					vo.loseGuide = x.@loseGuide;
					
					BATTLE_TYPE[type] = vo;
				}
				else
				{
					Logger.warn(BattleTypeManager , "没有战斗类型属性... type = " + type);
				}
			}
			return vo;
		}
	}
}