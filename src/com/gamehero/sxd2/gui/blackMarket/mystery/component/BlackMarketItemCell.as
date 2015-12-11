package com.gamehero.sxd2.gui.blackMarket.mystery.component
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	/**
	 * 神秘商店的item
	 * @author weiyanyu
	 * 创建时间：2015-9-29 下午2:57:29
	 * 
	 */
	public class BlackMarketItemCell extends ItemCell
	{
		
		
		private var _defaultMask:Bitmap;
		
		
		public function BlackMarketItemCell()
		{
			initUI();
			size = 64;
			this.cacheAsBitmap = true;
		}
		override protected function loadIcon():void
		{
			if(_propVo)
			{
				_url = GameConfig.ITEM_ICON_URL + _propVo.ico + "_store.jpg";
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
		override protected function onIconLoadError(event:ErrorEvent):void {
			
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			// 使用默认图标
			_url = GameConfig.ITEM_ICON_URL + "default_store.jpg";
			BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded);
		}	
		
		override public function setIcon(bd:BitmapData):void
		{
			super.setIcon(bd);
		}
		
		override protected function addChipMask():void
		{
			if(_blackMask == null) _blackMask = new Bitmap(ItemSkin.ChipBigMask);
			addChild(_blackMask); 
			_icon.cacheAsBitmap = true;
			_blackMask.cacheAsBitmap = true;
			_icon.mask = _blackMask;
			if(_chipIcon == null) _chipIcon = new Bitmap(ItemSkin.ChipBig);
			addChild(_chipIcon);
			_blackMask.x = _chipIcon.x = _icon.x;
			_blackMask.y = _chipIcon.y = _icon.y;
			if(_defaultMask != null) 
			{
				removeChild(_defaultMask); 
				_defaultMask = null;
			}
		}
		
		/**
		 * 碎片去掉特殊图片遮罩 
		 * 
		 */		
		override protected function clearChipMask():void
		{
			super.clearChipMask();
			if(_defaultMask == null) 
			{
				_defaultMask = new Bitmap(Global.instance.getBD(BlackMarketModel.inst.domain,"Mask"));
				addChild(_defaultMask); 
				_defaultMask.blendMode = BlendMode.ERASE;
				_defaultMask.cacheAsBitmap = true;
			}

		}
		
		
	}
}