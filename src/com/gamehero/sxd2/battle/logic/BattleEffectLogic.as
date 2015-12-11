import com.gamehero.sxd2.battle.BattleView;
import com.gamehero.sxd2.battle.data.BattleAtkData;
import com.gamehero.sxd2.battle.data.BattleMoveData;
import com.gamehero.sxd2.battle.data.BattleTurn;
import com.gamehero.sxd2.battle.data.BattleTurnData;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.event.BattleWorldEvent;
import com.gamehero.sxd2.manager.SkillMoveManager;
import com.gamehero.sxd2.pro.PRO_BattlePlayer;
import com.gamehero.sxd2.vo.BattleSkill;
import com.gamehero.sxd2.vo.BattleSkillEf;
import com.gamehero.sxd2.vo.BattleSkillMove;

import flash.utils.Dictionary;

import bowser.logging.Logger;
import bowser.utils.data.Group;
import bowser.utils.data.Vector2D;

/**
 * 2013-06-25
 * @author xuwenyi
 * @create 战斗效果层逻辑
 **/


// 单次伤害数据(key为battlePlayer的tempID)
private var damageData:Dictionary = new Dictionary();
// 受击对象列表
private var uaList:Group = new Group();





/**
 * 单个角色动作
 * */
private function act(turndata:BattleTurnData):void
{
	var aPlayer:BPlayer = turndata.aPlayer;
	// log
	Logger.debug(BattleView , " (" + aPlayer.name + "|" + aPlayer.tempID + ") 开始行动");
	
	// 是否执行引导
	/*if(isPause == false)
	{
		var monsterID:String = aPlayer.role.roleBase.userID.toString();
		this.checkGuide(10002 , callback , monsterID);
		this.checkGuide(10012 , callback , monsterID);
		this.checkGuide(10013 , callback , monsterID);
		this.checkGuide(10014 , callback , monsterID);
		this.checkGuide(10015 , callback , monsterID);
		this.checkGuide(10016 , callback , monsterID);
		function callback():void
		{
			act(turn);
		}
	}
	if(isPause == true)
	{
		return;
	}*/
	
	// 隐藏该角色血条
	aPlayer.showBlood(false);
	// 隐藏技能圈圈
	aPlayer.showPreSkill(false);
	
	// 行动前是否受到debuff影响,伤害或治疗
	var updateRole:PRO_BattlePlayer = turndata.updateRole;
	/*var dmgsBeforeAction:Array = updateRole.dmgsBeforeAction;
	for(var i:int=0;i<dmgsBeforeAction.length;i++)
	{
		// 伤害飘字
		var dmgShow:int = dmgsBeforeAction[i];
		var tempAtkData:BattleAtkData = new BattleAtkData();
		tempAtkData.dmgShow = dmgShow;
		this.addDamage(aPlayer , aPlayer , null , tempAtkData);
	}
	// 批量显示伤害数字
	this.showDamages();*/
	
	// 行动者更新状态
	aPlayer.role = updateRole;
	aPlayer.setBuff(updateRole.buffs);
	aPlayer.updateStatus();
	
	// 实时更新tips
	this.updateTips(aPlayer);
	
	// 扣完血后角色是否死亡
	if(aPlayer.alive == false)
	{
		aPlayer.dead();
		this.clearTurn(turndata);
		return;
	}
	else
	{	
		// 普通行动步骤
		this.excuteTurnData(turndata);
		
		// 反击(若有)
		var counterTurn:BattleTurn = turndata.counterTurn;
		var delay:Number;
		if(counterTurn != null)
		{
			delay = turndata.totalDuration - counterTurn.actionDuration;
			this.setTimer(counterAttack , delay , counterTurn);
		}
		
		// 合击(若有)
		var jointAtkTurnData:BattleTurnData = turndata.jointAtkTurnData;
		if(jointAtkTurnData != null)
		{
			delay = jointAtkTurnData.jointAtkDelay + 1;
			this.setTimer(excuteTurnData , delay , jointAtkTurnData);
		}
	}
}






/**
 * 解析并执行BattleTurnData
 * */
private function excuteTurnData(turndata:BattleTurnData):void
{
	// 普通行动步骤
	var turns:Vector.<BattleTurn> = turndata.turns;
	var delay:Number;
	
	// 先执行第一个攻击动作(可能是近战也可能是远程)
	if(turns.length > 0)
	{
		var firstTurn:BattleTurn = turns.shift();
		this.excuteTurn(turndata , firstTurn);
		
		for(var i:int=0;i<turns.length;i++)
		{
			if(i == 0)
			{
				delay = firstTurn.actionDuration;
			}
			else
			{
				var turn:BattleTurn = turns[i-1];
				delay += turn.actionDuration;
			}
			this.setTimer(attack , delay * dataCenter.playSpeed , turns[i]);
		}
	}
	
	// 一定时间后还原行动者属性
	// 动作持续时间
	delay = turndata.totalDuration * dataCenter.playSpeed;// 播放速度系数
	this.setTimer(clearTurn , delay , turndata);
}






/**
 * 行动步骤
 * */
private function excuteTurn(turndata:BattleTurnData , turn:BattleTurn):void
{
	// 根据技能类型判断动作
	var aPlayer:BPlayer = turn.aPlayer;
	var skill:BattleSkill = turn.skill;
	var skillEf:BattleSkillEf = turn.skillEf;
	
	// 角色位置(防止缩放浏览器错位)
	var pos:Vector2D = aPlayer.position;
	aPlayer.x = pos.x;
	aPlayer.y = pos.y;
	
	// 存在攻击目标才能行动
	var firstAtks:Array = turn.firstAtks;
	if(firstAtks.length > 0)
	{
		// 是否有技能
		if(skill)
		{
			// 主角逻辑
			if(aPlayer == dataCenter.leader)
			{
				// 是否出现横幅
				if(skillEf.isBurst == "1")
				{
					efCanvas.playBurstEf(aPlayer , skillEf);
					setTimer(step1 , 1500*dataCenter.playSpeed);//播放速度系数
				}
				else
				{
					// 显示主角释放技能的飘字
					showSkillText(skill);
					// 第一步
					step1();
				}
			}
			// 非主角
			else
			{
				// 第一步
				step1();
			}
		}
	}
	
	// 第一步行动
	function step1():void
	{
		// 是否需要聚气
		/*if(aPlayer.normalSkill == skill)
		{
			step2();//普通攻击不需要聚气
		}
		else
		{
			aPlayer.showJuqi(step2);//聚气
		}*/
		
		step2();
	}
	
	// 第二步行动
	function step2():void
	{
		// 跑动攻击(近战)
		if(skillEf.actionId == 1)
		{
			move(turn , 1 , turndata);
		}
		// 跳跃攻击(近战)
		else if(skillEf.actionId == 3)
		{
			move(turn , 2 , turndata);
		}
		// 远程攻击
		else
		{
			attack(turn);
		}
	}
}





/**
 * 移动
 * */
private function move(turn:BattleTurn , moveType:int , turndata:BattleTurnData):void
{
	// 行动者
	var aPlayer:BPlayer = turn.aPlayer;
	aPlayer.stillness = false;
	// 跑动
	if(moveType == 1)
	{
		aPlayer.run();
	}
	else
	{
		aPlayer.jump();
	}
	// 主要受击者
	var firstAtks:Array = turn.firstAtks;
	// 行动技能
	var skillEf:BattleSkillEf = turn.skillEf;
	
	// 动画数据
	var moveData:BattleMoveData = new BattleMoveData();
	moveData.from = aPlayer.position;
	moveData.to = dataCenter.getMovePosition(firstAtks , skillEf);
	moveData.moveType = moveType;// 跑动还是跳跃
	moveData.duration = 0.3 * dataCenter.playSpeed;// 播放速度系数
	moveData.delay = (turndata.totalDuration - 600) * 0.001 * dataCenter.playSpeed;// 播放速度系数
	moveData.target = aPlayer;
	moveData.turn = turn;
	
	// 移动
	world.move(moveData , turndata.isAliveAfterAction);
}



/**
 * 角色移动后抵达目的地
 * */
private function onPlayerMoveArrive(e:BattleWorldEvent):void
{
	// 发动攻击
	var moveData:BattleMoveData = e.data as BattleMoveData;
	attack(moveData.turn);
}



/**
 * 角色攻击动画播放完后返回
 * */
private function onPlayerMoveBack(e:BattleWorldEvent):void
{
	// 角色往回跑
	var moveData:BattleMoveData = e.data as BattleMoveData;
	var player:BPlayer = moveData.target;
	player.run();
}



/**
 * 角色返回原地
 * */
private function onPlayerMoveComplete(e:BattleWorldEvent):void
{
	// 角色回到站立状态
	var moveData:BattleMoveData = e.data as BattleMoveData;
	var player:BPlayer = moveData.target;
	player.stand();
	
	// 角色位置(防止缩放浏览器错位)
	var pos:Vector2D = player.position;
	player.x = pos.x;
	player.y = pos.y;
}




/**
 * 攻击
 **/
private function attack(turn:BattleTurn):void
{
	var delay:Number;
	
	// 角色攻击
	var player:BPlayer = turn.aPlayer;
	player.stillness = false;
	
	var skillEf:BattleSkillEf = turn.skillEf;
	player.attack(skillEf);
	player.addUsedSkill(turn.skill);// 保存使用过的技能
	
	// 播放自身特效
	if(skillEf.efSE != "")
	{
		if(skillEf.isPNG(skillEf.efSE) == true)
		{
			player.playSE(skillEf);
		}
		else
		{
			efCanvas.playSwfSE(skillEf , player);
		}
	}
	
	Logger.debug(BattleView , "[" + player.name + "]使用技能 , effectID = " + skillEf.effectID);
	
	// 触发技能特效
	this.triggerSkillEf(skillEf , turn);
	
	// 触发受击
	this.triggerUAtk(turn);
	
	// 触发壳动画
	this.triggerUaMove(turn);
	
	// 触发全屏特效
	efCanvas.playScreenEf(skillEf , this);
	
	// 变黑特效
	var blackPlayers:Array = turn.uPlayers.concat();
	blackPlayers.unshift(player);
	world.playBlack(blackPlayers , skillEf);
	
	// 更新BOSS UI
	if(player == dataCenter.boss)
	{
		this.updateBossUI();
	}
}





/**
 * 触发技能特效
 * */
private function triggerSkillEf(skillEf:BattleSkillEf , turn:BattleTurn):void
{
	// 效果延迟
	var skDelay:Number = skillEf.skDelay;
	var delay:int = skDelay != 0 ? skDelay : 10;// 默认10ms
	delay *= dataCenter.playSpeed;// 播放速度系数
	
	// 攻击者
	var aPlayer:BPlayer = turn.aPlayer;
	// 主要受击者
	var firstAtks:Array = turn.firstAtks.concat();
	
	// 是否为多重攻击
	var multiAtkInterval:int = skillEf.multiAtkInterval;
	multiAtkInterval *= dataCenter.playSpeed;// 播放速度系数
	
	var atk:BattleAtkData;
	var uPlayer:BPlayer;
	// 一次攻击
	if(multiAtkInterval == 0)
	{
		atk = firstAtks[0];
		uPlayer = atk.targetPlayer;
		this.setTimer(playSkillEf , delay , skillEf , aPlayer , uPlayer);
	}
	// 多重攻击
	else
	{
		while(firstAtks.length > 0)
		{
			atk = firstAtks.shift();
			uPlayer = atk.targetPlayer;
			this.setTimer(playSkillEf , delay , skillEf , aPlayer , uPlayer);
			
			delay += multiAtkInterval;
		}
	}
	
	
	
}





// 触发单次效果
private function playSkillEf(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
{
	// 是否为序列帧动画
	if(skillEf.efSK != "")
	{
		if(skillEf.isPNG(skillEf.efSK) == true)
		{
			efLayer.add(skillEf , aPlayer , uPlayer);
		}
		else
		{
			efCanvas.playSwfSK(skillEf , aPlayer , uPlayer);
		}
	}
}





/**
 * 触发受击
 * @param turn 攻击数据
 * */
private function triggerUAtk(turn:BattleTurn):void
{
	var aPlayer:BPlayer = turn.aPlayer;
	var skillEf:BattleSkillEf = turn.skillEf;
	
	var firstAtks:Array = turn.firstAtks;
	var secondAtks:Array = turn.secondAtks;
	
	// 清空受击列表
	uaList.clear();
	
	// 是否为多重攻击
	var multiAtkInterval:int = skillEf.multiAtkInterval;
	multiAtkInterval *= dataCenter.playSpeed;// 播放速度系数
	var delay:int = 0;
	
	// 主要受击者
	if(firstAtks.length > 0)
	{
		var uPlayer:BPlayer = firstAtks[0].targetPlayer;
		var uaDelay:int = skillEf.getUaDelay(uPlayer.pos);
		uaDelay *= dataCenter.playSpeed;// 播放速度系数
		delay = uaDelay;
		var atk:BattleAtkData;
		while(firstAtks.length > 0)
		{
			atk = firstAtks.shift();
			this.setTimer(playUAtk , delay , turn , atk , false);
			delay += multiAtkInterval;
			
			// 加入受击列表
			uaList.add(atk);
		}
	}
	
	// 溅射受击者
	// 溅射时间是从普通受击时间点开始算起
	/*var suaDelay:int = uaDelay + skillEf.suaDelay == "" ? 300 : Number(skillEf.suaDelay);
	suaDelay *= dataCenter.playSpeed;// 播放速度系数
	delay = suaDelay;
	while(spAtks.length > 0)
	{
		atk = spAtks.shift();
		this.setTimer(playUAtk , delay , turn , atk , true);
		
		// 加入受击列表
		uaList.add(atk);
	}*/
	
	// 次要受击者
	/*delay = uaDelay;
	while(seAtks.length > 0)
	{
		atk = seAtks.shift();
		this.setTimer(playUAtk , delay , turn , atk , false);
		
		// 加入受击列表
		uaList.add(atk);
	}*/
}







// 播放受击
private function playUAtk(turn:BattleTurn , atk:BattleAtkData , spurtMode:Boolean = false):void
{
	var aPlayer:BPlayer = turn.aPlayer;
	var targetPlayer:BPlayer = atk.targetPlayer;
	
	// 是否需要客户端加减血量
	// 若目标是自己则不需要计算
	var isSelf:Boolean = targetPlayer == aPlayer ? true : false;
	// 更新血量(非自己)
	// 更新攻击对象buff状态(非自己)
	if(isSelf == false)
	{
		// buff
		targetPlayer.setBuff(atk.buffs);
		
		// 计算角色hp,anger,volition
		targetPlayer.updateProperty(atk.dmg , atk.anger , atk.volition);
		// 更新角色状态
		targetPlayer.updateStatus();
		// 伙伴或怪物下回合是否可以释放技能
		targetPlayer.showPreSkill(targetPlayer.canUseSkill);
		
		// 实时更新tips
		this.updateTips(targetPlayer);
	}
	
	// 伤害或加血飘字
	this.addDamage(aPlayer , targetPlayer , turn.skillEf , atk);
	
	// ========================================================
	
	// 是否有反伤或加血
	var selfDmgs:Array = atk.selfdmg;
	if(selfDmgs != null)
	{
		// 攻击者反伤或加血飘字
		for(var x:int=0;x<selfDmgs.length;x++)
		{
			var tempAtkData:BattleAtkData = new BattleAtkData();
			tempAtkData.dmgShow = selfDmgs[x];
			this.addDamage(aPlayer , aPlayer , null , tempAtkData);
		}
	}
	
	// ================================ 打印日志  ===================================
	
	// 打印日志
	if(atk.targetPlayer)
	{
		if(atk.dmg > 0)
		{
			Logger.debug(BattleView , "("+aPlayer.name + ") 对 ("+targetPlayer.name+") 造成 ("+atk.dmg+") 伤害!");
		}
		else if(atk.dmg < 0)
		{
			Logger.debug(BattleView , "("+aPlayer.name + ") 对 ("+targetPlayer.name+") 治疗 ("+(-atk.dmg)+") 生命!");
		}
		else if(atk.avd == 1)
		{
			Logger.debug(BattleView , "("+aPlayer.name + ") 攻击 ("+targetPlayer.name+") , 但被闪避了!");
		}
	}
	
	// 批量显示伤害数字
	this.showDamages();
	
	// ================================ 更新UI ===================================
	
	// boss UI
	if(targetPlayer == dataCenter.boss)
	{
		this.updateBossUI();
	}
	
	// 从受击列表中移除
	uaList.remove(atk);
	/*if(uaList.length == 0)
	{
		// 更新防御链
		var chains:Array = aPlayer.role.chains;
		if(chains.length > 0)
		{
			world.updateBattleChain(chains);
		}
	}*/
}







// 触发壳动画
private function triggerUaMove(turn:BattleTurn):void
{
	var skillEf:BattleSkillEf = turn.skillEf;
	if(skillEf.moves != null)
	{
		var atks:Array = turn.atks.toArray();
		var moveDelays:Array = skillEf.moveDelays;
		
		for(var i:int=0;i<atks.length;i++)
		{
			var atk:BattleAtkData = atks[i];
			var uPlayer:BPlayer = atk.targetPlayer;
			var moveDelay:Number = moveDelays[uPlayer.pos - 1] * dataCenter.playSpeed;
			this.setTimer(playUaMove , moveDelay , skillEf , atk);
		}
	}
}






// 播放壳动画
private function playUaMove(skillEf:BattleSkillEf , atk:BattleAtkData):void
{
	var uPlayer:BPlayer = atk.targetPlayer;
	// 壳动画
	if(uPlayer.isSkillMove == true && skillEf.moves != null && atk.dmgShow != 0)
	{
		var movestr:String = skillEf.moves[uPlayer.pos - 1];
		var ids:Array = movestr.split(",");
		var moves:Array = [];
		for(var i:int=0;i<ids.length;i++)
		{
			var m:BattleSkillMove = SkillMoveManager.instance.getMove(ids[i]);
			if(m != null)
			{
				moves.push(m);
			}
		}
		uPlayer.uaMove(moves);
	}
}







/**
 * 反击
 * */
private function counterAttack(counterTurn:BattleTurn):void
{
	this.attack(counterTurn);
}
