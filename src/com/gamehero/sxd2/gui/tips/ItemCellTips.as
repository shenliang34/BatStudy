package com.gamehero.sxd2.gui.tips
{
    
    import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
    import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
    import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
    import com.gamehero.sxd2.manager.ItemManager;
    
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    import org.bytearray.display.ScaleBitmap;
    

	public class ItemCellTips
	{
		/**
		 * 默认的道具tips样式
		 * @param data
		 * @return 
		 * 
		 */		
		public static function getCellTips(data:ItemCellData):DisplayObject
		{
			var propBaseVo:PropBaseVo;
			if(data.data)
			{
				propBaseVo = ItemManager.instance.getPropById(data.data.itemId);
			}
			else
			{
				propBaseVo = data.propVo;
			}
			var container:Sprite = new Sprite();
			var pre:DisplayObject;//上面的一个显示对象，用来对位
			
			if(data.itemSrcType == ItemSrcTypeDict.HERO_EQUIP)
			{
				var equiped:Bitmap = new Bitmap(ItemSkin.EQUIPED);
				container.addChild(equiped);
				equiped.x = 161;
				equiped.y = 5;
			}
			
			
			var topSp:Sprite = ItemTipsManager.getTopSp(propBaseVo,data);//头部信息
			container.addChild(topSp);
			topSp.x = 16;
			topSp.y = 16;
			pre = topSp;
			
			if(propBaseVo.tips != null)//描述
			{
				var descSp:Sprite = ItemTipsManager.getDesc(propBaseVo);
				container.addChild(descSp);
				descSp.x = 11;
				descSp.y = pre.y + pre.height + TipsDict.lineGap;
				pre = descSp;
			}
			
			if(propBaseVo.prop0[0] > 1)
			{
				var propSp:Sprite = ItemTipsManager.getPropSp(propBaseVo,data.data);//属性部位
				propSp.x = 11;
				propSp.y = pre.y + pre.height + TipsDict.lineGap;
				container.addChild(propSp);
				pre = propSp;
			}
			
			var bottomSp:Sprite = ItemTipsManager.getTipBottomSp(data);//底部
			container.addChild(bottomSp);
			bottomSp.x = 11;
			bottomSp.y = pre.y + pre.height + TipsDict.lineGap;
			
			
			var bg:ScaleBitmap = new ScaleBitmap();
			bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
			bg.setSize(TipsDict.width, container.height + topSp.y + TipsDict.bottom);
			container.addChildAt(bg,0);
			return container;
		}
		
	}
}