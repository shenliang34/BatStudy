package com.gamehero.sxd2.gui.equips.model
{
	import flash.system.ApplicationDomain;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-10 10:56:40
	 * 
	 */
	public class EquipModel
	{
		private static var _instance:EquipModel;
		public static function get inst():EquipModel
		{
			if(_instance == null)
				_instance = new EquipModel();
			return _instance;
		}
		public function EquipModel()
		{
			if(_instance != null)
				throw "EquipModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		public var domain:ApplicationDomain;
		
		public var curSelectedId:int;//当前选中的伙伴
		
		
	}
}