package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideWindow;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Instance;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.GiftBoxItemVo;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * 剧情副本章节节点的tips
	 * @author weiyanyu
	 * 创建时间：2015-9-1 下午3:35:39
	 * 
	 */
	public class HurdleGuideTips
	{
		
		public function HurdleGuideTips()
		{
		}
		/**
		 * 副本导航节点的tips 
		 * @param data
		 * @param pro
		 * @return 
		 * 
		 */		
		public static function getTips(data:HurdleVo,pro:PRO_Instance):DisplayObject
		{
			var costProp:PropBaseVo = ItemManager.instance.getPropById(data.consume_id);
			var preDisplay:DisplayObject;
			var container:Sprite = new Sprite();
			var label:Label = new Label();
			label.leading = 0.5;
			label.color = GameDictionary.WHITE;
			label.bold = true;
			label.text = (data.name);
			preDisplay = label;
			container.addChild(label);
			label = new Label();
			label.text = "消耗" + costProp.name + " " + data.consume_num;
			label.y = preDisplay.y + preDisplay.height + TipsDict.gap;
			label.color = GameDictionary.BLUE;
			preDisplay = label;
			container.addChild(label);
			label.y = 21;
			
			if(pro.instanceId && pro.instanceId.length > 0)//有前置关卡没有完成
			{
				label = new Label();
				label.y = preDisplay.y + preDisplay.height + TipsDict.gap;
				label.color = GameDictionary.RED;
				label.text = "";
				var instance:HurdleVo;
				for each(var instanceId:int in pro.instanceId)
				{
					instance = HurdlesManager.getInstance().getHurdleById(instanceId);
					label.text += Lang.instance.trans(instance.name);
				}
				label.text += "未通过";
				preDisplay = label;
				container.addChild(label);
			}
			else if(pro.taskId && pro.taskId.length > 0)//有任务没有完成
			{
				label = new Label();
				label.y = preDisplay.y + preDisplay.height + TipsDict.gap;
				label.color = GameDictionary.RED;
				label.text = "";
//				var taskInfoVo:TaskInfoVo;
//				for each(var taskId:int in pro.taskId)
//				{
//					taskInfoVo = TaskManager.inst.getTaskDataById(taskId);
//					label.text += Lang.instance.trans(taskInfoVo.name);
//				}
				
				label.text = "主线任务未完成";
				preDisplay = label;
				container.addChild(label);
			}
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(199, 2);
			lineBM.y = preDisplay.y + preDisplay.height + TipsDict.lineGap;
			preDisplay = lineBM;
			container.addChild(lineBM);
			
			var proList:Vector.<Vector.<GiftBoxVo>> = ItemManager.instance.getMustProList(data.box_id);
			var proListSp:Sprite = getHurdleGet(proList);
			
			container.addChild(proListSp);
			proListSp.y = preDisplay.y + preDisplay.height + TipsDict.lineGap;
			
			return container;
		}
		
		private static function getHurdleGet(proList:Vector.<Vector.<GiftBoxVo>>):Sprite
		{
			var mustGet:Vector.<GiftBoxVo> = proList[0];//通关获得
			var propGet:Vector.<GiftBoxVo> = proList[1];//可能获得
			
			var sp:Sprite = new Sprite();
			var mustSp:Sprite;
			var propSp:Sprite;
			
			var i:int = 0;
			var lb:Label 
			
			if(mustGet.length > 0)
			{
				mustSp = new Sprite();
				sp.addChild(mustSp);
				lb = new Label();
				lb.text = "通关获得：";
				lb.color = GameDictionary.CHAT_PLAYER;
				mustSp.addChild(lb);
				var lbSp:Sprite = getLabelListWithIcon(mustGet);
				lbSp.x = 76;
				lbSp.y = -6;
				mustSp.addChild(lbSp);
				
			}
			
			i = 0;
			if(propGet.length > 0)
			{
				propSp = new Sprite();
				sp.addChild(propSp);
				if(mustSp)
				{
					propSp.y = mustSp.height + 10;
				}
				lb = new Label();
				lb.text = "可能获得：";
				lb.color = GameDictionary.CHAT_PLAYER;
				propSp.addChild(lb);
				var itemSp:Sprite = getItemListWithIcon(propGet);
				itemSp.x = 5;
				itemSp.y = lb.y + lb.height + 20;
				propSp.addChild(itemSp);
			}
			
			return sp;
		}
		/**
		 * 返回一个一个竖排的金钱奖励 
		 * @param list
		 * @return 
		 * 
		 */		
		private static function getLabelListWithIcon(list:Vector.<GiftBoxVo>):Sprite
		{
			var sp:Sprite = new Sprite();
			var moneyLb:MoneyLabel;
			var i:int = 0;
			for each(var box:GiftBoxVo in list)
			{
				for each(var boxItemVo:GiftBoxItemVo in box.items)
				{
					moneyLb = new MoneyLabel();
					sp.addChild(moneyLb);
					moneyLb.iconId = boxItemVo.dropId;
					moneyLb.text = boxItemVo.num;
					moneyLb.y = 18 * (i ++);
				}
			}
			return sp;
		}
		/**
		 * 根据列表，返回一个一个的物品框 
		 * @param list
		 * @return 
		 * 
		 */		
		private static function getItemListWithIcon(list:Vector.<GiftBoxVo>):Sprite
		{
			var sp:Sprite = new Sprite();
			var item:ItemCell;
			var prop:PropBaseVo;
			var i:int = 0;
			for each(var box:GiftBoxVo in list)
			{
				for each(var boxItemVo1:GiftBoxItemVo in box.items)
				{
					prop = ItemManager.instance.getPropById(boxItemVo1.dropId);
					item = new ItemCell();
					item.size = 52;
					item.propVo = prop;
					item.num = boxItemVo1.num;
					item.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG);
					item.x = 55 * (i ++);
					sp.addChild(item);
				}
			}
			
			return sp;
		}
		
		
		
		/**
		 *  
		 * @param boxItemId 宝箱列表
		 * @return 
		 * 
		 */		
		public static function getBoxTips(boxItemId:Array,pra:Object = null):DisplayObject
		{
			var container:Sprite = new Sprite();
			
			var lb:Label = new Label();
			lb.text = "副本奖励";
			lb.x = 69;
			lb.size = 14;
			lb.bold = true;
			lb.color = GameDictionary.ORANGE;
			container.addChild(lb);
			
			lb = new Label();
			lb.text = "达到 " + GameDictionary.createCommonText(int(pra).toString(),GameDictionary.ORANGE,12,true) + "       可领取";
			lb.x = 43;
			lb.y = 27;
			lb.color = GameDictionary.BLUE;
			container.addChild(lb);
			
			var FiveStar:Bitmap = new Bitmap(MainSkin.FiveStar);
			container.addChild(FiveStar);
			FiveStar.x = 85;
			FiveStar.y = 20;
			
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(199, 1);
			lineBM.y = 51;
			container.addChild(lineBM);
			
			var proList:Vector.<Vector.<GiftBoxVo>> = ItemManager.instance.getMustProList(boxItemId);
			var sp:Sprite = getItemListWithIcon(proList[0]);
			sp.x = 10;
			sp.y = 62;
			container.addChild(sp);
			return container;
		}
		/**
		 * 根据几率获得与必然获得 得到响应的显示 (文本形式)
		 * @param proList
		 * @return 
		 * 
		 */		
		public static function getBoxTextCont(proList:Vector.<Vector.<GiftBoxVo>>,pra:* = null):Sprite
		{
			var container:Sprite = new Sprite();
			var mustList:Vector.<GiftBoxVo> = proList[0];
			var probList:Vector.<GiftBoxVo> = proList[1];
			var preDisplay:DisplayObject;
			var mustStr:String = "";
			var probStr:String = "";
			var nameStr:String = "";
			var colorStr:int;
			var prop:PropBaseVo;
			for each(var box:GiftBoxVo in mustList)
			{
				for each(var boxItemVo:GiftBoxItemVo in box.items)
				{
					prop = ItemManager.instance.getPropById(boxItemVo.dropId);
					if(prop)
					{
						nameStr = prop.name + boxItemVo.getNumString();
						colorStr = GameDictionary.getColorByQuality(prop.quality);
						mustStr += "、" + GameDictionary.createCommonText(nameStr,colorStr);
					}
					else
					{
						trace("礼包道具配置的道具不存在！...id=" + boxItemVo.dropId);
					}
					
				}
			}
			mustStr = mustStr.substr(1);
			for each(var box1:GiftBoxVo in probList)
			{
				for each(var boxItemVo1:GiftBoxItemVo in box1.items)
				{
					prop = ItemManager.instance.getPropById(boxItemVo1.dropId);
					if(prop)
					{
						nameStr = prop.name + boxItemVo1.getNumString();
						colorStr = GameDictionary.getColorByQuality(prop.quality);
						probStr += "、" + GameDictionary.createCommonText(nameStr,colorStr);
					}
					else
					{
						trace("礼包道具配置的道具不存在！...id=" + boxItemVo1.dropId);
					}
					
				}
			}
			probStr = probStr.substr(1);
			if(mustStr != "")
			{
				var mustlabel:Label = new Label();
				mustlabel.leading = 0.5;
				mustlabel.color = GameDictionary.WINDOW_WHITE;
				if(int(pra) == HurdleGuideWindow.OPENED)//如果宝箱奖励已经领取
				{
					mustlabel.text = "奖励已领取"
				}
				else
				{
					mustlabel.text = "使用获得：";
				}
				container.addChild(mustlabel);
				preDisplay = mustlabel;
				mustlabel = new Label(false);
				mustlabel.y = preDisplay.y + preDisplay.height + TipsDict.gap;
				mustlabel.width = TipsDict.tipsWidth;
				mustlabel.text = mustStr;
				preDisplay = mustlabel;
				container.addChild(mustlabel);
			}
			if(probStr != "")
			{
				var label:Label = new Label();
				label.y = preDisplay ? preDisplay.y + preDisplay.height + TipsDict.gap: 0;
				label.leading = 0.5;
				label.color = GameDictionary.WINDOW_WHITE;
				label.text = "几率获得:";
				preDisplay = label;
				container.addChild(label);
				label = new Label(false);
				label.x = 20;
				label.y = preDisplay.y + preDisplay.height + TipsDict.gap;
				label.width = TipsDict.tipsWidth;
				label.text = probStr;
				container.addChild(label);
			}
			return container;
		}
		/**
		 *  		 * 根据几率获得与必然获得 得到响应的显示 (物品格子形式)
		 * @param proList
		 * @return 
		 * 
		 */		
		public static function getBoxItemCont(proList:Vector.<Vector.<GiftBoxVo>>,pra:* = null):Sprite
		{
			var container:Sprite = new Sprite();
			var mustList:Vector.<GiftBoxVo> = proList[0];
			var probList:Vector.<GiftBoxVo> = proList[1];
			
			var prop:PropBaseVo;
			var item:ItemCell;
			var proItem:PRO_Item;
			
			var mustGetList:Vector.<ItemCell> = new Vector.<ItemCell>();
			var proGetList:Vector.<ItemCell> = new Vector.<ItemCell>();
			var i:int;
			for each(var box:GiftBoxVo in mustList)
			{
				var boxItemVo:GiftBoxItemVo;
				for(i in box.items)
				{
					boxItemVo = box.items[i];
					prop = ItemManager.instance.getPropById(boxItemVo.dropId);
					if(prop)
					{
						item = new ItemCell();
						item.size = 52;
						item.propVo = prop;
						item.num = boxItemVo.num;
						item.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG);
						mustGetList.push(item);
					}
					else
					{
						trace("礼包道具配置的道具不存在！...id=" + boxItemVo.dropId);
					}
					
				}
			}
			for each(var box1:GiftBoxVo in probList)
			{
				var boxItemVo1:GiftBoxItemVo;
				for(i in box1.items)
				{
					boxItemVo1 = box1.items[i];
					prop = ItemManager.instance.getPropById(boxItemVo1.dropId);
					if(prop)
					{
						item = new ItemCell();
						item.size = 52;
						item.propVo = prop;
						item.num = boxItemVo.num;
						item.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG);
						proGetList.push(item);
					}
					else
					{
						trace("礼包道具配置的道具不存在！...id=" + boxItemVo1.dropId);
					}
					
				}
			}
			if(mustGetList.length > 0)
			{
				var mustlabel:Label = new Label();
				mustlabel.leading = 0.5;
				mustlabel.color = GameDictionary.WINDOW_WHITE;
				if(int(pra) == HurdleGuideWindow.OPENED)//如果宝箱奖励已经领取
				{
					mustlabel.text = "奖励已领取"
				}
				else
				{
					mustlabel.text = "必然获得:";
				}
				mustlabel.text = "每次扫荡可获得";
				container.addChild(mustlabel);
				
				for(i = 0; i < mustGetList.length; i++ )
				{
					container.addChild(mustGetList[i]);
					mustGetList[i].x = i * 52;
					mustGetList[i].y = 22;
				}
				
			}
			if(proGetList.length > 0)
			{
				var label:Label = new Label();
				label.x = 20;
				label.y = 80;
				label.leading = 0.5;
				label.color = GameDictionary.WINDOW_WHITE;
				label.text = "概率获得";
				container.addChild(label);
				for(i = 0; i < proGetList.length; i++ )
				{
					container.addChild(proGetList[i]);
					proGetList[i].x = i * 60;
					proGetList[i].y = 100;
				}
			}
			return container;
		}
	}
}