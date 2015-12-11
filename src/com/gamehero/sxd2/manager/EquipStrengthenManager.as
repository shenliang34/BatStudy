package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.EquipStrengthenVo;
	

	/**
	 * 装备强化
	 * @author weiyanyu
	 * 创建时间：2015-9-15 10:59:08
	 * 
	 */
	public class EquipStrengthenManager
	{
		private static var _instance:EquipStrengthenManager;
		public static function getInstance():EquipStrengthenManager
		{
			if(_instance == null)
				_instance = new EquipStrengthenManager();
			return _instance;
		}
		public function EquipStrengthenManager()
		{
			if(_instance != null)
				throw "EquipStrengthenManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.xmlList = settingsXML.equip_strengthen.Sheet1;
			var vo:EquipStrengthenVo;
			for each(var xml:XML in xmlList)
			{
				vo = new EquipStrengthenVo();
				vo.fromXML(xml);
				voList.push(vo);
			}
		}
		/**
		 * 装备强化表 
		 */		
		public var voList:Vector.<EquipStrengthenVo> = new Vector.<EquipStrengthenVo>();
		
		private var xmlList:XMLList;
		
	}
}