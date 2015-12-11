package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	
	/**
	 * 整合battleTurn，包含一个攻击者的所有攻击数据
	 * @author xuwenyi
	 * @create 2015-06-30
	 **/
	public class BattleTurnData
	{
		// 普通攻击数据
		public var turns:Vector.<BattleTurn>;
		// 合击数据
		public var jointAtkTurnData:BattleTurnData;
		// 反击数据
		public var counterTurn:BattleTurn;
		
		// 当前行动角色
		public var aPlayer:BPlayer;
		// 等该角色行动时更新数据
		public var updateRole:PRO_BattlePlayer;
		
		// 行动前的delay时间(合击用)
		public var jointAtkDelay:Number = 0;
		// 所有子行动耗时和
		public var totalDuration:Number = 0;
		
		// 该角色本回合行动完是否仍然存活(反击有时候会把攻击者杀死)
		public var isAliveAfterAction:Boolean = true;
		
		
		public function BattleTurnData()
		{
		}
	}
}