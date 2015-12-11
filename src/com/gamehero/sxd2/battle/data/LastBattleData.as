package com.gamehero.sxd2.battle.data
{
	import com.netease.protobuf.UInt64;
	
	import flash.utils.ByteArray;
	
	/**
	 * 存放上一次的战斗数据
	 * @author xuwenyi
	 * @create 2013-12-27
	 **/
	public class LastBattleData
	{
		// 上一场战斗的id
		public static var battleID:int;
		// 上一场战斗的类型
		public static var battleType:int;
		// 上一场战斗的结果
		public static var battleResult:BattleResult;
		// 上一场战斗的战斗回放id
		public static var replayID:UInt64;
		// 上一场战斗的全部数据
		public static var protoBytes:ByteArray;
		// 上一场战斗是否为战报
		public static var isReport:Boolean;
		// 是否为第一次打
		public static var isFirstBattle:Boolean;
	}
}