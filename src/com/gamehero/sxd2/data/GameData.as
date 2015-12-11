package com.gamehero.sxd2.data {
	
	import com.gamehero.sxd2.pro.BuyCount;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_PlayerExtra;
	import com.gamehero.sxd2.pro.PRO_Skill;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	
	
	/**
	 * 游戏数据存放类,存放游戏客户端运行时的临时数据 
	 */
	public class GameData extends EventDispatcher 
	{	
		static private var _instance:GameData;
		
		//用户信息
		private var _roleInfo:PRO_Player;
		//游戏全局设置(音乐音效,消费提示等)
		public var gameConfig:Object = new Object();
		//登录时开放的功能
		public var functions:Array = [];
		//主角是否在移动 
		public var isMove:Boolean;
		//主角是否在战斗中
		public var isBattle:Boolean;
		//任务数组信息
		public var taskList:Array = [];
		//玩家技能信息
		public var roleSkill:PRO_Skill;
		//当前所在副本id		
		public var curHurdleId:int = 0;
		//已加载的地图ID
		public var loadCompleteMapId:Array = [];
		//购买道具计数
		public var buyItems:Dictionary = new Dictionary();
		
		/**
		 * 临时用标记 用于解决 同一场景反复使用
		 */
		public var isLoadScene:Boolean = false;
		
		public var isLoadHurdle:Boolean = false;
		
		/**
		 * Constructor 
		 * @param singleton
		 * 
		 */
		public function GameData(singleton:Singleton) {

		}
		
		/**
		 * 获取单例
		 * */
		static public function get inst():GameData {
			return _instance ||= new GameData(new Singleton());
		}
		
		/**
		 * 获取用户信息
		 * */
		public function get roleInfo():PRO_Player
		{
			return _roleInfo;
		}
		
		/**
		 * 获取用户基础信息
		 * */
		public function get playerExtraInfo():PRO_PlayerExtra
		{
			return _roleInfo.extra;
		}
		
		/**
		 * 获取用户属性信息
		 * */
		public function get playerInfo():PRO_PlayerBase
		{
			return _roleInfo.base;
		}
		
		/**
		 * 设置用户属性信息
		 * */
		public function set playerInfo(value:PRO_PlayerBase):void
		{
			_roleInfo.base = value;
		}
		
		/**
		 * 设置用户地址信息
		 * */
		public function set mapInfo(mapInfo:PRO_Map):void
		{
			_roleInfo.map = mapInfo;
		}
		
		/**
		 * 获取用户地址信息
		 * */
		public function get mapInfo():PRO_Map
		{
			return _roleInfo.map;
		}

		/**
		 * 设置用户信息
		 * */
		public function set roleInfo(user:PRO_Player):void
		{
			if(_roleInfo)
			{
				if(user.base)
				{
					_roleInfo.base = user.base;
				}
				if(user.extra)
				{
					_roleInfo.extra = user.extra;
				}
				if(user.map)
				{
					_roleInfo.map = user.map;
					try
					{
						SXD2Main.inst.enterMap(_roleInfo.map);
					}catch(e:Error)
					{
						
					}
				}
			}
			else
			{
				_roleInfo = user;
			}

		}
		
		/** 
		 * 判断某个id是否是主角id
		 * */
		public function checkLeader(id:String):Boolean
		{
			if(_roleInfo != null)
			{
				var base:PRO_PlayerBase = _roleInfo.base;
				var myID:String = base.id.toString();
				return myID == id;
			}
			return false;
		}
		
		/** 
		 * 判断某个配置是否开启
		 * */
		public function checkConfigOpen(key:String):Boolean
		{
			if(gameConfig.hasOwnProperty(key) == true && gameConfig[key] == true)
			{
				return true;
			}
			return false;
		}
		
		public function setBuyItems(list:Array):void
		{
			for(var i:int;i<list.length;i++)
			{
				var item:BuyCount = list[i] as BuyCount;
				if(buyItems[item.itemId.toString()])
				{
					buyItems[item.itemId.toString()].buyCount = item.buyCount
				}
				else
				{
					buyItems[item.itemId.toString()] = item;
				}
			}
		}
		
		public function getItemCount(id:int):int
		{
			if(buyItems[id.toString()])
				return buyItems[id.toString()].buyCount;
			else
				return 0;
		}
	}
}

class Singleton{}