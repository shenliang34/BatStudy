package com.gamehero.sxd2.battle.data
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.manager.BattleUnitManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.MonsterLeaderManager;
	import com.gamehero.sxd2.manager.MonsterManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_BattleDetail;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	import com.gamehero.sxd2.pro.PRO_BattlePlayerType;
	import com.gamehero.sxd2.pro.PRO_BattleResult;
	import com.gamehero.sxd2.pro.PRO_BattleRoundInfo;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.gamehero.sxd2.vo.MonsterLeaderVO;
	import com.gamehero.sxd2.vo.MonsterVO;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.netease.protobuf.UInt64;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.logging.Logger;
	import bowser.utils.data.Group;
	import bowser.utils.data.Vector2D;
	
	/**
	 * 战斗数据中心
	 * @author xuwenyi
	 * @create 2013-07-10
	 **/
	public class BattleDataCenter
	{
		private static var _instance:BattleDataCenter;
		
		// 战斗资源加载器
		public var loader:BulkLoaderSingleton;
		
		// 游戏内部战斗还是外部录像
		public var inGame:Boolean = true;
		// 是否战斗回放
		public var isReplay:Boolean = false;
		
		// 战斗id
		public var battleID:int;
		// 战斗名
		public var battleName:String;
		// 战斗回放id
		public var replayID:UInt64;
		// 战斗类型
		public var battleType:int;
		// 战斗参数
		public var battleParam:int;
		// 总波数
		public var battleBoshu:int;
		// 当前波数
		public var curBoshu:int;
		// 本次战斗我处于的阵营
		public var selfCamp:int;
		// 是否第一次打本场战斗
		public var isFirstBattle:Boolean;
		
		// 战场数据
		public var battleDetail:PRO_BattleDetail;
		// 战斗播放速度
		public var playSpeed:Number = 1;
		// 战斗视图
		public var battleView:BattleView;
		// 波束数据列表
		private var boshuInfoCache:Array = [];
		// 行动列表缓存
		public var roundCache:Array = [];
		// 阵营1
		public var grid1:BattleGrid = new BattleGrid(1);
		// 阵营2
		public var grid2:BattleGrid = new BattleGrid(2);
		// 主角
		public var leader:BPlayer;
		// 玩家们
		public var leaders:Array = [];
		// boss
		public var boss:BPlayer;
		// 本场战斗的结果
		public var battleResult:PRO_BattleResult;
		
		// 帧频字典
		protected var frameRates:Dictionary = new Dictionary();
		// 本场战斗所用到的资源url
		private var resources:Dictionary = new Dictionary();
		// 分阵营保存资源url
		private var camp1Resources:Dictionary = new Dictionary();
		private var camp2Resources:Dictionary = new Dictionary();
		
		
		// MainUI
		public var mainUI:Object;// 用于保存MainUI的引用,不直接引用MainUI类是因为外部战斗录像需要减少体积
		// 聊天UI
		public var chatView:DisplayObject;// 同上
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleDataCenter()
		{
			// 帧频字典
			frameRates[PRO_BattlePlayerType.PLAYER] = new Dictionary();
			frameRates[PRO_BattlePlayerType.HERO] = new Dictionary();
			frameRates[PRO_BattlePlayerType.MONSTER] = new Dictionary();
			// 主角的帧频
			var rates:Dictionary = frameRates[PRO_BattlePlayerType.PLAYER];
			rates[BattleFigureItem.RUN] = 16;
			rates[BattleFigureItem.JUMP] = 16;
			rates[BattleFigureItem.STAND] = 18;
			rates[BattleFigureItem.HIT] = 16;
			rates[BattleFigureItem.PARRY] = 16;
			rates[BattleFigureItem.STANDUP] = 16;
			rates[BattleFigureItem.DEAD] = 16;
			// 伙伴的帧频
			rates = frameRates[PRO_BattlePlayerType.HERO];
			rates[BattleFigureItem.RUN] = 16;
			rates[BattleFigureItem.JUMP] = 16;
			rates[BattleFigureItem.STAND] = 18;
			rates[BattleFigureItem.HIT] = 16;
			rates[BattleFigureItem.PARRY] = 16;
			rates[BattleFigureItem.STANDUP] = 16;
			rates[BattleFigureItem.DEAD] = 16;
			// 怪物的帧频
			rates = frameRates[PRO_BattlePlayerType.MONSTER];
			rates[BattleFigureItem.RUN] = 16;
			rates[BattleFigureItem.JUMP] = 16;
			rates[BattleFigureItem.STAND] = 18; 
			rates[BattleFigureItem.HIT] = 16;
			rates[BattleFigureItem.PARRY] = 16;
			rates[BattleFigureItem.STANDUP] = 16;
			rates[BattleFigureItem.DEAD] = 16;
			
			// 创建加载器
			loader = BulkLoaderSingleton.createUniqueNamedLoader();
		}
		
		
		
		public static function get instance():BattleDataCenter
		{
			if(_instance == null)
			{
				_instance = new BattleDataCenter();
			}
			return _instance;
		}
		
		
		
		
		
		/**
		 * 保存战斗数据
		 * */
		public function saveDetailInfo(detail:PRO_BattleDetail):void
		{
			this.battleDetail = detail;
			this.battleID = detail.battleId;
			this.battleName = BattleUnitManager.inst.getBattleName(battleID);
			this.battleType = BattleUnitManager.inst.getBattleType(battleID);
			this.battleBoshu = detail.boshu;
			this.selfCamp = detail.selfCamp;
			this.isFirstBattle = true;//detail.isFirstBattle;
			this.replayID = detail.reportId;
			this.battleResult = detail.result;
			
			if(battleResult == null)
			{
				Logger.debug(BattleDataCenter , "此战斗没有胜负数据!!");
			}
			if(replayID)
			{
				Logger.debug(BattleDataCenter , "本场战斗战报 id = " + replayID.toString());
			}
			
			// 解析info
			this.saveBoshuInfos(detail.roundInfos);
		}
		
		
		
		
		
		
		/**
		 * 保存波数
		 * */
		private function saveBoshuInfos(roundInfos:Array):void
		{
			this.boshuInfoCache = roundInfos;
			
			// 当前波数
			this.curBoshu++;
			
			// 解析下一波场上人物数据
			this.parseNextBo();
		}
		
		
		
		
		
		
		
		/**
		 * 解析一波的战斗数据
		 * */
		public function parseNextBo():void
		{
			// 存在下一波数据
			if(this.hasNextBoshu == true)
			{
				var info:PRO_BattleRoundInfo = boshuInfoCache.shift();
				// 保存场上角色数据
				this.savePlayers(info.initPlayers);
				// 保存行动数据
				this.saveActions(info.actionPlayers);
			}
		}
		
		
		
		
		
		
		/**
		 * 保存角色数据
		 * */
		private function savePlayers(roles:Array):void
		{
			// 初始化角色
			var player:BPlayer;
			this.leader = null;
			this.leaders = [];
			this.boss = null;
			for(var i:int=0;i<roles.length;i++)
			{
				var role:PRO_BattlePlayer = roles[i];
				var base:PRO_PlayerBase = role.base;
				player = this.getPlayer(role.tempID);
				var id:String = base.id.toString();
				
				// 该角色是新增的
				if(player == null)
				{
					player = new BPlayer();
					player.role = role;// 角色基本数据
					player.pos = role.pos;// 角色站位
					player.tempID = role.tempID;// 角色在战斗中的id
					player.selfCamp = this.selfCamp;// 主角所站的阵营
					player.camp = role.camp;//客户端站位
					// 阵营分类
					if(player.camp == 1)
					{
						this.grid1.addPlayer(player);
					}
					else
					{
						this.grid2.addPlayer(player);
					}
					// 主角位置固定10
					if(role.playerType == PRO_BattlePlayerType.PLAYER)
					{
						player.pos = role.pos = 10;
					}
					// 解析技能
					var skillList:Array = role.skills;
					var skills:Group = new Group();
					var mgr:SkillManager = SkillManager.instance;
					for(var x:int=0;x<skillList.length;x++)
					{
						var skillId:int = skillList[x];
						// 通过配置表查找该技能
						var battleSkill:BattleSkill = mgr.getSkillBySkillID(skillId+"");
						// 所有技能数组
						skills.add(battleSkill);
						
						// 判断是否为绝技技能
						if(battleSkill.consumeAnger > 0)
						{
							player.angerSkill = battleSkill;
						}
					}
					player.skills = skills;
				}
				// 之前已经在场上的角色
				else
				{
					// 更新数据
					player.role = role;
					if(player.alive == true)
					{
						player.updateStatus();
					}
				}
				
				// 主角
				if(role.playerType == PRO_BattlePlayerType.PLAYER)
				{
					base.hp = 1;
					leaders.push(player);
					
					// 战斗中我是参战的
					if(GameData.inst.checkLeader(base.id.toString()) == true)
					{
						this.leader = player;
					}
				}
				// 怪物
				else if(role.playerType == PRO_BattlePlayerType.MONSTER)
				{
					// boss
					var monsterVO:MonsterVO = MonsterManager.instance.getMonsterByID(id);
					if(monsterVO.bossBlood != 0)
					{
						this.boss = player;
					}
				}
			}
			
			// 如果这场战斗我是观战方
			if(leader == null && leaders.length > 0)
			{
				leader = leaders[0];
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 保存行动数据
		 * */
		private function saveActions(players:Array):void
		{
			// 缓存roles
			this.roundCache = players;
		}
		
		
		
		
		
		/**
		 * 是否还有下一波
		 * */
		public function get hasNextBoshu():Boolean
		{
			return boshuInfoCache.length > 0;
		}
		
		
		
		
		
		/**
		 * 根据角色tempID获取battlePlayer对象
		 * */
		public function getPlayer(tempID:int):BPlayer
		{
			var player:BPlayer = grid1.getPlayerByID(tempID);
			if(player == null)
			{
				player = grid2.getPlayerByID(tempID);
			}
			
			/*if(player == null)
			{
				Logger.debug(BattleDataCenter , "无法找到战斗对象 , tempID = " + tempID);
			}*/
			
			return player;
		}
		
		
		
		
		
		/**
		 * 场上所有角色
		 * */
		public function get allPlayers():Array
		{
			var list1:Group = grid1.playerList;
			var list2:Group = grid2.playerList;
			return list1.concat(list2).toArray();
		}
		
		
		
		
		
		
		
		/**
		 * 获取某动作帧率
		 * */
		public function getFrameRate(classStatus:int , actionName:String):int
		{
			var rate:int = frameRates[classStatus][actionName];
			rate /= playSpeed;// 播放速度系数
			return rate;
		}
		
		
		
		
		
		
		/**
		 * 计算特殊位移后的终点坐标
		 * */
		public function getMovePosition(mainAtks:Array , skillEf:BattleSkillEf):Vector2D
		{
			// 取出所有主目标
			var uPlayers:Array = [];
			var uCamp:int;
			for(var i:int=0;i<mainAtks.length;i++)
			{
				var atk:BattleAtkData = mainAtks[i];
				uPlayers.push(atk.targetPlayer);
				
				uCamp = atk.targetPlayer.camp;
			}
			// 取第一个受击者为基准
			var uPlayer:BPlayer = uPlayers[0];
			
			// 是否有特殊位移
			var atkRange:int =  skillEf.atkRange != 0 ? skillEf.atkRange : 1;
			var moveDis:int = skillEf.moveDis != 0 ? skillEf.moveDis : 50 + (uPlayer.playerWidth >> 1);
			var targetPos:Vector2D;
			var offset:Vector2D = uCamp == 1 ? new Vector2D(moveDis , 2) : new Vector2D(-moveDis , 2);
			var grid:BattleGrid = uCamp == 1 ? grid1 : grid2;
			
			//1单体,2一行,3一列,4AOE
			switch(atkRange)
			{
				case 1:
					targetPos = uPlayer.position;//单体坐标
					break;
				
				case 2:
					targetPos = grid.getMidPosByRow(uPlayer.pos);//取横排中间的坐标
					break;
				
				case 3:
					targetPos = grid.getMidPosByColumn(uPlayer.pos);//取竖排中间的坐标
					break;
				
				case 4:
					targetPos = grid.getMidPos();//中心位置
					break;
			}
			
			return targetPos.add(offset);
		}
		
		
		
		
		
		/**
		 * 获取某阵营所有人物的url
		 * */
		public function getPlayersUrl(camp:int):Array
		{
			var urls:Array = [];
			
			var grid:BattleGrid = camp == 1 ? grid1 : grid2;
			var list:Array = grid.playerList.toArray();
			for(var i:int=0;i<list.length;i++)
			{
				var player:BPlayer = list[i];
				var role:PRO_BattlePlayer = player.role;
				var base:PRO_PlayerBase = role.base;
				var id:String = base.id.toString();
				var url:String = "";
				
				// 主角
				if(role.playerType == PRO_BattlePlayerType.PLAYER)
				{
					url = BattleConfig.LEADER_FIGURE_URL;
				}
				// 伙伴
				else if(role.playerType == PRO_BattlePlayerType.HERO)
				{
					var heroVO:HeroVO = HeroManager.instance.getHeroByID(id);
					url = GameConfig.BATTLE_FIGURE_URL + heroVO.url;
				}
				// 怪物
				else if(role.playerType == PRO_BattlePlayerType.MONSTER)
				{
					var monsterVO:MonsterVO = MonsterManager.instance.getMonsterByID(id);
					url = GameConfig.BATTLE_FIGURE_URL + monsterVO.figureURL;
				}
				// 怪物领袖
				else if(role.playerType == PRO_BattlePlayerType.MONSTER_OWNER)
				{
					var monsterLeader:MonsterLeaderVO = MonsterLeaderManager.inst.getLeader(id);
					url = GameConfig.BATTLE_FIGURE_URL + monsterLeader.url;
				}
				
				if(url != "" && urls.indexOf(url) < 0)
				{
					urls.push(url);
				}
			}
			
			return urls;
		}
		
		
		
		
		
		
		/**
		 * 检查某场战斗是否为同步战斗
		 * */
		public function checkSyncBattle(type:int):Boolean
		{
			/*if(type == GS_BattleType_Pro.BATTLE_PVP_DUNGEON
				|| type == GS_BattleType_Pro.BATTLE_MULTI_PVP_RED_DRAGON
				|| type == GS_BattleType_Pro.BATTLE_FUBEN
				|| type == GS_BattleType_Pro.BATTLE_PVP_VALLEY_COMMON
				|| type == GS_BattleType_Pro.BATTLE_PVP_VALLEY_FINAL)
			{
				return true;
			}*/
			return false;
		}
		
		
		
		
		
		/**
		 * 检查某场战斗是否为播报式的(可跳过战斗)
		 * */
		public function checkPassBattle(type:int):Boolean
		{
			// 战斗回放
			if(this.checkReplayBattle() == true)
			{
				return true;
			}
			
			/*if(type == GS_BattleType_Pro.BATTLE_GOBLINMONSTER 
				|| type == GS_BattleType_Pro.BATTLE_GOBLINUSER
				|| type == GS_BattleType_Pro.BTTTLE_PVP_FWAR1
				|| type == GS_BattleType_Pro.BATTLE_PVP_FWARTOWER
				|| type == GS_BattleType_Pro.BATTLE_PVP_CAMPWAR
			)
			{
				return true;
			}*/
			
			return false;
		}
		
		
		
		
		
		/**
		 * 检查当前战斗是否战斗回放
		 * */
		public function checkReplayBattle():Boolean
		{
			// 战斗回放
			return isReplay;
		}
		
		
		
		
		
		/**
		 * 保存资源url
		 * */
		public function addResource(url:String , camp:int = 0):void
		{
			// 分阵营保存资源url
			if(camp > 0)
			{
				var dic:Dictionary = camp == 1 ? camp1Resources : camp2Resources;
				dic[url] = url;
			}
			resources[url] = url;
		}
		
		
		
		
		
		/**
		 * 清理资源
		 * */
		public function clearResource():void
		{
			var renderCenter:GameRenderCenter = GameRenderCenter.instance;
			for each(var url:String in resources)
			{
				renderCenter.clearData(url);
			}
			
			resources = new Dictionary();
			camp1Resources = new Dictionary();
			camp2Resources = new Dictionary();
		}
		
		
		
		
		/**
		 * 清理某阵营的资源(保卫长城用)
		 * */
		public function clearCampResource(camp:int):void
		{
			var dic:Dictionary = camp == 1 ? camp1Resources : camp2Resources;
			var renderCenter:GameRenderCenter = GameRenderCenter.instance;
			for each(var url:String in dic)
			{
				renderCenter.clearData(url);
				loader.remove(url , true);
			}
			
			if(camp == 1)
			{
				camp1Resources = new Dictionary();
			}
			else
			{
				camp2Resources = new Dictionary();
			}
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			isReplay = false;
			
			battleID = 0;
			replayID = null;
			battleType = 0;
			battleParam = 0;
			battleBoshu = 0;
			curBoshu = 0;
			selfCamp = 0;
			isFirstBattle = false;
			//playSpeed = 1;
			
			battleDetail = null;
			boshuInfoCache = [];
			roundCache = [];
			battleResult = null;
			
			leader = null;
			leaders = [];
			boss = null;
			
			// 清理缓存资源
			this.clearResource();
			
			grid1.clear();
			grid2.clear();
			
			battleView = null;
		}
		
	}
}