package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.ErrcodeVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 错误码配置表
	 * @author xuwenyi
	 * @create 2014-05-14
	 **/
	public class ErrcodeManager
	{
		private static var _instance:ErrcodeManager;
		
		private var ERR:Dictionary = new Dictionary();//以itemID为key
		private var errcodeXMLList:XMLList;
		
		/**
		 * 构造函数
		 * */
		public function ErrcodeManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			errcodeXMLList = settingsXML.errcodes.errcode;
		}
		
		
		
		
		public static function get instance():ErrcodeManager {
			
			return _instance ||= new ErrcodeManager();
		}
		
		
		
		
		/**
		 * 获取产出配置
		 * */
		public function getErrcode(key:String):ErrcodeVO
		{
			var vo:ErrcodeVO = ERR[key];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(errcodeXMLList , "key" , key);
				if(x)
				{
					vo = new ErrcodeVO();
					vo.key = x.@key;
					vo.value = x.@value;
					
					ERR[vo.key] = vo;
				}
				else
				{
					Logger.warn(ErrcodeManager , "没有找到errcode... key = " + key);
				}
			}
			return vo;
		}
	}
}