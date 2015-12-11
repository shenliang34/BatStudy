package com.gamehero.sxd2.gui.core.group
{
	
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 呈现项
	 * @author weiyanyu
	 * 创建时间：2015-9-10 下午4:02:49
	 * 
	 */
	public class ItemRender extends ActiveObject
	{
		/**
		 * 索引 
		 */		
		protected var _itemIndex:int = -1;
		/**
		 * 是否被选中 
		 */		
		protected var _selected:Boolean;
		
		protected var _data:Object;
		
		
		public function ItemRender()
		{
			super();
		}
		
		public function set overAble(value:Boolean):void
		{
			if(value)
			{
				addEventListener(MouseEvent.ROLL_OVER,onMouseOver); 
				addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			else
			{
				removeEventListener(MouseEvent.ROLL_OVER,onMouseOver);
				removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
		}

		/**
		 * 鼠标移出 
		 * @param event
		 * @return 是否有移出效果
		 * 
		 */		
		public function onMouseOut(event:MouseEvent):Boolean
		{
			return true;
		}	
		/**
		 * 鼠标移入 
		 * @param event
		 * @return 是否有移入效果
		 * 
		 */		
		public function onMouseOver(event:MouseEvent):Boolean
		{
			return true;
		}
		public function onDoubleClick():void
		{
			
		}
		/**		 * 点击 
		 * @param event
		 */		
		public function onClick():void
		{
		}
		
		
		public function get itemIndex():int
		{
			return _itemIndex;
		}
		
		public function set itemIndex(value:int):void
		{
			_itemIndex = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		/**
		 * 是否被选中 
		 */	
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function clear():void
		{
			overAble = false;
			_data = null;
		}
	}
}