package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-28 下午3:12:29
	 * 
	 */
	public class GiftBoxManager
	{
		
		private static var _instance:GiftBoxManager;
		
		private var BOXES:Dictionary = new Dictionary();
		private var boxesXMLList:XMLList;
		
		
		
		public function GiftBoxManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			boxesXMLList = settingsXML.boxes.Sheet1;
		}
		
		
		
		
		public static function get instance():GiftBoxManager {
			
			return _instance ||= new GiftBoxManager();
		}
		
		
		/**
		 * 根据id获得box
		 * */
		public function getBoxById(id:int):GiftBoxVo
		{
			var vo:GiftBoxVo = BOXES[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(boxesXMLList , "id" , id);
				if(x)
				{
					vo = new GiftBoxVo();
					vo.fromXML(x);
					
					BOXES[id] = vo;
				}
				else
				{
					Logger.warn(BattleTypeManager , "没有找到礼包... id = " + id);
				}
			}
			return vo;
		}
		
	}
}