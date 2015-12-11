package com.gamehero.sxd2.core
{
	
	
	/**
	 * 联运平台枚举
	 * @author xuwenyi
	 * @create 2014-12-09
	 **/
	public class Agent
	{
		public static const A_pps:String = "pps";
		public static const A_1001:String = "1001";
		public static const A_jingdong:String = "jingdong";
		public static const A_qidian:String = "qidian";
		public static const A_91wan:String = "91wan";
		public static const A_37wan:String = "37wan";
		public static const A_baidu:String = "baidu";
		public static const A_fengyun:String = "fengyun";
		public static const A_kuaibo:String = "kuaibo";
		public static const A_bnbw:String = "bnbw";
		public static const A_baofeng:String = "baofeng";
		public static const A_aoyou:String = "aoyou";
		public static const A_9377:String = "9377";
		public static const A_gtv:String = "gtv";
		public static const A_duoku:String = "duoku";
		public static const A_ya247:String = "ya247";
		public static const A_7k7k:String = "7k7k";
		public static const A_bingxue:String = "bingxue";
		public static const A_kuaiyou:String = "kuaiyou";
		public static const A_xiaomi:String = "xiaomi";
		public static const A_uc:String = "uc";
		public static const A_91:String = "91";
		public static const A_360:String = "360";
		public static const A_test:String = "test";
		public static const A_4399:String = "4399";
		public static const A_sina:String = "sina";
		public static const A_guguo:String = "guguo";
		public static const A_duowan:String = "duowan";
		public static const A_kaiying:String = "kaiying";
		public static const A_kugou:String = "kugou";
		public static const A_kuwo:String = "kuwo";
		public static const A_sogou:String = "sogou";
		public static const A_51you:String = "51you";
		public static const A_51wan:String = "51wan";
		public static const A_shunwang:String = "shunwang";
		public static const A_fengxing:String = "fengxing";
		public static const A_8090:String = "8090";
		public static const A_common:String = "common";
		public static const A_959u:String = "959u";
		public static const A_kaixin:String = "kaixin";
		public static const A_ai6:String = "ai6";
		public static const A_game2:String = "game2";
		public static const A_616wan:String = "616wan";
		public static const A_dahei:String = "dahei";
		public static const A_37wanwan:String = "37wanwan";
		public static const A_baidutieba:String = "baidutieba";
		public static const A_aiyeyou:String = "aiyeyou";
		public static const A_xingdie:String = "xingdie";
		public static const A_renren:String = "renren";
		public static const A_lehaihai:String = "lehaihai";
		public static const A_65wan:String = "65wan";
		public static const A_844a:String = "844a";
		public static const A_33456:String = "33456";
		public static const A_17hihi:String = "17hihi";
		public static const A_jiudou:String = "jiudou";
		public static const A_yzwan:String = "yzwan";
		public static const A_e5wan:String = "e5wan";
		public static const A_679wan:String = "679wan";
		public static const A_xunlei:String = "xunlei";
		public static const A_wan78:String = "wan78";
		public static const A_pingan:String = "pingan";
		public static const A_522g:String = "522g";
		public static const A_yyy:String = "yyy";
		public static const A_play188:String = "play188";
		public static const A_dq247:String = "dq247";
		public static const A_511wan:String = "511wan";
		public static const A_214:String = "214";
		public static const A_juren:String = "juren";
		public static const A_changyou:String = "changyou";
		public static const A_zhiyou:String = "zhiyou";
		public static const A_yy:String = "yy";
		public static const A_fenghuang:String = "fenghuang";
		public static const A_jj:String = "jj";
		public static const A_912366:String = "912366";
		public static const A_2133:String = "2133";
		
		
		public function Agent()
		{
		}
		
		
		
		/**
		 * 检查当前平台是否是指定平台
		 * */
		public static function check1(agent:String):Boolean
		{
			return URI.agent == agent;
		}
		
		
		
		
		
		/**
		 * 检查当前平台是否是指定平台数组内的一个
		 * */
		public static function check2(agents:Array):Boolean
		{
			var myAgent:String = URI.agent;
			for(var i:int=0;i<agents.length;i++)
			{
				if(myAgent == agents[i])
				{
					return true;
				}
			}
			return false;
		}
		
		
		
		
		
	}
}