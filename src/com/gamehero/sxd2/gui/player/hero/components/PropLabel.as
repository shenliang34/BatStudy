package com.gamehero.sxd2.gui.player.hero.components
{
	import com.gamehero.sxd2.data.GameDictionary;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 设置属性数据  如：  等级 1 生命 20000
	 * @author weiyanyu
	 * 创建时间：2015-8-24 下午3:48:59
	 * 
	 */
	public class PropLabel extends ActiveLabel
	{
		private var _label:Label;
		/*private var _propNumLabel:ActiveLabel;*/
		private var _propName:String;
		public function PropLabel(propName:String,propNum:String,bd:BitmapData)
		{
			super();
			
			_propName = propName;
			var detailBg:Bitmap = new Bitmap(bd);
			detailBg.y = -5;
			this.addChild(detailBg);
			_label = new Label();
			_label.text = _propName;
			addChild(_label);
			_label.color = GameDictionary.WINDOW_BLUE;
			_label.width = 28;
			_label.x = 10;
			
			/*_propNumLabel = new ActiveLabel();
			_propNumLabel.cursorActive = false;
			_propNumLabel.label.text = propNum;
			_propNumLabel.label.color = GameDictionary.WINDOW_WHITE;
			addChild(_propNumLabel);
			_propNumLabel.x = 38;*/
			
		}
		/**
		 * 设置属性数据 
		 * @param value
		 * 
		 */		
		public function set propNum(value:int):void{
			_label.text = _propName + " " + GameDictionary.WHITE_TAG + value.toString() + GameDictionary.COLOR_TAG_END;
		}
		
		public function setHint(value:String):void
		{
			this.hint = value;
		}
	}
}