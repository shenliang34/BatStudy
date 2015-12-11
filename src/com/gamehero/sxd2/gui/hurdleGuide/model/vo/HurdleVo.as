package com.gamehero.sxd2.gui.hurdleGuide.model.vo
{
	import com.gamehero.sxd2.local.Lang;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-1 下午3:16:27
	 * 
	 */
	public class HurdleVo
	{
		public function HurdleVo()
		{
		}
		/**
		 * 副本id 
		 */		
		public var id:int;
		/**
		 * 副本名字 
		 */		
		public var name:String;
		/**
		 * 地图id 
		 */		
		public var mapId:int;
		/**
		 * 前置任务 
		 */		
		public var pre_taskid:Array;
		/**
		 * 消耗道具 
		 */		
		public var consume_id:int;
		/**
		 * 消耗数量 
		 */		
		public var consume_num:int;
		
		/**
		 * 战斗节点数组 
		 */		
		public var wave_num:Array;
		/**
		 * 通关奖励 
		 */		
		public var box_id:Array;
		/**
		 * 难度 
		 */		
		public var difficult:int;
		/**
		 * 剧情
		 * */
		public var drama:Array;
		/**
		 * 所在地图Id
		 * */
		public var entrance_id:int;
		
		
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			mapId = xml.@mapId;
			name = Lang.instance.trans(xml.@name);
			consume_id = xml.@consume_id;
			
			consume_num = xml.@consume_num;
			wave_num = String(xml.@wave_num).split("^");
			box_id = String(xml.@box_id).split("^");
			difficult = xml.@difficult;
			entrance_id = xml.@entrance_id;
			
			if(xml.@drama != "")
			{
				drama = String(xml.@drama).split("^");
			}
		}
	}
}