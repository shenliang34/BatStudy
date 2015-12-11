package com.gamehero.sxd2.gui.takeCards.components
{
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	
	import flash.display.Sprite;
	
	/**
	 * 抽过卡显示界面
	 * @author weiyanyu
	 * 创建时间：2015-10-14 下午4:37:06
	 * 
	 */
	public class TakeCardsHasHeroPanel extends Sprite
	{
		private var _heroVec:Vector.<TakeCardsHeroItem> = new Vector.<TakeCardsHeroItem>();
		
		private var _locArr:Array = [[149,343],[323,291],[500,265],[674,291],[849,343]];
		
		public function TakeCardsHasHeroPanel()
		{
			super();
		}
		
		public function init():void
		{
			var item:TakeCardsHeroItem;
			for(var i:int = 0; i < TakeCardsModel.HERO_NUM; i++)
			{
				
				try
				{
					item = _heroVec[i];
				}
				catch(e:Error)
				{
					item = new TakeCardsHeroItem();
					_heroVec.push(item);
				}
				item.index = i;
				item.x = _locArr[i][0];
				item.y = _locArr[i][1];
				item.setOpen(TakeCardsModel.inst.heroIsOpenVec[i],true);
				addChild(item);
			}
		}
		

		
		public function clear():void
		{
			var item:TakeCardsHeroItem;
			for(var i:int = 0; i < _heroVec.length; i++)
			{
				item = _heroVec[i];
				removeChild(item);
				item.clear();
			}
			_heroVec.length = 0;
		}
	}
}