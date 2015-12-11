package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	
	import bowser.utils.data.Group;
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 阵营
	 * @author xuwenyi
	 * @create 2013-06-25
	 **/
	public class BattleGrid
	{
		
		// 每个位置关联的身后pos(key为当前pos)
		//private static const NEIBOUR_BACK_POS:Array = [null,[5,6],[6,7],[7,8],[8,9],[10],[10,11],[11,12],[12,13],[13],[14],[14,15],[15,16],[16],[],[],[]];
		
		// 阵营
		private var camp:int;
		// 阵型前中后上的人物
		public var playerList:Group = new Group();
		
		// 阵型前中后排位置索引
		public var CAMP_COL_POS:Array;
		// 阵型上中下排位置索引
		public var CAMP_ROW_POS:Array;
		// 我方使用阵型(1920*1080)
		public var CAMP_POS_S:Array;
		
		// 每次浏览器缩放的阵型位置偏移量
		public var offset:Vector2D;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleGrid(camp:int)
		{
			this.camp = camp;
			
			// 向中间靠的偏移量(临时)
			//var move:Vector2D = new Vector2D(15,-9);//new Vector2D(14,-11);
			
			// 我方
			if(camp == 1)
			{
				CAMP_COL_POS = [[1,2,3],[4,5,6],[7,8,9]];
				CAMP_ROW_POS = [[1,4,7],[2,5,8],[3,6,9]];
				CAMP_POS_S = [
					/*new Vector2D(440,300) 
					,new Vector2D(410,370) 
					,new Vector2D(380,440) 
					,new Vector2D(315,300)
					,new Vector2D(285,370)
					,new Vector2D(255,440)
					,new Vector2D(190,300)
					,new Vector2D(160,370)
					,new Vector2D(130,440)
					,new Vector2D(40 , 370 - 180)*///主角站位
					new Vector2D(808,580) 
					,new Vector2D(778,650) 
					,new Vector2D(748,720) 
					,new Vector2D(683,580)
					,new Vector2D(653,650)
					,new Vector2D(623,720)
					,new Vector2D(558,580)
					,new Vector2D(529,650)
					,new Vector2D(498,720)
					,new Vector2D(408 , 650 - 180)//主角站位
				];
			}
			// 敌方
			else
			{
				CAMP_COL_POS = [[1,2,3],[4,5,6],[7,8,9]];
				CAMP_ROW_POS = [[1,4,7],[2,5,8],[3,6,9]];
				CAMP_POS_S = [
					/*new Vector2D(760,300) 
					,new Vector2D(790,370) 
					,new Vector2D(820,440) 
					,new Vector2D(885,300) 
					,new Vector2D(915,370) 
					,new Vector2D(945,440) 
					,new Vector2D(1010,300) 
					,new Vector2D(1040,370)
					,new Vector2D(1070,440)
					,new Vector2D(1160 , 370 - 180)*///主角站位
					new Vector2D(1128,580) 
					,new Vector2D(1158,650) 
					,new Vector2D(1188,720) 
					,new Vector2D(1253,580) 
					,new Vector2D(1283,650) 
					,new Vector2D(1313,720) 
					,new Vector2D(1378,580) 
					,new Vector2D(1408,650)
					,new Vector2D(1438,720)
					,new Vector2D(1528 , 650 - 180)//主角站位
				];
			}
		}
		
		
		
		
		
		/**
		 * 添加角色
		 * */
		public function addPlayer(player:BPlayer):void
		{
			playerList.add(player);
		}
		
		
		
		
		/**
		 * 移除角色
		 * */
		public function removePlayer(player:BPlayer):void
		{
			playerList.remove(player);
		}
		
		
		
		
		/**
		 * 根据战斗tempid获取角色
		 * */
		public function getPlayerByID(tempID:int):BPlayer
		{
			var player:BPlayer = playerList.getChildByParam("tempID" , tempID) as BPlayer;
			return player;
		}
		
		
		
		
		/**
		 * 根据阵型序号获取该位置上的角色
		 * */
		public function getPlayerByPos(pos:int):BPlayer
		{
			var player:BPlayer = playerList.getChildByParam("pos" , pos) as BPlayer;
			return player;
		}
		
		
		
		
		
		/**
		 * 获取指定位置的坐标
		 * */
		public function getPosition(pos:int):Vector2D
		{
			var position:Vector2D = CAMP_POS_S[pos-1];
			// 若存在偏移
			if(offset)
			{
				position = position.add(offset);
			}
			return position;
		}
		
		
		
		
		
		
		/**
		 * 获取阵型的中心位置
		 * */
		public function getMidPos():Vector2D
		{
			return this.getPosition(5);
		}
		
		
		
		
		
		
		/**
		 * 根据某个特定站位，获取其所在行的中间坐标
		 * */
		public function getMidPosByRow(pos:int):Vector2D
		{
			var midPos:int = 2;
			for(var i:int=0;i<CAMP_ROW_POS.length;i++)
			{
				var arr:Array = CAMP_ROW_POS[i];
				if(arr.indexOf(pos) >= 0)
				{
					midPos = arr[1];//取中间的站位
					break;
				}
			}
			
			return this.getPosition(midPos);
		}
		
		
		
		
		
		
		
		/**
		 * 根据某个特定站位，获取其所在列的中间坐标
		 * */
		public function getMidPosByColumn(pos:int):Vector2D
		{
			var midPos:int = 2;
			for(var i:int=0;i<CAMP_COL_POS.length;i++)
			{
				var arr:Array = CAMP_COL_POS[i];
				if(arr.indexOf(pos) >= 0)
				{
					midPos = arr[1];//取中间的站位
					break;
				}
			}
			
			return this.getPosition(midPos);
		}
		
		
		
		
		
		
		/**
		 * 获取某排活着的角色(若该排没有角色,自动向前(后)计算)
		 * */
		public function getColumnPlayers(col:int , direct:int):Array
		{
			var returnPlayers:Array = search();
			while(returnPlayers.length == 0 && (col >= 0 && col < CAMP_COL_POS.length))
			{
				col += direct;
				returnPlayers = search();
			}
			return returnPlayers;
			
			// 搜索该排角色
			function search():Array
			{
				var players:Array = [];
				if(col >= 0 && col < CAMP_COL_POS.length)
				{
					var posList:Array = CAMP_COL_POS[col];
					if(posList)
					{
						for(var i:int=0;i<playerList.length;i++)
						{
							var player:BPlayer = playerList.getChildAt(i) as BPlayer;
							if(posList.indexOf(player.pos) >= 0 && player.alive == true)
							{
								players.push(player);
							}
						}
					}
				}
				return players;
			}
			
		}
		
		
		
		
		/**
		 * 获取血量值最少角色
		 * */
		public function getMinhpRole1():BPlayer
		{
			var returnPlayer:BPlayer = playerList.getChildAt(0) as BPlayer;
			var base:PRO_PlayerBase;
			var minhp:int = int.MAX_VALUE;
			for(var i:int=0;i<playerList.length;i++)
			{
				var player:BPlayer = playerList.getChildAt(i) as BPlayer;
				base = player.role.base;
				// 必须是活着的人
				if(base.hp > 0 && base.hp < minhp)
				{
					minhp = base.hp;
					returnPlayer = player;
				}
			}
			return returnPlayer;
		}
		
		
		
		
		
		/**
		 * 获取血量百分比%最少角色
		 * */
		public function getMinhpRole2():BPlayer
		{
			var returnPlayer:BPlayer = playerList.getChildAt(0) as BPlayer;
			var base:PRO_PlayerBase;
			var minhp:Number = 1;
			for(var i:int=0;i<playerList.length;i++)
			{
				var player:BPlayer = playerList.getChildAt(i) as BPlayer;
				base = returnPlayer.role.base;
				var chp:Number = base.hp / base.maxhp;
				// 必须是活着的人
				if(chp > 0 && chp <= minhp)
				{
					minhp = chp;
					returnPlayer = player;
				}
			}
			return returnPlayer;
		}
		
		
		
		
		/**
		 * 获取所有活着的角色
		 * */
		public function getAlivePlayers():Array
		{
			var list:Array = playerList.toArray();
			var iLen:int = list.length;
			var result:Array = [];
			for(var i:int=0;i<iLen;i++)
			{
				var player:BPlayer = list[i];
				if(player && player.alive == true)
				{
					result.push(player);
				}
			}
			return result;
		}
		
		
		
		
		
		
		
		
		
		/**
		 * 检查阵型中是否存在角色前后相邻的情况
		 * */
		/*public function get hasNeibour():Boolean
		{
			// 从前往后遍历
			var iLen:int = playerList.length;
			for(var i:int=0;i<iLen;i++)
			{
				var player:BPlayer = playerList.getChildAt(i) as BPlayer;
				if(player && player.alive == true)
				{
					var pos:int = player.pos;
					// 找到身后的角色pos
					var neibourPosList:Array = NEIBOUR_BACK_POS[pos];
					if(neibourPosList)
					{
						var jLen:int = neibourPosList.length;
						for(var j:int=0;j<jLen;j++)
						{
							var neibourPos:int = neibourPosList[j];
							var neibour:BPlayer = this.getPlayerByPos(neibourPos);
							// 存在相邻的角色
							if(neibour && neibour.alive == true)
							{
								return true;
							}
						}
					}
				}
			}
			
			return false;
		}*/
		
		
		
		
		/**
		 * 判断一个角色是否为该阵营内成员
		 * */
		public function contains(player:BPlayer):Boolean
		{
			return playerList.contains(player);
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			// 清空角色
			var player:BPlayer;
			for(var i:int=0;i<playerList.length;i++)
			{
				player = playerList.getChildAt(i) as BPlayer;
				player.clear();
			}
			playerList.clear();
		}
		
	}
}