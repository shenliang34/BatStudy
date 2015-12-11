package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.CloseEvent;
	import com.gamehero.sxd2.gui.GlobalAlert;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ItemManager;

	/**
	 * 物品消耗的时候进行判断
	 * @author weiyanyu
	 * 创建时间：2015-10-12 下午5:40:12
	 * 
	 */
	public class ItemCost
	{
		public function ItemCost()
		{
		}
		/**
		 *  判断多种物品消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItems itemCostVo数组
		 * @return 物品是否足够
		 * 
		 */		
		public static function canUseMulCost(costItems:Array):Boolean
		{
			var vo:ItemCostVo;
			for(var i:int = 0; i < costItems.length; i++)
			{
				if(!canUseSingCost(costItems[i]))
					return false;
			}
			return true;
		}
		/**
		 *  判断单个消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param vo
		 * @return 
		 * 
		 */		
		public static function canUseSingCost(vo:ItemCostVo):Boolean
		{
			return canUse(vo.itemId,vo.itemCostNum);
		}
		/**
		 *   判断多种物品消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItems 物品[[物品id，物品数量],...]
		 * @return 
		 * 
		 */		
		public static function canUseMulItem(costItems:Array):Boolean
		{
			var canUse:Boolean;
			for(var i:int = 0; i < costItems.length; i++)
			{
				canUse = canUseSingItem(costItems[i]);
				if(!canUse)
				{
					return false;
				}
			}
			return true;
		}
		/**
		 *  判断单个消耗是否足够,弹出提示窗口(errorCode类似的)
		 * @param costItem 物品[物品id，物品数量]
		 * @return 
		 * 
		 */		
		public static function canUseSingItem(costItem:Array):Boolean
		{
			return canUse(costItem[0],costItem[1]);
		}
		
		public static function canUse(itemId:int,itemNum:int = 1):Boolean
		{
			if(itemId == MoneyDict.YUANBAO)
			{
				if(GameData.inst.playerExtraInfo.gold < itemNum)
				{
					DialogManager.inst.showPrompt("元宝不足");
					return false;
				}
			}
			else if(itemId == MoneyDict.TONG_QIAN)
			{
				if(GameData.inst.playerExtraInfo.coin < itemNum)
				{
					DialogManager.inst.showPrompt("铜钱不足");
					return false;
				}
			}
			else if(itemId == MoneyDict.LINT_YUN)
			{
				if(GameData.inst.playerExtraInfo.spirit < itemNum)
				{
					DialogManager.inst.showPrompt("灵蕴不足");
					return false;
				}
			}
			else
			{
				if(BagModel.inst.getItemNum(itemId) < itemNum)
				{
					var propBase:PropBaseVo = ItemManager.instance.getPropById(itemId);
					DialogManager.inst.showPrompt(propBase.name + "不足");
					return false;
				}
			}
			return true;
		}
		
		/**
		 * 使用消耗道具时候，弹出确认提示 
		 * @param configKey 全局配置的key
		 * @param backFun 回调
		 * @param str 描述文本
		 * @param arg 额外参数
		 * 
		 */		
		public static function showAlert(configKey:String,backFun:Function,str:String,...arg):void
		{
			if(GameData.inst.gameConfig[configKey])
			{
				backFun.apply(null,arg);
			}
			else
			{
				GlobalAlert.checkSelected = false;
				GlobalAlert.checkLabel = "下次不再提示";
				DialogManager.inst.show(str, GlobalAlert.OK|GlobalAlert.NO|GlobalAlert.CHECK, function(e:CloseEvent):void
				{
					// 点击确认
					if(e.detail == GlobalAlert.OK)
					{
						if(GlobalAlert.checkSelected)
						{
							GameProxy.inst.saveGameConfig(configKey,true);
						}
						backFun.apply(null,arg);
					}
				},GlobalAlert.BLUE);
			}
			
		}
	}
}
