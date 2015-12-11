package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree {

	import alternativa.gui.alternativagui;
	import alternativa.gui.container.list.IItemRenderer;

	use namespace alternativagui;
	
	/**
	 * 
	 * RU: визуальный класс для элемента List. Реализует интерфейс IItemRenderer.
	 * Данный класс представляет из себя визуальный элемент содержащий текстовую метку с иконкой(LabelWithIcon).
	 * EN: Visual class for List item. Implements IItemRenderer interface
     * This is the visual item witch contain a text label and an icon(LabelWithIcon)
     *
	 */	
	public class TaskTreeListObject extends TaskTreeSimpleButton implements IItemRenderer {
		
		static private const LIST_OBJECT_HEIGHT:int = 20;
		
		static private const WIDTH:int = 200;
		
		protected var _data:Object;

//		protected var _label:LabelWithIcon;
//		protected var _label:Label;
		protected var _label:TaskTreeLabel;

		protected var _selected:Boolean = false;

		protected var _itemIndex:int = 0;

		
		
		public function TaskTreeListObject(TREE_SIMPLEBUTTON_UP:Class = null, TREE_SIMPLEBUTTON0_UP:Class = null) {
			
			super(TREE_SIMPLEBUTTON_UP, TREE_SIMPLEBUTTON0_UP);
			
			// RU: добавляем текстовую метку с иконкой
            // EN: add a text label with an icon
//			_label = new LabelWithIcon();
//			_label = new Label();
			
			_label = new TaskTreeLabel();
			_label.isClickActive = true;
			_label.setTextWidth(WIDTH);
			addChild(_label);
			
			// RU: задаем высоту элемента
            // EN: set the item height
			_height = calculateHeight(_height);
			
			//this.mouseChildren = false;
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
			if (_selected) {
				setState(_stateDOWN);
			} else {
				setState(_stateUP);
				_over = false;
				_pressed = false;
			}
		}
		
		// RU: лочим состояние наведения, если элемент выбран
        // EN: If item is selected lock the mouseover state
		override public function set over(value:Boolean):void {
			if (!_selected) {
				super.over = value;
			}
		}
		
		// RU: лочим состояние нажатия, если элемент выбран
        // EN: If item is selected lock the mouseclick state
		override public function set pressed(value:Boolean):void {
			if (!_selected) {
				super.pressed = value;
			}
		}

		public function get data():Object {
			return _data;
		}

		public function set data(object:Object):void {
			// RU: при получении данных элементом, сохраняем данные
            // EN: save the date on receiving by the item
			_data = object;
			// RU: изменяем текст и иконку
            // EN: change the text and an icon
			if (_data != null)
			{
				if (!_data.canExpand)
				{
					_label.x = 20;
				}
				_label.text = _data.label;
				
				// tips
				_label.hint = _label.text;
			} 
			else 
			{
				_label.text = " ";
				_label.hint = "";
			}
			
//			draw();
		}
		// RU: высота у данного элемента является постоянной
        // EN: height of this item is constant
		override public function get height():Number {
//			return NumericConst.itemHeight;
			return LIST_OBJECT_HEIGHT;
		}
		
		// RU: указываем расположение текстовой метки
        // EN: set the position for a text label
		override protected function draw():void {
			super.draw();
			
			_label.width = _width - _padding * 2;
		}

		// RU: смотрим ширину элемента, проверка на минимальную ширину
        // EN: check on minimal width
		override protected function calculateWidth(value:int):int {
			if (value < (_label.width + _padding * 2)) {
				return (_label.width + _padding * 2);
			} else {
				return value;
			}
		}
	}
}
