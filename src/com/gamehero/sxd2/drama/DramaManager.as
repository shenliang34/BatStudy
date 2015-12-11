package com.gamehero.sxd2.drama
{
    import com.gamehero.sxd2.core.GameSettings;
    import com.gamehero.sxd2.drama.base.BaseCmd;
    import com.gamehero.sxd2.drama.cmds.LoadCmd;
    import com.gamehero.sxd2.drama.cmds.ParallelCmd;
    import com.gamehero.sxd2.drama.cmds.PlayMovieCmd;
    import com.gamehero.sxd2.drama.cmds.camera.CameraFocusCmd;
    import com.gamehero.sxd2.drama.cmds.camera.LocalCameraCmd;
    import com.gamehero.sxd2.drama.cmds.camera.MoveCameraCmd;
    import com.gamehero.sxd2.drama.cmds.dialog.BlackStoryCmd;
    import com.gamehero.sxd2.drama.cmds.dialog.DialogCmd;
    import com.gamehero.sxd2.drama.cmds.dialog.GossipCmd;
    import com.gamehero.sxd2.drama.cmds.dialog.ThinkCmd;
    import com.gamehero.sxd2.drama.cmds.effect.ClickEffectCmd;
    import com.gamehero.sxd2.drama.cmds.effect.EffectCmd;
    import com.gamehero.sxd2.drama.cmds.effect.ShakeEffectCmd;
    import com.gamehero.sxd2.drama.cmds.npc.CreateNPCCmd;
    import com.gamehero.sxd2.drama.cmds.npc.DestoryNPCCmd;
    import com.gamehero.sxd2.drama.cmds.npc.EffectInNPCCmd;
    import com.gamehero.sxd2.drama.cmds.npc.LocalNPCCmd;
    import com.gamehero.sxd2.drama.cmds.npc.MoveNPCCmd;
    import com.gamehero.sxd2.drama.cmds.npc.RemoveDecoCmd;
    import com.gamehero.sxd2.drama.cmds.npc.SetNPCRunStatusCmd;
    import com.gamehero.sxd2.drama.cmds.npc.SetNPCStatusCmd;
    import com.gamehero.sxd2.drama.cmds.npc.SetNpcVisibleCmd;
    import com.gamehero.sxd2.drama.cmds.scene.ChangeMapCmd;
    import com.gamehero.sxd2.drama.cmds.scene.CreateBattleCmd;
    import com.gamehero.sxd2.drama.cmds.scene.EnterHurdleCmd;
    import com.gamehero.sxd2.drama.cmds.user.LocalUserCmd;
    import com.gamehero.sxd2.drama.cmds.user.MoveUserCmd;
    import com.gamehero.sxd2.drama.cmds.user.SetUserRunStatusCmd;
    import com.gamehero.sxd2.drama.cmds.user.SetUserStatusCmd;
    import com.gamehero.sxd2.drama.cmds.user.SetUserVisibleCmd;
    import com.gamehero.sxd2.pro.MSGID;
    import com.gamehero.sxd2.pro.MSG_PLAY_DRAMA_REQ;
    import com.gamehero.sxd2.pro.PRO_Drama;
    import com.gamehero.sxd2.services.GameService;
    import com.gamehero.sxd2.vo.DramaConditionVO;
    
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    
    import bowser.logging.Logger;
    import bowser.utils.data.Group;
	
	
	
	/**
	 * 剧情脚本管理 
	 */	
	public class DramaManager extends EventDispatcher
	{
		
		/**
		 *触发类型 
		 */		
		public static const TriggerType_Null:String = "null";
		
		private static var _instance:DramaManager;
		
		// 已播放过的剧情列表
		public var playedDramas:Group;
		
		// 触发器类库 
		private var scriptTriggerLib:Dictionary;
		// 脚本命令库 
		private var cmdLib:Dictionary;
		// 脚本库 
		private var scriptLib:Dictionary;
		// 剧情触发条件配置
		private var conditionLib:Dictionary;
		
		// 当前执行的剧情脚本
		private var currentDrama:Drama;
		
		
		
		
		
		public function DramaManager()
		{
			super(this);
			
			cmdLib 	= new Dictionary;
			scriptLib = new Dictionary;
			conditionLib = new Dictionary;
			
			// 注册脚本命令
			registerCmd("cameraFocus", CameraFocusCmd);
			registerCmd("moveCamera", MoveCameraCmd);
			registerCmd("localCamera", LocalCameraCmd);
			
			registerCmd("createNPC", CreateNPCCmd);
			registerCmd("destoryNPC", DestoryNPCCmd);
			registerCmd("localNPC", LocalNPCCmd);
			registerCmd("moveNPC", MoveNPCCmd);
			registerCmd("setNpcVisible", SetNpcVisibleCmd);
			registerCmd("setNPCStatus", SetNPCStatusCmd);
			registerCmd("effectInNPC", EffectInNPCCmd);
			registerCmd("removeDeco", RemoveDecoCmd);
			registerCmd("setNPCRunStatus", SetNPCRunStatusCmd);
			
			registerCmd("localUser", LocalUserCmd);
			registerCmd("moveUser", MoveUserCmd);
			registerCmd("setUserVisible", SetUserVisibleCmd);
			registerCmd("setUserStatus", SetUserStatusCmd);
			registerCmd("setUserRunStatus", SetUserRunStatusCmd);
			
			//registerCmd("setPlayerVisible", SetPlayerVisibleCmd);
			
			registerCmd("dialog", DialogCmd);
			registerCmd("blackStory", BlackStoryCmd);
			registerCmd("gossip", GossipCmd);
			registerCmd("think", ThinkCmd);
			
			registerCmd("load" , LoadCmd);
			registerCmd("parallel", ParallelCmd);
			registerCmd("effect", EffectCmd);
			registerCmd("playMovie", PlayMovieCmd);
			registerCmd("shakeEffect", ShakeEffectCmd);
			registerCmd("clickEffect", ClickEffectCmd);
			
			registerCmd("enterHurdle", EnterHurdleCmd);
			registerCmd("createBattle", CreateBattleCmd);
			registerCmd("changeMap", ChangeMapCmd);
			
			//registerCmd("showMessage", ShowMessageCmd);
			//registerCmd("playDrama", PlayDramaCmd);
			
			
			//registerCmd("effectToNPC", EffectToNPCCmd);
			//registerCmd("effectInNPC", EffectInNPCCmd);
			//registerCmd("wait", WaitCmd);
			//registerCmd("battle", BattleCmd);
			//registerCmd("battleContinue", BattleContinueCmd);
			//registerCmd("fightDialog", FightDialogCmd);
			//registerCmd("fightAppear", FightAppearCmd);
			//registerCmd("action", ActionCmd);
			//registerCmd("movieInNPC", MovieInNPCCmd);
			//registerCmd("playGuide", PlayGuideCmd);
			//registerCmd("openWindow", OpenWindowCmd);
			
			//registerCmd("removeDeco", RemoveDecoCmd);
			
			//registerCmd("gotoMovie", GotoMovieCmd);
		}
		
		
		
		
		public static function get inst():DramaManager
		{
			return _instance ||= new DramaManager;
		}
		
		
		
		
		
		
		/**
		 * 初始化 
		 */		
		public function init():void
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			
			// 脚本配置
			var xml:XML = settingsXML.drama[0];
			
			var xmlList:XMLList = xml.children();
			var len:int = xmlList.length();
			var id:int;
			for(var i:int = 0; i < len; i++)
			{
				id = xmlList[i].@id;
				scriptLib[id] = xmlList[i];
			}
			
			// 剧情触发条件相关配置
			xml = settingsXML.drama_condition[0];
			len = xmlList.length();
			for(i = 0; i < len; i++)
			{
				id = xmlList[i].@dramaID;
				conditionLib[id] = xmlList[i];
			}
		}
		
		
		
		
		/**
		 * 注册脚本命令 
		 */		
		public function registerCmd(type:String, cla:Class):void
		{
			cmdLib[type] = cla;
		}
		
		
		
		
		/**
		 * 获取脚本命令实例 
		 */		
		public function getCmd(xml:XML):BaseCmd
		{
			var cmd:BaseCmd;
			try
			{
				cmd = new cmdLib[xml.localName()];
				cmd.fromXML(xml);
			}
			catch(e:Error)
			{
				Logger.error(DramaManager, "不存在" + xml.localName() + "剧情命令!");
			}
			
			return cmd;
		}
		
		
		
		
		/**
		 * 根据ID播放剧情脚本 
		 * @param id
		 * @param param
		 * @param callBack 剧情结束后回调
		 */		
		public function playDrama(id:uint, param:Object = null, callBack:Function = null):Drama
		{
			var obj:Object = scriptLib[id];
			if(obj == null)
			{
				Logger.error(DramaManager, "没有该剧情" + id);
				return null;
			}
			
			var drama:Drama;
			// 是否可播放
			if(this.canPlay(id) == true)
			{
				if(obj is XML)
				{
					drama = new Drama();
					drama.fromXML(obj as XML);
					scriptLib[id] = drama;
				}
				else
				{
					drama = obj as Drama;
				}
				
				currentDrama = drama;
				
				drama.startScript(param, null, callBack);
				
				//标记此剧情已播放过
				this.setDramaPlayed(id);
			}
			return drama;
		}
		
		
		
		
		
		
		
		
		/**
		 * 根据condition播放剧情
		 */		
		public function playDrama2(condition:String , param:Object = null, callBack:Function = null):void
		{
			var vo:DramaConditionVO;
			var obj:Object = conditionLib[condition];
			if(obj is XML)
			{
				vo = new DramaConditionVO();
				vo.fromXML(obj as XML);
				conditionLib[condition] = vo;
			}
			else
			{
				vo = obj as DramaConditionVO;
			}
			
			if(vo)
			{
				this.playDrama(vo.dramaID , param , callBack);
			}
		}
		
		
		
		
		
		
		/**
		 * 标记此剧情已播放过
		 * */
		private function setDramaPlayed(id:int):void
		{
			var proDrama:PRO_Drama = playedDramas.getChildByParam("id" , id) as PRO_Drama;
			if(proDrama)
			{
				proDrama.playedNum += 1;
			}
			else
			{
				// 此剧情没有播放过,创建一个新的
				proDrama = new PRO_Drama();
				proDrama.id = id;
				proDrama.playedNum = 1;
				playedDramas.add(proDrama);
			}
			
			// 在服务器记录此id的剧情已播放过
			var req:MSG_PLAY_DRAMA_REQ = new MSG_PLAY_DRAMA_REQ();
			req.id = id;
			
			GameService.instance.send(MSGID.MSGID_PLAY_DRAMA , req);
		}
		
		
		
		
		
		
		/**
		 * 剧情是否可以播放 
		 */
		public function canPlay(id:uint):Boolean
		{
			// 获取剧情触发条件vo
			var obj:Object = conditionLib[id];
			if(obj == null)
			{
				return true;
			}
			
			var condition:DramaConditionVO;
			if(obj is XML)
			{
				condition = new DramaConditionVO();
				condition.fromXML(obj as XML);
				conditionLib[id] = condition;
			}
			else
			{
				condition = obj as DramaConditionVO;
			}
			
			// 无限次播放
			if(condition.rate == 0)
			{
				return true;
			}
			
			var proDrama:PRO_Drama = playedDramas.getChildByParam("id" , id) as PRO_Drama;
			if(proDrama)
			{
				if(proDrama.playedNum >= condition.rate)
				{
					Logger.warn(DramaManager , "该剧情已超过播放次数限制! id = " + id);
					return false;
				}
			}
			
			return true;
		}
		
		
		
		
		
		/**
		 * 立即结束当前执行的剧情脚本 
		 */		
		public function skip():void
		{
			if(currentDrama)
			{
				currentDrama.skipScript();
			}
		}
		
	}
}