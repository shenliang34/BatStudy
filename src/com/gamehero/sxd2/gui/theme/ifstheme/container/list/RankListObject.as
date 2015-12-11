package com.gamehero.sxd2.gui.theme.ifstheme.container.list {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.pro.GS_UserRankInfo_Pro;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.container.list.IItemRenderer;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;
	
	/**
	 * 
	 * RU: визуальный класс для элемента List. Реализует интерфейс IItemRenderer.
	 * Данный класс представляет из себя визуальный элемент содержащий текстовую метку с иконкой(LabelWithIcon).
	 * EN: Visual class for List item. Implements IItemRenderer interface
     * This is the visual item witch contain a text label and an icon(LabelWithIcon)
     *
	 */	
	/**
	 * 排行榜列表ListObject 
	 * @author Trey
	 * @create-date 2014-1-12
	 */
	public class RankListObject extends ActiveObject implements IItemRenderer {
		
		protected var _data:Object;

		protected var _selected:Boolean = false;

		protected var _itemIndex:int = 0;

		// UI
		private var _padding:int = 5;
		
		private var _orderLb:Label;
		private var _campLb:Label;
		private var _userNameLb:Label;
		private var _propLb:Label;

		
		public function RankListObject() {
			
			super();
			// RU: добавляем текстовую метку с иконкой
            // EN: add a text label with an icon
//			_label = new LabelWithIcon();
//			addChild(_label);
			
			// RU: задаем высоту элемента
            // EN: set the item height
//			_height = calculateHeight(_height);
			
			
			_orderLb = new Label();
			_orderLb.x = -3;
			_orderLb.y = _padding - 1;
//			_orderLb.text = "1";
			_orderLb.width = 35;
			_orderLb.align = Align.CENTER;
			_orderLb.size = 16;
			_orderLb.color = GameDictionary.YELLOW;
			_orderLb.bold = true;
			addChild(_orderLb);
			
			_campLb = new Label();
			_campLb.x = 65;
			_campLb.y = _padding;
			_campLb.width = 36;
//			_campLb.text = "魔";
			_campLb.width = 40;
			_campLb.align = Align.CENTER;
			addChild(_campLb);
			
			_userNameLb = new Label();
			_userNameLb.x = 143;
			_userNameLb.y = _padding;
			_userNameLb.width = 90;
			_userNameLb.align = Align.CENTER;
//			_userNameLb.text = "马里奥";
			addChild(_userNameLb);
			
			_propLb = new Label();
			_propLb.x = 260;
			_propLb.y = _padding;
			_propLb.width = 100;
			_propLb.align = Align.CENTER;
//			_propLb.text = "999999";
			addChild(_propLb);
			
		}
		
		
		
		public function get itemIndex():int {
			
			return _itemIndex;
		}

		public function set itemIndex(value:int):void {
			
			_itemIndex = value;
		}

		public function get selected():Boolean {
			
			return _selected;
		}

		public function set selected(value:Boolean):void {
			
			_selected = value;
			// RU: при выделении объекта показываем нужное состояние кнопки
            // EN: if object is selected show an actual button state
//			if (_selected) {
//				setState(_stateDOWN);
//			} else {
//				setState(_stateUP);
//				_over = false;
//				_pressed = false;
//			}
		}
//		
//		// RU: лочим состояние наведения, если элемент выбран
//        // EN: If item is selected lock the mouseover state
//		override public function set over(value:Boolean):void {
//			if (!_selected) {
//				super.over = value;
//			}
//		}
//		
//		// RU: лочим состояние нажатия, если элемент выбран
//        // EN: If item is selected lock the mouseclick state
//		override public function set pressed(value:Boolean):void {
//			if (!_selected) {
//				super.pressed = value;
//			}
//		}
//
		public function get data():Object {
			
			return _data;
		}

		public function set data(object:Object):void {
			
            // EN: save the date on receiving by the item
			_data = object;
			
			if(_data) {
				
				var rankInfo:GS_UserRankInfo_Pro = _data as GS_UserRankInfo_Pro;
				
				_orderLb.text = String(rankInfo.rank);
				_campLb.text = String(rankInfo.camp);
				_userNameLb.text = String(rankInfo.name);
				_propLb.text = String(rankInfo.totalfight);
			}
			
		}
		
		
        // EN: height of this item is constant
		override public function get height():Number {
			
			return NumericConst.itemHeight + 12;
		}
		
		
//		// RU: указываем расположение текстовой метки
//        // EN: set the position for a text label
//		override protected function draw():void {
//			super.draw();
//			_label.x = _padding;
//			_label.width = _width - _padding * 2;
//			_label.y = (_height - _label.height) >> 1;
//		}
//
//		// RU: смотрим ширину элемента, проверка на минимальную ширину
//        // EN: check on minimal width
//		override protected function calculateWidth(value:int):int {
//			if (value < (_label.width + _padding * 2)) {
//				return (_label.width + _padding * 2);
//			} else {
//				return value;
//			}
//		}
		
	}
}
