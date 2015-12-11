package com.gamehero.sxd2.gui.player.hero.components
{
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 伙伴面板装备容器
	 * @author weiyanyu
	 * 创建时间：2015-8-19 上午10:21:06
	 * 
	 */
	public class HeroEquipGrid extends ActiveObject
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
		 * 是否可以点击 
		 */		
		public var clickAble:Boolean = true;
		/**
		 * 是否有鼠标滑动的效果 
		 */		
		public var mouseOverAble:Boolean = true;
		/**
		 * 格子背景 
		 */		
		private var _itemBg:BitmapData;
		/**
		 * 划过的状态位图 
		 */		
		private var _overBmp:Bitmap;
		private var _clickedBmp:Bitmap;
		
		private var _itemList:Vector.<HeroItemCell>;
		
		private var _curOverItem:HeroItemCell;
		
		
		public function HeroEquipGrid(itemBg:BitmapData=null)
		{
			_itemBg = itemBg;
			this.mouseEnabled = false;
			_itemList = new Vector.<HeroItemCell>();
		}
		/**
		 * 种族 
		 */		
		private var _race:String;
		/**
		 * 伙伴种族 
		 * @param value
		 * 
		 */		
		public function setRace(value:String):void
		{
			_race = value;
		}
		public function initGrid(col:int,row:int,itemSize:int = 52,gapX:int = 5,gapY:int = 5):void
		{
			clear();
			this.col = col;
			this.row = row;
			this.gapX = gapX;
			this.gapY = gapY;
			for(var i:int = 0; i < col; i++)
			{
				for(var j:int = 0; j < row; j++)
				{
					_itemList.push(addItem((itemSize + gapX) *  i,(itemSize + gapY) * j, (i * row + j)));
				}
			}
		}
		/**
		 * 设置数据 
		 * @param arr
		 * 
		 */		
		public function setData(arr:Array):void
		{
			for(var index:int in arr)
			{
				_itemList[index].data = BagModel.inst.getItemById(arr[index]);
			}
		}
		
		//添加格子
		protected function addItem(lx:int,ly:int,index:int):HeroItemCell
		{
			var item:HeroItemCell = new HeroItemCell();
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
			item.itemSrcType = ItemSrcTypeDict.HERO_EQUIP;
			item.itemLoc = index;
			item.x = lx;
			item.y = ly;
			item.setBg(_itemBg,_race + index);
			addChild(item);
			return item;
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
		
		public function clear():void
		{
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			_curOverItem = null;
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			_curOverItem = (e.target as HeroItemCell);
		}
		
		protected function onDoubleClick(e:MouseEvent):void
		{
			var item:HeroItemCell = (e.target as HeroItemCell);
			if(item && item.data)
			{
				HeroModel.instance.itemHeroEquip(item.data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_OFF);
			}
		}
		
		protected function onClick(e:MouseEvent):void
		{
			var item:HeroItemCell = (e.target as HeroItemCell);
			if(_curOverItem != item) return;
			if(item && item.data)
			{
				var options:Array = [];
				options.push(new OptionData(MenuPanel.OPTION_UNSNATCH , Lang.instance.trans("file_10004")));
				MenuPanel.instance.initOptions(options);
				MenuPanel.instance.showLater(item , App.topUI);
			}
		}
	}
}