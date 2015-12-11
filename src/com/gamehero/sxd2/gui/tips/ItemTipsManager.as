package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.money.MoneyIcon;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.EquipStrengthenVo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 使用通用格子的tips管理
	 * @author weiyanyu
	 * 创建时间：2015-9-2 下午6:04:56
	 * 
	 */
	public class ItemTipsManager
	{
		public function ItemTipsManager()
		{
		}
		/**
		 * 根据格子数据获得tips类型
		 * itemCellData设置他的propBaseVo属性
		 * @param data
		 * @return 
		 * 
		 */		
		public static function getTips(data:ItemCellData):DisplayObject
		{
			var propBaseVo:PropBaseVo;//基础数据
			if(data.data)
			{
				propBaseVo = ItemManager.instance.getPropById(data.data.itemId);
				data.propVo = propBaseVo;
			}
			else
				propBaseVo = data.propVo;
			
			if(propBaseVo == null) return null;//
			
			var content:DisplayObject;
			if(propBaseVo.type == ItemTypeDict.GIFT_BOX)
			{
				content = ItemGiftBoxTips.getCellTips(data);
			}
			else if(propBaseVo.type == ItemTypeDict.HERO || propBaseVo.type == ItemTypeDict.HERO_CHIPS)
			{
				content = ItemHeroTips.getHeroTips(data);
			}
			else
			{
				content = ItemCellTips.getCellTips(data);
			}
			return content;
		}
		
		/**
		 * 返回tips的头部 
		 * 
		 */		
		public static function getTopSp(propBaseVo:PropBaseVo,data:ItemCellData):Sprite
		{
			var sp:Sprite = new Sprite();
			var icon:ItemCell = new ItemCell();
			icon.data = data.data;
			icon.num = "";
			icon.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG)
			sp.addChild(icon);
			
			var label:Label = new Label();//名字
			label.leading = 0.5;
			label.width = 54;
			label.color = GameDictionary.getColorByQuality(propBaseVo.quality);
			label.text = propBaseVo.name;
			label.bold = true;
			sp.addChild(label);
			label.x = 63;
			
			if(propBaseVo.type == ItemTypeDict.EQUIP)
			{
				label = new Label();
				label.leading = 0.5;
				label.color = GameDictionary.CHAT_TIPS;
				label.text = "道具类型：" ;
				sp.addChild(label);
				label.width = 54;
				label.x = 63;
				label.y = 19;
				
				
				label = new Label();//道具类型
				label.color = GameDictionary.WINDOW_WHITE;
				sp.addChild(label);
				label.text = Lang.instance.trans("heroequip_loc_" + propBaseVo.subType);
				label.x = 119;
				label.y = 19;
			}
			else
			{
				label = new Label();
				label.leading = 0.5;
				label.color = GameDictionary.CHAT_TIPS;
				label.text = "【功能道具】" ;
				sp.addChild(label);
				label.x = 63;
				label.y = 19;
			}
			
			label = new Label();
			label.leading = 0.5;
			label.color = GameDictionary.CHAT_TIPS;
			label.text = "使用等级：" ;
			sp.addChild(label);
			label.x = 63;
			label.y = 38;
			label.width = 54;
			
			label = new Label();
			label.x = 119;
			label.y = 38;
			label.color = GameDictionary.WINDOW_WHITE;
			sp.addChild(label);
			label.text = propBaseVo.levelLimited +　"";
			
			return sp;
		}
		/**
		 * 获取道具描述 
		 * @param propBaseVo
		 * @return 
		 * 
		 */		
		public static function getDesc(propBaseVo:PropBaseVo):Sprite
		{
			var sp:Sprite = new Sprite();
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(199, 1);
			sp.addChild(lineBM);
			
			var label:Label = new Label(false);//道具描述
			label.x = 7;
			label.y =  10;
			label.color = GameDictionary.WINDOW_GRAY;
			label.text = propBaseVo.tips;
			label.width = TipsDict.tipsWidth;
			sp.addChild(label);
			label.bold = true;
			return sp;
		}
		/**
		 * 获得属性 
		 * 
		 */		
		public static function getPropSp(propBaseVo:PropBaseVo,data:PRO_Item):Sprite
		{
			var sp:Sprite = new Sprite();
			
			var pre:DisplayObject;
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(199, 1);
			sp.addChild(lineBM);
			
			var label:Label = new Label();
			label.x = 8;
			label.y = TipsDict.lineGap;
			label.leading = 0.5;
			label.color = GameDictionary.CHAT_TIPS;
			label.text = "基础属性：";
			sp.addChild(label);
			
			var propLb:Label = new Label();
			propLb.color = GameDictionary.CHAT_WORLD;//基础属性
			propLb.leading = .5;
			var rootPropStr:String = "";
			rootPropStr += getAttrStr(Lang.instance.trans("item_prop_" + propBaseVo.prop0[0]),propBaseVo.prop0[1]);
			rootPropStr += getAttrStr(Lang.instance.trans("item_prop_" + propBaseVo.prop1[0]),propBaseVo.prop1[1]);
			propLb.x = 65;
			propLb.y = TipsDict.lineGap;
			sp.addChild(propLb);
			propLb.text = rootPropStr;
			pre = propLb;
			
			if(data && data.addLevel > 0)//强化属性
			{
				var equipLv:EquipStrengthenVo = EquipStrengthenManager.getInstance().voList[data.addLevel];
				label = new Label();
				label.x = 9;
				label.y = pre.y + pre.height + TipsDict.gap;
				label.color = GameDictionary.CHAT_TIPS;
				label.text = "强化属性：";
				sp.addChild(label);
				pre = label;
				propLb = new Label();
				propLb.color = GameDictionary.CHAT_WORLD;
				propLb.leading = .5;
				rootPropStr = "";
				rootPropStr += getAttrStr(Lang.instance.trans("item_prop_" + propBaseVo.prop0[0]),propBaseVo.prop0[1] * equipLv.percent / 100);
				rootPropStr += getAttrStr(Lang.instance.trans("item_prop_" + propBaseVo.prop1[0]),propBaseVo.prop1[1] * equipLv.percent / 100);
				propLb.x = 65;
				propLb.y = pre.y;
				sp.addChild(propLb);
				propLb.text = rootPropStr;
				pre = propLb;
			}
			return sp;
		}
		
		/**
		 * 属性文字
		 * @param attrName 属性名称
		 * @param attrNum 属性基础值
		 */
		private static function getAttrStr(attrName:String, attrNum:int):String
		{
			var str:String = "";
			if(attrNum > 0)
			{
				str += attrName+ "  +" + attrNum + "\n";
			}
			return str;
		}
		/**
		 * tips的底部 
		 * @param itemType 道具类型
		 * @param srcType
		 * @param cost
		 */		
		public static function getTipBottomSp(data:ItemCellData):Sprite
		{
			var sp:Sprite = new Sprite();

			var desc:String = ItemTipsManager.getDoubleClickDesc(data);
			var propBaseVo:PropBaseVo = data.propVo;
			if(desc != "")//双击的描述
			{
				var descLb:Label = new Label();
				descLb.leading = 0.5;
				descLb.color = GameDictionary.WINDOW_BLUE_GRAY;
				descLb.text = desc;
				descLb.x = 8;
				descLb.y = TipsDict.lineGap;
				sp.addChild(descLb);
			}
			if(propBaseVo.cost && propBaseVo.cost.itemId > 0)//出售价格
			{
				var moneySp:Sprite = new Sprite();
				sp.addChild(moneySp);
				var moneyIcon:MoneyIcon = new MoneyIcon();
				moneyIcon.iconId = propBaseVo.cost.itemId;
				moneySp.addChild(moneyIcon);
				moneyIcon.y = 5;
				var moneyLb:Label = new Label();
				moneyLb.text = propBaseVo.cost.itemCostNum + "";
				moneySp.addChild(moneyLb);
				moneyLb.size = 10;
				moneyLb.x = 23;
				moneyLb.y = moneyIcon.y + (moneyIcon.height - moneyLb.height >> 1);
				
				moneySp.x = TipsDict.lineWidth - moneySp.width;
			}
			
			if(descLb != null || moneyLb != null)
			{
				var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
				lineBM.scale9Grid = ChatSkin.lineScale9Grid;
				lineBM.setSize(TipsDict.lineWidth, 1);
				sp.addChild(lineBM);
			}
			return sp;
		}
		
		/**
		 * 获取双击操作的描述 
		 * @param itemType 道具类型
		 * @return 
		 * 
		 */		
		private static function getDoubleClickDesc(data:ItemCellData):String
		{
			if(WindowManager.inst.isWindowOpenedByWindowName(WindowEvent.BUYBACK_WINDOW))//回购窗口打开时候
			{
				if(data.propVo.price_limit)
				{
					switch(data.itemSrcType)//判断来源面板
					{
						case ItemSrcTypeDict.BUY_BACK://
							return "双击回购";
						case ItemSrcTypeDict.BAG:
							return "双击出售";
						default:
							return "";
					}
				}
				else
				{
					return "不可出售";
				}
	
			}
			else
			{
				if(data.itemSrcType == ItemSrcTypeDict.BAG)
				{
					switch(data.propVo.type)//正常判断道具类型
					{
						case ItemTypeDict.EQUIP:
							return "双击装备";
						case ItemTypeDict.GIFT_BOX:
							return "双击使用";
						default:
							return "";
					}
				}
				else
				{
					return "";
				}
			}
		}
		
		
	}
}