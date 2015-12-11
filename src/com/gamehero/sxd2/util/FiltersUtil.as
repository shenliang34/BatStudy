package com.gamehero.sxd2.util
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Dictionary;

	/**
	 * Filters动画工具 
	 * @modify cuiyi 2014-11-19
	 * 
	 */
	public class FiltersUtil
	{
		public static var BW_Fiter:Array=[new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
		
		private static var _filterMovieLib:Dictionary = new Dictionary;
		
		
		
		
		
		/**
		 * 是否将可视物件灰显（目标物件必须未加载其他滤镜）
		 * @param target 目标物件
		 * @param boo true:灰显，false:还原
		 */
		public static function grayFilter(target:DisplayObject, boo:Boolean):void
		{
			if(target) {
				
				target.filters = (boo ? BW_Fiter : []);
			}
		}
		
	}
}