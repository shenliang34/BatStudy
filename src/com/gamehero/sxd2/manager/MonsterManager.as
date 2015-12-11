package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.MonsterVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 战斗中的怪物配置表
	 * @author xuwenyi
	 * @create 2014-02-24
	 **/
	public class MonsterManager
	{
		private static var _instance:MonsterManager;
		
		private var MONSTER:Dictionary = new Dictionary();//以ID为key
		private var monsterXMLList:XMLList;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function MonsterManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.monsterXMLList = settingsXML.monster_info.monster;
		}
		
		
		
		
		public static function get instance():MonsterManager {
			
			return _instance ||= new MonsterManager();
		}
		
		
		
		
		/**
		 * 根据伙伴id获取伙伴对象
		 * */
		public function getMonsterByID(monsterID:String):MonsterVO
		{
			var monster:MonsterVO = MONSTER[monsterID];
			if(monster == null)
			{
				var x:XML = GameTools.searchXMLList(monsterXMLList , "monsterID" , monsterID);
				if(x)
				{
					monster = new MonsterVO();
					// 配置表属性
					monster.monsterID = x.@monsterID;
					monster.monsterName = Lang.instance.trans(x.@monsterName);
					monster.level = x.@level;
					monster.normalatk = x.@normalatk;
					monster.skillid = x.@skillid;
					monster.bossBlood = x.@bossBlood;
					monster.isSkillMove = x.@isSkillMove;
					monster.figureURL = x.@url;
					monster.battleHead = x.@battleHead;
					monster.width = x.@width;
					monster.height = x.@height;
					// 保存到字典中
					// 按id分类
					MONSTER[monster.monsterID] = monster;
				}
				else
				{
					Logger.warn(MonsterManager , "没有找到怪物数据... monsterID = " + monsterID);
				}
			}
			return monster;
		}
	}
}