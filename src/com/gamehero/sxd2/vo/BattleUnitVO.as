package com.gamehero.sxd2.vo
{
	
	/**
	 * 战场VO
	 * @author xuwenyi
	 * @create 2014-02-20
	 **/
	public class BattleUnitVO extends BaseVO
	{
		public var battleID:int;
		public var battleName:String;
		public var battleType:int;
		public var mapid:String;
		public var boshu:int;
		public var sound:String;
		public var monsterLeaderID:String;
		public var mapName:String;
		public var endDrama:int;
		
		public function BattleUnitVO()
		{
			super();
		}
	}
}