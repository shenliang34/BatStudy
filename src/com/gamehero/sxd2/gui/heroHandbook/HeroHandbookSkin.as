package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.SButton;
	
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	

	/**
	 * @author Wbin
	 * 创建时间：2015-8-27 下午8:30:53
	 * 
	 */
	public class HeroHandbookSkin
	{
		/**图鉴面板按钮数*/
		public static const BOOK_BTN_NUM:int = 5;
		/**
		 * 每个分页固定显示12个伙伴
		 * */
		public static const BOOK_NUM:int = 12;
		
		public static var BG_1:BitmapData;
		public static var BG_2:BitmapData
		public static var BTN_ARR:Array = [];
		public static var BTN_POINT:Array = [];
		public static var BOOK_POINT:Array = [];
		
		public static var NO_HERO_BG:BitmapData;
		public static var NO_HEAD_ICON:BitmapData;
		
		public static var ORG_POINT_BG:BitmapData;
		public static var PUR_POINT_BG:BitmapData;
		public static var ORG_BG:BitmapData;
		
		public static var PUR_BG:BitmapData;
		public static var ORG_OVER:BitmapData;
		public static var PUR_OVER:BitmapData;
		
		public static var BLUE_BG:BitmapData;
		public static var BLUE_BG_OVER:BitmapData;
		public static var BLUE_BG_POINT:BitmapData;
		
		public static var GREEN_BG:BitmapData;
		public static var GREEN_BG_OVER:BitmapData;
		public static var GREEN_BG_POINT:BitmapData;
		
		public static var GRAY:BitmapData;
		public static var ENABLE_ACTIVE:BitmapData;
		public static var JB:BitmapData;
		public static var CHIP:BitmapData;
		public static var YUNHUN:BitmapData;
		public static var IN_BATTLE:BitmapData;
		public static var IN_FETTER:BitmapData;
		public static var FDJ:BitmapData;
		public static var FDJ_BG:BitmapData;
		public static var BAR_BG:BitmapData;
		public static var PROGRESS_BAR:Class;
		public static var SMALL_PROGRESS_BAR:Class;
		public static var BOX:Class;
		public static var FIGURE_BG:BitmapData;
		
		public static var BASE:BitmapData;
		public static var INTROUDUCE:BitmapData;
		public static var FETTER:BitmapData;
		
		public static var HERO_BG:Class;
		public static var POWER_BG:Class;
		public static var TIP_BG:Class
		public static var BIG_MASK:BitmapData;
		public static var LINE:BitmapData;
		
		public static var EFFECT:Array = [];
		
		public function HeroHandbookSkin()
		{
			
		}
		
		public static function init(domain:ApplicationDomain):void
		{
			BOOK_POINT = [new Point(103,134),new Point(237,80),new Point(408,113),new Point(581,90),new Point(719,113),new Point(882,183),
					      new Point(76,314),new Point(214,349),new Point(339,268),new Point(489,262),new Point(671,290),new Point(825,342)];
			
			BTN_POINT = [new Point(682,507),new Point(372,503),new Point(444,468),new Point(524,459),new Point(604,467)];
			var btnName:Array = ["zl","xz","rz","mz","yz","resolveBtn","back","arrows","arrows","cl","fj","arrows","arrows","circleBtn"];
			var sBtn:SButton;
			for(var i:int = 0;i<btnName.length;i++)
			{
				sBtn = new SButton(Global.instance.getRes(domain,btnName[i]) as SimpleButton);
				BTN_ARR.push(sBtn);
			}
			
			BG_1 =  Global.instance.getBD(domain,"bg1");
			BG_2 =  Global.instance.getBD(domain,"bg2");
			ORG_POINT_BG = Global.instance.getBD(domain,"orgPiontBg");
			PUR_POINT_BG = Global.instance.getBD(domain,"purplePointBg");
			ORG_BG = Global.instance.getBD(domain,"orgCellBg");
			PUR_BG = Global.instance.getBD(domain,"purpleCellBg");
			ORG_OVER = Global.instance.getBD(domain,"orgOver");
			PUR_OVER = Global.instance.getBD(domain,"purpleOver");
			GRAY = Global.instance.getBD(domain,"gray");
			JB = Global.instance.getBD(domain,"jb");
			CHIP = Global.instance.getBD(domain,"chip");
			YUNHUN = Global.instance.getBD(domain,"yh");
			IN_BATTLE = Global.instance.getBD(domain,"inBattle");
			IN_FETTER = Global.instance.getBD(domain,"fatter")
			FDJ = Global.instance.getBD(domain,"fdj");
			FDJ_BG = Global.instance.getBD(domain,"fdjBg");
			BAR_BG = Global.instance.getBD(domain,"barBg");
			PROGRESS_BAR =  Global.instance.getClass(domain,"progressBar") as Class;
			SMALL_PROGRESS_BAR = Global.instance.getClass(domain,"smallBar") as Class;
			BOX = Global.instance.getClass(domain,"Box") as Class;
			
			BLUE_BG = Global.instance.getBD(domain,"blueBg");
			BLUE_BG_OVER = Global.instance.getBD(domain,"blueOver");
			BLUE_BG_POINT = Global.instance.getBD(domain,"bluePoint");
			
			GREEN_BG = Global.instance.getBD(domain,"greenBg");
			GREEN_BG_OVER = Global.instance.getBD(domain,"greenOver");
			GREEN_BG_POINT = Global.instance.getBD(domain,"greenPiont");
			
			FIGURE_BG = Global.instance.getBD(domain,"figureBg");
			NO_HERO_BG = Global.instance.getBD(domain,"noHero");
			NO_HEAD_ICON = Global.instance.getBD(domain,"headNohero");
			
			BASE = Global.instance.getBD(domain,"base");
			INTROUDUCE = Global.instance.getBD(domain,"introuce");
			FETTER = Global.instance.getBD(domain,"tianyuan");
			
			HERO_BG = Global.instance.getClass(domain,"heroBg");
			POWER_BG = Global.instance.getClass(domain,"powerBg");
			
			ENABLE_ACTIVE = Global.instance.getBD(domain,"purpleOver");
			BIG_MASK = Global.instance.getBD(domain,"bigMask");
			TIP_BG =  Global.instance.getClass(domain,"tipsBg");
			LINE = Global.instance.getBD(domain,"line");
			
			for(i = 1;i<5;i++)
			{
				EFFECT.push(Global.instance.getClass(domain,"e" + i));
			}
		}
	}
}