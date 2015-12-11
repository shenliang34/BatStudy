package com.gamehero.sxd2.battle.algorithm
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleAtkData;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleTurn;
	import com.gamehero.sxd2.battle.data.BattleTurnData;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_BattleActionInfo;
	import com.gamehero.sxd2.pro.PRO_BattleCounter;
	import com.gamehero.sxd2.pro.PRO_BattleJointAtk;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import bowser.logging.Logger;
	import bowser.utils.data.Group;
	
	/**
	 * 战斗行动算法
	 * @author xuwenyi
	 * @create 2013-07-15
	 **/
	public class BattleActionAlg
	{
		/**
		 * 构造函数
		 * */
		public function BattleActionAlg()
		{
		}
		
		
		
		
		/**
		 * 生成这一波一起发动攻击的数据列表
		 * */
		public static function getBattleTurnList(role:PRO_BattlePlayer):Group
		{
			var turnList:Group = new Group();
			
			// 行动对象
			var firstPlayer:BPlayer = BattleDataCenter.instance.getPlayer(role.tempID);
			// 获取本轮攻击数据
			var turndata:BattleTurnData = getBattleTurns(firstPlayer , role);
			turndata.updateRole = role;
			addTurn(turnList , turndata);
			
			return turnList;
		}
		
		
		
		
		/**
		 * 生成一个角色的一轮攻击数据
		 * @param player 行动角色
		 * */
		public static function getBattleTurns(aPlayer:BPlayer , battleRole:PRO_BattlePlayer):BattleTurnData
		{
			var i:int;
			var j:int;
			var k:int;
			
			// 数据中心
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var turndata:BattleTurnData = new BattleTurnData();
			turndata.aPlayer = aPlayer;
			turndata.updateRole = battleRole;
			
			var turns:Vector.<BattleTurn> = new Vector.<BattleTurn>();
			turndata.turns = turns;
			
			var hasSpurt:Boolean = false;//是否含有溅射单位
			
			// 该角色使用的技能
			var mgr:SkillManager = SkillManager.instance;
			var skillEf:BattleSkillEf;
			var useSkill:BattleSkill = mgr.getSkillBySkillID(battleRole.useSkill+"");
			
			if(useSkill == null)
			{
				return turndata;
			}
			
			// 技能特效
			var skillEfs:Vector.<BattleSkillEf> = useSkill.efs;
			// 计算伤害权重
			var weight:Number = 0;
			for(i=0;i<skillEfs.length;i++)
			{
				weight += skillEfs[i].dmgWeight;
			}
			
			// 生成每一段攻击的数据
			for(i=0;i<skillEfs.length;i++)
			{
				skillEf = skillEfs[i];
				
				// 本次伤害权重
				var dmgWeight:Number = skillEf.dmgWeight / weight;
				
				// 计算本次行动所有数据
				var turn:BattleTurn = new BattleTurn();
				turn.aPlayer = aPlayer;
				turn.skill = useSkill;
				turn.skillEf = skillEf;
				
				// 解析action
				var actions:Array = battleRole.actions;
				// 该角色攻击对象
				var uPlayers:Array = [];
				var firstAtks:Array = [];
				var secondAtks:Array = [];
				var atks:Group = new Group();
				//var counters:Array = [];
				
				for(j=0;j<actions.length;j++)
				{
					// 单个攻击数据
					var atkData:BattleAtkData = new BattleAtkData();
					var action:PRO_BattleActionInfo = actions[j];
					
					// 查找tempID对应的角色
					var targetPlayer:BPlayer = dataCenter.getPlayer(action.target);
					atkData.targetPlayer = targetPlayer;
					
					atkData.dmgShow = Math.floor(action.dmgShow * dmgWeight);
					atkData.buffs = action.buffs;
					atkData.crt = action.crt;
					atkData.pay = action.parry;
					atkData.avd = action.avd;
					atkData.pnt = action.penetration;
					atkData.abb = action.absorb;
					//atkData.spurt = action.spurt;//0:非溅射,1:溅射
					atkData.step = action.step;// 第几步
					
					// 伤害,合击,反击等属性放在最后一次攻击上
					if(i == skillEfs.length - 1)
					{
						// 若存在合击并且伤害大于等于其现在的HP,则不杀死他
						if(battleRole.jointatk != null && action.dmg >= targetPlayer.role.base.hp)
						{
							atkData.dmg = targetPlayer.role.base.hp - 1;
						}
						else
						{
							atkData.dmg = action.dmg;
						}
						atkData.selfdmg = action.selfdmg;
						atkData.anger = action.anger;
						
						// 反击数据(若有)
						if(action.counter != null)
						{
							var counterTurn:BattleTurn = getCounterTurn(targetPlayer , aPlayer , action.counter);
							turndata.counterTurn = counterTurn;
							
							//counters.push(counterTurn);
						}
					}
					
					// 是否含有溅射单位
					/*if(hasSpurt == false)
					{
					hasSpurt = action.spurt;
					}*/
					
					// 主要的受击者
					if(atkData.step == 0)
					{
						firstAtks.push(atkData);
					}
					// 次要受击对象
					else
					{
						secondAtks.push(atkData);
					}
					
					atks.add(atkData);
					uPlayers.push(targetPlayer);
				}
				turn.atks = atks;
				turn.uPlayers = uPlayers;
				turn.firstAtks = firstAtks;
				turn.secondAtks = secondAtks;
				turn.hasSpurt = hasSpurt;
				
				// 计算动作持续时间
				if(skillEf != null)
				{
					var actionDuration:Number = skillEf.actionDuration;
					turn.actionDuration = actionDuration != 0 ? actionDuration : 1200;// 默认1.2秒
					
					// 加上反击技能的时间(若有)
					/*if(atkData.pay == true)
					{
						for(k=0;k<counters.length;k++)
						{
							turn.actionDuration += counters[k].actionDuration;
						}
					}*/
				}
				
				turns.push(turn);
			}
			// 计算此次行动所耗总时间
			for(i=0;i<turns.length;i++)
			{
				turndata.totalDuration += turns[i].actionDuration;
			}
			// 是否第一步是近战
			if(turns[0].skillEf.actionId != 2)
			{
				turndata.totalDuration += 600;//近战来回跑动的时间
			}
			// 反击逻辑
			if(turndata.counterTurn != null)
			{
				// 判断该角色行动完后是否会被反击杀死
				turndata.isAliveAfterAction = battleRole.base.hp - (turndata.counterTurn.atks.getChildAt(0) as BattleAtkData).dmg > 0;
				
				// 加上反击的时间
				turndata.totalDuration += turndata.counterTurn.actionDuration;
			}
			
			// 计算合击数据
			if(battleRole.jointatk != null)
			{
				turndata.jointAtkTurnData = getJointAtkTurn(targetPlayer , battleRole.jointatk);
			}
			
			return turndata;
		}
		
		
		
		
		
		
		
		/**
		 * 生成一个角色的合击攻击数据
		 * */
		public static function getJointAtkTurn(uPlayer:BPlayer , jointatk:PRO_BattleJointAtk):BattleTurnData
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var i:int;
			
			var turndata:BattleTurnData = new BattleTurnData();
			turndata.aPlayer = dataCenter.getPlayer(jointatk.attacker);// 合击者
			
			var turns:Vector.<BattleTurn> = new Vector.<BattleTurn>();
			turndata.turns = turns;
			
			// 该角色使用的技能
			var mgr:SkillManager = SkillManager.instance;
			var useSkill:BattleSkill = mgr.getSkillBySkillID(jointatk.skillID+"");
			// 技能特效
			var skillEfs:Vector.<BattleSkillEf> = useSkill.efs;
			// 计算伤害权重
			var weight:Number = 0;
			for(i=0;i<skillEfs.length;i++)
			{
				weight += skillEfs[i].dmgWeight;
			}
			
			// 生成每一段攻击的数据
			for(i=0;i<skillEfs.length;i++)
			{
				var skillEf:BattleSkillEf = skillEfs[i];
				
				// 合击时间点
				if(skillEf.jointAtkDelay > 0)
				{
					turndata.jointAtkDelay = skillEf.jointAtkDelay;
				}
				
				// 本次伤害权重
				var dmgWeight:Number = skillEf.dmgWeight / weight;
				
				// 计算本次行动所有数据
				var turn:BattleTurn = new BattleTurn();
				turn.aPlayer = turndata.aPlayer;
				turn.skill = useSkill;
				turn.skillEf = skillEf;
				
				// 单个攻击数据
				var atkData:BattleAtkData = new BattleAtkData();
				
				// 查找tempID对应的角色
				atkData.targetPlayer = uPlayer;
				atkData.dmgShow = Math.floor(jointatk.dmgShow * dmgWeight);
				atkData.crt = jointatk.crt;
				atkData.pnt = jointatk.penetration;
				atkData.abb = jointatk.absorb;
				
				// 伤害,合击,反击等属性放在最后一次攻击上
				if(i == skillEfs.length - 1)
				{
					atkData.dmg = jointatk.dmg;
					// 之前因连击或合击为了不杀死目标而伤害-1，从这里补回来
					if(atkData.dmg == 0)
					{
						atkData.dmg += 1;
					}
				}
				
				turn.atks = new Group([atkData]);
				turn.uPlayers = [uPlayer];
				turn.firstAtks = [atkData];
				turn.secondAtks = [];
				turn.hasSpurt = false;
				
				var actionDuration:Number = skillEf.actionDuration;
				turn.actionDuration = actionDuration != 0 ? actionDuration : 1200;// 默认1.2秒
				
				turns.push(turn);
			}
			// 计算此次行动所耗总时间
			for(i=0;i<turns.length;i++)
			{
				turndata.totalDuration += turns[i].actionDuration;
			}
			// 是否第一步是近战
			if(turns[0].skillEf.actionId != 2)
			{
				turndata.totalDuration += 600;//近战来回跑动的时间
			}
			
			return turndata;
		}
		
		
		
		
		
		
		/**
		 * 生成一个角色的反击攻击数据
		 * */
		public static function getCounterTurn(aPlayer:BPlayer , uPlayer:BPlayer , counter:PRO_BattleCounter):BattleTurn
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			
			var turn:BattleTurn = new BattleTurn();
			turn.aPlayer = aPlayer;
			// 该角色使用的技能
			var mgr:SkillManager = SkillManager.instance;
			var useSkill:BattleSkill = mgr.getSkillBySkillID(counter.skillID+"");
			if(useSkill)
			{
				turn.skill = useSkill;
				// 反击技能只用第一个特效
				var efs:Vector.<BattleSkillEf> = useSkill.efs;
				turn.skillEf = efs[0];
			}
			else
			{
				Logger.warn(BattleView , "[" + aPlayer.name+"|"+aPlayer.tempID + "]反击技能没有找到!");
			}
			
			// 单个攻击数据
			var atkData:BattleAtkData = new BattleAtkData();
			
			atkData.targetPlayer = uPlayer;
			atkData.dmg = counter.dmg;
			atkData.dmgShow = counter.dmgShow;
			atkData.abb = counter.absorb;
			atkData.step = 0;
			
			// 保存
			turn.atks = new Group([atkData]);
			turn.uPlayers = [uPlayer];
			turn.firstAtks = [atkData];
			
			// 动作持续时间
			var skillEf:BattleSkillEf = turn.skillEf;
			if(skillEf != null)
			{
				var actionDuration:Number = skillEf.actionDuration;
				turn.actionDuration = actionDuration != 0 ? actionDuration : 1200;// 默认1.2秒
			}
			
			return turn;
		}
		
		
		
		
		
		
		/**
		 * 添加行动数据
		 * */
		private static function addTurn(turnList:Group , turndata:BattleTurnData):void
		{
			turnList.add(turndata);
		}
		
		
	}
}