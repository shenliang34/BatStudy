package com.gamehero.sxd2.gui.blackMarket.model
{
	import flash.system.ApplicationDomain;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-17 18:16:26
	 * 
	 */
	public class BlackMarketModel
	{
		private static var _instance:BlackMarketModel;
		public static function get inst():BlackMarketModel
		{
			if(_instance == null)
				_instance = new BlackMarketModel();
			return _instance;
		}
		public function BlackMarketModel()
		{
			if(_instance != null)
				throw "BlackMarketModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		public var domain:ApplicationDomain;
		
		/**
		 * 操作来源  1： 打开界面的刷新 ；2： 主动请求的刷新； 3：购买物品后的刷新 
		 */		
		public var optFromType:int = 0;//操作来源
		
	}
}