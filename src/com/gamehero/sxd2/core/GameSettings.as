package com.gamehero.sxd2.core {

	
	import com.gamehero.sxd2.drama.DramaManager;
	
	import flash.utils.getTimer;
	
	import bowser.logging.Logger;
	
	
	
	/**
	 * 游戏配置表类
	 * @author Trey
	 * @create-date 2013-8-28
	 */
	public class GameSettings {
		
		static private var _instance:GameSettings;
		
		public var settingsXML:XML;

		
		
		/**
		 * Constructor
		 */
		public function GameSettings(singleton:Singleton) {}
		
		
		public static function get instance():GameSettings {
			
			return _instance ||= new GameSettings(new Singleton());
		}
		
		
		
		
		/**
		 * Init 
		 */
		public function init():void 
		{	
			if(App.settingsBinary)
			{
				Logger.debug(GameSettings, "GameSettins Init...");
				
				var t:int;
				t = getTimer();
				
				// 解压
				App.settingsBinary.uncompress();
				//Logger.debug(GameSettings, "uncompress: " + (getTimer() - t));
				//t = getTimer();
				
				// 赋值settingsXML
				settingsXML = new XML(App.settingsBinary);
				
				// 清除settingsBinary
				App.settingsBinary.clear();
				App.settingsBinary = null;
				
				//Logger.debug(GameSettings, "new XML(ba): " + (getTimer() - t));
				
				/** 初始化剧情脚本 */
				DramaManager.inst.init();
			}
		}
		
		
	}
}

class Singleton{}