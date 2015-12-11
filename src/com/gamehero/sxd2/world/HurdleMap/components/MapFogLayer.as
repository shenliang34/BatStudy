package com.gamehero.sxd2.world.HurdleMap.components
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.gamehero.sxd2.world.model.MapConfig;	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import bowser.render.display.SpriteItem;
	
	/**
	 * 战争迷雾图层
	 * @author weiyanyu
	 * 创建时间：2015-6-25 下午8:27:08
	 * 
	 */
	public class MapFogLayer extends SpriteItem
	{
		
		
		public function MapFogLayer(wid:int,hegt:int)
		{
			super();
			this.width = wid;
			this.height = hegt;
			var thumb:BitmapData = MapSkin.MAP_FOG;
			var bd:BitmapData = getCircleBmd(thumb,800,800);
			
			var xml:XML = MapFogCellItem.FOG_LOC_XML;
			var cellItem:MapFogCellItem;
			for each(var item:XML in xml.item)
			{
				cellItem = new MapFogCellItem();
				addChild(cellItem);
				cellItem.setSource(bd);
				cellItem.x = item.@px;
				cellItem.y = item.@py;
			}
			
		}
		/**
		 * 根据原始位图，获得对应比例的位图 
		 * @param bd
		 * @param w
		 * @param h
		 * @return 
		 */		
		private function getCircleBmd(bd:BitmapData,w:int,h:int):BitmapData
		{
			var thumb:BitmapData = new BitmapData(w,h,true,0x00000000);
			var mat:Matrix = new Matrix();
			var xs:Number = w / bd.width;
			var ys:Number = h / bd.height;
			mat.scale(xs,ys);
			thumb.draw(bd,mat,null,null,null,true);
			return thumb;
		}
		/**
		 * 每帧要调整位置 
		 * @param lx
		 * @param ly
		 * 
		 */		
		public function focus(lx:int,ly:int):void
		{
			
			for each(var item:MapFogCellItem in childs)
			{
				if(((item.x - lx) * (item.x - lx) + (item.y - ly) * (item.y - ly)) < MapConfig.FOG_DISSTANCE)
				{
					item.visible = false;
				}
				
			}
		}
		
		private function getDistance(item:MapFogCellItem,lx:int,ly:int):int
		{
			return (item.x - lx) * (item.x - lx) + (item.y - ly) * (item.y - ly);
		}
	}
}