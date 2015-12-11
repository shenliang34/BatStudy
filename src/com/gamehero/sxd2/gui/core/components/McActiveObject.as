package com.gamehero.sxd2.gui.core.components
{
	import flash.display.Shape;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * <b>嵌套的鼠标区域</b><br>
	 * 有些mc组件无法直接响应 activeObject的鼠标事件，<br>
	 * 在tips、鼠标状态等方面会有问题，因此在mc上面<br>
	 * 添加一个交互的层,方便响应鼠标事件
	 * @author weiyanyu
	 * 创建时间：2015-9-2 下午2:58:38
	 * 
	 */
	public class McActiveObject extends ActiveObject
	{
		/**
		 * 章节节点 
		 */		
		public static var HurdleGuideNode:int = 1;
		/**
		 * 章节宝箱 
		 */		
		public static var HurdleGuideBox:int = 2;
		
		private var shape:Shape;
		
		public function McActiveObject(type:int = 0)
		{
			this.type = type;
			super();
			
			shape = new Shape();
			addChild(shape);
		}
		
		private var _type:int;
		/**
		 * 基础数据 
		 */		
		private var _data:*;
		
		private var _pro:*;
		/**
		 * 额外参数 
		 */		
		private var _ent:*;
		
		public function get ent():Object
		{
			return _ent;
		}

		public function set ent(value:Object):void
		{
			_ent = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}
		/**
		 * 设置类型，表示设置的位置 
		 * @return 
		 * 
		 */
		public function get data():*
		{
			return _data;
		}

		public function set data(value:*):void
		{
			_data = value;
		}

		public function get pro():*
		{
			return _pro;
		}

		public function set pro(value:*):void
		{
			_pro = value;
		}
		/**
		 * 设置交互区域 
		 * @param w
		 * @param h
		 * @param px
		 * @param py
		 * 
		 */		
		public function setArea(w:int,h:int,px:int = 0, py:int = 0):void
		{
			shape.graphics.clear();
			shape.graphics.beginFill(0,0);
			shape.graphics.drawRect(px, py,w,h);
			shape.graphics.endFill();
		}
		
		override public function get height():Number
		{
			return shape.height;
		}
		
		override public function get width():Number
		{
			return shape.width;
		}
	}
}