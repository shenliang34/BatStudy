package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.HurdleMonsterVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 
	 * 关卡怪物的配置表
	 * @author weiyanyu
	 * 创建时间：2015-7-29 上午10:55:31
	 * 
	 */
	public class HurdleMonsterManager
	{
		
		private static var _instance:HurdleMonsterManager;
		
		public static function get instance():HurdleMonsterManager {
			
			return _instance ||= new HurdleMonsterManager();
		}
		/**
		 * 关卡怪物字典 
		 */		
		private var MONSTER:Dictionary = new Dictionary();
		
		private var monsterXMLList:XMLList;
		
		public function HurdleMonsterManager()
		{
			monsterXMLList = GameSettings.instance.settingsXML.hurdle_monster.monster;
		}
		/**
		 * 通过id获取怪物配置 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getMonsterByID(id:int):HurdleMonsterVo
		{
			var monster:HurdleMonsterVo = MONSTER[id];
			if(monster == null)
			{
				var x:XML = GameTools.searchXMLList(monsterXMLList , "id" , id);
				if(x)
				{
					monster = new HurdleMonsterVo();
					monster.fromXML(x);
					MONSTER[id] = monster;
				}
				else
				{
					Logger.warn(MonsterManager , "没有找到关卡怪物数据... id = " + id);
				}
			}
			return  monster;
		}

	}
}