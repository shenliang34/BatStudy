package com.gamehero.sxd2.data {
	
    import com.gamehero.sxd2.gui.formation.ActiveBitmap;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
    import com.gamehero.sxd2.local.Lang;
	
	
	/**
	 * 游戏字典
	 * @author Trey
	 * @create-date 2013-8-26
	 */
	public class GameDictionary {
		
		// 游戏默认字体
		static public const FONT_NAME:String = "宋体";
		
		
		/** 游戏颜色 */
		static public const WHITE:uint = 0xd7deed;		// 白色
		static public const PINK:uint = 0xff5bf2;		// 粉色
		static public const BLUE:uint = 0x568dfe;		// 蓝色
		static public const PURPLE:uint = 0xc552f5;		// 紫色
		static public const ORANGE:uint = 0xffad2c;		// 橙色
		static public const RED:uint = 0xec2727;		// 红色
		static public const YELLOW:uint = 0xf6e33f;		// 黄色
		static public const GREEN:uint = 0x5fbe5c;		// 绿色
		static public const GRAY:uint = 0x959494;		// 灰色
		static public const STROKE:uint = 0x191d20;		// 描边色
		static public const TASK_GREEN:uint = 0x2ce80e;		// 任务相关绿色

		
		/**面板颜色*/
		static public const WINDOW_GRAY:uint = 0x7b8ba0;//灰色
		static public const WINDOW_WHITE:uint = 0xd7deed;//白色
		static public const WINDOW_BLUE:uint = 0x8ea0ff;//蓝色字
		static public const WINDOW_BLUE_GRAY:uint = 0x5e658b;//蓝灰色字
		
		//聊天颜色
		static public const CHAT_WORLD:uint = 0x568dfe;		// 世界
		static public const CHAT_FAMILY:uint = 0x6dfe56;	// 帮派
		static public const CHAT_SYSTEM:uint = 0xf6e33f;	// 通告
		static public const CHAT_TIPS:uint = 0x959494;		// 提示
		static public const CHAT_PLAYER:uint = 0x949ed3;	// 玩家
		static public const CHAT_DETAILS:uint = 0xd7deed;	// 内容
		static public const CHAT_BATTLELOG:uint = 0xc552f5;	// 战报
		
		
		// 颜色标签(Label)
		static public const WHITE_TAG:String = "|color=0x" + WHITE.toString(16) + "|";
		static public const ORANGE_TAG:String = "|color=0x" + ORANGE.toString(16) + "|";
		static public const YELLOW_TAG:String = "|color=0x" + YELLOW.toString(16) + "|";
		static public const RED_TAG:String = "|color=0x" + RED.toString(16) + "|";
		static public const GREEN_TAG:String = "|color=0x" + GREEN.toString(16) + "|";
		static public const BLUE_TAG:String = "|color=0x" + BLUE.toString(16) + "|";
		static public const PURPLE_TAG:String = "|color=0x" + PURPLE.toString(16) + "|";
		static public const GRAY_TAG:String = "|color=0x" + GRAY.toString(16) + "|";
		
		//面板颜色标签
		static public const WINDOW_BLUE_TAG:String = "|color=0x" + WINDOW_BLUE.toString(16) + "|";
		static public const WINDOW_GRAY_TAG:String = "|color=0x" + WINDOW_GRAY.toString(16) + "|";
		static public const WINDOW_BLUE_GRAY_TAG:String = "|color=0x" + WINDOW_BLUE_GRAY.toString(16) + "|";
		
		static public const COLOR_TAG_END:String = "|/color|";
		
		
		// 颜色标签(HtmlText)
		static public const WHITE_TAG2:String = "<font color='#" + WHITE.toString(16) + "'>";
		static public const ORANGE_TAG2:String = "<font color='#" + ORANGE.toString(16) + "'>";
		static public const YELLOW_TAG2:String = "<font color='#" + YELLOW.toString(16) + "'>";
		static public const RED_TAG2:String = "<font color='#" + RED.toString(16) + "'>";
		static public const GREEN_TAG2:String = "<font color='#" + GREEN.toString(16) + "'>";
		static public const BLUE_TAG2:String = "<font color='#" + BLUE.toString(16) + "'>";
		static public const PURPLE_TAG2:String = "<font color='#" + PURPLE.toString(16) + "'>";
		static public const GRAY_TAG2:String = "<font color='#" + GRAY.toString(16) + "'>";
		
		static public const COLOR_TAG_END2:String = "</font>";
		
		
		// 一分钟、一小时、一天秒数	
		static public const MINUTE_SECONDS:uint = 60;
		static public const HOUR_SECONDS:uint = MINUTE_SECONDS * 60;
		static public const DAY_SECONDS:uint = HOUR_SECONDS * 24;
		static public const TEN_DAY_SECONDS:uint = DAY_SECONDS * 10;
		
		
		
		/**
		 *根据品质获取颜色值 
		 * @param quality
		 * @return 
		 * 
		 */		
		static public function getColorByQuality(quality:uint):uint
		{
			switch(quality)
			{
				case 0:
					return GameDictionary.WHITE;
				case 1:
					return GameDictionary.GREEN;
				case 2:
					return GameDictionary.BLUE;
				case 3:
					return GameDictionary.PURPLE;
				case 4:
					return GameDictionary.ORANGE;
				case 5:
					return GameDictionary.RED;
			}
			return GameDictionary.WHITE;
		}
		
		
		/**
		 * 根据种族获取tips
		 * @param quality
		 * @return 
		 * 
		 */		
		static public function getRaceHint(race:int):String
		{
			var str:String = "";
			switch(race)
			{
				case 0:
					str = Lang.instance.trans("AS_race_0");
					break;
				
				case 1:
					str = Lang.instance.trans("AS_race_1");
					break;
				
				case 2:
					str = Lang.instance.trans("AS_race_2");
					break;
				
				case 3:
					str = Lang.instance.trans("AS_race_3");
					break;
				
				case 4:	
					str = Lang.instance.trans("AS_race_4");
					break;
			}
			return str;
		}
		
		
		
		/**
		 * 获得职业名称 
		 * @param career
		 * @return 
		 * 
		 */
		static public function getJobName(job:int):String {
			
			var name:String = "";
			
			switch(job)
			{
				case 1:
					name = "武圣";
					break;
				case 2:
					name = "剑灵";
					break;
				case 3:
					name = "将星";
					break;
				case 4:
					name = "法师";
					break;
				case 5:
					name = "飞羽";
					break;
				case 6:
					name = "方士";
					break;
				case 7:
					name = "金刚";
					break;
				case 8:
					name = "幽冥";
					break;
				case 9:
					name = "罗刹";
					break;
				case 10:
					name = "巫祝";
					break;
				case 11:
					name = "奇门";
					break;
				case 12:
					name = "天师";
					break;
			}
			
			return name;
		}
		
		/**
		 * 获得伙伴属性
		 * @param type
		 * @return 
		 * 
		 */
		public static function getHeroProperty(type:int):String
		{
			var property:String;
			switch(type)
			{
				case 0:
					property = "( )";
					break;
				case 1:
					property = "生命";
					break;
				case 2:
					property = "( )";
					break;
				case 3:
					property = "( )";
					break;
				case 4:
					property = "( )";
					break;
				case 5:
					property = "攻击";
					break;
				case 6:
					property = "物防";
					break;
				case 7:
					property = "法防";
					break;
				case 8:
					property = "内力";
					break;
				case 9:
					property = "暴击";
					break;
				case 10:
					property = "( )";
					break;
				case 11:
					property = "闪避";
					break;
				case 12:
					property = "( )";
					break;
				case 13:
					property = "格挡";
					break;
				case 14:
					property = "( )";
					break;
				case 15:
					property = "穿透";
					break;
				
			}
			
			return property;
		}
		
		
		
		
		
		
		/**
		 * 格式化秒为天数
		 * @param second
		 * @return 
		 * 
		 */
		public static function formatTime(seconds:int):String {
			
			var str:String = String(int(seconds / DAY_SECONDS));
			
			return str;// + Lang.instance.trans("AS_81");
		}
		
		
		
		
		/**
		 * 格式化金钱相关 
		 * @param value
		 * @return 
		 * 
		 */
		static public function formatMoney(value:Number):String {
			
			var str:String = "";
			
			// 当货币数量＜1000000时，用纯数字显示实际的数量
			if(value < 100000) {
				
				str = value.toString();
			}
			// 当1000000≤货币数量＜1亿时，用数字+“万”显示，显示整数万
			else if(value < 100000000) {
				
				str = int(value / 10000) + "万";//Lang.instance.trans("AS_85");
			}
			// 当货币数量≥1亿时，用数字+“亿”显示，显示整数亿
			else {
				
				str = int(value / 100000000) + "亿";//Lang.instance.trans("AS_86");
			}
			
			return str;
		}
		
		/**
		 * 反格式化金钱相关 
		 * @param value
		 * @return 
		 * 
		 */
		static public function reFormatMoney(value:String):Number {
			
			var num:Number = 0;
			
			// 当货币数量＜1000000时，用纯数字显示实际的数量
			if(value.indexOf("亿") > -1)
			{
				num = int(value.substr(value.length,-1)) * 100000000;
			}
			else if(value.indexOf("万") > -1)
			{
				num = int(value.substr(value.length,-1)) * 10000;
			}
			else
			{
				num = Number(value);
			}
			
			return num;
		}
		
		
		
		
		/**
		 * 获取中文数字(0~9)
		 */
		public static function getNumCHN(num:uint):String
		{
			var numArr:Array = [Lang.instance.trans("AS_87"), Lang.instance.trans("AS_88"), Lang.instance.trans("AS_89"), Lang.instance.trans("AS_90"), Lang.instance.trans("AS_91"), Lang.instance.trans("AS_92"), Lang.instance.trans("AS_93"), Lang.instance.trans("AS_94"), Lang.instance.trans("AS_95"), Lang.instance.trans("AS_96")];
			return numArr[num];
		}
		
		
		
		
		/**
		 * 生成支持alternativeGUI的html文本
		 * */
		public static function createCommonText(text:String , color:uint = WHITE , size:uint = 12 , bold:Boolean = false):String
		{
			var colorStr:String = "0x" + color.toString(16);
			var colorStart:String = "|color=" + colorStr + "|";
			var colorEnd:String = "|/color|";
			
			var sizeStart:String = "|size=" + size + "|";
			var sizeEnd:String = "|/size|";
			
			var boldStart:String = "";
			var boldEnd:String = "";
			if(bold == true)
			{
				boldStart = "|b|";
				boldEnd = "|/b|";
			}
			
			var returnStr:String = colorStart + sizeStart + boldStart + text + boldEnd + sizeEnd + colorEnd;
			return returnStr;
		}
		
		/**
		 * 将字符串处理成整形数组
		 * @param str 要处理的字符串
		 * @param cla 数组项的类型
		 * @param delim 分隔符
		 */
		static public function stringToArray(str:String, cla:Class, delim:String = "^"):Array
		{
			var arr:Array = [];
			if(str.length>0){
				arr = str.split(delim);
				var len:int = arr.length;
				for(var i:int=0; i<len; i++)
				{
					arr[i] = cla(arr[i]);
				}
			}
			return arr;
		}
		
	}
}