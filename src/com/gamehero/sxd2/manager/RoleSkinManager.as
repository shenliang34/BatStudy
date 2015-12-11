package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.world.model.vo.RoleSkinVo;
	
	import flash.utils.Dictionary;
	
	import bowser.utils.GameTools;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-17 下午1:47:50
	 * 
	 */
	public class RoleSkinManager
	{
		
		private static var _instance:RoleSkinManager;
		
		private var ROLESKIN:Dictionary = new Dictionary();
		private var roleSkinXMLList:XMLList;
		
		
		
		public function RoleSkinManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			roleSkinXMLList = settingsXML.role_skin.role_skin;
		}
		
		
		
		
		public static function get instance():RoleSkinManager {
			
			return _instance ||= new RoleSkinManager();
		}
		
		
		
		
		/**
		 * =获取皮肤的配置
		 * */
		public function getRoleSkinVo(url:String):RoleSkinVo
		{
			var vo:RoleSkinVo = ROLESKIN[url];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(roleSkinXMLList , "url" , url);
				if(x)
				{
					vo = new RoleSkinVo();
					vo.fromXML(x);
					ROLESKIN[url] = vo;
				}
			}
			return vo;
		}
	}
}