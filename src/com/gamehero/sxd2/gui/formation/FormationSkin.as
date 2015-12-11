package com.gamehero.sxd2.gui.formation
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;
	

	/**
	 * @author Wbin
	 * 创建时间：2015-8-27 下午8:30:53
	 * 
	 */
	public class FormationSkin
	{
		
		/** =====================================================布阵======================================================*/
		/**站位格子数*/
		public static const LOCA_NUM:int = 9;
		/**总阵型数*/
		public static const FORMATION_NUM:int = 8;
		/**伙伴背包高亮框*/
		public static var bagOverBmp:BitmapData;
		/**伙伴背景框*/
		public static var headIcon:BitmapData;
		/**上阵标识*/
		public static var inBattle:BitmapData;
		/**助阵标识*/
		public static var helpBattle:BitmapData;
		
		/**阵容选中高亮*/
		public static var forOverBmp:BitmapData;
		/**阵容开启标识*/
		public static var newIcon:BitmapData;
		
		/**阵型图标*/
		public static var formationVec:Vector.<BitmapData> = new Vector.<BitmapData>;
		/**布阵底框*/
		public static var KUANG_DISABLE_NEW:Array = new Array();
		public static var KUANG_ENABLE_NEW:Array = new Array();
		public static var KUANG_OVER_NEW:Array = new Array();
		
		/**伙伴背包底框*/
		private static var heroBagRet:BitmapData;
		/**伙伴框线*/
		private static var heroBagLine:BitmapData;
		/**窗口框线*/
		private static var windowLine:BitmapData
		
		/**布阵按钮资源*/
		public static var BS_DOWN:BitmapData
		public static var BS_OVER:BitmapData
		public static var BN_UP:BitmapData
		public static var BN_OVER:BitmapData
		/**天缘按钮资源*/
		public static var TS_OVER:BitmapData
		public static var TS_DOWN:BitmapData
		public static var TN_UP:BitmapData
		public static var TN_OVER:BitmapData
		/**羁绊按钮资源*/
		public static var J_UP:BitmapData
		public static var J_OVER:BitmapData
		
		/**转圈特效*/
		public static var ROUND_MC:Class
		/**粒子特效*/
		public static var PARTICLE_MC:Class
		/**收缩按钮*/
		public static var CONTRACT_OVER:BitmapData
		public static var CONTRACT_DOWN:BitmapData
		public static var CONTRACT_UP:BitmapData
		
		public static var CLOUD_MC_UP:Class;
		public static var CLOUD_MC_OVER:Class;
		
		/**锁动画*/
		public static var LOCK_MV:Class;
		
		
		/** =====================================================奇术======================================================*/
		public static var QISHU_BG:BitmapData;
		public static var GF:BitmapData;
		public static var ZF:BitmapData
		public static var GR:BitmapData
		public static var QISHU_OVER:BitmapData
		public static var QISHU_UP:BitmapData
		public static var YL:BitmapData
		public static var LVUP_SUCESS:Class;
		
		public function FormationSkin()
		{
		}
		
		public static function init(domain:ApplicationDomain):void
		{
			bagOverBmp = Global.instance.getBD(domain,"headOver");
			headIcon = Global.instance.getBD(domain,"headIcon");
			inBattle = Global.instance.getBD(domain,"inBattle");
			helpBattle = Global.instance.getBD(domain,"helpBattle");
			forOverBmp = Global.instance.getBD(domain,"formationOver");
			newIcon = Global.instance.getBD(domain,"newIcon");
			
			BS_OVER = Global.instance.getBD(domain,"BS_OVER");
			BS_DOWN = Global.instance.getBD(domain,"BS_DOWN");
			BN_UP = Global.instance.getBD(domain,"BN_UP");
			BN_OVER = Global.instance.getBD(domain,"BN_OVER");
			
			TS_OVER = Global.instance.getBD(domain,"TS_OVER");
			TS_DOWN = Global.instance.getBD(domain,"TS_DOWN");
			TN_UP = Global.instance.getBD(domain,"TN_UP");
			TN_OVER = Global.instance.getBD(domain,"TN_OVER");
			
			J_UP = Global.instance.getBD(domain,"J_UP");
			J_OVER = Global.instance.getBD(domain,"J_OVER");
			
			ROUND_MC = Global.instance.getClass(domain,"mc4");
			
			PARTICLE_MC = Global.instance.getClass(domain,"mc2");
			CLOUD_MC_OVER = Global.instance.getClass(domain,"cloudOver");
			CLOUD_MC_UP = Global.instance.getClass(domain,"cloudUp");
			
			LOCK_MV = Global.instance.getClass(domain,"lock");
			
			CONTRACT_OVER = Global.instance.getBD(domain,"contractOVER");
			CONTRACT_UP = Global.instance.getBD(domain,"contractUP");
			CONTRACT_DOWN = Global.instance.getBD(domain,"contractUP");
			
			//阵型图标按顺序排列
			for(var i:int = 0;i<FORMATION_NUM;i++)
			{
				formationVec.push(Global.instance.getBD(FormationModel.inst.domain,"Z_"+i));
			}
			//站位底框
			for(i = 1 ; i <= LOCA_NUM ; i++)
			{
				KUANG_DISABLE_NEW.push(Global.instance.getBD(domain,"KUANG_DISABLE_"+i));
				KUANG_ENABLE_NEW.push(Global.instance.getBD(domain,"KUANG_ENABLE_"+i));
				KUANG_OVER_NEW.push(Global.instance.getBD(domain,"KUANG_OVER_"+i));
			}
			
			QISHU_BG = Global.instance.getBD(domain,"qishuBg");
			GF = Global.instance.getBD(domain,"gongfa");
			ZF = Global.instance.getBD(domain,"zhenfa");
			GR = Global.instance.getBD(domain,"gray1");
			QISHU_OVER = Global.instance.getBD(domain,"qishuOver");
			QISHU_UP = Global.instance.getBD(domain,"qishuUp");
			YL = Global.instance.getBD(domain,"yl");
			LVUP_SUCESS = Global.instance.getClass(domain,"lp_Success");
		}
		
	}
}