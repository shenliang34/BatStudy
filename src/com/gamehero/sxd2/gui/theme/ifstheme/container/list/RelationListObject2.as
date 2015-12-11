package com.gamehero.sxd2.gui.theme.ifstheme.container.list {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.AnotherPlayerEvent;
	import com.pps.ifs.event.FriendWinEvent;
	import com.gamehero.sxd2.event.RelationEvent;
	import com.gamehero.sxd2.gui.proxy.RelationProxy;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.pro.GS_Gender_Pro;
	import com.gamehero.sxd2.pro.GS_RoleBase_Pro;
	import com.gamehero.sxd2.pro.GS_UserStat_Pro;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.container.list.IItemRenderer;
	import alternativa.gui.theme.defaulttheme.controls.text.LabelWithIcon;
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
	public class RelationListObject2 extends ActiveObject implements IItemRenderer {
		
		protected var _data:Object;

		protected var _label:LabelWithIcon;

		protected var _selected:Boolean = false;

		protected var _itemIndex:int = 0;

		// UI
		/*private var _campLb:Label;*/
		private var _nameLb:Label;
		private var _levelLb:Label;

		private var genderBp:Bitmap;
		
		

		public function RelationListObject2() {
			
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
			genderBp = new Bitmap();
			genderBp.bitmapData = new MainSkin.iconMale;
			addChild(genderBp);
			
			/*_campLb = new Label();
			_campLb.x = 23;
			_campLb.y = 2;
			_campLb.width = 160;
			_campLb.text = "阵营";
			addChild(_campLb);*/
			
			_nameLb = new Label();
			_nameLb.x = 31;
			_nameLb.y = 2;
//			_nameLb.text = "牛逼哄哄的窟窿王";
			addChild(_nameLb);
			
			_levelLb = new Label();
			_levelLb.x = 133;
			_levelLb.y = 2;
			_levelLb.text = "Lv.999";
			addChild(_levelLb);
			
			
			var text1:Label = new Label();
//			text1.text = "关注了你";
			text1.x = 170;
			text1.y = 2;
			text1.color = GameDictionary.YELLOW;
			addChild(text1);
			
			
			var _detailButton:Button;
			_detailButton = new Button(MainSkin.searchButtonUp, MainSkin.searchButtonUp, MainSkin.searchButtonOver, MainSkin.searchButtonUp);
			_detailButton.x = 230;
			_detailButton.y = 2;
			_detailButton.addEventListener(MouseEvent.CLICK, onDetailItem);
			addChild(_detailButton);

			var _gouButton:Button;
			_gouButton = new Button(MainSkin.gouButtonUp, MainSkin.gouButtonUp, MainSkin.gouButtonOver, MainSkin.gouButtonUp);
			_gouButton.x = 255
			_gouButton.y = 2;
			_gouButton.addEventListener(MouseEvent.CLICK, onAddFriend);
			addChild(_gouButton);

			var _chaButton:Button;
			_chaButton = new Button(MainSkin.closeButton2Down, MainSkin.closeButton2Down, MainSkin.closeButton2Over, MainSkin.closeButton2Down);
			_chaButton.x = 280;
			_chaButton.y = 2;
			_chaButton.addEventListener(MouseEvent.CLICK, onRemoveItem);
			addChild(_chaButton);

		}
		
		
		private function onDetailItem(event:MouseEvent):void
		{
			this.dispatchEvent(new AnotherPlayerEvent(AnotherPlayerEvent.VIEW_ANOTHER_PLAYER_E, _data.userID)); 
		}
		
		
		private function onRemoveItem(event:MouseEvent):void
		{
			var friendEvent:FriendWinEvent = new FriendWinEvent(FriendWinEvent.REMOVE_ITEM, true);
			friendEvent.index = itemIndex;
			this.dispatchEvent(friendEvent);
		}
		
		private function onAddFriend(event:MouseEvent):void
		{
			var relationEvent:RelationEvent = new RelationEvent(RelationEvent.RELATION_CHANGE_OPERATOR, _data.username);
			relationEvent.operatorType = RelationProxy.OPERATORTYPE_ADD_FRIEND;
			this.dispatchEvent(relationEvent);
			
			var friendEvent:FriendWinEvent = new FriendWinEvent(FriendWinEvent.REMOVE_ITEM ,true);
			friendEvent.index = itemIndex;
			this.dispatchEvent(friendEvent);
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
			
			var relationUserInfo:GS_RoleBase_Pro = _data as GS_RoleBase_Pro;
			if (relationUserInfo != null) {
				
				// 性别
				if(relationUserInfo.sex == GS_Gender_Pro.MAN) {
					
					genderBp.bitmapData = new MainSkin.iconMale;
				}
				else {
					
					genderBp.bitmapData = new MainSkin.iconFemale;
				}
				
				// 信息
				/*_campLb.text = String(relationUserInfo.zoneid);*/
				_nameLb.text = relationUserInfo.username;
				_levelLb.text = "Lv." + String(relationUserInfo.level);
				
				// 在线与否
				if(relationUserInfo.stat > GS_UserStat_Pro.User_Offline) {
					
					/*_campLb.color = GameDictionary.WHITE;*/
					_nameLb.color = GameDictionary.WHITE;
					_levelLb.color = GameDictionary.WHITE;
				}
				else {
					
					/*_campLb.color = GameDictionary.GRAY;*/
					_nameLb.color = GameDictionary.GRAY;
					_levelLb.color = GameDictionary.GRAY;
				}
			}
		}
		
		
        // EN: height of this item is constant
		override public function get height():Number {
			
			return NumericConst.itemHeight + 8;
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
