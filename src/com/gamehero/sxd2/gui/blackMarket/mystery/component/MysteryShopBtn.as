package com.gamehero.sxd2.gui.blackMarket.mystery.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import alternativa.gui.enum.Align;
	
	
	/**
	 * 刷新按钮
	 * @author weiyanyu
	 * 创建时间：2015-9-29 下午3:46:42
	 * 
	 */
	public class MysteryShopBtn extends Button
	{
		
		private var _numLb:Label;
		
		private var _numSp:Sprite;
		
		public function MysteryShopBtn()
		{
			super(CommonSkin.blueBigButton3Up,CommonSkin.blueBigButton3Down,CommonSkin.blueBigButton3Over,CommonSkin.blueBigButton3Disable);
			var global:Global = Global.instance;
			var model:BlackMarketModel = BlackMarketModel.inst;
			
			_numSp = new Sprite();
			addChild(_numSp);
			_numSp.x = 73;
			_numSp.y = -4;
			
			var numBg:Bitmap = new Bitmap(global.getBD(model.domain,"NumBg"));
			_numSp.addChild(numBg);
			
			_numLb = new Label();
			_numSp.addChild(_numLb);
			_numLb.width = 20;
			_numLb.align = Align.CENTER;
			_numLb.y = 3;
			
			this.width = 84;
			this.height = 32;
		}
		
		public function set num(value:int):void
		{
			_numSp.visible = value > 0;
			_numLb.text = value.toString();
		}
	}
}