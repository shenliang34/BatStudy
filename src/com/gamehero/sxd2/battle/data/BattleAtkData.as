package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	
	/**
	 * 战斗中的攻击数据
	 * @author xuwenyi
	 * @create 2013-07-15
	 **/
	public class BattleAtkData
	{
		// 目标
		public var targetPlayer:BPlayer;
		
		// 伤害(正数为伤害,负数为治疗)
		public var dmg:int;
		// 用于显示的伤害(正数为伤害,负数为治疗)
		public var dmgShow:int;
		// 反伤(正数为伤害,负数为治疗)
		public var selfdmg:Array;
		// 增加的怒气
		public var anger:int;
		// 增加的战意
		public var volition:int;
		// buff
		public var buffs:Array;
		
		// 是否暴击
		public var crt:Boolean;
		// 是否格挡
		public var pay:Boolean;
		// 是否闪避
		public var avd:Boolean;
		// 是否穿透
		public var pnt:Boolean;
		// 是否存在伤害吸收
		public var abb:int;
		// 是否溅射(客户端的技能攻击预判断要用到)
		public var spurt:Boolean;
		// 本次行动是技能的第几步(一般第一步就是主要攻击对象)
		public var step:int;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleAtkData()
		{
		}
	}
}