package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_BREAK_REQ;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_ENABLE_REQ;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_RWD_REQ;
	import com.gamehero.sxd2.services.GameService;
	
	import bowser.remote.RemoteResponse;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-2 下午6:06:56
	 * 
	 */
	public class HeroHandbookWindowMediator extends Mediator
	{
		[Inject]
		public var view:HeroHandbookWindow
		
		public function HeroHandbookWindowMediator()
		{
			super();
		}
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			//图鉴分解
			this.addViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_BREAK,onReqBreak);
			//图鉴激活
			this.addViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_ENABLE,onReqActive);
			//领取奖励
			this.addViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_RWD,onReqRwd);
			
		}
		
		/**
		 * destory
		 */
		override public function destroy():void
		{
			//图鉴分解
			this.removeViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_BREAK,onReqBreak);
			//图鉴激活
			this.removeViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_ENABLE,onReqActive);
			//领取奖励
			this.removeViewListener(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_RWD,onReqRwd);
		}
		/**============================================================================================*/
		/**
		 * 图鉴分解
		 * */
		private function onReqBreak(evt:HeroHandbookEvent):void
		{
			var msg:MSG_PHOTOAPPRAISAL_BREAK_REQ = evt.data as MSG_PHOTOAPPRAISAL_BREAK_REQ;
			GameService.instance.send(MSGID.MSGID_PHOTO_APPRAISAL_BREAK,msg,onRepBreak);
		}
		
		/**
		 * 图鉴分解
		 * */
		private function onRepBreak(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view._heroBookPanel.updata();
				view._heroFigurePanel.upDataSoulNum();
			}
		}
		
		/**============================================================================================*/
		/**
		 * 图鉴激活
		 * */
		private function onReqActive(evt:HeroHandbookEvent):void
		{
			var msg:MSG_PHOTOAPPRAISAL_ENABLE_REQ = new MSG_PHOTOAPPRAISAL_ENABLE_REQ();
			msg.id = int(evt.data);
			GameService.instance.send(MSGID.MSGID_PHOTO_APPRAISAL_ENABLE,msg,onRepActive);
		}
		
		/**
		 * 图鉴激活
		 * */
		private function onRepActive(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view._heroBookPanel.updata();
				view._heroMoviePanel.show();
			}
		}
		
		
		/**============================================================================================*/
		/**
		 * 领取奖励
		 * */
		private function onReqRwd(evt:HeroHandbookEvent):void
		{
			var msg:MSG_PHOTOAPPRAISAL_RWD_REQ = evt.data as MSG_PHOTOAPPRAISAL_RWD_REQ;
			GameService.instance.send(MSGID.MSGID_PHOTO_APPRAISAL_RWD,msg,onRepRwd);
		}
		/**
		 * 领奖返回
		 * */
		private function onRepRwd(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				view._heroBookPanel.setProgress();																																																						
			}
		}
		
	}
}