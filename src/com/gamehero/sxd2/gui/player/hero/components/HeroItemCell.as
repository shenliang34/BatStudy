package com.gamehero.sxd2.gui.player.hero.components
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.mouse.dnd.IDrag;
	import alternativa.gui.mouse.dnd.IDragObject;
	import alternativa.gui.mouse.dnd.IDrop;
	
	import bowser.loader.BulkLoaderSingleton;
	
	/**
	 * 物品格子
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:58:02
	 * 
	 */
	public class HeroItemCell extends ItemCell implements IDrag,IDrop
	{
		/**
		 * 格子位置 
		 */		
		public var itemLoc:int;
		
		/**
		 * 背景 
		 */		
		private var _bgCont:ActiveObject;
		/**
		 * 背景圆圈 
		 */		
		private var _bg:Bitmap;
		/**
		 * 格子对应的灰色道具图标 
		 */		
		private var _locBg:Bitmap;
		
		public function HeroItemCell()
		{
			super();
			_bgCont = new ActiveObject();
			_bg = new Bitmap();
			_bgCont.addChild(_bg);
			_locBg = new Bitmap();
			_bgCont.addChild(_locBg);
			
			addChildAt(_bgCont,0);
		}
		/**
		 * 设置背景 
		 * @param bd （圆形的）背景图
		 * @param locUrl 位置上的图标
		 * @param index 当前位置索引
		 * 
		 */
		public function setBg(bd:BitmapData,locUrl:String):void
		{
			_bg.bitmapData = bd;
			_bg.x = _size - bd.width >> 1;
			_bg.y = _size - bd.height >> 1;
			_locBg.bitmapData = (Global.instance.getBD(HeroModel.instance.domain,locUrl));
			_locBg.x = _size - _locBg.width >> 1;
			_locBg.y = _size - _locBg.height >> 1;
			_bgCont.hint = Lang.instance.trans("team_ui_" + (itemLoc + 20));
		}
		
		override public function set data(value:PRO_Item):void
		{
			super.data = value;
			MenuPanel._instance.hide();
			if(data == null)
			{
				_locBg.visible = true;
			}
			else
			{
				_locBg.visible = false;
				_bgCont.hint = " ";
			}
		}
		override public function isDragable():Boolean
		{
			return false;
		}
		
		
		override public function canDrop(dragObject:IDragObject):Boolean
		{
			return true;
		}
		override protected function loadIcon():void
		{
			_url = GameConfig.ITEM_ICON_URL + propVo.ico + "_hero" + ".png";
			BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded, null, onIconLoadError);
			BulkLoaderSingleton.instance.start();
			this.hint = propVo.name + "";
			_isDragable = true;
		}
		/**
		 */
		override public function drop(dragObject:IDragObject):void
		{
			var dragData:Object = dragObject.data;
			if(dragData)
			{
				if(dragData.itemCell is ItemCell)
				{
					var item:ItemCell = dragData.itemCell;
					if(item.propVo.type == ItemTypeDict.EQUIP )
					{
						HeroModel.instance.itemHeroEquip(item.data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON);
					}
				}
			}
		}
		
		/**
		 * 打扫卫生 
		 * 
		 */		
		override public function clear():void
		{
			super.clear();
			itemLoc = -1;
		}

	}
}