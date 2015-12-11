package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.BuffVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * buff配置表管理
	 * @author xuwenyi
	 * @create 2013-12-06
	 **/
	public class BuffManager
	{
		private static var _instance:BuffManager;
		
		private var BUFF:Dictionary = new Dictionary();
		private var buffXMLList:XMLList;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BuffManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.buffXMLList = settingsXML.buff.buff;
		}
		
		
		
		
		public static function get instance():BuffManager {
			
			return _instance ||= new BuffManager();
		}
		
		
		
		
		
		/**
		 * 获取某个buff数据
		 * */
		public function getBuff(id:String):BuffVO
		{
			var buffVO:BuffVO = BUFF[id];
			if(buffVO == null)
			{
				var x:XML = GameTools.searchXMLList(buffXMLList , "buffId" , id);
				if(x)
				{
					buffVO = new BuffVO();
					buffVO.buffId = x.@buffId;
					//buffVO.maxoverLay = x.@maxoverLay;
					buffVO.cname = Lang.instance.trans(x.@cname);
					buffVO.description = Lang.instance.trans(x.@description);
					buffVO.buffClass = x.@buffClass;
					buffVO.expireType = x.@expireType;
					//buffVO.expireValue = x.@expireValue;
					//buffVO.effect = x.@effect;
					buffVO.Bufficon = x.@Bufficon;
					buffVO.efURL = x.@efURL;
					buffVO.displayType = x.@displayType;
					buffVO.displayPos = x.@displayPos;
					buffVO.isStopAction = x.@isStopAction;
					buffVO.cannotUseSkill = x.@cannotUseSkill;
					buffVO.priority = x.@priority;
					buffVO.isHide = x.@isHide;
					
					BUFF[buffVO.buffId] = buffVO;
				}
				else
				{
					Logger.warn(BuffManager , "找不到buff , id = " + id);
				}
			}
			return buffVO;
		}
	}
}