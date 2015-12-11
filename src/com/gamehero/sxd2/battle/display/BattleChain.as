package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.world.display.MovieItem;
	
	import flash.display.BitmapData;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	/**
	 * 防御链显示对象
	 * @author xuwenyi
	 * @create 2014-01-03
	 **/
	public class BattleChain extends SpriteItem
	{
		// 在阵型中的位置
		public var pos:int = 0;
		private var items:Array = [];
		// 格子是否有人
		public var hasPlayer:Boolean;
		// 闪光动画
		private var flashItem:MovieItem;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleChain()
		{
			var chainsBmds:Array = BattleSkin.CHAIN_ITEMS;
			for(var i:int=0;i<3;i++)
			{
				var bmd:BitmapData = chainsBmds[i];
				var item:RenderItem = new RenderItem();
				item.x = -bmd.width>>1;
				item.y = -bmd.height>>1;
				item.renderSource = bmd;
				item.visible = false;
				this.addChild(item);
				
				items.push(item);
			}
		}
		
		
		
		
		
		/**
		 * 显示防御链框
		 * @param level 防御链等级
		 * */
		public function updateStatus(level:int = 0 , minLevel:int = 0 , maxLevel:int = 0):void
		{
			// 格子有人
			if(hasPlayer == true)
			{
				// 0级
				if(level == 0)
				{
					items[0].visible = true;
					items[1].visible = false;
					items[2].visible = false;
				}
				// 防御链等级没有出现大小不一的情况
				else if(level == minLevel && level == maxLevel)
				{
					items[0].visible = false;
					items[1].visible = true;
					items[2].visible = false;
				}
				// 存在最高等级
				else
				{
					if(level == maxLevel)
					{
						items[0].visible = false;
						items[1].visible = false;
						items[2].visible = true;
					}
					else
					{
						items[0].visible = false;
						items[1].visible = true;
						items[2].visible = false;
					}
				}
			}
			else
			{
				items[0].visible = false;
				items[1].visible = false;
				items[2].visible = false;
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			this.removeChildren();
		}
		
		
	}
}