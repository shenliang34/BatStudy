package com.gamehero.sxd2.manager {
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.NpcVO;
	
	import flash.utils.Dictionary;
	
	
	/**
	 * NPC工具类
	 * @author Trey
	 * @create-date 2013-9-13
	 */
	public class NPCManager {
		
		static private var _instance:NPCManager;
		public var NPC_LINK_FUNC:String = "npclinkFunc";//点击功能面板
		
		private var NPC:Dictionary = new Dictionary();
		
		/**
		 * Constructor
		 * @param singleton
		 * 
		 */
		public function NPCManager(singleton:Singleton) {
		
			var _npcsList:XMLList = GameSettings.instance.settingsXML.npcs.npc;	
			NPC = new Dictionary();//以ID为key
			var npcVo:NpcVO;
			for each(var xml:XML in _npcsList)
			{
				npcVo = new NpcVO();
				npcVo.fromXML(xml);
				NPC[npcVo.id] = npcVo;
			}
		}
		
		
		public static function get instance():NPCManager {
			
			return _instance ||= new NPCManager(new Singleton());;
		}
		
		public function setNpcXY(id:int,x:int,y:int):void
		{
			NPC[id].x = x;
			NPC[id].y = y;
		}
		
		/**
		 * 获得npc数据 
		 * @param npcId 
		 */
		public function getNpcData(npcid:int):NpcVO 
		{	
			return NPC[npcid];
		}
	}
}

class Singleton{}