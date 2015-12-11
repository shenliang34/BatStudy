import com.gamehero.sxd2.battle.data.BattleDataCenter;
import com.gamehero.sxd2.battle.data.BattleGrid;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.battle.gui.BattleSkIcon;
import com.gamehero.sxd2.battle.gui.BattleSkillBar;
import com.gamehero.sxd2.core.GameConfig;
import com.gamehero.sxd2.guide.GuideVO;
import com.gamehero.sxd2.manager.GuideManager;
import com.gamehero.sxd2.pro.GS_ClassStatus_Pro;
import com.gamehero.sxd2.world.display.data.GameRenderCenter;

import flash.utils.Dictionary;

import bowser.loader.BulkLoaderSingleton;
import bowser.utils.data.Group;

/**
 * 战斗中的新手引导逻辑
 * @author xuwenyi
 * @create 2014-01-14
 **/

private static var GUIDE_BATTLE_ID:Dictionary = new Dictionary();
private static var GUIDE_ID_LIST:Array = [10001 , 10002 , 10003 , 10011 , 10012 , 10013 , 10014 , 10015 , 10016 , 10031 , 10032];


// 是否暂停
private var isPause:Boolean = false;
// 重新开始游戏后的执行函数
private var resumeHandler:Function;




/**
 * 初始化
 * */
private function initGuide():void
{
	// 涉及到新手引导的战斗id
	var mgr:GuideManager = GuideManager.instance;
	for(var i:int=0;i<GUIDE_ID_LIST.length;i++)
	{
		var guideID:int = GUIDE_ID_LIST[i];
		var info:GuideVO = mgr.getGuideInfo(guideID);
		if(info)
		{
			var battleID:int = int(info.conditionParam);
			GUIDE_BATTLE_ID[guideID] = battleID;
		}
	}
}





/**
 * 检查该场战斗的新手引导
 * @param guideID 指定引导id
 * @param 完成后执行的回调
 * */
private function checkGuide(guideID:int , callback:Function = null , param:Object = null):void
{
	var currentBattleID:int = dataCenter.battleID;
	var battleID:int = GUIDE_BATTLE_ID[guideID];
	// 本场战斗存在新手引导
	if(currentBattleID == battleID)
	{
		// 引导参数
		var mgr:GuideManager = GuideManager.instance;
		var info:GuideVO = mgr.getGuideInfo(guideID);
		if(info.isPlay == false)
		{
			// 指定回合
			var param1:int = int(info.param1);
			if(curRound == param1)// 是否本回合的引导
			{
				switch(guideID)
				{
					case 10001:// 第1场战斗使用第一个技能
					case 10031:// 第1个关卡使用第一个技能
						this.enabled = true;
						this.playGuide(guideID , true);
						break;
					
					case 10003:// 第1场战斗使用第二个技能
					case 10032:// 第1个关卡使用第二个技能
						this.enabled = true;
						this.playGuide(guideID , false);
						break;
					
					case 10011:// 第2场战斗敌我上阵
						this.playGuide(guideID , true , callback);
						break;
					
					case 10002:// 第1场战斗援军上阵并出现剧情
					case 10012:// 第2场战斗单位1触发剧情
					case 10013:// 第2场战斗单位2触发剧情
					case 10014:// 第2场战斗单位3触发剧情
					case 10015:// 第2场战斗boss触发剧情并变身
					case 10016:// 第2场战斗单位3再次触发剧情并变身
						// 行动者是指定monster
						if(param == info.param2)
						{
							this.playGuide(guideID , true , callback);
						}
						break;
				}
			}
		}
	}
}





/**
 * 播放指定id的引导
 * */
private function playGuide(guideID:int , pause:Boolean , callback:Function = null):void
{
	// 是否需要暂停游戏
	if(pause == true)
	{
		this.pause();
		this.resumeHandler = callback;
		
		// 禁用键盘事件
		var skillBar:BattleSkillBar = ui.skillBar;
		skillBar.keyboard = false;
	}
	// 开始播放引导
	var mgr:GuideManager = GuideManager.instance;
	mgr.playGuide(guideID , guideCompHandler);
}





/**
 * 引导完成
 * */
private function guideCompHandler():void
{
	// 启用键盘事件
	var skillBar:BattleSkillBar = ui.skillBar;
	skillBar.keyboard = true;
	
	// 重新开始游戏
	this.resume();
}





/**
 * 暂停游戏
 **/
private function pause():void
{
	this.isPause = true;
}




/**
 * 恢复游戏
 **/
private function resume():void
{
	this.isPause = false;
	
	if(this.resumeHandler)
	{
		var func:Function = this.resumeHandler;
		this.resumeHandler = null;
		
		func();
	}
}




/**
 * 获取某个快捷技能ICON的实例
 */
public function getSkIcon(pos:int):BattleSkIcon
{
	return ui.getSkIcon(pos);
}






/**
 * 显示or隐藏某快捷技能icon
 * */
public function showSkIcon(pos:int , value:Boolean):void
{
	var skillIcon:BattleSkIcon = this.getSkIcon(pos);
	if(skillIcon)
	{
		skillIcon.visible = value;
	}
}




/**
 * 显示防御链
 * */
public function showBattleChain(camp:int , visible:Boolean):void
{
	world.showBattleChain(camp , visible);
}




/**
 * 防御链显示开关
 * */
public function setBattleChainEnabled(camp:int , value:Boolean):void
{
	world.setBattleChainEnabled(camp , value);
}







/**
 * 本场战斗是否是第1场引导
 * */
private function check10002():void
{
	var currentBattleID:int = dataCenter.battleID;
	var battleID:int = GUIDE_BATTLE_ID[10002];
	if(currentBattleID == battleID)
	{
		// 隐藏我方友军
		var mgr:GuideManager = GuideManager.instance;
		var info:GuideVO = mgr.getGuideInfo(10002);
		var monsterID:String = info.param2;
		var players:Array = dataCenter.getRole(GS_ClassStatus_Pro.MONSTER , monsterID);
		for(var i:int=0;i<players.length;i++)
		{
			players[i].openingVisible = false;
			players[i].alpha = 0;
		}
		
		// 遍历我方角色,若有天使则隐藏
		var grid1:BattleGrid = dataCenter.grid1;
		var playerList:Group = grid1.playerList;
		var iLen:int = playerList.length;
		for(i=0;i<iLen;i++)
		{
			var player:BPlayer = playerList.getChildAt(i) as BPlayer;
			if(player.isAngel == true)
			{
				player.visible = false;
				player.alpha = 0;
			}
		}
		
		// 关闭防御链
		this.setBattleChainEnabled(1 , false);
		this.setBattleChainEnabled(2 , false);
		
		// 提前加载7宫格泛光特效
		var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "chain_light.swf");
	}
}





/**
 * 本场战斗是否是第2场引导
 * */
private function check10011():void
{
	var currentBattleID:int = dataCenter.battleID;
	var battleID:int = GUIDE_BATTLE_ID[10011];
	if(currentBattleID == battleID)
	{
		var players:Array;
		var player:BPlayer;
		var i:int;
		
		// 隐藏我方友军
		var mgr:GuideManager = GuideManager.instance;
		var info:GuideVO = mgr.getGuideInfo(10011);
		var heros:Array = info.param2.split("^");
		for(i=0;i<heros.length;i++)
		{
			players = dataCenter.getRole(GS_ClassStatus_Pro.MONSTER , heros[i]);
			if(players && players.length > 0)
			{
				player = players[0];
				player.openingVisible = false;
				player.alpha = 0;
			}
		}
		
		// 提前加载变身资源
		var renderCenter:GameRenderCenter = GameRenderCenter.instance;
		// 史塔克
		var model1:String = GameConfig.BATTLE_FIGURE_URL + "monster_bianshenshitake01_b_rt";
		renderCenter.loadData(model1 , true , dataCenter.loader , false , false);
		dataCenter.addResource(model1);
		// boss
		var model2:String = GameConfig.BATTLE_FIGURE_URL + "monster_xinshousiwangzhiyibianshen01_b_lb";
		renderCenter.loadData(model2 , true , dataCenter.loader , false , false);
		dataCenter.addResource(model2);
		
		// 提前加载新手资源
		var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "trans_honglong.swf");
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "trans_shitake.swf");
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "skill_honglong_sk.swf");
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "skill_shitake_se.swf");
		loader.addWithListener(GameConfig.BATTLE_NEW_PLAYER_URL + "skill_shitake_ua.swf");
	}
}






/**
 * 本场战斗是否有新手引导
 * */
private function get hasGuide():Boolean
{
	var currentBattleID:int = dataCenter.battleID;
	var bool:Boolean = false;
	for each(var battleID:int in GUIDE_BATTLE_ID)
	{
		if(currentBattleID == battleID)
		{
			bool = true;
			break;
		}
	}
	return bool;
}
