package com.gamehero.sxd2.gui.bag.component
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.dnd.IDrag;
	import alternativa.gui.mouse.dnd.IDragObject;
	import alternativa.gui.mouse.dnd.IDrop;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * 物品格子
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:58:02
	 * 
	 */
	public class ItemCell extends ActiveObject implements ICellData,IDrop,IDrag
	{
		/**
		 * 格子来源类型 
		 */		
		public var itemSrcType:int;
		/**
		 * 格子数据 
		 */		
		protected var _data:PRO_Item;
		/**
		 * 道具信息 
		 */		
		protected var _propVo:PropBaseVo;
		/**
		 * 背景框 
		 */		
		protected var _backGroud:Bitmap;
		/**
		 * 图标资源 
		 */		
		protected var _icon:Bitmap;
		/**
		 * 右下角的数量字符 
		 */		
		protected var _numLabel:Label;
		/**
		 * 图标路径 
		 */		
		protected var _url:String;
		/**
		 * 格子大小 
		 */		
		protected var _size:int;
		/**
		 * 是否可以拖动 
		 */		
		protected var _isDragable:Boolean;
		/**
		 * 拖拽的数据 
		 */		
		protected var _dragData:Object;
		private var _itemCellData:ItemCellData = new ItemCellData();
		
		/**
		 * 黑色遮罩 
		 */		
		protected var _blackMask:Bitmap;
		/**
		 * 碎片的小标志 
		 */		 
		protected var _chipIcon:Bitmap;
		
		
		public function ItemCell()
		{
			super();
			initUI();
			size = 52;
		}
		
		/**
		 * 格子信息，来源；基础数据；服务器数据； 
		 */
		public function get itemCellData():ItemCellData
		{
			_itemCellData.itemSrcType = itemSrcType;
			_itemCellData.data = data;
			_itemCellData.propVo = propVo;
			return _itemCellData;
		}

		public function set size(value:int):void
		{
			this.height = this.width = _size = value;
			initLoc();
		}
		
		public function get size():int
		{
			return _size;
		}
		
		/**
		 * 重新设置ui位置 
		 */		
		private function initLoc():void
		{
			_numLabel.x = _size - 47;
			_numLabel.y = _size - 16;
			_numLabel.width = 44;
			
			_backGroud.x = _size - _backGroud.width >> 1;
			_backGroud.y = _size - _backGroud.height >> 1;
			
			_icon.x = (_size - _icon.width) >> 1;
			_icon.y = (_size - _icon.height) >> 1;
		}
		
		public function get itemType():int
		{
			return _propVo.type;
		}
		/**
		 * 格子道具信息 
		 * @return 
		 * 
		 */		
		public function get propVo():PropBaseVo
		{
			if(_data && _propVo == null)
			{
				_propVo = ItemManager.instance.getPropById(_data.itemId);
			}
			return _propVo;
		}
		
		public function set propVo(value:PropBaseVo):void
		{
			_propVo = value;
			_data = new PRO_Item;
			_data.itemId = _propVo.itemId;
			loadIcon();
		}


		/**
		 * 道具数据 
		 */
		public function get data():PRO_Item
		{
			return _data;
		}
		/**
		 * @private
		 */
		public function set data(value:PRO_Item):void
		{
			if(value == null)
			{
				clear();
				return;
			}

			_data = value;
			// 数量
			setNum(_data.num);
			_propVo = ItemManager.instance.getPropById(_data.itemId);
			loadIcon();
		}
		
		/**
		 * 设置右下角数量显示 
		 * @param value
		 * 
		 */		
		public function set num(value:String):void
		{
			if(int(value))
			{
				setNum(int(value));
			}
			else
			{
				_numLabel.text = value;
			}
		}
		/**
		 * 设置显示个数 
		 * @param value
		 * 
		 */		
		private function setNum(value:int):void
		{
			if(value == 0 || value == 1)
			{
				_numLabel.text = "";
			}
			else
			{
				if(value >= 10000)//万位了
				{
					var num:int = value / 10000;
					_numLabel.text = num + "万";
				}
				else
					_numLabel.text = value.toString();
			}
		}
		
		protected function loadIcon():void
		{
			if(_propVo)
			{
				_url = GameConfig.ITEM_ICON_URL + _propVo.ico + ".jpg";
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
		
		protected function onIconLoaded(event:Event):void {
			
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			
			var png:BitmapData = imageItem.content.bitmapData;
			
			setIcon(png);
		}
		/**
		 * 设置格子背景 
		 * @param bd
		 * 
		 */		
		public function setBackGroud(bd:BitmapData):void
		{
			_backGroud.bitmapData = bd;
			_backGroud.x = _size - bd.width>> 1;
			_backGroud.y = _size - bd.height >> 1;
		}
		/**
		 * 设置icon图片 
		 * @param bd
		 * 
		 */		
		public function setIcon(bd:BitmapData):void
		{
			_icon.bitmapData = bd;
			_icon.width = bd.width;
			_icon.height = bd.height;
			_icon.x = (_size - _icon.width) >> 1;
			_icon.y = (_size - _icon.height) >> 1;
			
			if(propVo.type == ItemTypeDict.HERO_CHIPS)//碎片要加一个六边形的遮罩
			{
				addChipMask();
			}
			else
			{
				clearChipMask();
			}
		}
		/**
		 * 加载失败（临时用） 
		 * @param event
		 * 
		 */
		protected function onIconLoadError(event:ErrorEvent):void {
			
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			// 使用默认图标
			_url = GameConfig.ITEM_ICON_URL + "default.jpg";
			BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded);
		}	
		

		/**
		 * 设置基本的ui 
		 * 
		 */		
		protected function initUI():void
		{
			_backGroud = new Bitmap();
			addChild(_backGroud);
			
			_icon = new Bitmap();
			addChild(_icon);
			
			_numLabel = new Label();
			_numLabel.align = Align.RIGHT;
			_numLabel.color = 0xffd40e;
			addChild(_numLabel);
		}
		
		public function isDragable():Boolean
		{
//			return _isDragable;
			return false;
		}
		
		public function getDragObject():IDragObject
		{
			if(_dragData == null)
			{
				_dragData = new Object();
			}
			_dragData.itemCell = this;
			
			if(_dragData.bd == null) {
				
				_dragData.bd = _icon.bitmapData; 
			}
			return new ItemDragObject(_dragData);
		}
		
		public function canDrop(dragObject:IDragObject):Boolean
		{
			return true;
		}
		
		/**
		 */
		public function drop(dragObject:IDragObject):void
		{
//			trace("draped" + dragObject);
		}
		/**
		 * 碎片添加特殊图片遮罩 
		 * 
		 */		
		protected function addChipMask():void
		{
			if(_blackMask == null)
			{
				_blackMask = new Bitmap(ItemSkin.ChipSmallMask);
				addChild(_blackMask); 
				_icon.cacheAsBitmap = true;
				_blackMask.cacheAsBitmap = true;
				_icon.mask = _blackMask;
				if(_chipIcon == null) _chipIcon = new Bitmap(ItemSkin.ChipSmall);
				addChild(_chipIcon);
				_blackMask.x = _chipIcon.x = _icon.x;
				_blackMask.y = _chipIcon.y = _icon.y;
			}
		}
		/**
		 * 碎片去掉特殊图片遮罩 
		 * 
		 */		
		protected function clearChipMask():void
		{
			if(_blackMask)
			{
				removeChild(_blackMask);
				removeChild(_chipIcon);
				_icon.mask = null;
				_blackMask = null;
				_chipIcon = null;
			}
		}
		
		/**
		 * 
		 * 清除数据相关的内容
		 * （一般用于界面内清除，背景_backGroud保留）
		 *  @see gc()
		 */		
		public function clear():void
		{
			_icon.bitmapData = null;
			itemSrcType = 0;
			this.hint = null;
			_data = null;
			_propVo = null;
			_url = null;
			this.filters = null;
			if(_numLabel)
			{
				_numLabel.text = "";
			}
			_isDragable = false;
			_dragData = null;
			
			clearChipMask();
		}
		/**
		 * 扔到对象池子里面， 可以复用；<br>
		 * 一般情况下是背包用。无限背包，保证格子可以重复利用。
		 * @see clear();
		 */		
		public function gc():void
		{
			clear();
			_backGroud.bitmapData = null;//
			ItemPool.push(this);
		}

	}
}