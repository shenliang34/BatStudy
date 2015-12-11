package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	/**
	 * 物品的一些通用资源
	 * @author weiyanyu
	 * 创建时间：2015-8-31 13:44:41
	 * 
	 */
	public class ItemSkin
	{
		public function ItemSkin()
		{
		}
		
		/**
		 * 物品栏格子背景 鼠标划入效果
		 */		
		static public var BAG_ITEM_MOUSEOVER_BG:BitmapData;
		/**
		 * 物品栏格子背景
		 */		
		static public var BAG_ITEM_NORMAL_BG:BitmapData;
		/**
		 * "已装备"图标 
		 */		
		public static var EQUIPED:BitmapData;
		
		/**
		 * 获取道具动画 
		 */		
		public static var ITEM_GET_EFFECT:Class;
		/**
		 * 元宝金币的闪烁动画 
		 */		
		public static var GOLD_FLASH:Class;
		/**
		 * 元宝 
		 */		
		public static var YUANBAO:BitmapData;
		/**
		 * 铜钱 
		 */		
		public static var TONGQIAN:BitmapData;
		/**
		 * 灵蕴 
		 */		
		public static var LINGYUN:BitmapData;
		public static var CANYE:BitmapData;
		public static var SUIPIAN:BitmapData;
		public static var JINGYAN:BitmapData;
		/**
		 * 碎片标志 
		 */		
		public static var ChipBig:BitmapData;
		public static var ChipBigMask:BitmapData;
		public static var ChipSmall:BitmapData;
		public static var ChipSmallMask:BitmapData;
		
		/**
		 * 64*64图标底图
		 * */
		public static var ITEM_BIG_BG:BitmapData;
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			BAG_ITEM_MOUSEOVER_BG = global.getBD(domain,"ITEM_MOUSE_OVER_BG");
			BAG_ITEM_NORMAL_BG = global.getBD(domain,"ITEM_NORMAL_BG");
			EQUIPED = global.getBD(domain,"EQUIPED");
			
			ITEM_GET_EFFECT = global.getClass(domain,"ITEM_GET_EFFECT");
			GOLD_FLASH = global.getClass(domain,"GOLD_FLASH");
			TONGQIAN = global.getBD(domain,"TONGQIAN");
			YUANBAO = global.getBD(domain,"YUANBAO");
			LINGYUN = global.getBD(domain,"LINGYUN");
			JINGYAN = global.getBD(domain,"JINGYAN");
			SUIPIAN = global.getBD(domain,"SUIPIAN");
			CANYE = global.getBD(domain,"CANYE");
			
			ChipBig = global.getBD(domain,"ChipBig");
			ChipBigMask = global.getBD(domain,"ChipBigMask");
			ChipSmall = global.getBD(domain,"ChipSmall");
			ChipSmallMask = global.getBD(domain,"ChipSmallMask");
			
			ITEM_BIG_BG = global.getBD(domain,"ITEM_BG_64");  
			
		}
	}
}