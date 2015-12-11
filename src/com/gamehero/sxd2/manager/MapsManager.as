package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.world.model.vo.MapsVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * 配置地图的基本信息
	 * @author weiyanyu
	 * 创建时间：2015-9-7 11:14:44
	 * 
	 */
	public class MapsManager
	{
		private static var _instance:MapsManager;
		public static function get inst():MapsManager
		{
			if(_instance == null)
				_instance = new MapsManager();
			return _instance;
		}
		public function MapsManager()
		{
			if(_instance != null)
				throw "MapsManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.xmlList = settingsXML.maps.map;
		}
		
		private var dict:Dictionary = new Dictionary();
		
		private var xmlList:XMLList;
		
		public function getMaps(id:int):MapsVo
		{
			var vo:MapsVo = dict[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(xmlList , "id" , id);
				if(x)
				{
					vo = new MapsVo();
					vo.fromXML(x);
					
					dict[vo.mapId] = vo;
				}
				else
				{
					Logger.warn(ChapterManager , "找不到地图信息 , id = " + id);
				}
			}
			return vo;
		}
	}
}