package com.gamehero.sxd2.gui.hurdleGuide.model
{
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.ChapterVo;
	import com.gamehero.sxd2.manager.ChapterManager;
	import com.gamehero.sxd2.pro.InstanceStatus;
	import com.gamehero.sxd2.pro.PRO_Instance;
	
	import flash.system.ApplicationDomain;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-8-30 19:54:42
	 * 
	 */
	public class HurdleGuideModel
	{
		private static var _instance:HurdleGuideModel;
		public static function get inst():HurdleGuideModel
		{
			if(_instance == null)
				_instance = new HurdleGuideModel();
			return _instance;
		}
		public function HurdleGuideModel()
		{
			if(_instance != null)
				throw "HurdleGuideModel.as" + "is a SingleTon Class!!!";
			_instance = this;
			
			instanceList = new Array();
		}
		/**
		 * 战报 
		 */		
		public var reportDomain:ApplicationDomain;
		
		public var guideDomain:ApplicationDomain;

		/**
		 * 简单 
		 */		
		public static var EASY:int = 0;
		/**
		 * 困难 
		 */		
		public static var HARD:int = 1;
		/**
		 * 炼狱 
		 */		 
		public static var HELL:int = 2;
		
		
		
		/**
		 * 三个难度服务器返回的节点列表 
		 */		
		private var arr:Array;
		/**
		 * 总通关数量 
		 */		
		public var starLen:int;
		/**
		 * 服务器返回的列表 
		 */		
		public var instanceList:Array;
		/**
		 * 当前章节 
		 */		
		public var curChapter:ChapterVo;
		/**
		 * 当前选择的难度 
		 */		
		public var curDiff:int;
		/**
		 * 当前要提示的关卡 
		 */		
		public var curTipsNode:int = -1;
		/**
		 * 当前章节id 
		 */		
		public var curChapterId:int;
		
		/**
		 * 初始化三个难度的通关数据 
		 * @param list
		 * 
		 */		
		public function init(list:Array):void
		{
			instanceList = list;
			arr = [[],[],[]];
			starLen = 0;
			for each(var pro:PRO_Instance in instanceList)
			{
				if(curChapter.simple.indexOf(pro.id))
				{
					arr[0].push(pro.id);
				}
				else if(curChapter.hard.indexOf(pro.id))
				{
					arr[1].push(pro.id);
				}
				else if(curChapter.hell.indexOf(pro.id))
				{
					arr[2].push(pro.id);
				}
				if(pro.status == InstanceStatus.Completed)
				{
					starLen ++;
				}
			}
		}
		
		/**
		 * 根据节点id获得服务器的返回数据 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getNodeData(id:int):PRO_Instance
		{
			for each(var pro:PRO_Instance in instanceList)
			{
				if(pro.id == id)
					return pro;
			}
			return null;
		}
		
		
		public function clear():void
		{
			arr = null;
			starLen = 0;
			instanceList = null;
			curChapter = null;
			
			curDiff = 0;
			curTipsNode = -1;
		}
		
	}
}