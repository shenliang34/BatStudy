package com.gamehero.sxd2.guide.gui
{
	
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 简单窗口 
	 * @author wulongbin
	 */	
	public class SimpleWindow extends Sprite
	{
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		
		
		/**
		 * 构造函数
		 * */
		public function SimpleWindow()
		{
			super();
			
			this.initWindow();
		}
		
		
		
		/**
		 * 初始化窗口
		 * */
		protected function initWindow():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE , onAddtoStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemoveFromStage);
		}
		
		
		
		protected function onAddtoStage(event:Event):void
		{
			if(stage)
			{
				stage.addEventListener(Event.RESIZE,onResize,false,int.MAX_VALUE);
			}
			
			this.onResize();
		}
		
		
		
		protected function onRemoveFromStage(event:Event):void
		{
			if(stage)
			{
				stage.removeEventListener(Event.RESIZE, onResize);
			}
		}
		
		
		
		protected function onResize(e:Event = null):void
		{
			if(stage)
			{
				this.x = stage.stageWidth - width >> 1;
				this.y = stage.stageHeight - height >>1;
			}
		}
		
		
		/**
		 * 关闭窗口
		 * */
		public function close():void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
		}

		override public function get height():Number
		{
			return _height;
		}

		override public function set height(value:Number):void
		{
			_height = value;
		}

		
		public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}

	}
}