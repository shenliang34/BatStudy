package com.gamehero.sxd2.guide
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	public class GuideArrow extends Sprite
	{
		protected var _bg:ScaleBitmap;
		protected var _label:Label;
		protected var _arrow:DisplayObject;
		protected var _direction:int;
		protected var _width:Number;
		protected var _height:Number;
		public function GuideArrow()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_bg = new ScaleBitmap(MainSkin.arrowBG);
			_bg.scale9Grid = MainSkin.arrowBGScale9Grid;
			addChild(_bg);
			
			_label = new Label();
			_label.leading = 0.4;
			addChild(_label);
		}
		
		public function setLabel(value:String, dir:int):void
		{
			_label.text = value;
			_label.y = 70 - _label.height >> 1;
			_label.x = 20;
			
			width = _label.width + 40;
			height = 70;
			
			_bg.setSize(width, height);
			
			_direction = dir;
			const dis:uint = 13;
			switch(dir)
			{
				case Guide.Direct_Down:
					arrow = new  (MainSkin.getSwfClass("Arrow_Down"));
					arrow.x = width >> 1;
					arrow.y = height +dis;
					break;
				case Guide.Direct_Up:
					arrow = new  (MainSkin.getSwfClass("Arrow_Up"));
					
					arrow.x = width >> 1;
					arrow.y =- dis;
					break;
				case Guide.Direct_Left:
					arrow = new  (MainSkin.getSwfClass("Arrow_Left"));
					arrow.x = - dis;
					arrow.y = height  >>1;
					break;
				case Guide.Direct_Right:
					arrow = new  (MainSkin.getSwfClass("Arrow_Right"));
					
					arrow.x = width + dis;
					arrow.y = height  >>1;
					break;
			}
		}

		protected function get arrow():DisplayObject
		{
			return _arrow;
		}

		protected function set arrow(value:DisplayObject):void
		{
			if(_arrow)
			{
				removeChild(_arrow);
			}
			_arrow = value;
			if(_arrow)
			{
				addChild(_arrow);
			}
		}

		public function get direction():int
		{
			return _direction;
		}

		public function set direction(value:int):void
		{
			_direction = value;
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


	}
}