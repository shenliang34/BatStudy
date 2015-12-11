package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.CursorManager;
	
	
	/**
	 * 翻页按钮组件 
	 * @author Trey
	 * @create-date 2013-11-7
	 */
	public class PageButton extends GUIobject {
		
		private var _prePageButton:Button;
		private var _nextPageButton:Button;
		private var _pageLabel:Label;
		
		private var _page:int = 0;
		private var _pageNums:int = 0;	// 每页数量
		private var _maxNums:int = 0;	// 总数量
		private var _pages:int = 0;		// 总页数
		private var _turnCallBack:Function;
		
		
		/**
		 * Constructor 
		 * 
		 */
		public function PageButton() {
			
			_prePageButton = new Button(CommonSkin.LeftStepper_Up,CommonSkin.LeftStepper_Down,CommonSkin.LeftStepper_Over);
			_prePageButton.locked = true;
			_prePageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_prePageButton.x = 0;
			_prePageButton.y = 0;
			addChild(_prePageButton);
			
			_nextPageButton = new Button(CommonSkin.RightStepper_Up,CommonSkin.RightStepper_Down,CommonSkin.RightStepper_Over);
			_nextPageButton.locked = true;
			_nextPageButton.addEventListener(MouseEvent.CLICK , onTurnPage);
			_nextPageButton.x = 72;
			_nextPageButton.y = 0;
			addChild(_nextPageButton);

			_pageLabel = new Label();
			_pageLabel.text = "0/0";
			_pageLabel.align = Align.CENTER;
			_pageLabel.color = GameDictionary.GRAY;
			_pageLabel.width = 45;
			_pageLabel.x = 22;
			_pageLabel.y = 2;
			addChild(_pageLabel);
		}
		
				
		/**
		 * 初始化 
		 * @param pageNums
		 * @param maxNums
		 * @param turnCallBack
		 * 
		 */
		public function init(pageNums:int, maxNums:int, turnCallBack:Function):void {
			
			this._page = 0;
			this._pageNums = pageNums;
			this._maxNums = maxNums;
			this._pages = Math.ceil(_maxNums / _pageNums);
			
			_turnCallBack = turnCallBack;
			
			update();
		}
		
		
		/**
		 * Reset 
		 * 
		 */
		public function reset():void {
			
			this._pageNums = 0;
			this._maxNums = 0;
			this._pages = 0;
			this._page = 0;
			
			update();
		}
		
		
		/**
		 * Update UI 
		 * 
		 */
		private function update():void {
			
			_pageLabel.text = (_pages > 0 ? String(_page + 1) : "0") + "/" + String(_pages);
			
			_prePageButton.locked = _page > 0 ? false : true;
			_nextPageButton.locked = _page < _pages - 1 ? false : true;
			if(_prePageButton.locked){
				Mouse.cursor = CursorManager.ARROW;
			}
			if(_nextPageButton.locked){
				Mouse.cursor = CursorManager.ARROW;
			}
			
		}
		
		
		/**
		 * 翻页Handler
		 * @param event
		 * 
		 */
		private function onTurnPage(event:MouseEvent):void {
			
			if(event.target == _prePageButton) {
				
				page--;
			}
			else if(event.target == _nextPageButton) {
				
				page++;
			}
		}

		
		public function get page():int {
			
			return _page;
		}

		
		public function set page(value:int):void {
			
			if(value < _pages) {
				
				_page = value;
				_page = Math.max(0 , _page);
				
				update();
				
				if(_turnCallBack) {
					
					_turnCallBack();
				}
			}
		}

		public function get maxNums():int
		{
			return _maxNums;
		}

		public function set maxNums(value:int):void
		{
			_maxNums = value;
			this._pages = Math.ceil(_maxNums / _pageNums);
			update();
		}
		
		public function get pages():int{
			return _pages;
		}
	}
}