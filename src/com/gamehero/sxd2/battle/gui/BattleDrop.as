package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.item.ItemCell;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.vo.ItemProVO;
	import com.gamehero.sxd2.vo.PackItemProVO;
	
	import flash.display.Sprite;
	
	import alternativa.gui.enum.Align;
	
	
	/**
	 * 战斗结算面板显示的掉落物品
	 * @author xuwenyi
	 * @create 2014-03-11
	 **/
	public class BattleDrop extends Sprite
	{
		private var cell:ItemCell;
		private var nameLabel:Label;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleDrop()
		{
			cell = new ItemCell();
			cell.useable = 1;
			this.addChild(cell);
			
			nameLabel = new Label(false);
			nameLabel.x = -29;
			nameLabel.y = 55;
			nameLabel.size = 12;
			nameLabel.align = Align.CENTER;
			nameLabel.width = 100;
			nameLabel.height = 20;
			nameLabel.color = GameDictionary.WHITE;
			this.addChild(nameLabel);
		}
		
		
		
		
		/**
		 * 显示某物品
		 * */
		public function update(item:PackItemProVO):void
		{
			if(item)
			{
				cell.cellData = item;
				var itemVO:ItemProVO = cell.cellData ? cell.cellData.itemVO : null;
				if(itemVO)
				{
					nameLabel.text = itemVO.name;
					nameLabel.color = GameDictionary.getColorByQuality(itemVO.quality);
				}
			}
			else
			{
				this.clear();
			}
		}
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			cell.cellData = null;
			nameLabel.text = "";
		}
		
		
	}
}