package com.gamehero.sxd2.gui.bag.component
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.buyback.model.BuyBackDict;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_STORE_OPT_REQ;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	
	/**
	 * 格子网格
	 * @author weiyanyu
	 * 创建时间：2015-8-6 下午2:30:26
	 * 
	 */
	public class ItemGrid extends Sprite
	{
		/**
		 * 间距 
		 */		
		public var gapX:int = 1;
		
		public var gapY:int = 1;
		
		private var _col:int = 4;//列
		private var _row:int = 2;//行
		
		private var _gridType:int;//格子类型
		private var _data:Array;//格子数据
		private var _itemSize:int = 52;//格子大小
		/**
		 * 格子数组 
		 */		
		protected var _itemVec:Vector.<ItemCell>;
		/**
		 * 是否可以点击 
		 */		
		public var clickAble:Boolean = false;
		/**
		 * 是否有鼠标滑动的效果 
		 */		
		public var mouseOverAble:Boolean = false;
		/**
		 * 格子背景 
		 */		
		private var _itemBg:BitmapData;
		/**
		 * 划过的状态位图 
		 */		
		private var _overBmp:Bitmap;
		/**
		 * 选中的框框 
		 */		
		private var _clickedBmp:Bitmap;
		/**
		 * 单击后需要延时处理的settimeout
		 */		
		private var _clickTime:uint;
		
		private var _curOverItem:ItemCell;
		
		private var _itemSrcType:int;
		
		/**
		 *  
		 * @param itemBg 背景
		 * 
		 */		
		public function ItemGrid(itemBg:BitmapData = null)
		{
			super();
			
			_itemBg = itemBg ? itemBg : ItemSkin.BAG_ITEM_NORMAL_BG;
			
			_overBmp = new Bitmap(ItemSkin.BAG_ITEM_MOUSEOVER_BG);
			_overBmp.x = 1;
			_overBmp.y = 1;
			_clickedBmp = new Bitmap(ItemSkin.BAG_ITEM_MOUSEOVER_BG);
			_clickedBmp.x = 1;
			_clickedBmp.y = 1;
				
			_itemVec = new Vector.<ItemCell>;
		}
		/**
		 * 格子来源 
		 */
		public function get itemSrcType():int
		{
			return _itemSrcType;
		}

		public function set itemSrcType(value:int):void
		{
			_itemSrcType = value;
		}

		/**
		 * 格子大小 
		 */
		public function get itemSize():int
		{
			return _itemSize;
		}

		/**
		 * @private
		 */
		public function set itemSize(value:int):void
		{
			_itemSize = value;
		}

		/**
		 * 设置容器属性 
		 * @param col 列数
		 * @param row 行数
		 * @param itemSize 格子大小
		 * @param gap 各自间距
		 * 
		 */		
		public function initGrid(col:int,row:int,itemSize:int = 52,gapX:int = 5,gapY:int = 5):void
		{
			clear();
			this.col = col;
			this.row = row;
			this.gapX = gapX;
			this.gapY = gapY;
			for(var i:int = 0; i < row; i++)
			{
				for(var j:int = 0; j < col; j++)
				{
					_itemVec.push(addItem((itemSize + gapX) *  j,(itemSize + gapY) * i));
				}
			}
		}
		//添加格子
		protected function addItem(lx:int,ly:int):ItemCell
		{
			var item:ItemCell = ItemPool.getItem();
			if(clickAble)
			{
				item.addEventListener(MouseEvent.MOUSE_UP,onClick);
				item.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = true;
			}
			else
			{
				item.removeEventListener(MouseEvent.MOUSE_UP,onClick);
				item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
				item.doubleClickEnabled = false;
			}
			if(mouseOverAble)
			{
				item.addEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			else
			{
				item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			item.x = lx;
			item.y = ly;
			addChild(item);
			return item;
		}
		
		protected function onDoubleClick(e:MouseEvent):void
		{
			MenuPanel.instance.hide();
			var item:ItemCell = (e.target as ItemCell);
			if(item && item.data)
			{
				if(WindowManager.inst.isWindowOpened(BuybackWindow))
				{
					var sellMsg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
					sellMsg.opt = BuyBackDict.SELL;
					sellMsg.id = item.data.id;
					GameService.instance.send(MSGID.MSGID_STORE_OPT,sellMsg);
				}
				else
				{
					if(item.itemType == ItemTypeDict.EQUIP)//如果装备，默认是穿戴
					{
						HeroModel.instance.itemHeroEquip(item.data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON);
					}
					else if(item.itemType == ItemTypeDict.GIFT_BOX)//如果是礼包，则双击使用
					{
						GameProxy.inst.itemUse(item.data.id,1);
					}
				}
				
			}
		}
		
		protected function onClick(e:MouseEvent):void
		{
			// 区分双击
			if(getTimer() - _clickTime <  GameConfig.MOUSE_DOUBLE_CLICK_TIME)
			{
				return;
			}
			
			_clickTime = getTimer();
			var item:ItemCell = (e.target as ItemCell);
			if(_curOverItem != item) return;
			if(item && item.data)
			{
				item.addChild(_clickedBmp);
				var options:Array = [];
				if(WindowManager.inst.isWindowOpened(BuybackWindow))
				{
					if(item.propVo.price_limit)
					{
						options.push(new OptionData(MenuPanel.OPTION_SELL ,  "出售"));
					}
					else
					{
						return;
					}
				}
				else
				{
					if(item.itemType == ItemTypeDict.EQUIP)
					{
						options.push(new OptionData(MenuPanel.OPTION_HERO_EQUIP ,  Lang.instance.trans("file_10003")));
					}
					else if(item.itemType == ItemTypeDict.GIFT_BOX)
					{
						options.push(new OptionData(MenuPanel.OPTION_USE , Lang.instance.trans("file_10001")));
					}
					options.push(new OptionData(MenuPanel.OPTION_SHOW ,  Lang.instance.trans("file_10002")));
				}
	
				
				MenuPanel.instance.initOptions(options);
				MenuPanel.instance.showLater(item , App.topUI);
				
				// 物品点击音效
				SoundManager.inst.play(SoundConfig.ITEM_CLICK);
			}
		}
		
		
		protected function onMouseOut(e:MouseEvent):void
		{
			_curOverItem = null;
			removeBmp(_overBmp,e.target as ItemCell);
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			_curOverItem = (e.target as ItemCell);
			_curOverItem.addChild(_overBmp);
		}


		/**
		 * 格子数据组 
		 */
		public function get data():Array
		{
			return _data;
		}

		/**
		 * 设置数据源
		 */
		public function set data(value:Array):void
		{
			clear();
			_data = value;
			var item:ItemCell;
			var itemRow:int;
			var itemCol:int;
			var proItem:PRO_Item;
			for(var i:int = 0; i < value.length; i++)
			{
				proItem = value[i];
				
				itemRow = int(i / col);
				itemCol = (i % col);
				item =addItem((itemSize + gapX) *  itemCol,(itemSize + gapY) * itemRow);
				_itemVec.push(item);
				item.setBackGroud(_itemBg);
				item.itemSrcType = _itemSrcType;
				item.data = proItem;
			}
			
		}

		/**
		 * 格子类型 
		 * @return 
		 * 
		 */		
		public function get gridType():int
		{
			return _gridType;
		}

		public function set gridType(value:int):void
		{
			_gridType = value;
		}

		/**
		 * 行数 
		 */
		public function get row():int
		{
			return _row;
		}

		/**
		 * @private
		 */
		public function set row(value:int):void
		{
			_row = value;
		}

		public function set col(value:int):void
		{
			_col = value;
		}
		/**
		 * @return 列数
		 * 
		 */
		public function get col():int
		{
			return _col;
		}
		/**
		 * 清除数据相关 
		 * 
		 */		
		public function clear():void
		{
			if(_itemVec)
			{
				var item:ItemCell;
				for(var i:int = 0; i < _itemVec.length; i++)
				{
					item = _itemVec[i];
					if(item.parent)
						item.parent.removeChild(item);
					item.gc();
					removeBmp(_clickedBmp,item);
					removeBmp(_overBmp,item);
					item.removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
					item.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
					item.removeEventListener(MouseEvent.CLICK,onClick);
					item.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
					item.doubleClickEnabled = false;
				}
				_itemVec.length = 0;
			}
			MenuPanel.instance.hide();
			_curOverItem = null;
			
		}
		
		/**
		 * 移除 选中的效果
		 * @param bmp
		 * @param father
		 * 
		 */		
		private function removeBmp(bmp:Bitmap,father:ItemCell):void
		{
			if(bmp)
			{
				if(bmp.parent == father)
				{
					father.removeChild(bmp);
				}
			}
		}
	}
}