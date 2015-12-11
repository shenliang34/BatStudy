package com.gamehero.sxd2.gui.takeCards.model
{
	import com.gamehero.sxd2.pro.MSG_UPDATE_PRAY_ACK;
	
	import flash.system.ApplicationDomain;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-10-14 16:45:24
	 * 
	 */
	public class TakeCardsModel
	{
		private static var _instance:TakeCardsModel;

		public static function get inst():TakeCardsModel
		{
			if(_instance == null)
				_instance = new TakeCardsModel();
			return _instance;
		}
		public function TakeCardsModel()
		{
			if(_instance != null)
				throw "TakeCardsModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		public var domain:ApplicationDomain;
		
		/**
		 * 令牌id 
		 */		
		public static var heroItemId:int = 15010002;
		/**
		 *令牌消耗 
		 */		
		public static var heroItemCost:int = 10;
		/**
		 * 元宝消耗数量 
		 */		
		public static var moneyCost:int = 1500;
		
		/**
		 * 激活的伙伴个数（纯粹是客户端显示用） 
		 */		
		public var heroIsOpenVec:Vector.<Boolean> = new Vector.<Boolean>();
		
		
		/**
		 * 抽卡获取的伙伴数量 
		 */		
		public static const HERO_NUM:int = 5;
		private var _msg:MSG_UPDATE_PRAY_ACK;
		/**
		 * 初始化伙伴开卡 
		 * 
		 */		
		public function initOpenVec():void
		{
			clearOpenVec();
			for(var i:int = 0; i < HERO_NUM; i++)
			{
				heroIsOpenVec.push(false);
			}
		}
		
		public function clearOpenVec():void
		{
			heroIsOpenVec.length = 0;
		}
		
		/**
		 * 抽卡返回的数据 
		 */
		public function get msg():MSG_UPDATE_PRAY_ACK
		{
			return _msg;
		}
		
		/**
		 * @private
		 */
		public function set msg(value:MSG_UPDATE_PRAY_ACK):void
		{
			_msg = value;
		}
	}
}