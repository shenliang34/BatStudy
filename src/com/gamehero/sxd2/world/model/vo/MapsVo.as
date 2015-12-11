package com.gamehero.sxd2.world.model.vo
{
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-7 上午11:17:53
	 * 
	 */
	public class MapsVo
	{
		public function MapsVo()
		{
		}
		/**
		 * 地图id 
		 */		
		public var mapId:int;
		/**
		 * 地图名字 
		 */		
		public var name:String;
		
		/**
		 * 地图类型 
		 */
		public var type:int;
		/**
		 * 需要播放的音乐 
		 */		
		public var sounds:String;
		public var drama:int;
		
		public function fromXML(x:XML):void
		{
			mapId = x.@id;
			name = x.@name;
			type = x.@style;
			sounds = x.@sounds;
			drama = x.@drama;
		}
	}
}