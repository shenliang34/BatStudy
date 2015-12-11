package com.gamehero.sxd2.gui.hurdleGuide.model.vo
{
	/**
	 * 剧情副本配置
	 * @author weiyanyu
	 * 创建时间：2015-8-31 下午10:03:30
	 * 
	 */
	public class ChapterVo
	{
		
		public var id:int;
		/**
		 * 简单id 
		 */		
		public var simple:Array;
		/**
		 * 隐藏关卡 
		 */		
		public var simpleHide:Array;
		
		/**
		 * 困难id 
		 */		
		public var hard:Array;
		/**
		 * 隐藏困难关卡 
		 */		
		public var hardHide:Array;
		/**
		 * 炼狱id 
		 */		
		public var hell:Array;
		/**
		 * 隐藏炼狱关卡 
		 */		
		public var hellHide:Array;
		/**
		 * 关卡列表 
		 */		
		public var hurdleList:Array;
		/**
		 * 宝箱条件 
		 */		
		public var condition:Array;
		/**
		 * 宝箱奖励 
		 */		
		public var reward_1:Array;
		public var reward_2:Array;
		public var reward_3:Array;
		
		/**
		 * 难度数量 ，1，2，3
		 */		
		public var hardNum:int;
		
		public function ChapterVo()
		{
		}
		
		
		public function fromXML(xml:XML):void
		{
			id = xml.@chapter_Id;
			
			simple = String(xml.@simple).split("^");
			hard = String(xml.@hard).split("^");
			hell = String(xml.@hell).split("^");
			
			hurdleList = [simple,hard,hell];
			
			condition = String(xml.@condition).split("^");
			reward_1 = String(xml.@reward_1).split("^");
			reward_2 = String(xml.@reward_2).split("^");
			reward_3 = String(xml.@reward_3).split("^");
			
			hardNum = xml.@hardNum;
		}
	}
}