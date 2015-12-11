package com.gamehero.sxd2.gui.chat
{	

	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK;
	import com.gamehero.sxd2.pro.PRO_ChatContents;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.pro.PRO_Notice;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.util.Time;
	import com.gamehero.sxd2.vo.HeroVO;

	/**
	 * 聊天文字格式化
	 * @author xuwenyi
	 * @create 2013-12-03
	 * @Modify zhangxueyou
	 * @ModifyTimer 2015-7-28
	 **/
	public class ChatFormat
	{
		// 消息链接类型
		public static const LINK_TYPE_PLAYER:String = "player";
		public static const LINK_TYPE_ITEM:String = "item";
		public static const LINK_TYPE_HERO:String = "hero";
		public static const LINK_TYPE_SYSTEM:String = "system";
		public static const LINK_TYPE_BATTLE:String = "battle";
		// 系统公告链接类型

		// 文字颜色
		public static const COLORS:Array = 
			[GameDictionary.CHAT_WORLD 
			, GameDictionary.CHAT_FAMILY 
			, GameDictionary.CHAT_SYSTEM
			, GameDictionary.CHAT_TIPS 
			, GameDictionary.CHAT_PLAYER 
			, GameDictionary.CHAT_DETAILS 
			, GameDictionary.CHAT_BATTLELOG]
		
		/**
		 * 消息格式化的XML
		 * */
		public static function getMessage(type:int , vo:*):Object
		{
			switch(type)
			{
				// 提示
				case ChatData.TOOLTIP:
				// 世界聊天	
				case ChatData.WORLD:
				// 帮会聊天
				case ChatData.FAMILY:
					return getChatMessage(type , vo);
					break;
				// 私聊
				case ChatData.PRIVATE:
					return getPrivateChatXML(vo);
					break;
				// 公告
				case ChatData.SYSTEM:
					return getSystemXML(vo.notice);
					break;
			}
			return null;
		}
		
		/**
		 * 获取聊天消息格式化的XML
		 * */
		private static function getChatMessage(type:int , chatVo:MSG_CHAT_NOTIFY_ACK):Object
		{
			var messageXML:XML = new XML(chatVo.message);
			
			var playerStr:String = "<font size='12' face='宋体' color='#" + COLORS[4].toString(16) + "'>";//玩家
			var detailsStr:String = "<font size='12' face='宋体' color='#" + COLORS[5].toString(16) + "'>";//内容
			var typeStr:String = "<font size='12' face='宋体' color='#" + COLORS[type - 1].toString(16) + "'>";// 世界,帮派,系统,提示
			var battleStr:String = "<font size='12' face='宋体' color='#" + COLORS[6].toString(16) + "'>";//战报
			var end:String = "</font>";
			
			// 消息类型
			var rangeStr:String = "";
			switch(type)
			{	
				// 世界聊天
				case ChatData.WORLD:
					rangeStr = "["+ Lang.instance.trans(ChatData.CHAT_WORLD) +"]";
					break;
				// 家族聊天
				case ChatData.FAMILY:
					rangeStr = "[" + Lang.instance.trans(ChatData.CHAT_FAMILY) + "]";
					break;
				// 提示信息
				case ChatData.TOOLTIP:
					rangeStr = "[" + Lang.instance.trans(ChatData.CHAT_TOOLTIP) + "]";
					break;
			}
			// 加上颜色和粗体
			rangeStr = "<B>" + typeStr  + rangeStr + end + "</B>";
			
			var sendStr:String = messageXML.text;
			var textStr:String
			var msgStr:String;
			
			//提示需要特殊处理
			if(type != ChatData.TOOLTIP){
				// 发送者
				var senderName:String = chatVo.senderName;
				var params:String = chatVo.senderId + "&" + chatVo.senderName;
				var senderStr:String = formatChatLink(LINK_TYPE_PLAYER , params , senderName);
				// 加上颜色
				senderStr = playerStr + senderStr  + "：" + end;	
				
				var itemStr:String
				var texts:Array = sendStr.split("^");
				if(texts[0] == "item")
				{
					params = texts[2];
					var prop:PropBaseVo = ItemManager.instance.getPropById(int(params));
					detailsStr = "<font size='12' face='宋体' color='#" + GameDictionary.getColorByQuality(prop.quality).toString(16) + "'>";//道具
					itemStr = detailsStr + "[" + texts[1] + "]" + end;
					textStr = formatChatLink(LINK_TYPE_ITEM , params , itemStr);
				}
				else if(texts[0] == "battle")
				{
					itemStr = texts[1];//battleStr + "[" + texts[1] + "]" + end;
					params = texts[2];
					textStr = formatChatLink(LINK_TYPE_BATTLE , params , itemStr);
				}
				else
				{
					textStr = detailsStr + sendStr + end;
				}
				msgStr = rangeStr + senderStr + textStr;
			}
			else
			{
				textStr = typeStr + sendStr + end;
				msgStr = rangeStr + textStr;
			}
			messageXML.text = msgStr;
			
			var spriteIndex:int = 5;
			// 表情索引往后移动
			if(type == ChatData.TOOLTIP) return {xml:messageXML};

			var strLen:int = senderName.length + spriteIndex;
			var spriteList:XMLList = messageXML.sprites;
			var len:int = spriteList.sprite.length();
			var i:int = 0;
			for(i;i<len;i++){
				var xml:XML = spriteList.sprite[i];
				if(String(xml.@src).indexOf("eip")>=0)
				{
					var idx:int = int(xml.@index);
					xml.@index = idx + strLen;
				}
			}	
			return {xml:messageXML};
		}
		
		/**
		 * 获取私聊xml
		 * */
		private static function getPrivateChatXML(vo:PRO_ChatContents):Object
		{
			var str:String = "<rtf><text></text><sprites/></rtf>";
			var titleXML:XML = new XML(str);
			var messageXML:XML = new XML(vo.message);
			
			var start1:String = "<font size='12' face='宋体' color='#" + COLORS[1].toString(16) + "'>";//蓝
			var start2:String = "<font size='12' face='宋体' color='#" + COLORS[2].toString(16) + "'>";//绿
			var start3:String = "<font size='12' face='宋体' color='#" + COLORS[0].toString(16) + "'>";//白
			var end:String = "</font>";
			
			// 姓名
			var base:PRO_PlayerBase = GameData.inst.playerInfo;
			var start:String = (vo.base.name == base.name) ? start2 : start1;
			var nameStr:String = start + vo.base.name + " ";
			// 时间
			var timeStr:String = Time.getStringTime3(vo.time.toNumber()) + end;
			// title XML
			titleXML.text = nameStr + timeStr;
			
			// 文字 XML
			var text:String = start3 + messageXML.text + end;
			messageXML.text = text;
			
			return {title:titleXML,message:messageXML};
		}
		
		/**
		 * 公告XML
		 * */
		public static function getSystemXML(systemLog:PRO_Notice , hasTitle:Boolean = true):Object
		{
			var str:String = "<rtf><text></text><sprites/></rtf>";
			var messageXML:XML = new XML(str);
			
			if(systemLog != null)
			{	
				var start1:String = "<font size='12' face='宋体' color='#" + COLORS[2].toString(16) + "'>";
				var start2:String = "<font size='12' face='宋体' color='#" + COLORS[5].toString(16) + "'>";
				var end:String = "</font>";
				
				// 解析systemLog
				var lang:String = parseSystemLog(systemLog);
				
				// 公告文字加上颜色
				lang = start2 + lang + end;
				
				// 文字 XML
				var text:String;
				if(hasTitle)
				{
					// 公告标题
					var title:String = start1 + "<b>[公告]</b>" + end;
					text = title + lang;
				}
				else
				{
					text = lang;
				}
				messageXML.text = text;
			}
			
			return {xml:messageXML};
		}
		
		/**
		 * 解析systemLog
		 * */
		public static function parseSystemLog(systemLog:PRO_Notice):String
		{
			// language表中文字
			var lang:String;
			if(systemLog.id && systemLog.id != 0)
			{
				lang = Lang.instance.trans(systemLog.id.toString());//"{user}成功把{item}强化到{str}级";	
			}
			/*
			else
			{
				lang = systemLog.title;
			}
			*/
			// 替换{str}
			var strs:Array = systemLog.param;
			for(var i:int=0;i<strs.length;i++)
			{
				lang = formatStr(lang , strs[i]);
			}
			// 替换(user)
			var users:Array = systemLog.player;
			for(i=0;i<users.length;i++)
			{
				lang = formatUser(lang , users[i]);
			}
			// 替换(hero)
			var heros:Array = systemLog.hero;
			for(i=0;i<heros.length;i++)
			{
				lang = formatHero(lang , heros[i]);
			}
			// 替换(item)
			var items:Array = systemLog.item;
			for(i=0;i<items.length;i++)
			{
				lang = formatItem(lang , items[i]);
			}
			/*
			// 替换(monster)
			var monsters:Array = systemLog.monster;
			for(i=0;i<monsters.length;i++)
			{
				lang = formatMonster(lang , monsters[i]+"");
			}
			
			// 替换(language)
			var languages:Array = systemLog.language;
			for(i=0;i<languages.length;i++)
			{
				lang = formatLanguage(lang , languages[i]+"");
			}
			*/
			
			// 替换{link}
			var links:Array = systemLog.link;
			lang = formatSystemLink(lang , links);
			
			return lang;
		}
	
		/**
		 * 格式化普通字符串
		 * */
		private static function formatStr(text:String , str:String):String
		{
			text = text.replace("{str}" , str);
			return text;
		}
		
		/**
		 * 格式化角色名
		 * */
		private static function formatUser(text:String , base:PRO_PlayerBase):String
		{
			var start1:String = "<font size='12' face='宋体' color='#" + COLORS[4].toString(16) + "'>";
			var end:String = "</font>";
			
			var name:String = base.name;

			// 加上链接(非自己)
			if(GameData.inst.checkLeader(base.id.toString()) == false)
			{
				var params:String = base.id + "&" + base.name;
				name = formatChatLink(LINK_TYPE_PLAYER , params , name);
			}
			// 加上颜色
			name = start1 + name + end;
			// 替换
			text = text.replace("{user}" , name);
			return text;
		}
		
		/**
		 * 格式化伙伴名
		 * */
		private static function formatHero(text:String , hero:PRO_Hero):String
		{
			var base:PRO_PlayerBase = hero.base;
			var heroVO:HeroVO = HeroManager.instance.getHeroByID(base.id.toString());
			if(heroVO)
			{
				// 加上链接
				var params:String = base.id.toString();
				var name:String = formatChatLink(LINK_TYPE_HERO , params , heroVO.symbol);
				// 加上颜色
				var color:Number = GameDictionary.getColorByQuality(int(heroVO.quality));
				name = "<font color='#" + color.toString(16) + "'>" + name + "</font>";
				// 替换
				text = text.replace("{hero}" , name);
			}
			return text;
		}
		
		/**
		 * 格式化装备
		 * */
		private static function formatItem(text:String , item:PRO_Item):String
		{
			
			var itemVO:PropBaseVo = ItemManager.instance.getPropById(item.itemId);
			// 加上链接
			var params:String = itemVO.itemId + "";
			var name:String = formatChatLink(LINK_TYPE_ITEM , params , itemVO.name);
			// 加上颜色
			name = "<font color='#" + GameDictionary.getColorByQuality(itemVO.quality).toString(16) + "'>[" + name + "]</font>";
			// 替换
			text = text.replace("{item}" , name);
			
			return text;
		}
		
		/**
		 * 格式化怪物
		 * */
		private static function formatMonster(text:String , monsterID:String):String
		{
			/*
			var monster:MonsterVO = MonsterManager.instance.getMonsterByID(monsterID);
			if(monster)
			{
				var start1:String = "<font size='12' face='宋体' color='#" + COLORS[6].toString(16) + "'>";//黄
				var end:String = "</font>";
				// 加上链接
				//var params:String = monsterID;
				//var name:String = formatChatLink(LINK_TYPE_ITEM , params , monster.Name);
				// 加上颜色
				var name:String = start1 + monster.monsterName + end;
				// 替换
				text = text.replace("{monster}" , name);
			}
			return text;
			*/
			return null;
		}
		
		/**
		 * 格式化语言id
		 * */
		private static function formatLanguage(text:String , langID:String):String
		{
			// 替换
			var name:String = Lang.instance.trans(langID);
			text = text.replace("{language}" , name);
			return text;
		}
		
		/**
		 * 格式化功能超链
		 * */
		private static function formatSystemLink(text:String , linkParams:Array):String
		{
			// 获取link参数
			var params:Array = text.match(/{link_[0-9]*_\W*}/gi);
			// 替换link
			for(var i:int=0;i<params.length;i++)
			{
				var param:String = params[i];
				var arr:Array = param.split("_");
				var linkType:String = arr[1];
				var linkLang:String = arr[2].replace("}" , "");
				if(linkParams && linkParams.length > i)
				{
					linkType += "&" + linkParams[i];
				}
				// 有颜色的链接文字
				var start:String = "<font size='12' face='宋体' color='#" + COLORS[2].toString(16) + "'>";//绿
				var end:String = "</font>";
				var linkText:String = start + formatChatLink(LINK_TYPE_SYSTEM , linkType , linkLang) + end;
				text = text.replace(/{link_[0-9]*_\W*}/ , linkText);
			}
			return text;
		}
		
		/**
		 * 可点链接
		 * */
		private static function formatChatLink(type:String, params:String, content:String):String
		{	
			var str:String = "";
			str = "<a href='event:" + type + "^" + params + "'><u>" + content + "</u></a>";
			return  str;
		}
		
		/**
		 * 健康游戏公告
		 * */
		public static function getHealthNotice():XML
		{
			var start1:String = "<font size='12' face='宋体' color='#" + COLORS[5].toString(16) + "'>";//黄
			var end:String = "</font>";
			
			var str:String = "<rtf><text></text><sprites/></rtf>";
			var messageXML:XML = new XML(str);
			var lang:String = Lang.instance.trans("10024");
			var text:String = start1 + lang + end;
			messageXML.text = text;
			
			return messageXML;
		}
		
	}
}