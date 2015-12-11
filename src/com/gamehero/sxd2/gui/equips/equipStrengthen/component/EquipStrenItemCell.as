package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	
	import bowser.loader.BulkLoaderSingleton;
	
	/**
	 * 加载大的物品
	 * @author weiyanyu
	 * 创建时间：2015-9-21 上午11:23:34
	 * 
	 */
	public class EquipStrenItemCell extends ItemCell
	{
		
		public function EquipStrenItemCell()
		{
			super();
		}
		
		
		override protected function loadIcon():void
		{
			if(_propVo)
			{
				_url = GameConfig.ITEM_ICON_URL + _propVo.ico + "_big.png";
				BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded, null, onIconLoadError);
				BulkLoaderSingleton.instance.start();
				this.hint = _propVo.name + "";
				_isDragable = true;
			}
			else
			{
				trace("不存在道具id：" + _data.itemId);
			}
			
		}
	}
}