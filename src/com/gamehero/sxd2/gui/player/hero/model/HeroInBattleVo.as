package com.gamehero.sxd2.gui.player.hero.model
{
	import com.gamehero.sxd2.vo.BaseVO;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-11 上午11:14:12
	 * 
	 */
	public class HeroInBattleVo extends BaseVO
	{
		public var id:int; // 物品Id      
		public var heroId:int;// 配置Id
		public var battlePrower:int;// 战斗力
		public var maxhp:int;// 生命
		public var dam:int; // 攻击
		public var pdef:int;// 物理防御
		public var mdef:int;// 法术防御
		public var dog:int;// 闪避
		public var crit:int; // 暴击
		public var arp:int;// 穿透
		public var parry:int;// 格挡
		public var skillAtt:int;// 内力
		
		public function HeroInBattleVo()
		{
			
		}
	}
}