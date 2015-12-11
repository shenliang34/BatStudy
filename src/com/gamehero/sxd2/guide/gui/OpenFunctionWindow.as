package com.gamehero.sxd2.guide.gui
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.util.BitmapLoader;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	/**
	 * 功能开启背景 
	 * @author wulongbin
	 * 
	 */	
	public class OpenFunctionWindow extends SimpleWindow
	{
		private static var _instance:OpenFunctionWindow;
		public static function get instance():OpenFunctionWindow
		{
			return _instance ||(_instance = new OpenFunctionWindow);
		}
		
		
		protected var _iconContainer:Sprite = new Sprite;
		protected var _icon:DisplayObject;
		
		
		public function OpenFunctionWindow()
		{
			
		}
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			var bg:BitmapLoader = new BitmapLoader;
			bg.bmdUrl = GameConfig.GUIDE_URL + "Guide_OpenFuncBG.swf";
			addChild(bg);
			
			_iconContainer.x = 126;
			_iconContainer.y = 66;
			addChild(_iconContainer);
			
			var mouseEffect:MovieClip = new (MainSkin.getRes("MOUSE_CLICK_EFFECT"))();
			mouseEffect.scaleX = mouseEffect.scaleY = .6;
			mouseEffect.x = 85;
			mouseEffect.y = 164 - 32;
			addChild(mouseEffect);
		}
		
		
		public function set icon(value:DisplayObject):void
		{
			if(value != _icon)
			{
				// 删除原来的icon
				if(_icon)
				{
					_iconContainer.removeChild(_icon);
				}
				_icon = value;
				// 添加现在的icon
				if(_icon)
				{
					_iconContainer.addChild(_icon);
				}
			}
			
		}

		public function get icon():DisplayObject
		{
			return _icon;
		}
		
		override public function close():void
		{
			icon = null;
			super.close();
		}
		
		override public function get width():Number
		{
			return 314;
		}
		
		override public function get height():Number
		{
			return 164;
		}

	}
}