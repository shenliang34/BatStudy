package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-31 22:14:06
	 * 
	 */
	public class HurdlesManager
	{
		private static var _instance:HurdlesManager;
		public static function getInstance():HurdlesManager
		{
			if(_instance == null)
				_instance = new HurdlesManager();
			return _instance;
		}
		public function HurdlesManager()
		{
			if(_instance != null)
				throw "HurdlesManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.xmlList = settingsXML.hurdles.hurdle;
		}
		
		private var dict:Dictionary = new Dictionary();
		private var mapdict:Dictionary = new Dictionary();
		
		private var xmlList:XMLList;
		/**
		 * 通过id获得副本数据 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getHurdleById(id:int):HurdleVo
		{
			var vo:HurdleVo = dict[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(xmlList , "id" , id);
				if(x)
				{
					vo = new HurdleVo();
					vo.fromXML(x);
					
					dict[vo.id] = vo;
				}
				else
				{
					Logger.warn(ChapterManager , "找不到副本 , id = " + id);
				}
			}
			return vo;
		}
	}
}