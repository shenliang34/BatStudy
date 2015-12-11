package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.pro.PRO_BattleBuff;
	import com.gamehero.sxd2.vo.BuffVO;
	
	/**
	 * buff数据
	 * @author xuwenyi
	 * @create 2014-05-07
	 **/
	public class BattleBuff
	{
		public var id:int;
		public var vo:BuffVO;
		
		public var triggerTime:int;
		public var data:PRO_BattleBuff;
		
		
		public function BattleBuff()
		{
		}
	}
}