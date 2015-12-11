package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.FormationVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 阵型配置表管理
	 * @author xuwenyi
	 * @create 2013-11-25
	 **/
	public class FormationManager
	{
		private static var _instance:FormationManager;
		
		// 阵型等级配置
		private var formationXMLList:XMLList;
		
		private var formationDic:Dictionary = new Dictionary();;
		
		
		/**
		 * 构造函数
		 * */
		public function FormationManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.formationXMLList = settingsXML.formation.formation;
		}
		
		
		
		
		public static function get instance():FormationManager {
			
			return _instance ||= new FormationManager();
		}
		
		/**
		 * 通过ID获得阵中伙伴站位的位置
		 * */
		public function getPosById(id:int):FormationVo
		{
			var vo:FormationVo;
			if(this.formationXMLList)
			{
				var x:XML = GameTools.searchXMLList(this.formationXMLList , "formation_id" , id);
				if(x)
				{
					vo = new FormationVo();
					vo.formation_id = x.@formation_id;
					vo.pos_1 = x.@pos_1;
					vo.pos_2 = x.@pos_2;
					vo.pos_3 = x.@pos_3;
					vo.pos_4 = x.@pos_4;
					vo.pos_5 = x.@pos_5;
					vo.name = Lang.instance.trans(x.@formation_name);
					vo.des = Lang.instance.trans(x.@des);
					
					vo.posList = [vo.pos_1,vo.pos_2,vo.pos_3,vo.pos_4,vo.pos_5];
					
					formationDic[vo.formation_id] = vo;
				}
			}
			else
			{
				Logger.warn(MonsterManager , "没有找到阵型数据...");
			}
			return vo;
		}
	}
}