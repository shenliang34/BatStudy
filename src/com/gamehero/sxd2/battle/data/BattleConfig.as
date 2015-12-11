package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.core.GameConfig;
	
	/**
	 * 战斗内全局配置
	 * @author xuwenyi
	 * @create 2014-01-25
	 **/
	public class BattleConfig
	{
		// 玩家素材高度(按职业分)
		public static const PLAYER_HEIGHT:Array = [0,120,120,120,120];
		// 爆发状态高度
		public static const PLAYER_HEIGHT_BURST:int = 210;
		
		// 特效URL
		//public static var JUQI:String;
		public static var PRE_ATK:String;
		public static var PARRY:String;
		public static var PENETRATION:String;
		public static var DEATH_PARTICLE:String;
		public static var DEATH_MASK:String;
		public static var SOUL:String;
		
		// 主角上阵
		public static var LEADER_OPENING1:String;
		public static var LEADER_OPENING2:String;
		public static var LEADER_CLOUD1:String;
		public static var LEADER_CLOUD2:String;
		
		// 主角模型
		public static var LEADER_FIGURE_URL:String;
		
		
		// 杀和桃人物特效
		//public static var KILL:String;
		//public static var HEAL:String;
		//public static var REBORN:String;
		
		
		
		/**
		 * 初始化
		 * */
		public static function init():void
		{
			// 特效URL
			PRE_ATK = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_zhanyi01_se";
			PARRY = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_gedang01_ua";
			PENETRATION = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_chuangtou01_ua";
			DEATH_PARTICLE = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_dead01_ua";
			DEATH_MASK = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_dead02_ua";
			SOUL = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_soul_se";
			
			// 主角上阵
			LEADER_OPENING1 = GameConfig.BATTLE_SE_SWF_URL + "swf_tx_zhujueshangzhen_se";
			LEADER_OPENING2 = GameConfig.BATTLE_SE_SWF_URL + "swf_tx_huobanshangzhen_se";
			LEADER_CLOUD1 = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_daijiyun_bai";
			LEADER_CLOUD2 = GameConfig.PLAYER_PLAYER_EFFECT_URL + "png_daijiyun_hei";
			
			// 主角模型
			LEADER_FIGURE_URL = GameConfig.BATTLE_FIGURE_URL + "player_zhujue01_b";
			
			// 杀和桃人物特效
			//KILL = GameConfig.PLAYER_PLAYER_EFFECT_URL + "tx_miaosha01_ua_a";
			//HEAL = GameConfig.PLAYER_PLAYER_EFFECT_URL + "tx_wallheal_ua_a";
			//REBORN = GameConfig.PLAYER_PLAYER_EFFECT_URL + "tx_shuaguai01_ua_a";
		}
	}
}