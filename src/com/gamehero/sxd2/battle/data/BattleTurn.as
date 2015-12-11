package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import bowser.utils.data.Group;
	
	/**
	 * 用于存放战斗中角色一轮攻击的所有数据
	 * @author xuwenyi
	 * @create 2013-07-11
	 **/
	public class BattleTurn
	{
		// 当前行动角色
		public var aPlayer:BPlayer;
		// 所有被攻击对象
		public var uPlayers:Array;
		// 当前被攻击的角色
		public var firstAtks:Array;
		public var secondAtks:Array;
		
		// 当前使用技能
		public var skill:BattleSkill;
		// 技能效果
		public var skillEf:BattleSkillEf;
		// 伤害数据
		public var atks:Group;
		// 是否含有溅射单位
		public var hasSpurt:Boolean;
		
		// 动作持续总时间
		public var actionDuration:Number = 0;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleTurn()
		{
		}
		
		
		
		/**
		 * 是否存在行动数据
		 * */
		public function get hasAction():Boolean
		{
			if(atks && atks.length > 0)
			{
				return true;
			}
			return false;
		}
		
	}
}