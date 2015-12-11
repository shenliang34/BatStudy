import com.gamehero.sxd2.battle.algorithm.BattleActionAlg;
import com.gamehero.sxd2.battle.data.BattleTurnData;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.pro.PRO_BattlePlayer;
import com.gamehero.sxd2.vo.BattleSkill;

import bowser.utils.data.Group;

/**
 * 战斗游戏层逻辑
 * @author xuwenyi
 * @create 2013-06-25
 **/


// 当前阶段行动人员列表
private var rounds:Array = [];

// 主人公使用技能缓存
public var willSkill:BattleSkill;

// 本轮行动序列
private var turnList:Group = new Group();

/**标志位*/
// 是否发送过技能请求(防止技能请求还没返回时再次发送)
public var skillUsed:Boolean = false;

// 上回合和当前回合
public var lastRound:int = 0;
public var curRound:int = 0;

// 战斗播放速度(在下一个角色行动时设置)
private var playSpeed:Number = 0;

// 战斗是否已结束
private var isBattleEnd:Boolean = false;









/**
 * 执行本回合逻辑
 * */
private function executeRoundLogic():void
{
	// 当场景上的行动角色为0时
	// 动画停止时
	if(this.willPlay == false && this.isPlaying == false && isBattleEnd == false)
	{
		// 若非暂停状态
		// 回合开始前先执行新手引导逻辑
		/*if(isPause == false)
		{
			this.checkGuide(10001);
			this.checkGuide(10003);
			this.checkGuide(10011 , executeRoundLogic);
			this.checkGuide(10031);
			this.checkGuide(10032);
		}
		if(isPause == true)
		{
			return;
		}*/
		
		// round1Cache有数据
		rounds = dataCenter.roundCache;
		dataCenter.roundCache = [];
		
		// 存在行动数据
		if(this.willPlay == true)
		{
			// 解析该阶段角色行动列表  , 并归类
			this.parseActionRole();
			return;
		}
		// 需要切换波数
		else if(dataCenter.hasNextBoshu == true)
		{
			// 解析下一波数据
			dataCenter.parseNextBo();
			// 改变波数
			this.changeBoshu();
			return;
		}
		// 战斗结束了
		else if(dataCenter.battleResult)
		{
			// 显示战报
			this.showBattleResult();
			
			// 战斗结束
			isBattleEnd = true;
			dataCenter.battleResult = null;
			return;
		}
	}
	
}






/**
 * 解析现阶段行动角色列表,归类
 * */
private function parseActionRole():void
{
	// 本回合还有武将没行动过
	// 战斗未结束
	if(this.willPlay == true)
	{
		// 保存当前回合数
		curRound = (rounds[0] as PRO_BattlePlayer).round;
		this.updateRoundUI();
		
		// 解析rounds , 取出相同回合的行动数据
		/*var actionRole:PRO_BattlePlayer;
		var list:Array = [];
		for(var i:int=0;i<rounds.length;i++)
		{
			actionRole = rounds[i];
			if(actionRole.round <= curRound)
			{
				list.push(actionRole);
				rounds.splice(i , 1);// 从原数组中移除
				i--;
			}
		}*/
		
		// 计算这一轮攻击数据,并执行
		// 清空角色攻击列表
		turnList.clear();
		// 获取这一波的攻击数据
		turnList = BattleActionAlg.getBattleTurnList(rounds.shift() as PRO_BattlePlayer);
		/*if(this.hasGuide == false)
		{
			turnList = BattleActionAlg.getBattleTurnList(list);
		}
		else
		{
			var guideID:int = 10002;
			var currentBattleID:int = dataCenter.battleID;
			var battleID:int = GUIDE_BATTLE_ID[guideID];
			// 第二场战斗引导,雪诺不参与合击
			if(currentBattleID == battleID)
			{
				var mgr:GuideManager = GuideManager.instance;
				var info:GuideInfo = mgr.getGuideInfo(guideID);
				var userLimit:String = info.param2;
				turnList = BattleActionAlg.getBattleTurnList(list , userLimit);
			}
			else
			{
				turnList = BattleActionAlg.getBattleTurnList(list);
			}
		}*/
		// 没有参与到此轮行动的角色,放回rounds
		//rounds = list.concat(rounds);
		
		// 执行角色行动
		this.executeTurn();
		
		// 更新关卡回合(若有)
		this.updateHurdleNotePanel();
		
		// 保存上一轮的回合数
		lastRound = curRound;
	}
	// 没有行动角色了
	else
	{
		// 系统判断
		// 1 使用AI,让主人公发动技能
		// 2 切换数据源
		executeRoundLogic();
	}
}









/**
 * 执行本轮攻击
 * */
private function executeTurn():void
{
	// 行动前先设置播放速度(若有改变)
	if(playSpeed > 0)
	{
		dataCenter.playSpeed = playSpeed;
		playSpeed = 0;
	}
	
	// 复制一份攻击数据
	var list:Group = turnList.clone();
	// 执行单词攻击逻辑
	setTimer(excute , int(100/dataCenter.playSpeed));
	
	// 单次攻击
	function excute():void
	{
		var turndata:BattleTurnData = list.next() as BattleTurnData;
		if(turndata != null)
		{
			// 动作
			act(turndata);
			
			// 攻击间隔有时间差
			/*var delay:int = 500 + 500*Math.random();
			delay *= dataCenter.playSpeed;// 播放速度系数
			if(list.index < list.length)
			{
				setTimer(excute , delay);
			}*/
		}
	}
}




/**
 * 单轮攻击结算
 * */
private function clearTurn(turndata:BattleTurnData):void
{
	// 行动者UI复原 , 数据还原
	var aPlayer:BPlayer = turndata.aPlayer;
	aPlayer.curSkill = null;
	aPlayer.stillness = true;
	
	// 该角色存活
	if(aPlayer.alive == true)
	{
		// 显示血条
		aPlayer.showBlood(true);
	}
	
	// 若行动者是主角
	/*if(aPlayer == dataCenter.leader)
	{
		// 非10003引导的战斗
		if(curRound != 1 || dataCenter.battleID != GUIDE_BATTLE_ID[10003])
		{
			// 之后主角是否还有行动,若有则不能使用技能
			var actions:Array = BattlePreSkillAlg.getLeaderActions(dataCenter.roundCache);
			if(actions == null)
			{
				this.enabled = true;
			}
		}
	}*/
	// 伙伴或怪物
	if(aPlayer.isHero == true || aPlayer.isMonster == true)
	{
		// 是否可以释放技能
		aPlayer.showPreSkill(aPlayer.canUseSkill);
	}
	
	// 从攻击者列表中去掉自己
	turnList.remove(turndata);
	// 若本轮没有攻击者了 , 则进入下一轮
	if(turnList.length == 0)
	{
		this.parseActionRole();
	}
}




/**
 * 是否有角色将要行动
 * */
public function get willPlay():Boolean
{
	return rounds.length > 0;
}



/**
 * 动画是否在播放ing
 * */
public function get isPlaying():Boolean
{
	return turnList.length > 0;
}




/**
 * 玩家点击变速时暂时先将播放速度保存起来,等下一个角色行动时才生效
 * */
public function savePlaySpeed(speed:Number):void
{
	playSpeed = speed;
}
