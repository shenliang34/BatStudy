package com.gamehero.sxd2.world.display.data
{
	import com.gamehero.sxd2.world.display.SwfAtlas;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-13 下午5:28:58
	 * 
	 */
	public class SwfAtalsCenter
	{
		/**
		 * atlas字典 
		 */		
		public static var swfAtlasDict:Dictionary = new Dictionary();
		/**
		 * 场景加载的pngdata的字典 
		 */		
		public static var bmpDict:Dictionary = new Dictionary();
		
		public function SwfAtalsCenter()
		{
			
		}
		public static function dispose():void
		{
			var swfAtlas:SwfAtlas
			for(var url:String in SwfAtalsCenter.swfAtlasDict)
			{
				swfAtlas = SwfAtalsCenter.swfAtlasDict[url];
				swfAtlas.dispose();
				swfAtlas = null;
				SwfAtalsCenter.swfAtlasDict[url] = null;
				delete SwfAtalsCenter.swfAtlasDict[url];
			}
			var bd:BitmapData;
			for(url in SwfAtalsCenter.bmpDict)
			{
				bd = SwfAtalsCenter.bmpDict[url];
				bd.dispose();
				bd = null;
				SwfAtalsCenter.bmpDict[url] = null;
				delete SwfAtalsCenter.bmpDict[url];
			}
		}
	}
}