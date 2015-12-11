package com.gamehero.sxd2.gui.takeCards.components
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 幸运值进度条
	 * @author weiyanyu
	 * 创建时间：2015-10-27 下午2:55:52
	 * 
	 */
	public class TakeCardsLuckyBar extends Sprite
	{
		
		/**
		 * 进度条 
		 */		
		private var _proBar:MovieClip;
		
		/**
		 * 幸运值 
		 */		
		private var _luckLb:Label;
		
		private var _model:TakeCardsModel;
		
		public function TakeCardsLuckyBar()
		{
			super();
			var global:Global = Global.instance;
			_model = TakeCardsModel.inst;
			
			var progressBg:Bitmap = new Bitmap(global.getBD(_model.domain,("ProgressBarBg"))); 
			addChild(progressBg);
			
			_proBar = global.getRes(_model.domain,"ProgressBar") as MovieClip;
			addChild(_proBar);
			_proBar.y = 7.5;
			
			
			_luckLb = new Label();
			_luckLb.width = 97;
			_luckLb.height = 14;
			_luckLb.x = 88;
			_luckLb.y = 1;
			addChild(_luckLb);
		}
		/**
		 * 设置幸运值 
		 * @param value
		 * 
		 */		
		public function set luck(value:int):void
		{
			_luckLb.text = "幸运值："  + value + "/" + 1000;
			
			_proBar.gotoAndStop(int(value / 10));// 除以1000乘以100 
		}
	}
}