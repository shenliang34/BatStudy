package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.ChapterVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-31 22:01:33
	 * 
	 */
	public class ChapterManager
	{
		private static var _instance:ChapterManager;
		public static function getInstance():ChapterManager
		{
			if(_instance == null)
				_instance = new ChapterManager();
			return _instance;
		}
		public function ChapterManager()
		{
			if(_instance != null)
				throw "ChapterManager.as" + "is a SingleTon Class!!!";
			_instance = this;
			
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.chapterXMLList = settingsXML.chapter.chapter;
		}
		private var CHAPTER:Dictionary = new Dictionary();
		
		private var chapterXMLList:XMLList;
		
		/**
		 * 通过id找到章节 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getChapterById(id:int):ChapterVo
		{
			var vo:ChapterVo = CHAPTER[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(chapterXMLList , "chapter_Id" , id);
				if(x)
				{
					vo = new ChapterVo();
					vo.fromXML(x);
					
					CHAPTER[vo.id] = vo;
				}
				else
				{
					Logger.warn(ChapterManager , "找不到章节 , id = " + id);
				}
			}
			return vo;
		}
	}
}