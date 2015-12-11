package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.MonsterLeaderVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 怪物首领配置
	 * @author xuwenyi
	 * @create 2015-08-12
	 **/
	public class MonsterLeaderManager
	{
		private static var _instance:MonsterLeaderManager;
		
		private var LEADER:Dictionary = new Dictionary();//以ID为key
		private var leaderXMLList:XMLList;
		
		
		
		/**
		 * 构造函数
		 * */
		public function MonsterLeaderManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.leaderXMLList = settingsXML.monster.monster;
		}
		
		
		
		
		
		public static function get inst():MonsterLeaderManager {
			
			return _instance ||= new MonsterLeaderManager();
		}
		
		
		
		
		/**
		 * 根据伙伴id获取伙伴对象
		 * */
		public function getLeader(id:String):MonsterLeaderVO
		{
			var leader:MonsterLeaderVO = LEADER[id];
			if(leader == null)
			{
				var x:XML = GameTools.searchXMLList(leaderXMLList , "monsterid" , id);
				if(x)
				{
					leader = new MonsterLeaderVO();
					// 配置表属性
					leader.monsterid = x.@monsterid;
					leader.name = Lang.instance.trans(x.@name);
					leader.level = x.@level;
					leader.url = x.@url;
					
					// 保存到字典中
					// 按id分类
					LEADER[id] = leader;
				}
				else
				{
					Logger.warn(MonsterLeaderManager , "没有找到怪物领袖数据... id = " + id);
				}
			}
			return leader;
		}
	}
}