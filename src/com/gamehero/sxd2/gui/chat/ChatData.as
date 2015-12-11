package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.pro.PRO_ChatContents;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.netease.protobuf.UInt64;
	
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	/**
	 * 聊天常量数据
	 * @author zhangxueyou
	 * @create 2015-7-28
	 **/
	public class ChatData
	{
		//类型常量
		public static const WORLD:int = 1;   //世界
		public static const FAMILY:int = 2;  //帮派
		public static const SYSTEM:int = 3;  //系统
		public static const TOOLTIP:int = 4; //提示
		public static const PRIVATE:int = 5; //私聊
		
		public static const SENGGAP:int = 5000; //聊天间隔时间

		public static const SMALLCHATOUTPUTBG:Rectangle = new Rectangle(0,0,298,185); //正常窗口输出面板背景
		public static const BIGCHATOUTPUTBG:Rectangle = new Rectangle(0,-100,298,285);  //放大窗口输出面板背景
		public static const OUTPUTBGLIST:Array = [SMALLCHATOUTPUTBG,BIGCHATOUTPUTBG];
		
		public static const SMALLCHATOUTPUTPANEL:Rectangle = new Rectangle(5,5,0,140); //正常窗口输出面板
		public static const BIGCHATOUTPUTPANEL:Rectangle = new Rectangle(5,-95,0,240);//放大窗口输出面板
		public static const OUTPUTPANELLIST:Array = [SMALLCHATOUTPUTPANEL,BIGCHATOUTPUTPANEL];
		
		public static const SMALLCHATOUTPUT:Rectangle = new Rectangle(5,5,280,150);//正常窗口输出文本 
		public static const BIGCHATOUTPUT:Rectangle = new Rectangle(5,5,280,250);  //放大窗口输出文本
		public static const OUTPUTLIST:Array = [SMALLCHATOUTPUT,BIGCHATOUTPUT];
		
		public static const INPUTPANEL:Rectangle = new Rectangle(5,177,220,25);//输入面板
		public static const EXPRESSIONPANEL:Rectangle = new Rectangle(245,40,0,0);//输入面板
		public static const FACEBTN:Rectangle = new Rectangle(237,178,0,0);//输入面板		
		
		public static const INPUTMAXCHARS:int = 50; //输入最大字符数
		public static const OUTPUTMAXLINE:int = 40; //输出显示最多条数
		
		public static const OUTPUTBGALPHA:Array = [0,0.8]; //输出背景面板透明度 索引为0是移除 1为移入
		
		public static const ROLE_FILE:String = "file_10000"; //复制昵称
		public static const CHAT_WORLD:String = "chat_paging_10000"; //世界
		public static const CHAT_FAMILY:String = "chat_paging_10001"; //家族
		public static const CHAT_SYSTEM:String = "chat_paging_10002"; //公告
		public static const CHAT_TOOLTIP:String = "chat_paging_10003"; //提示
		
		public static var mainDomain:ApplicationDomain;//主UI资源
		public static var privateChat:Dictionary = new Dictionary();//当前私聊记录 key:PRO_PlayerBase,value:vos[PRO_ChatContents...]
		public static var privateChatCache:Array = [];//没有读取过的私聊数据缓存[PRO_ChatContents...]
		public static var historys:Array = [];//聊天记录数据
		
		public function ChatData()
		{
			
		}
		
		/**
		 * 将未读取过的私聊数据保存
		 * */
		public static function savePrivateChat():void
		{
			var vo:PRO_ChatContents;
			var vos:Array = [];
			var len:int = privateChatCache.length;
			for(var i:int=0;i<len;i++)
			{
				vo = privateChatCache[i] as PRO_ChatContents;
				vos = getCurrentHistory(vo.base.id);
				vos.push(vo);
				privateChat[vo.base] = vos;
			}
			// 将缓存清空
			privateChatCache = [];
		}
		
		/**
		 * 查找当前聊天记录中某角色的记录数组[PRO_ChatContents]
		 * */
		public static function getCurrentHistory(id:UInt64):Array
		{
			var vos:Array = [];
			for(var role:PRO_PlayerBase in privateChat)
			{
				if(role.id.toNumber() == id.toNumber())
				{
					vos = privateChat[role];
					break;
				}
			}
			return vos;
		}
		
		/**
		 * 添加新的当前私聊消息
		 * */
		public static function addCurrentHistory(sender:PRO_PlayerBase, vo:PRO_ChatContents = null):void
		{
			var vos:Array = getCurrentHistory(sender.id);
			if(vo)
			{
				vos.push(vo);
			}
			privateChat[sender] = vos;
		}
	}
}