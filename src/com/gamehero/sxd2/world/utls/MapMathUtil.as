package com.gamehero.sxd2.world.utls
{
	import bowser.render.display.DisplayItem;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-1 上午11:42:49
	 * 
	 */
	public class MapMathUtil
	{
		public function MapMathUtil()
		{
		}
		/**
		 * 返回两个物件的距离 
		 * @param item0
		 * @param item1
		 * @return 
		 * 
		 */		
		public static function getItemDistance(item0:DisplayItem,item1:DisplayItem):Number
		{
			var dx:Number = item0.x - item1.x;
			var dy:Number = item0.y - item1.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
	}
}