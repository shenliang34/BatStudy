package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 提示层工具类
	 * @author zhangxueyou
	 * @create-date 2015-9-25
	 */
	public class NoticeManager extends EventDispatcher {
		private static var _instance:NoticeManager;
		
		/**
		 *构造
		 */
		public function NoticeManager(singleton:Singleton) {
			
		}
		
		/**
		 * 通过id获取显示区域
		 */
		public function getNoticeAreaById(id:int):String
		{
			var noticeXMLList:XMLList = GameSettings.instance.settingsXML.system_log_limit.info;
			var i:int;
			var len:int = noticeXMLList.length();
			for(i;i<len;i++)
			{
				var xml:XML = noticeXMLList[i];
				if(xml.@id == id)
				{
					return xml.@showArea;
				}
			}
			return null
		}
		
		public static function get inst():NoticeManager {
			return _instance ||= new NoticeManager(new Singleton());;
		}
	}
}

class Singleton{}