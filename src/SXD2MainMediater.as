package
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.LastBattleData;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.SXD2MainEvent;
	import com.gamehero.sxd2.gui.GlobalAlert;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.JSManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_BATTLE_CD_TIME_ACK;
	import com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_ACK;
	import com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_REQ;
	import com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_ACK;
	import com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_REQ;
	import com.gamehero.sxd2.pro.MSG_MAP_ENTER_REQ;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.event.GameServiceEvent;
	import com.gamehero.sxd2.util.Time;
	
	import flash.utils.ByteArray;
	
	import bowser.remote.RemoteResponse;
	import bowser.utils.time.TimeTick;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-22 下午9:46:32
	 * 
	 */
	public class SXD2MainMediater extends Mediator
	{
		[Inject]
		public var view:SXD2Main;
		
		private var gameService:GameService;
		private var mapInfo:PRO_Map; //地图数据
		
		
		public function SXD2MainMediater()
		{
			super();
			
			gameService = GameService.instance;
		}
		
		
		
		
		override public function initialize():void
		{
			super.initialize();
			
			this.addViewListener(SXD2MainEvent.ENTER_MAP , onEnterMapReq);
			this.addViewListener(SXD2MainEvent.LEAVE_MAP , onLeaveMapReq);
			this.addViewListener(SXD2MainEvent.BATTLE_CREATE , battleCreate);
			this.addViewListener(SXD2MainEvent.BATTLE_REPORT , battleReport);
			
			//监听进入战斗响应
			gameService.addEventListener(MSGID.MSGID_BATTLE_CREATE.toString() , onBattleCreate);
			gameService.addEventListener(MSGID.MSGID_BATTLE_CD_TIME.toString() , onBattleCD);
			
			gameService.addEventListener(GameServiceEvent.ERRCODE , onShowErrcode);
			gameService.addEventListener(GameServiceEvent.CONNECT_ERROR , onConnectError);
		}
		
		
		
		
		
		/**
		 * 发起战斗
		 * */
		private function battleCreate(e:SXD2MainEvent):void
		{
			var req:MSG_BATTLE_CREATE_REQ = e.data as MSG_BATTLE_CREATE_REQ;
			gameService.send(MSGID.MSGID_BATTLE_CREATE , req);
		}
		
		
		
		
		/**
		 * 战斗响应
		 * */
		private function onBattleCreate(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			var protoBytes:ByteArray = response.protoBytes;
			if(response.errcode == "0" && protoBytes != null)
			{
				// 保存这场战斗2进制数据
				LastBattleData.protoBytes = Global.instance.cloneByteArray(protoBytes);
				LastBattleData.isReport = false;
				
				var ack:MSG_BATTLE_CREATE_ACK = new MSG_BATTLE_CREATE_ACK();
				ack.mergeFrom(protoBytes);
				// 打印此次数据
				gameService.debug(response , ack);
				
				// 保存战斗数据
				var dataCenter:BattleDataCenter = BattleDataCenter.instance;
				dataCenter.saveDetailInfo(ack.detail);
				dataCenter.isReplay = false;
				
				// 进入战斗
				view.showBattle();
			}
		}
		
		
		
		
		
		/**
		 * 观看一场战报
		 * */
		private function battleReport(e:SXD2MainEvent):void
		{
			var req:MSG_BATTLE_REPORT_REQ = e.data as MSG_BATTLE_REPORT_REQ;
			gameService.send(MSGID.MSGID_BATTLE_REPORT , req , onBattleReport);
		}
		
		
		
		
		
		
		
		/**
		 * 战斗响应
		 * */
		private function onBattleReport(response:RemoteResponse):void
		{
			var protoBytes:ByteArray = response.protoBytes;
			if(response.errcode == "0" && protoBytes != null)
			{
				// 保存这场战斗2进制数据
				LastBattleData.protoBytes = Global.instance.cloneByteArray(protoBytes);
				LastBattleData.isReport = true;
				
				var ack:MSG_BATTLE_REPORT_ACK = new MSG_BATTLE_REPORT_ACK();
				ack.mergeFrom(protoBytes);
				// 打印此次数据
				gameService.debug(response , ack);
				
				// 保存战斗数据
				var dataCenter:BattleDataCenter = BattleDataCenter.instance;
				dataCenter.saveDetailInfo(ack.detail);
				dataCenter.isReplay = true;
				
				// 进入战斗
				view.showBattle();
			}
		}
		
		
		
		
		
		
		
		/**
		 * 战斗cd中
		 * */
		private function onBattleCD(e:GameServiceEvent):void
		{
			var response:RemoteResponse = e.data as RemoteResponse;
			var protoBytes:ByteArray = response.protoBytes;
			if(response.errcode == "0" && protoBytes != null)
			{
				var ack:MSGID_BATTLE_CD_TIME_ACK = new MSGID_BATTLE_CD_TIME_ACK();
				ack.mergeFrom(protoBytes);
				// 打印此次数据
				gameService.debug(response , ack);
				
				var cd:int = ack.time - TimeTick.inst.getCurrentTime2();
				if(cd > 0)
				{
					GameData.inst.isBattle = false;
					
					DialogManager.inst.showPrompt("战斗CD中  " + Time.getStringTime1(cd));
				}
			}
		}
		
		
		
		
		
		
		
		/**
		 * 进入场景 
		 * @param event
		 * 
		 */	
		public function onEnterMapReq(event:SXD2MainEvent):void
		{
			var enterReq:MSG_MAP_ENTER_REQ = new MSG_MAP_ENTER_REQ();
			mapInfo = event.data as PRO_Map;
			
			if(mapInfo == null)
			{
				mapInfo = new PRO_Map();
				mapInfo.id = 10000;
			}
			
			enterReq.map = mapInfo;
			
			GameService.instance.send(MSGID.MSGID_MAP_ENTER,enterReq);
			
		}
		
		
		/**
		 * 离开场景 
		 * @param event
		 * 
		 */		
		protected function onLeaveMapReq(event:SXD2MainEvent):void
		{
			GameService.instance.send(MSGID.MSGID_MAP_LEAVE);
		}

		
		
		
		
		/**
		 * 显示errcode
		 * */
		private function onShowErrcode(e:GameServiceEvent):void
		{
			var errcode:String = e.data as String;
			DialogManager.inst.showWarning(errcode);
		}
		
		
		
		
		
		
		/**
		 * 服务器连接失败
		 * */
		private function onConnectError(e:GameServiceEvent):void
		{
			DialogManager.inst.show("服务器无法连接，请稍后再试。", GlobalAlert.OK, refreshGame);
			
			// 刷新浏览器
			function refreshGame():void
			{
				JSManager.refreshGame();
			}
		}
		
	}
}