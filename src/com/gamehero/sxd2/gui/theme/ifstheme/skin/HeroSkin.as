package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-27 下午7:00:10
	 * @伙伴通用标识
	 */
	public class HeroSkin
	{
		/**中立*/
		public static var RACE_0:BitmapData;
		/**神族*/
		public static var RACE_1:BitmapData;
		/**人族*/
		public static var RACE_2:BitmapData;
		/**妖族*/
		public static var RACE_3:BitmapData;
		/**魔族*/
		public static var RACE_4:BitmapData;
		
		
		/**武圣*/
		public static var JOB_1:BitmapData;
		/**剑灵*/
		public static var JOB_2:BitmapData;
		/**将星*/
		public static var JOB_3:BitmapData;
		/**将星*/
		public static var JOB_4:BitmapData;
		/**飞羽*/
		public static var JOB_5:BitmapData;
		/**方士*/
		public static var JOB_6:BitmapData;
		/**金刚*/
		public static var JOB_7:BitmapData;
		/**幽冥*/
		public static var JOB_8:BitmapData;
		/**罗刹*/
		public static var JOB_9:BitmapData;
		/**巫祝*/
		public static var JOB_10:BitmapData;
		/**奇门*/
		public static var JOB_11:BitmapData;
		/**天师*/
		public static var JOB_12:BitmapData;
		
		/**tips*/
		public static var TIP_BG:Class;
		public function HeroSkin()
		{
			
		}
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			RACE_0 = global.getBD(domain , "race_0");
			RACE_1 = global.getBD(domain , "race_1");
			RACE_2 = global.getBD(domain , "race_2");
			RACE_3 = global.getBD(domain , "race_3");
			RACE_4 = global.getBD(domain , "race_4");
			
			JOB_1 = global.getBD(domain , "job_1");
			JOB_2 = global.getBD(domain , "job_2");
			JOB_3 = global.getBD(domain , "job_3");
			JOB_4 = global.getBD(domain , "job_4");
			JOB_5 = global.getBD(domain , "job_5");
			JOB_6 = global.getBD(domain , "job_6");
			JOB_7 = global.getBD(domain , "job_7");
			JOB_8 = global.getBD(domain , "job_8");
			JOB_9 = global.getBD(domain , "job_9");
			JOB_10 = global.getBD(domain , "job_10");
			JOB_11 = global.getBD(domain , "job_11");
			JOB_12 = global.getBD(domain , "job_12");
			
			TIP_BG =  global.getClass(domain , "tipsBg");
		}
		/**
		 * 通过种族获得皮肤 
		 * @param race
		 * @return 
		 * 
		 */		
		public static function getRaceSkin(race:String):BitmapData
		{
			switch(race)
			{
				case "0":
					return (HeroSkin.RACE_0);
					break;
				case "1":
					return (HeroSkin.RACE_1);
					break;
				
				case "2":
					return(HeroSkin.RACE_2);
					break;
				
				case "3":
					return(HeroSkin.RACE_3);
					break;
				
				case "4":	
					return(HeroSkin.RACE_4);
					break;
				default:
					return null;
			}
		}
		
		/**
		 * 获得职业图标
		 * @param career
		 * @return 
		 * 
		 */
		static public function getJobSkin(job:int):BitmapData {
			
			switch(job)
			{
				case 1:
					return(HeroSkin.JOB_1);
					break;
				case 2:
					return(HeroSkin.JOB_2);
					break;
				case 3:
					return(HeroSkin.JOB_3);
					break;
				case 4:
					return(HeroSkin.JOB_4);
					break;
				case 5:
					return(HeroSkin.JOB_5);
					break;
				case 6:
					return(HeroSkin.JOB_6);
					break;
				case 7:
					return(HeroSkin.JOB_7);
					break;
				case 8:
					return(HeroSkin.JOB_8);
					break;
				case 9:
					return(HeroSkin.JOB_9);
					break;
				case 10:
					return(HeroSkin.JOB_10);
					break;
				case 11:
					return(HeroSkin.JOB_11);
					break;
				case 12:
					return(HeroSkin.JOB_12);
					break;
			}
			
			return null;
		}
	}
}