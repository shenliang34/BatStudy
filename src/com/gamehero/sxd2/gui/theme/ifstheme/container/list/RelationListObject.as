package com.gamehero.sxd2.gui.theme.ifstheme.container.list {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.chat.ChatPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.pro.GS_Gender_Pro;
	import com.gamehero.sxd2.pro.GS_RoleBase_Pro;
	import com.gamehero.sxd2.pro.GS_UserStat_Pro;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.container.list.IItemRenderer;
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
	public class RelationListObject extends ActiveObject implements IItemRenderer {
		
		protected var _data:Object;

		protected var _selected:Boolean = false;

		protected var _itemIndex:int = 0;

		// UI
		private var _campLb:Label;
		private var _nameLb:Label;
		private var _levelLb:Label;

		private var genderBp:Bitmap;
		private var _selectedBp:Bitmap;
		

		public function RelationListObject() {
			
			super();
			// RU: добавляем текстовую метку с иконкой
            // EN: add a text label with an icon
//			_label = new LabelWithIcon();
//			addChild(_label);
			
			// RU: задаем высоту элемента
            // EN: set the item height
//			_height = calculateHeight(_height);
			
			
			// 性别ICON
			//var bd:Object = sex == GS_Gender_Pro.MAN ? WindowSkin.iconMale : WindowSkin.iconFemale;
			
			_selectedBp = new Bitmap;
			_selectedBp.x=0;
			_selectedBp.y=0;
			_selectedBp.bitmapData = CommonSkin.blueButton2Down;
			_selectedBp.visible = false;
			addChild(_selectedBp);
			
//			genderBp = new Bitmap();
//			genderBp.x = 3
//			genderBp.y = 2;
//			genderBp.bitmapData = new MainSkin.iconMale;
//			addChild(genderBp);
			
			_campLb = new Label();
			_campLb.x = 26;
			_campLb.y = 4;
			_campLb.width = 160;
//			_campLb.text = "阵营";
			addChild(_campLb);
			
			_nameLb = new Label();
			_nameLb.x = 54;
			_nameLb.y = 4;
//			_nameLb.text = "牛逼哄哄的窟窿王";
			addChild(_nameLb);
			
			_levelLb = new Label();
			_levelLb.x = 156;
			_levelLb.y = 4;
//			_levelLb.text = "Lv.999";
			addChild(_levelLb);
			
			this.doubleClickEnabled = true;
			this.mouseChildren = false ;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			this._selectedBp.visible = true;
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			this._selectedBp.visible = false;
		}
		
		protected function onDoubleClick(event:MouseEvent):void
		{
			var relationUserInfo:Object = _data as Object;
			if(relationUserInfo)
			{
//				ChatPanel.instance.chatToPlayer(relationUserInfo);
			}
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
			
			var relationUserInfo:Object = _data as Object;
			if (relationUserInfo != null) {
				
				// 性别
//				if(relationUserInfo.sex == GS_Gender_Pro.MAN) {
//					
//					genderBp.bitmapData = new MainSkin.iconMale;
//				}
//				else {
//					
//					genderBp.bitmapData = new MainSkin.iconFemale;
//				}
				
				// 信息
//				_campLb.text = String(relationUserInfo.camp);
				_nameLb.text = relationUserInfo.username;
				_levelLb.text = "Lv." + String(relationUserInfo.level);
				
				// 在线与否
//				if(relationUserInfo.stat > GS_UserStat_Pro.User_Offline) {
//					
//					_campLb.color = GameDictionary.WHITE;
//					_nameLb.color = GameDictionary.WHITE;
//					_levelLb.color = GameDictionary.WHITE;
//				}
//				else {
//					
//					_campLb.color = GameDictionary.GRAY;
//					_nameLb.color = GameDictionary.GRAY;
//					_levelLb.color = GameDictionary.GRAY;
//				}
			}
		}
		
		override protected function draw():void
		{
			super.draw();
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, width, height);
		}
		
		
        // EN: height of this item is constant
		override public function get height():Number {
			
			return NumericConst.itemHeight + 2;
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
