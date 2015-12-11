package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.blackMarket.model.RandomItemVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * 一些随机几率获得的物品配置
	 * @author weiyanyu
	 * 创建时间：2015-10-15 14:55:43
	 * 
	 */
	public class RandomItemManager
	{
		private static var _instance:RandomItemManager;
		public static function get inst():RandomItemManager
		{
			if(_instance == null)
				_instance = new RandomItemManager();
			return _instance;
		}
		public function RandomItemManager()
		{
			if(_instance != null)
				throw "RandomItemManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.xmlList = settingsXML.random_items.random_items;
		}
		
		private var dict:Dictionary = new Dictionary();
		
		private var xmlList:XMLList;
		public function getVoById(id:int):RandomItemVo
		{
			var vo:RandomItemVo = dict[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(xmlList , "id" , id);
				if(x)
				{	
					vo = new RandomItemVo();
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