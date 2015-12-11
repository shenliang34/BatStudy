package com.gamehero.sxd2.world.display
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.BitmapData;
	import flash.text.TextFormat;
	
	import bowser.render.display.RenderItem;
	
	
	/**
	 * 用于渲染引擎富文本对象 
	 * @author xuwenyi
	 */	
	public class RichTextItem extends RenderItem
	{
		private var _richText:RichTextField;
		private var _defaultTextFormat:TextFormat;
		
		
		
		public function RichTextItem()
		{
			super(false);
			
			this.initText();
		}
		
		
		
		private function initText():void
		{
			// 输入文本框
			_defaultTextFormat = new TextFormat();
			_defaultTextFormat.leading = 5;
			_richText = new RichTextField();
			_richText.textfield.filters = null;
			//_richText.domain = ChatDataCenter.mainDomain;
			_richText.textfield.wordWrap = true;
			_richText.textfield.multiline = true;
			
			color = 0xd7deed;
			size = 12;
			
			width = 160;
			height = 60;
		}
		
		
		
		public function set color(value:uint):void
		{
			_defaultTextFormat.color = value;
			_richText.textfield.defaultTextFormat = _defaultTextFormat;
		}
		
		
		
		
		public function set size(value:int):void
		{
			_defaultTextFormat.size = value;
			_richText.textfield.defaultTextFormat = _defaultTextFormat;
		}
		
		
		
		
		public function set text(value:String):void
		{
			_richText.text = value;
			
			if(renderSource)
			{
				renderSource.dispose();
				renderSource = null;
			}
			
			drawTextField();
		}
		
		
		
		private function drawTextField():void 
		{
			this.renderSource = new BitmapData(width, height , true, 0);
			this.renderSource.draw(_richText);
			isNeedRender = true;
		}
		
		
		
		override public function draw():void
		{
			super.draw();
		}
		
		
		
		override public function set width(value:Number):void
		{
			super.width = value;
			
			_richText.setSize(value - 2 , _richText.height);
		}
		
		
		
		override public function set height(value:Number):void
		{
			super.height = value;
			
			_richText.setSize(_richText.width,value - 2);
		}
	}
}