package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	/**
	 * 单次伤害数据
	 * @author xuwenyi
	 * @create 2013-12-12
	 **/
	public class BattleDamageData
	{
		public var aPlayer:BPlayer;
		public var uPlayer:BPlayer;
		public var skillEf:BattleSkillEf;
		public var id:int;
		public var atkData:BattleAtkData;
		public var isSelf:Boolean; // 攻击对象是否是攻击者本人
		
		
		public function BattleDamageData()
		{
		}
	}
}