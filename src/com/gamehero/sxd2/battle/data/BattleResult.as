package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.pro.PRO_BattleDetail;
	import com.gamehero.sxd2.pro.PRO_BattleResult;
	
	/**
	 * 战斗结果
	 * @author xuwenyi
	 * @create 2014-03-06
	 **/
	public class BattleResult
	{
		public var battleResult:PRO_BattleResult;
		public var win:Boolean;
		public var leaderName:String;
		public var isReplay:Boolean;
		
		public function BattleResult()
		{
		}
	}
}