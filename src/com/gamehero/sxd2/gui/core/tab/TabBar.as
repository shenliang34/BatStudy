package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-29 下午4:52:46
	 * 
	 */
	public class TabBar extends Sprite
	{
		/**
		 *  横向
		 */		
		public static var HORIZEN:int = 0;
		/**
		 * 纵向 
		 */		
		public static var VERTICAL:int = 1;
		
		
		private var _type:int = 0;
		
		/**
		 * 移入 
		 */		
		private var over:BitmapData;
		/**
		 * 正常 
		 */		
		private var normal:BitmapData;
		/**
		 * 选中 
		 */		
		private var selected:BitmapData;
		/**
		 * 当前选择的页签索引 
		 */		
		private var _curIndex:int = -1;
		/**
		 *  当前选中的按钮 
		 */		
		private var _curBtn:TabBarBtn;
		/**
		 * 首次打开页签后，记录页签顺序 
		 */		
		private var _btnList:Vector.<TabBarBtn> = new Vector.<TabBarBtn>();
		/**
		 * 设置三态皮肤 
		 * @param over
		 * @param normal
		 * @param selected
		 * 
		 */		
		public function setSkin(over:BitmapData,normal:BitmapData,selected:BitmapData):void
		{
			this.over = over;
			this.normal = normal;
			this.selected = selected;
		}
		
		public function TabBar()
		{
			super();
		}

		public function set type(value:int):void
		{
			_type = value;
		}
		
		public function set dataProvider(arr:Array):void
		{
			clear();
			var btn:TabBarBtn;
			var data:Object;
			var heroId:int = -1;
			for(var i:int = 0; i < arr.length; i++)
			{
				btn = new TabBarBtn(normal,selected,over);
				addChild(btn);
				btn.index = i;
				btn.data = arr[i];
				btn.addEventListener(MouseEvent.MOUSE_UP,onClick);
				_btnList.push(btn);
			}
			graphics.clear();
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,67,arr.length * 45);
			this.graphics.endFill();
		}
		
		/**
		 * 点击 
		 * @param event
		 */		
		protected function onClick(event:MouseEvent):void
		{
			var btn:TabBarBtn;
			btn = event.target as TabBarBtn;
			curIndex = (btn.index);
			// 切页音效
			SoundManager.inst.play(SoundConfig.TOOGLE_CLICK);
		}
		
		/**
		 * 当前选择的页签 
		 */
		public function get curIndex():int
		{
			return _curIndex;
		}
		
		/**
		 * 设置当前页签
		 * @private
		 */
		public function set curIndex(value:int):void
		{
			_curIndex = value;
			for each(var tab:TabBarBtn in _btnList)
			{
				if(tab.index != value)
				{
					tab.selected = false;
				}
				else
				{
					tab.selected = true;
					_curBtn = tab;
				}
			}
			if(_curBtn && _curBtn.data)
				dispatchEvent(new TabEvent(TabEvent.SELECTED,_curBtn.data));
		}
		
		/**
		 * 当前选中的按钮 
		 * @return 
		 * 
		 */		
		public function get curBtn():TabBarBtn
		{
			return _curBtn;
		}
		
		public function clear():void
		{
			for each(var tab:TabBarBtn in _btnList)
			{
				removeChild(tab);
				tab.clear();
				tab = null;
			}
			_btnList.length = 0;
			this.graphics.clear();
		}

	}
}