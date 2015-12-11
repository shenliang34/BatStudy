package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * 礼包掉落
	 * @author weiyanyu
	 * 创建时间：2015-8-28 下午4:06:04
	 * 
	 */
	public class ItemGiftBoxTips
	{
		public function ItemGiftBoxTips()
		{
		}
		public static function getCellTips(data:ItemCellData):DisplayObject
		{
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(data.data.itemId);
			
			var container:Sprite = new Sprite();
			var icon:ItemCell = new ItemCell();
			icon.data = data.data;
			icon.num = "";
			icon.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG)
			container.addChild(icon);
			icon.x = 14;
			icon.y = 15;
			
			var sp:Sprite = new Sprite();
			sp.x = 87;
			sp.y = 13;
			container.addChild(sp);
			var label:Label = new Label();
			label.leading = 0.5;
			label.width = 54;
			label.color = GameDictionary.getColorByQuality(propBaseVo.quality);
			label.text = propBaseVo.name;
			label.bold = true;
			sp.addChild(label);
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(199, 2);
			lineBM.y = 81;
			lineBM.x = 11;
			container.addChild(lineBM);
			
			var proList:Vector.<Vector.<GiftBoxVo>> = ItemManager.instance.getBoxItemList(data.data.itemId);
			var proListSp:Sprite = HurdleGuideTips.getBoxTextCont(proList);
			
			container.addChild(proListSp);
			proListSp.y = 90;
			proListSp.x = 14;
			
			var bottomSp:Sprite = ItemTipsManager.getTipBottomSp(data);
			container.addChild(bottomSp);
			bottomSp.y = proListSp.y + proListSp.height + TipsDict.gap * 2;
			bottomSp.x = 11;
			
			
			var bg:ScaleBitmap = new ScaleBitmap();
			bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
			var w:int = container.width + GameHint.paddingX * 2;
			var h:int = container.height + GameHint.paddingY * 2 + GameHintSkin.edge;
			bg.setSize(w , h);
			container.addChildAt(bg,0);
			return container;
		}
	}
}