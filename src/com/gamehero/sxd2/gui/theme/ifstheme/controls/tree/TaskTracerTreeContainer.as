package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree
{
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.list.IItemRenderer;
	import alternativa.gui.controls.tree.TreeItemContainer;
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.DataChangeEvent;
	import alternativa.gui.event.ListEvent;
	
	import org.bytearray.display.ScaleBitmap;
	
	use namespace alternativagui;
	
	/**
	 * 任务追踪栏，可折叠子项组件 
	 * @author xuqiuyang
	 * 
	 */	
	public class TaskTracerTreeContainer extends TreeItemContainer
	{

		protected var _contentHeight:Number;
		
		protected var _itemBg:ScaleBitmap;
		
		//选中的任务数据，没法通过id之类的属性来确定当前选中的item，只能通过data对象来确定了
		protected var _selectData:Object;
		
		protected var _visibleItems:Array;
		
		public function TaskTracerTreeContainer()
		{
			super();
			
			_itemBg = new ScaleBitmap(ChatSkin.CHAT_OUTPUT_BG_BD);
			_itemBg.scale9Grid = new Rectangle(10,10,200,25);
			addChildAt(_itemBg, 0);
			_itemBg.visible = false;
			
			_visibleItems = [];
			
			addEventListener(MouseEvent.MOUSE_MOVE, moveOnItem);
			addEventListener(MouseEvent.ROLL_OUT, moveOutItem);
		}
		
		private function moveOutItem(event:MouseEvent):void
		{
			_itemBg.visible = false;
		}
		
		protected function moveOnItem(event:MouseEvent):void
		{
			_itemBg.visible = false;
			
			var item:GUIobject;
			var pos:Point;
			for(var i:int = 0; i < _visibleItems.length; i++)
			{
				item = _visibleItems[i];
				pos = item.globalToLocal(this.localToGlobal(new Point(this.mouseX,this.mouseY)));
				if(pos.y > 0 && pos.y < item.height)
				{
					if((item as IItemRenderer).data.level == 0)
						makeItemBgByTitleItem(item);
					else
					{
						var index:int = (item as IItemRenderer).itemIndex;
						index--;
						if(index >= 0)
						{
							while(_visibleItems[index] && (_visibleItems[index] as IItemRenderer).data.level == 1)
							{
								index--;
							}
							if(_visibleItems[index])
							{
								item = _visibleItems[index];
								makeItemBgByTitleItem(item);
							}
						}
					}
				}
			}
		}
		
		override public function set itemRenderer(value:Class):void {
			ItemClass = value;
		}
		
		override public function get dataProvider():DataProvider {
			return _dataProvider;
		}
		override public function set dataProvider(value:DataProvider):void {
			var i:int = 0;
			var prop:*;
			if (_dataProvider) {
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, changeData);
				
//				for (prop in dataDictionary) {
//					dataDictionary[prop].data = null;
//					delete dataDictionary[prop];
//				}
				
//				for (prop in visibleElementsDictionary) {
//					(visibleElementsDictionary[prop] as IItemRenderer).data = null;
//					delete visibleElementsDictionary[prop];
//				}
//				var itemsArrayLength:int = itemsArray.length;
//				for (i = 0; i < itemsArrayLength; i++) {
//					if (contains(itemsArray[i])) {
//						removeChild(itemsArray[i]);
//					}
//				}
				_vertValue = 0;
			}
			_dataProvider = value;

			
			draw();
			
			if (_dataProvider != null) 
				_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, changeData);
			
			dispatchEvent(new Event(ListEvent.REDRAW));
		}
		
		/**
		 * 点击任务追踪栏确定点击的对象 
		 * @param e
		 * 
		 */		
		override protected function clickOnItem(e:MouseEvent):void {
			if (e.target is IItemRenderer || (e.target as DisplayObject).parent is IItemRenderer) {
				var target:IItemRenderer;
				if(e.target is IItemRenderer)
					target = e.target as IItemRenderer;
				else if((e.target as Sprite).parent is IItemRenderer)
					target = (e.target as DisplayObject).parent as  IItemRenderer;
				
				selectItem(target.itemIndex, true);
				
				dispatchEvent(new ListEvent(ListEvent.CLICK_ITEM, target.data));
			}
		}
		
		/**
		 * 选择item 
		 * @param index
		 * @param showElement
		 * 
		 */		
		override protected function selectItem(index:int, showElement:Boolean = false):void {
			if(index < 0 || index >= _visibleItems.length)return;
			var item:* = _visibleItems[index];
			var opened:Boolean = (item as IItemRenderer).data.opened;
			if((item as IItemRenderer).data.level == 0)
			{
				_selectData = (item as IItemRenderer).data;
				(item as IItemRenderer).data.opened = !opened;
			}
			draw();
			
			if (_dataProvider != null) 
				_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, changeData);
			
			dispatchEvent(new Event(ListEvent.REDRAW));
			
			if(_height >= _contentHeight)
			{
				_vertValue = 0;
				draw();
				
				if (_dataProvider != null) 
					_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, changeData);
				dispatchEvent(new Event(ListEvent.REDRAW));
			}
		}
		
		override protected function changeData(e:Event):void {
			var dataProviderLength:int = _dataProvider.length; 
			var prop:*;
			if (dataProviderLength == 0) {
//				for (var prop:* in visibleElementsDictionary) {
//					delete visibleElementsDictionary[prop];
//				}
				dispatchEvent(new Event(ListEvent.REMOVE_DATA));
				_vertValue = 0;
			} else {
//				for (prop in dataDictionary) {
//					dataDictionary[prop].data = null;
//					delete dataDictionary[prop];
//				}
//				for (var i:int = 0; i < dataProviderLength; i++) {
//					if (dataDictionary[i] == null) {
//						dataDictionary[i] = new Object();
//					}
//					dataDictionary[i].data = _dataProvider.getItemAt(i);
//					dataDictionary[i].id = i;
//					if(selectedItem != null) {
//						if (_dataProvider.getItemAt(i) == selectedItem) { 
//							dataDictionary[i].selected = true;
//						}
//					} else {
//						dataDictionary[i].selected = false;
//					}
//				}
				update();
				dispatchEvent(new Event(ListEvent.REDRAW));
			}
			_height = calculateHeight(_height);
			draw();
		}
		
		override protected function calculateHeight(value:int):int {
			var h:Number;
			_height = value;
			return _height;
		}
		
		override public function set height(value:Number):void {
			_height = value;
		}
		
		override public function set width(value:Number):void {
			_width = value;
		}
		
		override protected function draw():void {
			//super.draw();
			if(_dataProvider == null || _dataProvider.length == 0)return;
			
			var itemsArrayLength:int = itemsArray.length;
			
			for (i = 0; i < _visibleItems.length; i++) {
				if (contains(_visibleItems[i])) {
					removeChild(_visibleItems[i]);
				}
			}
			
			_visibleItems.length = 0;
			
			_contentHeight = 0;
			
//			if(this.contains(_itemBg))
//				removeChild(_itemBg);
			
			_itemBg.visible = false;
			
			var item:*;
			var itemData:Object;
			var space:int; 
			var parentOpened:Boolean = false;
			
			var isSelect:Boolean;
			
			for(var i:int = 0, l:int = _dataProvider.length; i < l; i++)
			{
				itemData = _dataProvider.getItemAt(i);
				
				if(i < itemsArrayLength)
				{
					item = itemsArray[i];
				}
				else
				{
					item = new ItemClass();
					itemsArray.push(item);
				}
				 	
				(item as GUIobject).mouseChildren = true;
				(item as IItemRenderer).data = itemData;
				(item as IItemRenderer).itemIndex = _visibleItems.length;
				(item as IItemRenderer).selected = false;
				
				//先判断标题
				if(itemData.level == 0)
				{
					space = 3;	
					
					parentOpened = itemData.opened;
					item.y = _contentHeight + ((i == 0) ? 0 : space);
					if(!contains(item))
						addChild(item);
					//(item as DisplayObject).visible = true;
					_contentHeight = item.y + item.height;	
					_visibleItems.push(item);
				}
				//再确定内容
				else if(itemData.level == 1)
				{
					space = -2;	
					
					if(parentOpened)
					{
						item.y = _contentHeight + space;
						if(!contains(item))
							addChild(item);
						_contentHeight = item.y + item.height;
						_visibleItems.push(item);
					}
					else
					{
						if (contains(item)) {
							removeChild(item);
						}
					}
				}
			}
			this.scrollRect = new Rectangle(0, _vertValue, _width, _height);
			
			
			//dispatchEvent(new Event(ListEvent.REDRAW));
		}
		
		private function makeItemBgByTitleItem(item:*):void
		{
			if((item as IItemRenderer).data.level == 1)return;
			
			_itemBg.visible = true;
			_itemBg.x = item.x - 2;
			_itemBg.y = item.y - 2;
			_itemBg.width = 180;
			_itemBg.height = (item as GUIobject).height + 6;
			
			var index:int = (item as IItemRenderer).itemIndex;
			index++;
			while(_visibleItems[index] && (_visibleItems[index] as IItemRenderer).data.level != 0)
			{
				item = _visibleItems[index];
				_itemBg.height = (item.y - _itemBg.y + (item as GUIobject).height + 2);
				index++;
			}
		}
		
		override public function get showScrollBar():Boolean {
			if (_dataProvider && _dataProvider.length > 0 && _height < contentHeight) {
				return true;
			} else {
				return false;
			}
		}
		
		override public function get contentHeight():Number {
			return _contentHeight;
		}
		
		override public function get mouseDelta():Number {
			return 20;
		}
	}
	
	
}