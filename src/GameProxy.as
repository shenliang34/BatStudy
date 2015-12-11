package
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.gui.heroHandbook.HerohandbookModel;
	import com.gamehero.sxd2.gui.main.MainTaskPanel;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.player.hero.event.HeroEvent;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.roleSkill.RoleSkillView;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.manager.MailManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.CHAR_ID_INFO;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_ENTER_GAME_ACK;
	import com.gamehero.sxd2.pro.MSG_ENTER_GAME_REQ;
	import com.gamehero.sxd2.pro.MSG_FUNCTION_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_GAME_CONFIG_REQ;
	import com.gamehero.sxd2.pro.MSG_HREO_BATTLE_ACK;
	import com.gamehero.sxd2.pro.MSG_ITEM_USE_REQ;
	import com.gamehero.sxd2.pro.MSG_MAP_ENTER_ACK;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_ACK;
	import com.gamehero.sxd2.pro.MSG_SYS_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_FORMATION_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ITEM_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_MAIL_NUM_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_PLAYER_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_QUICK_BUY_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_SKILL_ACK;
	import com.gamehero.sxd2.pro.MSG_UPDATE_TASK_ACK;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.netease.protobuf.UInt64;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import bowser.remote.RemoteResponse;
	import bowser.utils.data.Group;
	import bowser.utils.time.TimeTick;
	import com.gamehero.sxd2.pro.PRO_FunctionInfo;

	/**
	 * 全局的一些接口处理
	 * @author weiyanyu
	 * 创建时间：2015-8-12 下午6:32:18
	 * 
	 */
	public class GameProxy extends EventDispatcher
	{
		private static var _instance:GameProxy;
		
		private var _gameService:GameService;
		
		
		
		public function GameProxy()
		{
			_gameService = GameService.instance;
			_gameService.addEventListener(MSGID.MSGID_UPDATE_ITEM.toString() , onUpdataBag);//道具更新
			_gameService.addEventListener(MSGID.MSGID_UPDATE_TASK.toString(),updataTaskHandle);//任务数据更新
			_gameService.addEventListener(MSGID.MSGID_MAP_ENTER.toString(),onEnterMapRspd);
			_gameService.addEventListener(MSGID.MSGID_FUNCTION_INFO.toString(),updateFunctionInfo);//功能开放
			_gameService.addEventListener(MSGID.MSGID_UPDATE_MAIL_NUM.toString(),updateMailNumHandle);//邮件数量
			_gameService.addEventListener(MSGID.MSGID_UPDATE_PLAYER.toString(),updataPlayerHandle);//玩家数据更新
			_gameService.addEventListener(MSGID.MSGID_UPDATE_SKILL.toString(),updataSkillHandle);//玩家技能更新	
			_gameService.addEventListener(MSGID.MSGID_PHOTO_APPRAISAL_INFO.toString() , upDataHeroHandbook);//伙伴图鉴信息更新
			_gameService.addEventListener(MSGID.MSGID_FORMATION_INFO.toString(), upDataHeroInfo);//所有伙伴信息 包括布阵
			_gameService.addEventListener(MSGID.MSGID_FORMATION_PUT_HERO.toString(), upDataHeroInfo);//上阵伙伴变化
			
			_gameService.addEventListener(MSGID.MSGID_HREO_BATTLE.toString(),ackHeroBattleList);//当前上阵的伙伴信息
			_gameService.addEventListener(MSGID.MSGID_UPDATE_QUICK_BUY.toString(),updateQuickBuyHandle);//当前上阵的伙伴信息
		}
		
		public static function get inst():GameProxy
		{
			return _instance ||= new GameProxy();
		}
		
		
		
		
		/**
		 * 进入游戏，获取用户总信息
		 * */
		public function enterGame(callback:Function):void
		{
			var req:MSG_ENTER_GAME_REQ = new MSG_ENTER_GAME_REQ();
			// TO DO: 当前只有一个角色, 因此取第一个角色（今后跨服有多个角色时需要修改）
			req.charID =( SXD2Game.instance.existCharList[0] as CHAR_ID_INFO).charID;
			
			_gameService.send(MSGID.MSGID_ENTER_GAME , req, onEnterGame);
			
			function onEnterGame(response:RemoteResponse):void
			{
				var ack:MSG_ENTER_GAME_ACK = new MSG_ENTER_GAME_ACK();
				ack.mergeFrom(response.protoBytes);
				_gameService.debug(response , ack);
				
				//保存用户信息
				GameData.inst.roleInfo = ack.player;
				//保存剧情配置
				DramaManager.inst.playedDramas = new Group(ack.dramas);

				//保存开放的功能
				
				// TO TEST BENGIN: 暂时开放所有功能
				ack.functions = new Array();
				var funcs:Array = [10010,10020,10030,10040,10050,10060,20010,20020,30010];
				var func:PRO_FunctionInfo;
				for (var i:int = 0; i < funcs.length; i++) {
					
					func = new PRO_FunctionInfo();
					func.id = funcs[i];
					func.isOpen = true;
					ack.functions.push(func);
				}
				// TO TEST END
				GameData.inst.functions = ack.functions;
				
				
				//保存用户配置
				if(ack.gameConfig)
				{
					GameData.inst.gameConfig = JSON.parse(ack.gameConfig);
				}
				
				// 启动更新服务器状态计时器
				var sysInfoTimer:Timer = new Timer(60000);
				sysInfoTimer.addEventListener(TimerEvent.TIMER , checkSysInfo);
				sysInfoTimer.start();
				checkSysInfo();
				
				callback();
				_gameService.send(MSGID.MSGID_HREO_BATTLE);
			}
			
			//请求所有伙伴相关的信息
			_gameService.send(MSGID.MSGID_FORMATION_INFO , null , null);
		}
		
		
		private function ackHeroBattleList(event:GameServiceEvent):void
		{
			var response:RemoteResponse = event.data as RemoteResponse;
			if(response.errcode == "0"&&response.protoBytes)
			{
				var heroListinfo:MSG_HREO_BATTLE_ACK = new MSG_HREO_BATTLE_ACK();
				GameService.instance.mergeFrom(heroListinfo, response.protoBytes);
				//打印此次数据
				GameService.instance.debug(response, heroListinfo);
				//保存后端推送的伙伴列表
				HeroModel.instance.analysis(heroListinfo);
				//刷新面板伙伴信息
				dispatchEvent(new HeroEvent(HeroEvent.HERO_INFO_UPDATA));
			}
		}
		
		
		private function onEnterMapRspd(event:GameServiceEvent):void
		{
			var remote:RemoteResponse = event.data as RemoteResponse;
			if(remote.errcode == "0")
			{
				var mapInfo:MSG_MAP_ENTER_ACK = new MSG_MAP_ENTER_ACK();
				mapInfo.mergeFrom(remote.protoBytes);
				
				// map信息保存到全局
				var map:PRO_Map = mapInfo.map;
				GameData.inst.mapInfo = map;
				// 切换地图
				SXD2Main.inst.changeView(map.id);
			}
		}
		/**
		 * 使用道具 
		 * @param id
		 * @param num
		 * 
		 */		
		public function itemUse(id:UInt64,num:int):void
		{
			var req:MSG_ITEM_USE_REQ = new MSG_ITEM_USE_REQ;
			req.id = id;
			req.num = num;
			_gameService.send(MSGID.MSGID_ITEM_USE,req,itemUseCallBack);
		}
		private function itemUseCallBack(r:RemoteResponse):void
		{
			if(r.errcode == "0")
			{
				//trace("使用成功");
			}
		}	
		
		/**
		 * 更新背包道具 
		 * @param event
		 * 
		 */		
		protected function onUpdataBag(event:GameServiceEvent):void
		{
			var remote:RemoteResponse = event.data as RemoteResponse;
			if(remote.errcode == "0" && event.data.protoBytes!=null)
			{
				var info:MSG_UPDATE_ITEM_ACK = new MSG_UPDATE_ITEM_ACK();
				GameService.instance.mergeFrom(info, event.data.protoBytes);
				// 打印此次数据
				GameService.instance.debug(event.data as RemoteResponse, info);
				BagModel.inst.updata(info);
				dispatchEvent(new BagEvent(BagEvent.ITEM_UPDATA));
			}
		}
		
		/**
		 * 更新任务信息
		 */	
		private function updataTaskHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0" && remote.protoBytes!=null)
			{
				var task:MSG_UPDATE_TASK_ACK = new MSG_UPDATE_TASK_ACK();
				task.mergeFrom(remote.protoBytes);
				GameData.inst.taskList = task.task;
				TaskManager.inst.updataTaskList(task.task);
				MainTaskPanel.inst.initTasksInfoHandle();
			}
		}
		
		
		
		
		/**
		 * 保存游戏全局配置(音乐音效,消费提示等)
		 * */
		public function saveGameConfig(key:String , value:Boolean):void
		{
			var config:Object = GameData.inst.gameConfig;
			config[key] = value;
			
			// 请求保存配置
			var req:MSG_GAME_CONFIG_REQ = new MSG_GAME_CONFIG_REQ();
			req.config = JSON.stringify(config);
			_gameService.send(MSGID.MSGID_GAME_CONFIG , req);
		}
		
		
		
		
		/**
		 * 定时更新服务器状态信息(时间等)
		 * */
		private function checkSysInfo(e:TimerEvent = null):void
		{
			_gameService.send(MSGID.MSGID_SYS_INFO , null , onCheckSysInfo);
		}
		
		
		
		
		private function onCheckSysInfo(response:RemoteResponse):void
		{
			if(response.errcode == "0" && response.protoBytes != null)
			{
				var ack:MSG_SYS_INFO_ACK = new MSG_SYS_INFO_ACK();
				ack.mergeFrom(response.protoBytes);
				
				TimeTick.inst.setServerTime(ack.serverTime);
			}
		}
		
		
		
		
		
		/**
		 * 更新function信息
		 * */
		private function updateFunctionInfo(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes != null)
			{
				var ack:MSG_FUNCTION_INFO_ACK = new MSG_FUNCTION_INFO_ACK();
				ack.mergeFrom(response.protoBytes);
				
				FunctionManager.inst.updateOpenFunction(ack.functions);
			}
		}
		
		/**
		 * 更新邮件数量
		 * */
		private function updateMailNumHandle(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes != null)
			{
				var ack:MSG_UPDATE_MAIL_NUM_ACK = new MSG_UPDATE_MAIL_NUM_ACK();
				ack.mergeFrom(response.protoBytes);
				MailManager.instance.updataMailCount(ack.num);
				if(MainUI.inst.miniFuncPanel)
					MainUI.inst.miniFuncPanel.setMailTips();
			}
			
		}
		
		
		/**
		 * 玩家数据更新
		 */
		private function updataPlayerHandle(e:GameServiceEvent):void
		{
			var remote:RemoteResponse = e.data as RemoteResponse;
			if(remote.errcode == "0" && remote.protoBytes!=null)
			{
				var playerInfo:MSG_UPDATE_PLAYER_ACK = new MSG_UPDATE_PLAYER_ACK();
				playerInfo.mergeFrom(e.data.protoBytes);
				
				_gameService.debug(remote , playerInfo);
				// 保存用户基础属性
				GameData.inst.roleInfo = playerInfo.player;
				if(MainUI.inst.leaderPanel)
					MainUI.inst.leaderPanel.initPlayerInfo();
				if(MainUI.inst.expPanel)
					MainUI.inst.expPanel.initPlayerExpHandle();
				if(MainUI.inst.battlePanel)
					MainUI.inst.battlePanel.bEfAnimation();
			}
		}
		
		/**
		 *玩家技能更新 
		 * @param e
		 * 
		 */		
		private function updataSkillHandle(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes!=null)
			{
				var ack:MSG_UPDATE_SKILL_ACK = new MSG_UPDATE_SKILL_ACK();
				ack.mergeFrom(response.protoBytes);
				
				GameData.inst.roleSkill = ack.skill;
				if(RoleSkillView.inst.skillListPanel)
				{
					RoleSkillView.inst.initWindowInfo();	
				}
					
			}
		}
		
		/**
		 * 所有伙伴信息、包括布阵信息
		 * */
		private function upDataHeroInfo(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes!=null)
			{
				var formationHeros:MSG_UPDATE_FORMATION_ACK = new MSG_UPDATE_FORMATION_ACK();
				formationHeros.mergeFrom(response.protoBytes);
				_gameService.debug(response , formationHeros);
				
				FormationModel.inst.heroList = formationHeros.hero;
				FormationModel.inst.formationList = formationHeros.activeFormationId;
				FormationModel.inst.heroFormation = formationHeros.formation;
			}
			
			if(WindowManager.inst.isWindowOpenedByWindowName(WindowEvent.FORMATION_WINDOW))
			{
				(WindowManager.inst.getWindowInstance(FormationWindow,WindowPostion.CENTER_ONLY) as FormationWindow).update();
			}
		}
		
		/**
		 * 伙伴图鉴信息更新
		 * */
		private function upDataHeroHandbook(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes!=null)
			{
				var ack:MSG_PHOTOAPPRAISAL_ACK = new MSG_PHOTOAPPRAISAL_ACK();
				ack.mergeFrom(response.protoBytes);
				//保存全局的变量
				HerohandbookModel.inst.rwdNum = ack.num;
			}
		}
		
		/**
		 *快速购买 
		 * @param e
		 * 
		 */		
		private function updateQuickBuyHandle(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			if(response.errcode == "0" && response.protoBytes!=null)
			{
				var ack:MSG_UPDATE_QUICK_BUY_ACK = new MSG_UPDATE_QUICK_BUY_ACK();
				ack.mergeFrom(response.protoBytes);
				
				GameData.inst.setBuyItems(ack.items);
			}
		}
	}
}