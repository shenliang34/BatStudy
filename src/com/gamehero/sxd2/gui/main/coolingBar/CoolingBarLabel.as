package com.gamehero.sxd2.gui.main.coolingBar
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.FunctionVO;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-11-5 下午3:06:31
	 * 
	 */
	public class CoolingBarLabel extends ActiveObject
	{
		/**
		 *  
		 */		
		private var _textField:TextField;
		
		private var _data:FunctionVO;
		/**
		 * 图标 
		 */		
		private var _icon:Bitmap;
		/**
		 * 交互区域 
		 */		
		private var _activeObject:Shape;
		
		public function CoolingBarLabel()
		{
			super();
			mouseChildren = false;
			
			_icon = new Bitmap();
			addChild(_icon);
			
			_textField = new TextField();
			_textField.height = 20;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.filters = [Label.TEXT_FILTER];
			_textField.selectable = false;
			addChild(_textField);
			
			var tf:TextFormat = new TextFormat();
			tf.size = 12;
			tf.font = GameDictionary.FONT_NAME;
			_textField.defaultTextFormat = tf;
			
			_activeObject = new Shape();
			addChild(_activeObject);
		}
		
		public function set data(funcVO:FunctionVO):void
		{
			_data = funcVO;
			
			_icon.bitmapData = MainSkin.getSwfBD(funcVO.name + "_coolingBar");
			
			_textField.htmlText = "<font size='12' face='宋体' color='#" + GameDictionary.TASK_GREEN.toString(16) + "'>" + "<u>" +  Lang.instance.trans(funcVO.funcName) + "</u>" + "</font>";
			
			_textField.x = _icon.width;
			_textField.y = (_icon.height - _textField.height >> 1);
			
			_activeObject.graphics.clear();
			_activeObject.graphics.beginFill(0x777777, 0);
			_activeObject.graphics.drawRect(0, 0, _icon.width + _textField.width, _icon.height);
		}
		
		public function get data():FunctionVO
		{
			return _data;
		}
	}
}