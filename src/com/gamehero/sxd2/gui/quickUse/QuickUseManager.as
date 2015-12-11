package com.gamehero.sxd2.gui.quickUse
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 快捷使用弹窗控制器
	 * @author weiyanyu
	 * 创建时间：2015-11-9 21:06:42
	 * 
	 */
	public class QuickUseManager
	{
		private static var _instance:QuickUseManager;
		
		public static function get inst():QuickUseManager
		{
			if(_instance == null)
				_instance = new QuickUseManager();
			return _instance;
		}
		public function QuickUseManager()
		{
			if(_instance != null)
				throw "QuickUseManager.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		/**
		 * 需要快捷展示的物品列表 
		 */		
		private var _proList:Vector.<PRO_Item> = new Vector.<PRO_Item>();
		
		private var _timeId:uint;
		/**
		 * 弹窗的间隔</br>
		 * 如果没有间隔的话，如 当在强化界面进行 购买操作时候，其实此时已经进行了穿戴操作；
		 *  
		 */		
		private var TIME:int = 200;
		/**
		 * 是否可以展示 
		 */		
		private var _canShow:Boolean = true;
		
		
		/**
		 * 快速使用提示 
		 * @param pro
		 * 
		 */		
		public function show(pro:PRO_Item):void
		{
			//
			if(pro != null)
			{
				_proList.push(pro);
			}
			if(_canShow)
				start();
		}
		
		private function onOpen():void
		{
			if(_timeId > 0)
			{
				clearTimeout(_timeId);
				_timeId = 0;
			}
			while(_proList.length > 0)//找到可以进行弹窗的道具
			{
				var pro:PRO_Item = _proList.shift();
				var prop:PropBaseVo = ItemManager.instance.getPropById(pro.itemId);
				var bagPro:PRO_Item = BagModel.inst.getItemById(pro.id);
				if(bagPro && !bagPro.occupied)//如果这个道具还存在,并且没有被占用
				{
					
					if(prop.type == ItemTypeDict.EQUIP)//如果是装备
					{
						var proHero:PRO_Hero = HeroModel.instance.getNoEquipList(prop.subType);//找到此位置没有装备，且战力最高的伙伴
						if(proHero != null && prop.levelLimited <= GameData.inst.roleInfo.base.level)//等级需求
						{
							NoticeUI.inst.notiArea4.showQuickUse(pro);
						}
						else
						{
							continue;
						}
					}
					else
					{
						NoticeUI.inst.notiArea4.showQuickUse(pro);
					}
					return;
				}
			}
		}
		
		
		/**
		 * 开启快速提示 
		 * 
		 */		
		public function start():void
		{
			_canShow = true;
			if(_timeId == 0 && !NoticeUI.inst.notiArea4.quickUseWinIsShow && _proList.length > 0)//窗口未显示，且需要展示的道具还有，则继续展示
			{
				_timeId = setTimeout(onOpen,TIME);
			}
		}
		/**
		 * 关闭快速提示 
		 * 
		 */		
		public function stop():void
		{
			_canShow = false;
			if(_timeId > 0)//清除计时器
			{
				clearTimeout(_timeId);
				_timeId = 0;
			}
		}
	}
}