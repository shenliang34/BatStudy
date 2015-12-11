package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK;
	
	/**
	 * 竞技场数据
	 * @author xuwenyi
	 * @create 2015-10-09
	 **/
	public class ArenaModel
	{
		private static var _instance:ArenaModel
		
		public var data:MSG_UPDATE_ARENA_ACK;
		
		
		public function ArenaModel()
		{
		}
		
		
		
		public static function get inst():ArenaModel
		{
			return _instance ||= new ArenaModel();
		}
	}
}