import com.gamehero.sxd2.world.views.item.MapCityItem;

import com.gamehero.sxd2.manager.TaskManager;

import com.gamehero.sxd2.battle.BattleView;
import com.gamehero.sxd2.battle.data.BattleDataCenter;
import com.gamehero.sxd2.battle.data.BattleResult;
import com.gamehero.sxd2.battle.data.LastBattleData;
import com.gamehero.sxd2.battle.gui.BattleChange;
import com.gamehero.sxd2.data.GameData;
import com.gamehero.sxd2.drama.DramaManager;
import com.gamehero.sxd2.event.WindowEvent;
import com.gamehero.sxd2.gui.arena.ArenaView;
import com.gamehero.sxd2.gui.bag.manager.GameItemEffect;
import com.gamehero.sxd2.gui.chat.ChatView;
import com.gamehero.sxd2.gui.core.WindowManager;
import com.gamehero.sxd2.gui.main.MainUI;
import com.gamehero.sxd2.gui.notice.NoticeUI;
import com.gamehero.sxd2.gui.roleSkill.RoleSkillView;
import com.gamehero.sxd2.gui.tips.FloatTips;
import com.gamehero.sxd2.manager.BattleUnitManager;
import com.gamehero.sxd2.manager.MapsManager;
import com.gamehero.sxd2.pro.PRO_BattleType;
import com.gamehero.sxd2.pro.PRO_Map;
import com.gamehero.sxd2.services.GameService;
import com.gamehero.sxd2.world.HurdleMap.HurdleSceneView;
import com.gamehero.sxd2.world.globolMap.GlobalSceneView;
import com.gamehero.sxd2.world.model.MapModel;
import com.gamehero.sxd2.world.model.MapTypeDict;
import com.gamehero.sxd2.world.sceneMap.SceneView;
import com.gamehero.sxd2.world.views.SceneViewBase;

import alternativa.gui.mouse.CursorManager;

/**
 * 场景切换相关
 * @author xuwenyi
 * @create 2014-12-23
 **/




/**
 * 改变视图
 * @mapId 场景id
 * */
public function changeView(mapId:int):void 
{
	WindowManager.inst.closeAllWindow();
	NoticeUI.inst.setPathingItem(false);
	
	if(_mapModel.mapVo && _mapModel.mapVo.mapId == mapId)//刷的同一张地图代表刷新位置
	{
		if(currentView != null && viewUI.contains(currentView) == true)
		{
			var map:PRO_Map = GameData.inst.mapInfo;
			if(map != null)
			{
				currentView.setRolePoint(map.x , map.y);
			}
		}
	}
	else
	{
		_mapModel.mapVo = MapsManager.inst.getMaps(mapId);
		changeMainMinFuncPanel();
		changeMainTaskPanel();
		MainUI.inst.leaderPanel.stageClickHandle();
		switch(_mapModel.mapVo.type)
		{	
			// 场景地图
			case MapTypeDict.NORMAL_MAP:
				NoticeUI.inst.visible = true;
				this.showScene();
				break;
			case MapTypeDict.HURLDE_MAP:
				NoticeUI.inst.visible = false;
				this.showHurdleMap();
				break;
			case MapTypeDict.GLOBAL_MAP:
				NoticeUI.inst.visible = false;
				this.showGlobalMap();
				break;
		}
	}
}


/**
 * 显示战斗视图
 */
public function showBattle():void
{
	//关闭寻路动画
	NoticeUI.inst.setPathingItem(false);
	// 关闭所有窗口
	WindowManager.inst.closeAllWindow();
	// 停止场景渲染
	currentView.stopRender();
	
	// 关闭飘字
	GameItemEffect.inst.stop();
	FloatTips.inst.stop();
	
	// 还原鼠标
	CursorManager.cursorType = CursorManager.ARROW;
	
	if(battleView == null)
	{	
		BattleDataCenter.instance.mainUI = MainUI.inst;
		BattleDataCenter.instance.chatView = ChatView.inst;
		
		battleView = new BattleView();
	}
	
	// 战斗场景切换，先复制当前场景
	BattleChange.inst.play(this , 0 , 20 , newBattle);
	
	function newBattle():void
	{
		// 退出所有全屏玩法
		hideFullScreenView();
		// 隐藏之前的视图
		currentView.setVisible(false);
		// 隐藏主UI
		MainUI.inst.visible = false;
		//隐藏提示层
		NoticeUI.inst.visible = false;
		viewUI.addChild(battleView);
		
		
		// 初始化一场新的战斗
		battleView.newGame();
	}
	
	// TO TEST：消息挂起，不再处理消息
	GameService.instance.pending = true;
}

/**
 * 退出战斗视图
 */
public function hideBattle():void
{
	// 重新开启物品飘字
	GameItemEffect.inst.start();
	FloatTips.inst.start();
	
	// 战斗状态
	GameData.inst.isBattle = false;
	
	viewUI.removeChild(battleView);
	currentView.setVisible(true);
	currentView.playMusic();

	// 显示主UI
	MainUI.inst.visible = true;
	//显示提示层
//	NoticeUI.inst.visible = true;
	// TO TEST：取消消息挂起，继续处理消息
	GameService.instance.pending = false;
	
	// 非战报回放
	if(LastBattleData.isReport == false)
	{
		var battleType:int = LastBattleData.battleType;
		var result:BattleResult = LastBattleData.battleResult;
		if(result)
		{
			// 若战斗失败,弹出失败引导
			if(result.win == false && LastBattleData.replayID == null)
			{
				
			}
			else
			{
				// 剧情副本
				if(battleType == PRO_BattleType.BATTLE_HURDLE && result.win == true)
				{
					var hurdleView:HurdleSceneView = (currentView as HurdleSceneView);
					// 进入下一波 并判断是否第一次过关可以获得命魂
					hurdleView.setNextWave(LastBattleData.isFirstBattle == true);
				}
			}
		}
		
		// 根据战斗类型特殊处理
		switch(battleType)
		{
			// 竞技场
			case PRO_BattleType.BATTLE_ARENA:
				MainUI.inst.openWindow(WindowEvent.ARENA_WINDOW);
				break;
		}
	}
	
	// 触发剧情
	var endDrama:int = BattleUnitManager.inst.getEndDrama(LastBattleData.battleID);
	if(endDrama > 0)
	{
		DramaManager.inst.playDrama(endDrama);
	}
}




/**
 * 显示全屏玩法视图
 * */
public function showFullScreenView(type:String):void
{
	// 打开全屏玩法前先关闭所有窗口
	WindowManager.inst.closeAllWindow();
	
	if(fullScreenView)
	{
		viewUI.removeChild(fullScreenView);
	}
	
	switch(type)
	{
		case WindowEvent.ARENA_WINDOW:
			fullScreenView = ArenaView.inst;
			break;
		case WindowEvent.ROLESKILL_VIEW:
			fullScreenView = RoleSkillView.inst;
			break;
	}
	
	viewUI.addChild(fullScreenView);
	
	// 只显示需要的UI组件
	MainUI.inst.displayType = type;
	
	// 隐藏地图场景
	currentView.setVisible(false);
	
	NoticeUI.inst.setPathingItem(false);
}





/**
 * 关闭屏玩法视图
 * */
public function hideFullScreenView():void
{
	if(fullScreenView)
	{
		viewUI.removeChild(fullScreenView);
	}
	fullScreenView = null;
	
	// 还原MainUI显示
	MainUI.inst.displayType =_mapModel.mapVo.type;
	
	// 还原地图场景
	currentView.setVisible(true);
}





/**
 * 显示场景视图
 */
private function showScene():void
{
	sceneView = new SceneView();
	this.setCurrentView(sceneView);
}
/**
 * 显示副本场景视图
 */
private function showHurdleMap():void
{
	hurdleMapView = new HurdleSceneView();
	this.setCurrentView(hurdleMapView);
}

/**
 * 显示大地图
 */
private function showGlobalMap():void
{
	// 隐藏主UI
	MainUI.inst.visible = false;
	golbalMapView = new GlobalSceneView();
	this.setCurrentView(golbalMapView);
}

/**
 * 更改右上显示试图
 */
private function changeMainMinFuncPanel():void
{
	MainUI.inst.miniFuncPanel.setBtnList();
}

private function changeMainTaskPanel():void
{
	MainUI.inst.taskPanel.changeView();
}


/**
 * 设置当前的场景
 * 
 */
private function setCurrentView(value:SceneViewBase):void
{
	// TRICKY：先移除，为了触发Mediataor的destroy()方法，清除原来的地图
	if(currentView != null && viewUI.contains(currentView) == true)
	{
		viewUI.removeChild(currentView);
		currentView = null;
	}
	
	currentView = value;
	viewUI.addChild(currentView);
}


