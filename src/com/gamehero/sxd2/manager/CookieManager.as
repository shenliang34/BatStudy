package com.gamehero.sxd2.manager {
		
	import com.gamehero.sxd2.core.URI;
	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	

	/**
	 * Cookie(SharedObject)管理类
	 * @author: Trey
	 * @Create-date: 2010-07-21 
	 */
	public class CookieManager {
		
		// 账号密码cookie
		static public const ACCOUNT:String = "account";
		static public const PASSWORD:String = "password";
		
		// 音效音量cookie
		static public const VOLUME1:String = "volume1";
		static public const VOLUME2:String = "volume2";
		static public const MUTE:String = "mute";
		
		// 保卫长城使用杀和桃
		static public const KILL:String = "kill";
		static public const HEAL:String = "heal";
		
		// 签到相关
		static public const SIGNIN:String = "signin";
		
		// 世界boss复活
		static public const WBOSS_REBORN:String = "wbossReborn";
		
		// 家族战第一阶段复活
		static public const FAMILY_WAR_REBORN_1:String = "familyWarReborn1";
		// 家族战第二阶段复活
		static public const FAMILY_WAR_REBORN_2:String = "familyWarReborn2";
		
		// 是否显示其他玩家
		static public const SHOW_OTHER_ROLE:String = "showOtherRole";
		
		// 魔神英雄购买挑战次数
		static public const MASHIN_BUY_TIMES:String = "mashinBuyTimes";
		
		// 地牢猎手进入倒计时提示
		static public const DUNGEON_HIDDEN:String = "dungeonHidden";

		
		
		private static var _instance:CookieManager;
		private static var cookie:SharedObject = SharedObject.getLocal("ifs", "/");
		
		
		/**
		 * Constructor(Singleton) 
		 * @param enforcer
		 * 
		 */
		public function CookieManager(enforcer:SingletonEnforcer) {}
		
		public static function get instance():CookieManager {
			
			if (_instance == null) {
				
				_instance = new CookieManager(new SingletonEnforcer());	
			}
			
			return _instance;
		}
		
		/**
		 * 根据不同类型取共享对象中的值
		 * @param type
		 * @return 
		 * 
		 */
		public function getCookieData(name:String):Object
		{
			name = URI.user + "_" + name;
			
			var value:Object;
			var data:Object = cookie.data;
			if(data.hasOwnProperty(name) == true)
			{
				value = data[name];
			}
			return value;
		}
		
		/**
		 * 根据不同出征类型将数据写入共享对象
		 * @param type
		 * @param obj
		 * 
		 */
		public function setCookieData(name:String, value:Object):void {
			
			name = URI.user + "_" + name;
			cookie.data[name] = value;
			
			try
			{
				var flushResult:String = cookie.flush();
				// 需要开启存储
				if(flushResult == SharedObjectFlushStatus.PENDING)
				{ 
					cookie.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus); 
				}
				// 存储空间已满
				else if(flushResult == SharedObjectFlushStatus.FLUSHED)
				{
					
				}
			}
			catch(e:Error)
			{
				
			}
		}
		
		
		
		
		private function onNetStatus(e:NetStatusEvent):void
		{
			
		}
		
		
		
		
		/**
		 * 判断今日不再提醒
		 * */
		public function checkTodayCookie(name:String , nowDate:int):Boolean
		{
			var hasTodayData:Boolean = false;
			
			// 今日不再提示cookie数据
			var cookieData:Object = this.getCookieData(name);
			if(cookieData && cookieData.hasOwnProperty("date") == true)
			{
				// 日期是今天, 则不询问
				if(cookieData.date != null && cookieData.date == nowDate)
				{
					hasTodayData = true;
				}
			}
			
			return hasTodayData;
		}
		
		/**
		 * 清掉单个cookie的缓存 
		 * @param name
		 * 
		 */		
		public function clearCookie(name:String):void
		{
			var cookieData:Object = this.getCookieData(name);
			name = URI.user + "_" + name;
			if(cookieData)
				delete cookie.data[name];
		}
		
	}
}

class SingletonEnforcer {}