package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.equips.model.StoreVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * 
	 * 物品购买
	 * @author weiyanyu
	 * 创建时间：2015-9-17 16:38:06
	 * 
	 */
	public class StoreManager
	{
		private static var _instance:StoreManager;
		public static function get inst():StoreManager
		{
			if(_instance == null)
				_instance = new StoreManager();
			return _instance;
		}
		public function StoreManager()
		{
			if(_instance != null)
				throw "StoreManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.xmlList = settingsXML.store.store;
		}
		
		private var dict:Dictionary = new Dictionary();
		
		private var xmlList:XMLList;
		
		public function getVoById(id:int):StoreVo
		{
			var vo:StoreVo = dict[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(xmlList , "item_id" , id);
				if(x)
				{	
					vo = new StoreVo();
					vo.fromXML(x);
					// 保存到字典中
					dict[id] = vo;
				}
				else
				{
					Logger.warn(StoreManager , StoreManager + "数据找不到... item_id = " + id);
				}
			}
			return vo;
		}
	}
}