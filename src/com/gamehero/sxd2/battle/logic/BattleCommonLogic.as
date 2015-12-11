import com.gamehero.sxd2.battle.data.BattleResult;
import com.gamehero.sxd2.battle.data.LastBattleData;
import com.gamehero.sxd2.battle.gui.BattleReportWindow;
import com.gamehero.sxd2.battle.gui.BattleResultWindow;
import com.gamehero.sxd2.core.Global;
import com.gamehero.sxd2.gui.core.WindowManager;
import com.gamehero.sxd2.gui.core.WindowPostion;
import com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_ACK;
import com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_ACK;

import flash.events.TimerEvent;
import flash.utils.ByteArray;
import flash.utils.Timer;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

/**
 * 战斗中日常事务处理
 * @author xuwenyi
 * @create 2013-06-26
 **/



// 第一回合的m1计时器
private var firstRoundTimer:Timer;
// 所有setTimeout产生的id
private var timeoutList:Array = [];





/**
 * 初始化各计时器
 * */
private function initTimers():void
{
	// 第一回合的m1计时器
	firstRoundTimer = new Timer(2000 , 1);
	firstRoundTimer.addEventListener(TimerEvent.TIMER_COMPLETE , onFirstRoundTimerHandler);
}





/**
 * 清理计时器
 * */
private function clearTimers():void
{
	firstRoundTimer.stop();
	
	var len:int = timeoutList.length;
	for(var i:int=0;i<len;i++)
	{
		var id:uint = timeoutList[i];
		clearTimeout(id);
	}
	timeoutList = [];
}




/**
 * 开始计算第一回合m1计时器
 * */
private function startFirstRoundTimer():void
{
	var time:int;
	if(dataCenter.battleType < 100)
	{
		// pve
		time = 2000;
	}
	else
	{
		// pvp
		time = 3000;
	}
	firstRoundTimer.delay = time;
	firstRoundTimer.reset();
	firstRoundTimer.start();
}



/**
 * 停止第一回合m1计时器
 * */
private function stopFirstRoundTimer():void
{
	firstRoundTimer.stop();
}



/**
 * 第一回合m1计时器是否正在执行
 * */
private function get firstRoundTimerRunning():Boolean
{
	return firstRoundTimer.running;
}




/**
 * 第一回合m1计时器结束处理
 * */
private function onFirstRoundTimerHandler(e:TimerEvent):void
{
	this.executeRoundLogic();
}





/**
 * 获取回合间的休眠时间
 * @return 毫秒
 * */
private function getWaitTime():Number
{
	var time:Number = 0;
	// 同步战斗(红龙,地牢等)
	if(dataCenter.checkSyncBattle(dataCenter.battleType) == true)
	{
		time = 5000;
	}
	else
	{
		time = 10000;
	}
	return time;
}






/**
 * 启动一个计时器(setTimeout)
 * */
private function setTimer(func:Function , delay:Number , ... args):void
{
	var timerID:uint;
	if(args && args.length > 0)
	{
		var len:int = args.length;
		switch(len)
		{
			case 1:
				timerID = setTimeout(func , delay , args[0]);
				break;
			case 2:
				timerID = setTimeout(func , delay , args[0] , args[1]);
				break;
			case 3:
				timerID = setTimeout(func , delay , args[0] , args[1] , args[2]);
				break;
			case 4:
				timerID = setTimeout(func , delay , args[0] , args[1] , args[2] , args[3]);
				break;
		}
	}
	else
	{
		timerID = setTimeout(func , delay);
	}
	
	if(timeoutList.indexOf(timerID) < 0)
	{
		timeoutList.push(timerID);
	}
}






/**
 * 跳过战斗
 * */
public function pass():void
{
	if(this.willPlay == true)
	{
		this.rounds = [];
		dataCenter.roundCache = [];
	}
	
	if(dataCenter.battleResult)
	{
		this.showBattleResult();
		
		// 战斗结束
		isBattleEnd = true;
		dataCenter.battleResult = null;
	}
}








/**
 * 显示战报
 * */
private function showBattleResult():void
{
	// 禁用交互
	this.enabled = false;
	
	// 关掉角色tips
	this.onTipsClose();
	
	// 停止计时器
	this.clearTimers();
	
	// 存放本场战斗数据
	LastBattleData.battleID = dataCenter.battleID;
	LastBattleData.battleType = dataCenter.battleType;
	LastBattleData.replayID = dataCenter.replayID;
	LastBattleData.isFirstBattle = dataCenter.isFirstBattle;
	// 战斗结果
	var result:BattleResult = new BattleResult();
	result.win = 1 == dataCenter.battleResult.winnerCamp;
	result.leaderName = dataCenter.leader.name;
	result.isReplay = dataCenter.checkReplayBattle();
	result.battleResult = dataCenter.battleResult;
	LastBattleData.battleResult = result;
	
	setTimeout(function():void
	{
		// 非录像
		if(result.isReplay == false && dataCenter.inGame == true)
		{
			WindowManager.inst.openWindow(BattleResultWindow , WindowPostion.CENTER_ONLY);
		}
		else
		{
			WindowManager.inst.openWindow(BattleReportWindow , WindowPostion.CENTER_ONLY);
		}
	} , 1000);
}






/**
 * 回放
 * */
public function replay():void
{
	// 清空战斗数据及显示对象
	this.clear();
	
	// 重新初始化数据
	var bytes:ByteArray = Global.instance.cloneByteArray(LastBattleData.protoBytes);
	var ack:Object;
	if(LastBattleData.isReport == false)
	{
		ack = new MSG_BATTLE_CREATE_ACK();
		ack.mergeFrom(bytes);
		dataCenter.saveDetailInfo(ack.detail);
		dataCenter.isReplay = false;
	}
	else
	{
		ack = new MSG_BATTLE_REPORT_ACK();
		ack.mergeFrom(bytes);
		dataCenter.saveDetailInfo(ack.detail);
		dataCenter.isReplay = true;
	}
	
	this.newGame();
}






/**
 * 退出战斗
 * */
public function quit():void
{
	// 清空战斗数据及显示对象
	this.clear();
	
	// MainUI添加聊天面板
	var mainUI:Object = dataCenter.mainUI;
	if(mainUI != null)
	{
		var chatView:Object = dataCenter.chatView;
		mainUI.addChild(chatView);
		mainUI.resize();
	}
}



