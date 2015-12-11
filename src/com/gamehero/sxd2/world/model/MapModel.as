package com.gamehero.sxd2.world.model
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.pro.MSG_MAP_UPDATE_ACK;
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.vo.NpcVO;
	import com.gamehero.sxd2.world.model.vo.MapsVo;
	import com.gamehero.sxd2.world.model.vo.SceneVo;
	
	import flash.utils.Dictionary;

	/**
	 * 场景信息
	 * @author weiyanyu
	 * 创建时间：2015-7-20 11:47:31
	 * 
	 */
	public class MapModel
	{
		private static var _instance:MapModel;
		
		public static function get inst():MapModel
		{
			if(_instance == null)
				_instance = new MapModel();
			return _instance;
		}
		public function MapModel()
		{
			if(_instance != null)
				throw "MapModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		/**
		 * 场景信息 
		 */		
		public var sceneVo:SceneVo;
		/**
		 * 当前地图信息 
		 */		
		public var mapVo:MapsVo;
		/**
		 * 场景是否加载成功 
		 */		
		public var isLoaded:Boolean;
		
		/**
		 * 玩家字典
		 */		
		public var playerDict:Dictionary = new Dictionary();
		/**
		 * Npc对象数组
		 */
		public var npcDict:Dictionary = new Dictionary();
		/**
		 * 玩家可进入城市数组
		 */
		public var cityList:Array = [];
		
		/**
		 *  在场景没有加载完成的时候先记录角色的数据 
		 * @param info
		 * 
		 */		
		public function upDatePlayer(info:MSG_MAP_UPDATE_ACK):void
		{
			var num:Number;
			for each(var pp:PRO_Player in info.player)
			{
				num = pp.id.toNumber();
				
				if(num == GameData.inst.playerInfo.id.toNumber() || pp.map == null) continue;
				
				if(playerDict[num] == null)
					playerDict[num] = pp;
				else
				{
					if(pp.map != null)
					{
						playerDict[num].map = pp.map;
					}
					if(pp.base != null)
					{
						playerDict[num].base = pp.base;
					}
				}
			}
		}
		
		/**
		 *根据位置获取玩家信息
		 * 
		 */	
		public function getPlayetInfo(x:int,y:int):PRO_PlayerBase{
			for each(var p:PRO_Player in playerDict){
				if(p.map.x == x && p.map.y){
					return p.base
				}
			}
			
			return null;
		}

	}
}