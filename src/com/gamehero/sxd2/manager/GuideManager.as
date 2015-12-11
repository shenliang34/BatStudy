package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.guide.script.Guide_10001;
	import com.gamehero.sxd2.guide.script.Guide_10002;
	import com.gamehero.sxd2.guide.script.Guide_10003;
	import com.gamehero.sxd2.guide.script.Guide_10011;
	import com.gamehero.sxd2.guide.script.Guide_10012;
	import com.gamehero.sxd2.guide.script.Guide_10013;
	import com.gamehero.sxd2.guide.script.Guide_10014;
	import com.gamehero.sxd2.guide.script.Guide_10015;
	import com.gamehero.sxd2.guide.script.Guide_10016;
	import com.gamehero.sxd2.guide.script.Guide_10021;
	import com.gamehero.sxd2.guide.script.Guide_10022;
	import com.gamehero.sxd2.guide.script.Guide_10031;
	import com.gamehero.sxd2.guide.script.Guide_10032;
	import com.gamehero.sxd2.guide.script.Guide_11001;
	import com.gamehero.sxd2.guide.script.Guide_11002;
	import com.gamehero.sxd2.guide.script.Guide_11003;
	import com.gamehero.sxd2.guide.script.Guide_12001;
	import com.gamehero.sxd2.guide.script.Guide_13001;
	import com.gamehero.sxd2.guide.script.Guide_20001;
	import com.gamehero.sxd2.guide.script.Guide_20002;
	import com.gamehero.sxd2.guide.script.Guide_20003;
	import com.gamehero.sxd2.guide.script.Guide_20004;
	import com.gamehero.sxd2.guide.script.Guide_30001;
	import com.gamehero.sxd2.guide.script.Guide_30002;
	import com.gamehero.sxd2.guide.script.Guide_30003;
	import com.gamehero.sxd2.guide.script.Guide_30005;
	import com.gamehero.sxd2.guide.script.Guide_30011;
	import com.gamehero.sxd2.guide.script.Guide_30012;
	import com.gamehero.sxd2.guide.script.Guide_30013;
	import com.gamehero.sxd2.guide.script.Guide_30014;
	import com.gamehero.sxd2.guide.script.Guide_40001;
	import com.gamehero.sxd2.guide.script.Guide_40002;
	import com.gamehero.sxd2.guide.script.Guide_40003;
	import com.gamehero.sxd2.guide.script.Guide_40004;
	import com.gamehero.sxd2.guide.script.Guide_40100;
	import com.gamehero.sxd2.guide.script.Guide_40101;
	import com.gamehero.sxd2.guide.script.Guide_40102;
	import com.gamehero.sxd2.guide.script.Guide_40103;
	import com.gamehero.sxd2.guide.script.Guide_40104;
	import com.gamehero.sxd2.guide.script.Guide_40105;
	import com.gamehero.sxd2.guide.script.Guide_50001;
	import com.gamehero.sxd2.guide.script.Guide_60001;
	import com.gamehero.sxd2.guide.script.Guide_80001;
	import com.gamehero.sxd2.guide.script.Guide_80002;
	import com.gamehero.sxd2.guide.script.Guide_80003;
	import com.gamehero.sxd2.guide.script.Guide_90001;
	import com.gamehero.sxd2.guide.script.Guide_90003;
	import com.gamehero.sxd2.guide.script.Guide_90004;
	import com.gamehero.sxd2.guide.script.Guide_90005;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	
	/**
	 * 新手引导管理器 
	 * @author xuwenyi
	 */	
	public class GuideManager extends EventDispatcher
	{
		private static var _instance:GuideManager;
		
		private var GUIDES:Dictionary;//引导信息
		
		
		
		/**
		 * 构造函数
		 * */
		public function GuideManager()
		{
			GUIDES = new Dictionary;
			
			init(GameSettings.instance.settingsXML.guide[0]);

		}
		
		
		
		public static function get instance():GuideManager
		{
			return _instance ||= new GuideManager()
		}
		
		
		
		public function init(xml:XML):void
		{
			var i:int=0;
			var xmlList:XMLList = xml.guideitem;
			var len:int = xmlList.length();
			for(i=0;i<len;i++)
			{
				var vo:GuideVO = new GuideVO;
				vo.fromXML(xmlList[i]);
				
				GUIDES[vo.id] = vo;
			}
			
			Guide_10001;
			Guide_10002;
			Guide_10003;
			Guide_10011;
			Guide_10012;
			Guide_10013;
			Guide_10014;
			Guide_10015;
			Guide_10016;
			Guide_10021;
			Guide_10022;
			Guide_10031;
			Guide_10032;
			Guide_20001;
			Guide_20002;
			Guide_20003;
			Guide_20004;
			Guide_30001;
			Guide_30002;
			Guide_30003;
			//Guide_30004;
			Guide_30005;
			Guide_30011;
			Guide_30012;
			Guide_30013;
			Guide_30014;
			Guide_40001;
			Guide_40002;
			Guide_40003;
			Guide_40004;
			Guide_40100;
			Guide_40101;
			Guide_40102;
			Guide_40103;
			Guide_40104;
			Guide_40105;
			Guide_50001;
			Guide_60001;
			//Guide_70001;
			//Guide_70002;
			Guide_80001;
			Guide_80002;
			Guide_80003;
			Guide_90001;
			//Guide_90002;
			Guide_90003;
			Guide_90004;
			Guide_90005;
			Guide_11001;
			Guide_11002;
			Guide_11003;
			Guide_12001;
			Guide_13001;
		}
		
		
		
		
		/**
		 *注册引导类 
		 */		
		protected function registerGuide(id:uint , guideClass:Class):void
		{
			(_guideLib[id] as GuideVO).guide = guideClass;
		}
		
		
		
		
		
		
		/**
		 *更新状态 
		 */		
		public function updateStatus(listInfo:GS_UserGuids_Pro):void
		{
			for each(var info:GS_Guid_Pro in listInfo.guid)
			{
				var guideInfo:GuideVO = (_guideLib[info.guidId] as GuideVO);
				if(guideInfo)
					guideInfo.isPlay = info.status;
			}
		}
		
		
		
		
		
		
		/**
		 * 播放引导 
		 */		
		public function playGuide(guideId:uint, callBack:Function = null, param:Object = null):void
		{
			var vo:GuideVO = (GUIDES[guideId] as GuideVO);

			if(vo.isCloseAllWindow)
			{	
				// 关闭所有窗口
				WindowManager.inst.closeAllWindow();
			}
			
			var guide:Guide = new guideInfo.guide;
			guide.playGuide(vo, callBack, param);
		}
		
		
		
		
		
		/**
		 *新手引导是否播放 
		 */		
		public function hasPlayed(guideId:uint):Boolean
		{
			return (GUIDES[guideId] as GuideVO).isPlay;
		}
		
		
		
		
		
		/**
		 * 获取引导参数
		 * */
		public function getGuideVO(id:uint):GuideVO
		{
			return GUIDES[id] as GuideVO;
		}
		
		
		
		
		
		/**
		 * 完成所有现有引导
		 * */
		public function completeAllGuides(param:Object = null):void
		{
			this.dispatchEvent(new GuideEvent(GuideEvent.GUIDE_COMPLETE , param));
		}
		
	}
}