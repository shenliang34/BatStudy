package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.base.ActiveObject;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-3 下午1:58:43
	 * 查看详细信息按钮
	 */
	public class HeroHandbookLookBtn extends ActiveObject
	{
		/**
		 * 伙伴相关信息
		 * */
		public var heroVo:HeroVO;
		public var heroPro:PRO_Hero;
		/**
		 * 按钮
		 * */
		private var btn:GTextButton;
		public var bmp1:Bitmap;
		public var bmp2:Bitmap;
		public function HeroHandbookLookBtn(bmd1:BitmapData,bmd2:BitmapData,vo:HeroVO = null,pro:PRO_Hero = null)
		{
			super();
			
			this.heroVo = vo;
			this.heroPro = pro;
			
			bmp1 = new Bitmap(bmd1);
			bmp2 = new Bitmap(bmd2);
			addChild(bmp1);
			addChild(bmp2);
		}
		/**
		 *for tips
		 */
		public function setData(herovo:HeroVO,heroPro:PRO_Hero = null):void
		{
			this.heroVo = herovo;
			this.heroPro = heroPro;
		}
		
		public function setHint(tips:String):void
		{
			this.btn.hint = " ";
		}
		
		public function clear():void
		{
			bmp1 = null;
			bmp2 = null;
		}
	}
}