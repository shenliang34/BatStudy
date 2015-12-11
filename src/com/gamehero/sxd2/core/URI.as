package com.gamehero.sxd2.core {
	
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	
	
	/**
	 * 游戏URI，通过stage.loaderInfo.parameters获得 
	 * @author Trey
	 * @create-date 2014-3-3
	 */
	public class URI {
		
		// pps 你提我改URL
		public static const PPS_ADVICE_LINK_URL:String = "http://bhzrbbs.pps.tv/forum.php?mod=viewthread&tid=1273";
		// 搜狗 新手卡
		public static const SOUGOU_NEW_PLAYER_CARD:String = "http://wan.sogou.com/ticket.do?gid=476";
		
		// 多语言枚举
		public static const CN:String = "";//中国大陆
		public static const TW:String = "tw";//台湾
		
		
		static public var params:Object;
		static public var agent:String;
		//多语言
		static public var lang:String = CN;
		
		
		/**
		 * 服务器ip 
		 */
		public static function get ip():String {
			
			return params.ip;
		}
		
		/**
		 * 服务器prot 
		 * @return 
		 * 
		 */
		public static function get port():int {
			
			return params.port;
		}
		
		/**
		 * 平台user（userid） 
		 * @return 
		 * 
		 */
		public static function get user():String {
			
			return params.user;
		}
		
		/**
		 * CDN 
		 * @return 
		 * 
		 */
		public static function get cdn():String {
			
			return params.cdn || "";
		}
		
		
		/**
		 * 平台viptype
		 * @return 
		 * 
		 */
		public static function get viptype():int {
			
			return params.viptype || 0;
		}
		
		
		/**
		 * 平台vip的参数
		 * @return 
		 * 
		 */
		public static function get vipparam():int {
			
			return params.vipparam || -1;;
		}
		
		
		/**
		 * 平台viptype2(现用于获取PPS游戏平台VIP等级)
		 * @return 
		 * 
		 */
		public static function get viptype2():int {
			
			return params.viptype2 || -1;
		}
		
		
		/**
		 * 平台vip的参数2
		 * @return 
		 * 
		 */
		public static function get vipparam2():int {
			
			return params.vipparam2 || -1;;
		}
		
		
		/**
		 * 游戏服标示
		 * @return 
		 * 
		 */
		public static function get server():String {
			
			return params.server;
		}
		
		
		
		
		
		/**
		 * 游戏主页地址
		 * @return 
		 * 
		 */
		public static function get gameIndex():String
		{	
			var url:String = params.game_index || "";
			// 替换链接中的{user}
			if(url.indexOf("{user}") >= 0)
			{	
				url = url.replace("{user}", user);
			}
			return url;
		}
		
		/**
		 * 游戏BBS地址
		 * @return 
		 * 
		 */
		public static function get gameBBS():String
		{
			var url:String = params.game_bbs || "";
			// 替换链接中的{user}
			if(url.indexOf("{user}") >= 0)
			{	
				url = url.replace("{user}", user);
			}
			return url;
		}
		
		/**
		 * 游戏GM地址 
		 * @return 
		 * 
		 */
		public static function get gmURL():String
		{	
			var url:String = params.gm_url || "";
			// 替换链接中的{user}
			if(url.indexOf("{user}") >= 0)
			{	
				url = url.replace("{user}", user);
			}
			return url;
		}
		
		
		/**
		 * 游戏防沉迷标示，1-表示被防沉迷，0-表示不需要被防沉迷
		 * @return 
		 * 
		 */
		public static function get fcm():Boolean {
			
			return (params.fcm == "1");
		}
		
		
		/**
		 * 充值地址 
		 * @return 
		 * 
		 */
		public static function get payURL():String {
			
			return params.pay_url || "";
		}
		
		
		
		
		/**
		 * 去充值地址 
		 * 
		 */
		public static function toPay():void {
			
			var payurl:String = URI.payURL;
			
			// 替换充值链接中的{user}
			if(payurl.indexOf("{user}") >= 0) {
				
				payurl = payurl.replace("{user}", user);
			}
			else {
				
				// 搜狗充值链接处理
				if(URI.agent == Agent.A_sogou) {
					
					payurl += "&u=" + URI.user;
				}
				// YY充值链接处理
				else if(URI.agent == Agent.A_yy) {
					
					payurl += "&userid=" + URI.user;
				}
				// 8090充值链接处理
				else if(URI.agent == Agent.A_8090) {
					
					payurl += "&username=" + URI.user;
				}
				
			}
			
			URI.toURL(payurl);
		}
		
		
		
		/**
		 * 跳转到制定地址 
		 * @param url
		 * 
		 */
		public static function toURL(url:String):void {
			
			navigateToURL(new URLRequest(url), "_blank");
		}
	}
}