package com.gamehero.sxd2.gui.bag.model
{
	/**
	 * 先攻	身法	招架	会心	穿刺	初始怒气	武力	智力	根骨	生命	物理攻击	物理防御	法术防御	内力	闪避	命中	格挡	破击	穿透	守护	爆击	韧性
	 * att_effect	dog_effect	parry_effect	crit_effect	arp_effect	anger	force	intellect	skeleton	maxhp	attack	pdef	mdef	skill_att	dog	anti_dog	parry	anti_parry	arp	anti_arp	crit	anti_crit

	 * @author weiyanyu
	 * 创建时间：2015-9-15 上午11:47:22
	 * 
	 */
	public class ItemPropAddDict
	{
		public function ItemPropAddDict()
		{
		}
		
//		public static var propName:Vector.<String> = new <String>['当前血量',	'血量上限','初始怒气','怒气上限','物理攻击',
//			'物理防御','法术防御','内力','暴击','会心',
//			'闪避','身法','格挡','招架','穿透',
//			'穿刺','武器','智力','根骨','先攻',
//			'命中','破击','韧性','守护'];
		
		
		/**
		 * 当前血量 
		 */		
		public static var HP:int = 1;
		/**
		 * 生命 
		 */		
		public static var MAXHP:int = 2;
		/**
		 * 初始怒气 
		 */		
		public static var ANGER:int = 3;
		/**
		 *  怒气上限
		 */		
		public static var MAXANGER:int = 4;
		/**
		 * 物理攻击 
		 */		
		public static var ATTACK:int = 5;
		/**
		 * 物理防御 
		 */		
		public static var PDEF:int = 6;
		/**
		 * 法术防御 
		 */		
		public static var MDEF:int = 7;
		/**
		 *  内力
		 */		
		public static var SKILL_ATT:int = 8;
		/**
		 * 爆击 
		 */		
		public static var CRIT:int = 9;
		/**
		 * 会心 
		 */		
		public static var ANTI_CRIT:int = 10;
		/**
		 * 身法 
		 */		
		public static var ANTI_DOG:int = 12;
		/**
		 * 闪避 
		 */		
		public static var DOG:int = 11;
		/**
		 * 格挡 
		 */		
		public static var PARRY:int = 13;
		/**
		 * 招架 
		 */		
		public static var ANTI_PARRY:int = 14;

		/**
		 * 穿透 
		 */		
		public static var ARP:int = 15;
		/**
		 * 穿刺 
		 */		
		public static var ANTI_ARP:int = 16;

		/**
		 * 武力 
		 */		
		public static var FORCE:int = 17;
		/**
		 * 智力 
		 */		
		public static var INTELLECT:int = 18;
		/**
		 * 根骨 
		 */		
		public static var SKELETON:int = 19;
		/**
		 * 先攻 
		 */		
		public static var ATT_EFFECT:int = 20;
		/**
		 * 命中 
		 */		
		public static var DOG_EFFECT:int = 21;

		/**
		 * 破击 
		 */		
		public static var PARRY_EFFECT:int = 22;
		/**
		 * 韧性 
		 */		
		public static var CRIT_EFFECT:int = 23;
		/**
		 * 守护
		 */		
		public static var ARP_EFFECT:int = 1;


	}
}