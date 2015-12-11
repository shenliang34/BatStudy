package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.BattleUnitVO;
	import com.gamehero.sxd2.vo.MonsterLeaderVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 战场配置
	 * @author xuwenyi
	 * @create 
	 **/
	public class BattleUnitManager
	{
		private static var _instance:BattleUnitManager;
		
		private var BATTLE:Dictionary = new Dictionary();
		private var battleXMLList:XMLList;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleUnitManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.battleXMLList = settingsXML.battle_unit.battle;
		}
		
		
		
		
		public static function get inst():BattleUnitManager {
			
			return _instance ||= new BattleUnitManager();
		}
		
		
		
		
		
		/**
		 * 获取某场战斗
		 * */
		public function getBattle(id:int):BattleUnitVO
		{
			var unit:BattleUnitVO = BATTLE[id];
			if(unit == null)
			{
				var x:XML = GameTools.searchXMLList(battleXMLList , "id" , id);
				if(x)
				{
					unit = new BattleUnitVO();
					// 配置表属性
					unit.battleID = x.@id;
					unit.battleName = x.@name;
					unit.battleType = x.@type;
					unit.mapid = x.@mapid;
					unit.sound = x.@sound;
					unit.monsterLeaderID = x.@monsterLeaderID;
					unit.mapName = x.@mapName;
					
					// 波数
					var boshuXMLList:XMLList = x.*.boshu;
					unit.boshu = boshuXMLList.length();
					
					BATTLE[unit.battleID] = unit;
				}
				else
				{
					Logger.warn(BattleUnitManager , "战场数据找不到... id = " + id);
				}
			}
			return unit;
		}
		
		
		
		
		/**
		 * 获取某场战斗名
		 * */
		public function getBattleName(id:int):String
		{
			var name:String = "";
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				name = unit.battleName;
			}
			return name;
		}
		
		
		
		
		/**
		 * 获取某场战斗的类型
		 * */
		public function getBattleType(id:int):int
		{
			var battleType:int = 0;
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				battleType = unit.battleType;
			}
			return battleType;
		}
		
		
		
		
		/**
		 * 获取某场战斗的地图资源
		 * */
		public function getMapID(id:int):String
		{
			var mapid:String = "1";
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				mapid = unit.mapid;
			}
			return mapid;
		}
		
		
		
		
		
		/**
		 * 获取某场战斗的波数
		 * */
		public function getBoshu(id:int):int
		{
			var boshu:int = 1;
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				boshu = unit.boshu;
			}
			return boshu;
		}
		
		
		
		
		
		/**
		 * 获取音效资源
		 * */
		public function getSound(id:int):String
		{
			var sound:String = "";
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				sound = unit.sound;
			}
			return sound;
		}
		
		
		
		
		
		/**
		 * 获取怪物领袖
		 * */
		public function getMonsterLeader(id:int):MonsterLeaderVO
		{
			var leader:MonsterLeaderVO;
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				leader = MonsterLeaderManager.inst.getLeader(id.toString());
			}
			return leader;
		}
		
		
		
		
		
		/**
		 * 获取战斗名
		 * */
		public function getMapName(id:int):String
		{
			var mapName:String = "";
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				mapName = unit.mapName;
			}
			return mapName;
		}
		
		
		
		
		
		/**
		 * 获取战斗名
		 * */
		public function getEndDrama(id:int):int
		{
			var endDrama:int = 0;
			var unit:BattleUnitVO = this.getBattle(id);
			if(unit)
			{
				endDrama = unit.endDrama;
			}
			return endDrama;
		}
	}
}