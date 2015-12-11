package com.gamehero.sxd2.drama.cmds.scene
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.pro.PRO_Map;

	/**
	 * 切换场景命令 
	 */
	public class ChangeMapCmd extends BaseCmd
	{
		private var mapId:uint;
		private var x:int;
		private var y:int;
		
		
		
		public function ChangeMapCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			mapId = xml.@mapId;
			x = xml.@x;
			y = xml.@y;
		}
		
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			// 设置出生点
			var map:PRO_Map = GameData.inst.mapInfo;
			map.x = x;
			map.y = y;
			
			SXD2Main.inst.changeView(mapId);
			
			complete();
		}
		
		
		
	}
}