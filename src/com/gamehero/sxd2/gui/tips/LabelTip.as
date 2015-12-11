package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * 单纯文本tips
	 * @author weiyanyu
	 * 创建时间：2015-8-26 下午4:52:05
	 * 
	 */
	public class LabelTip extends Sprite
	{
		private var _label:TextField;
		
		private var _tween:TweenMax;
		public function LabelTip()
		{
			super();
			_label = new TextField();
			_label.textColor = GameDictionary.TASK_GREEN;
			addChild(_label);
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
			_tween = TweenMax.to(this , 2 , {y:this.y - 150,alpha:0 , onComplete:onAlpha,delay:.2});
		}
		
		
		protected function onAlpha():void
		{
			if(_tween) 
			{
				_tween.kill();
				_tween = null;
			}
			_label.text = "";
			this.parent.removeChild(this);
		}
	}
}