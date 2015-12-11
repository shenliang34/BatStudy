import com.gamehero.sxd2.battle.data.BattleGrid;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.battle.gui.BattleRoleTips;
import com.gamehero.sxd2.event.BattleTipsEvent;
import com.gamehero.sxd2.manager.BattleUnitManager;
import com.gamehero.sxd2.manager.SoundManager;
import com.gamehero.sxd2.vo.BattleSkill;

import flash.display.Sprite;
import flash.utils.setTimeout;

import bowser.utils.data.Group;

/**
 * 战斗UI层逻辑
 * @author xuwenyi
 * @create 2013-06-25
 **/




/**
 * 更新全部UI
 * */
private function updateUI():void
{
	ui.update();
}






/**
 * 更新BOSS相关
 * */
private function updateBossUI():void
{
	ui.updateBossHP();
	//ui.updateBossBuff();
}





/**
 * 更新波数
 * */
private function updateBoshuUI():void
{
	//ui.updateBoshu(dataCenter.curBoshu);
}



/**
 * 更新当前回合数
 * */
private function updateRoundUI():void
{
	ui.updateRound(curRound);
}



/**
 * 显示boss头像信息UI
 * */
private function showBossUI():void
{
	ui.showBossUI();
}




/**
 * 显示pvp开场动画
 * */
private function showPvpOpening():void
{
	var battleType:int = dataCenter.battleType;
	if(battleType >= 100)// pvp战斗
	{
		setTimeout(function():void
		{
			var leaders:Array = dataCenter.leaders;
			if(leaders.length >= 2)
			{
				ui.showPvpOpening(leaders[0].role.base , leaders[1].role.base);
			}
		} , 1400);
	}
}




/**
 * 显示技能飘字
 * */
private function showSkillText(skill:BattleSkill):void
{
	//ui.showSkillText(skill);
}





/**
 * 更新关卡回合
 * */
private function updateHurdleNotePanel():void
{
	/*if(curRound > lastRound)
	{
		ui.updateHurdleNotePanel();
	}*/
}






/**
 * 播放战斗背景音乐
 * */
private function playMusic():void
{
	// 先停止所有背景音乐
	SoundManager.inst.stopAllSounds();
	
	var battleID:int = dataCenter.battleID;
	var sound:String = BattleUnitManager.inst.getSound(battleID);
	if(sound != "")
	{
		SoundManager.inst.play(sound , 500);
	}
}




/**
 * 显示tips
 * */
private function onTipsOpen(e:BattleTipsEvent):void
{
	var player:BPlayer = e.data as BPlayer;
	var tips:BattleRoleTips = ui.tips;
	if(player.alive == true && player.alpha > 0)
	{
		tips.show(player);
		ui.addChild(tips);
		
		// 判断x是否越界
		if(ui.mouseX + tips.width > viewWidth)
		{
			tips.x = ui.mouseX - tips.width;
		}
		else
		{
			tips.x = ui.mouseX + 5;
		}
		// 判断y是否越界
		if(tips.height <= (viewHeight >> 1))
		{
			if(ui.mouseY + tips.height > viewHeight)
			{
				tips.y = ui.mouseY - tips.height;
			}
			else
			{
				tips.y = ui.mouseY + 5;
			}
		}
		else
		{
			if(ui.mouseY + tips.height > viewHeight)
			{
				if(tips.height > viewHeight)
				{
					tips.y = 0;
				}
				else
				{
					tips.y = viewHeight - tips.height;
				}
			}
			else
			{
				tips.y = ui.mouseY + 5;
			}
		}
	}
	
	// 显示所有角色的名字
	var players:Array = dataCenter.allPlayers;
	for(var i:int=0;i<players.length;i++)
	{
		var p:BPlayer = players[i];
		if(p.alive == true)
		{
			p.showName(true);
		}
	}
}




/**
 * 更新tips位置
 * */
private function onTipsUpdate(e:BattleTipsEvent):void
{
	var player:BPlayer = e.data as BPlayer;
	var tips:BattleRoleTips = ui.tips;
	if(player.alive == true && player.alpha > 0)
	{
		// 判断x是否越界
		if(ui.mouseX + tips.width > this.width)
		{
			tips.x = ui.mouseX - tips.width;
		}
		else
		{
			tips.x = ui.mouseX + 5;
		}
		// 判断y是否越界
		if(tips.height <= (this.height >> 1))
		{
			if(ui.mouseY + tips.height > this.height)
			{
				tips.y = ui.mouseY - tips.height;
			}
			else
			{
				tips.y = ui.mouseY + 5;
			}
		}
		else
		{
			if(ui.mouseY + tips.height > this.height)
			{
				if(tips.height > this.height)
				{
					tips.y = 0;
				}
				else
				{
					tips.y = this.height - tips.height;
				}
			}
			else
			{
				tips.y = ui.mouseY + 5;
			}
		}
	}
	else
	{
		if(ui.contains(tips) == true)
		{
			tips.clear();
			ui.removeChild(tips);
		}
	}
}




/**
 * 关闭tips
 * */
private function onTipsClose(e:BattleTipsEvent = null):void
{
	var tips:BattleRoleTips = ui.tips;
	if(ui.contains(tips) == true)
	{
		tips.clear();
		ui.removeChild(tips);
	}
	
	// 隐藏所有角色的名字
	var players:Array = dataCenter.allPlayers;
	for(var i:int=0;i<players.length;i++)
	{
		var p:BPlayer = players[i];
		if(p.alive == true)
		{
			p.showName(false);
		}
	}
}






/**
 * 更新tips数据(角色数据变动时调用)
 * */
private function updateTips(player:BPlayer):void
{
	var tips:BattleRoleTips = ui.tips;
	if(tips.player == player && ui.contains(tips) == true)
	{
		tips.show(player);
	}
}






/**
 * 是否允许交互
 * */
public function set enabled(value:Boolean):void
{
	/*var skillBar:BattleSkillBar = ui.skillBar;
	
	skillBar.mouseEnabled = value;
	skillBar.mouseChildren = value;
	// 技能栏交互
	skillBar.enabled = value;
	
	// 逃跑按钮
	this.escapeEnabled = value;*/
}




public function get enabled():Boolean
{
	/*var skillBar:BattleSkillBar = ui.skillBar;
	return skillBar.mouseEnabled;*/
	
	return true;
}





/**
 * 是否允许逃跑
 * */
public function set escapeEnabled(value:Boolean):void
{
	var escapeBtnPanel:Sprite;// = ui.escapeBtnPanel;
	if(escapeBtnPanel)
	{
		if(value == true)
		{
			// 是否为同步pvp战斗
			if(dataCenter.checkSyncBattle(dataCenter.battleType) == true)
			{
				escapeBtnPanel.visible = false;
				return;
			}
			
			// 是否为播报式战斗
			if(dataCenter.checkPassBattle(dataCenter.battleType) == true)
			{
				escapeBtnPanel.visible = false;
				return;
			}
			
			// 是否为赏金猎人
			/*if(dataCenter.battleType == GS_BattleType_Pro.BATTLE_BountyHunter)
			{
				escapeBtnPanel.visible = false;
				return;
			}*/
			
			// 等级是否满足
			var leader:BPlayer = dataCenter.leader;
			var leaderLevel:int = leader.role.base.level;
			/*if(leaderLevel < BattleUI.ESCAPE_LIMIT_LEVEL)
			{
				escapeBtnPanel.visible = false;
				return;
			}*/
			
			// 主角是否死亡
			if(leader.alive == false)
			{
				escapeBtnPanel.visible = false;
				return;
			}
			
			// 我方是否有人阵亡
			var grid1:BattleGrid = dataCenter.grid1;
			var allPlayers:Group = grid1.playerList;
			var alivePlayers:Array = grid1.getAlivePlayers();
			if(allPlayers.length <= alivePlayers.length)
			{
				escapeBtnPanel.visible = false;
				return;
			}
			
			// 启动逃跑引导
			//ui.startEscapeGuide();
		}
		escapeBtnPanel.visible = value;
	}
}

