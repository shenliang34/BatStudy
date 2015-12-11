package com.gamehero.sxd2.gui.takeCards.components
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.display.SimpleButton;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 抽卡按钮
	 * @author weiyanyu
	 * 创建时间：2015-10-20 下午2:21:45
	 * 
	 */
	public class TakeCardsBtn extends ActiveObject
	{
		/**
		 * 元宝求神 
		 */		
		public static var YUANBAO:int = 1;
		/**
		 * 令牌求神 
		 */		
		public static var LINGPAI:int = 2;
		/**
		 * 确定按钮 
		 */		
		public static var OK:int = 3;
		
		private var _type:int;
		
		private var _btn:SButton;
		public function TakeCardsBtn()
		{
			super();
		}
		
		public function set type(value:int):void
		{
			
			_type = value;
			var global:Global = Global.instance;
			var domain:ApplicationDomain = TakeCardsModel.inst.domain;
			if(_btn)
			{
				if(_btn.parent)
					_btn.parent.removeChild(_btn);
				_btn = null;
			}
			switch(value)
			{
				case YUANBAO:
					_btn = new SButton(global.getRes(domain,"YB_Btn") as SimpleButton);
					addChild(_btn);
					_btn.hint = Lang.instance.trans("searchhero_yuanbao");
					break;
				case LINGPAI:
					_btn = new SButton(global.getRes(domain,"LP_Btn") as SimpleButton);
					addChild(_btn);
					_btn.hint = Lang.instance.trans("searchhero_canye");
					break;
				case OK:
					_btn = new SButton(global.getRes(domain,"OK_Btn") as SimpleButton);
					addChild(_btn);
					_btn.hint = "";
					break;
			}
		}
		
		public function get type():int
		{
			return _type;
		}
	}
}