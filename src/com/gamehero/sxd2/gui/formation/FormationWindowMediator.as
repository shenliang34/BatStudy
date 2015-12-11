package com.gamehero.sxd2.gui.formation
{
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_FORMATION_INFO_REQ;
	import com.gamehero.sxd2.pro.MSG_FORMATION_PUT_HERO_REQ;
	import com.gamehero.sxd2.pro.MSG_LEVELUP_MAGIC;
	import com.gamehero.sxd2.pro.MSG_MAGIC_INFO;
	import com.gamehero.sxd2.pro.MSG_UPDATE_FORMATION_ACK;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-25 下午5:08:34
	 * 
	 */
	public class FormationWindowMediator extends Mediator
	{
		[Inject]
		public var view:FormationWindow;
		
		public function FormationWindowMediator()
		{
			super();
		}
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			this.addViewListener(FormationEvent.MSGID_FORMATION_INFO , formationInfo);
			this.addViewListener(FormationEvent.MSGID_FORMATION_PUT_HERO , putHero);
			
			this.addViewListener(FormationEvent.MSGID_MAGIC_INFO , magicInfo);
			this.addViewListener(FormationEvent.MSGID_LEVELUP_MAGIC , lvlUp);
		}
		
		override public function destroy():void
		{
			this.removeViewListener(FormationEvent.MSGID_FORMATION_INFO , formationInfo);
			this.removeViewListener(FormationEvent.MSGID_FORMATION_PUT_HERO , putHero);
		}
		
		
		
		/**
		 * 获取阵型总数据
		 * */
		private function formationInfo(evt:FormationEvent):void
		{
			if(evt.data)
			{
				var msg:MSG_FORMATION_INFO_REQ = new MSG_FORMATION_INFO_REQ();
				msg.id = (evt.data as MSG_FORMATION_INFO_REQ).id;
			}
			else
			{
				msg = new MSG_FORMATION_INFO_REQ();
				msg.id = 0;
			}
			GameService.instance.send(MSGID.MSGID_FORMATION_INFO , msg , null);
		}
		
		
		
		/**数据返回*/
		private function onFormationInfo(response:RemoteResponse):void
		{
			if(response.errcode == "0" && response.protoBytes)
			{
				var ACK:MSG_UPDATE_FORMATION_ACK = new MSG_UPDATE_FORMATION_ACK();
				GameService.instance.mergeFrom(ACK, response.protoBytes);
				
				FormationModel.inst.heroList = ACK.hero;
				FormationModel.inst.formationList = ACK.activeFormationId;
				FormationModel.inst.heroFormation = ACK.formation;
				//同名伙伴剔除
				/*FormationModel.inst.passSNHero();*/
				//打印此次数据
				GameService.instance.debug(response, ACK);																																																							
				//刷新面板
				/*view.update();*/
			}
			// errcode
			else
			{
				// 出现errcode需要将阵上伙伴还原
				/*view.heroBattlePanel.setDragFigureVisible(true);*/
			}
			
			view.update();
		}
		
		
		
		
		/**
		 * 伙伴上阵
		 * */
		private function putHero(e:FormationEvent):void
		{
			var req:MSG_FORMATION_PUT_HERO_REQ = e.data as MSG_FORMATION_PUT_HERO_REQ;
			GameService.instance.send(MSGID.MSGID_FORMATION_PUT_HERO , req , null);
		}
		
		
		
		/**
		 * 请求奇术信息
		 * */
		private function magicInfo(e:FormationEvent):void
		{
			var req:MSG_MAGIC_INFO = new MSG_MAGIC_INFO();
			req.type = e.data as uint;
			GameService.instance.send(MSGID.MSGID_MAGIC_INFO , req , onMagicInfo);
			
			view.thaumaPanel.upData(req);
		}
		
		/**数据返回*/
		private function onMagicInfo(response:RemoteResponse):void
		{
			if(response.errcode == "0" && response.protoBytes)
			{
				var ACK:MSG_MAGIC_INFO = new MSG_MAGIC_INFO();
				GameService.instance.mergeFrom(ACK, response.protoBytes);
				//打印此次数据
				GameService.instance.debug(response, ACK);	
			}
		}
		
		/**
		 * 升级操作
		 **/
		private function lvlUp(e:FormationEvent):void
		{
			var req:MSG_LEVELUP_MAGIC = e.data as MSG_LEVELUP_MAGIC;
			GameService.instance.send(MSGID.MSGID_LEVELUP_MAGIC , req , onLvlUp);
			view.thaumaPanel.upDataLvl(req);
		}
		
		/**数据返回*/
		private function onLvlUp(response:RemoteResponse):void
		{
			if(response.errcode == "0" && response.protoBytes)
			{
				var ACK:MSG_LEVELUP_MAGIC = new MSG_LEVELUP_MAGIC();
				GameService.instance.mergeFrom(ACK, response.protoBytes);
				
				//打印此次数据
				GameService.instance.debug(response, ACK);	
			}
		}
	}
}