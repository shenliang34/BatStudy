package com.gamehero.sxd2.gui.core.money
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.events.Event;
	
	import alternativa.gui.base.ActiveObject;
	
	
	/**
	 * 金钱文本<br>
	 * 一个物品图标，一串数字
	 * @author weiyanyu
	 * 创建时间：2015-11-15 下午6:23:54
	 * 
	 */
	public class MoneyLabel extends ActiveObject
	{
		
		private var _icon:MoneyIcon;
		
		private var _label:Label;
		
		public function MoneyLabel()
		{
			super();
			_icon = new MoneyIcon();
			_label = new Label();
			
			addChild(_icon);
			addChild(_label);
		}
		
		public function set iconId(value:int):void
		{
			if(_icon.iconId != value)
			{
				_icon.iconId = value;
				_icon.addEventListener(Event.COMPLETE,onComplet);
			}
			else
			{
				resize();
			}
		}
		
		private function resize():void
		{
			_label.x = _icon.width + 2;
			_label.y = _icon.height - _label.height >> 1;
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
			resize();
		}
		/**
		 *  根据文本的坐标y设置新坐标；<br>
		 *  正常情况下坐标设置是根据 icon图标的。<br>
		 * 
		 */		
		public function setyByLabel(value:int):void
		{
			this.y = value - _label.y;
		}
		/**
		 * 获取label，方便给lb设置属性 <br>
		 * 注意   不要直接设置文本，否则坐标会有问题
		 * @return 
		 * 
		 */		
		public function get lb():Label
		{
			return _label;
		}
		
		protected function onComplet(event:Event):void
		{
			_icon.removeEventListener(Event.COMPLETE,onComplet);
		}
	}
}