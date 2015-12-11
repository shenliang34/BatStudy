package com.gamehero.sxd2.world.utls
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.vo.TileData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-5-29 下午2:26:47
	 * 
	 */
	public class BitmapUtil
	{
		public function BitmapUtil()
		{
		}
		
		public static function cutMiniMap(miniMap:Bitmap,worldWidth:int,worldHeight:int,tileSize:int):Vector.<Vector.<TileData>>
		{
			var xs:Number = worldWidth / miniMap.width;
			var ys:Number = worldHeight / miniMap.height;
			var thumb:BitmapData = new BitmapData(worldWidth,worldHeight,true,0x00000000);
			var mat:Matrix = new Matrix();
			mat.scale(xs,ys);
			thumb.draw(miniMap,mat);
			var rect:Rectangle = new Rectangle();
			var pt:Point = new Point();
			var tileVec:Vector.<Vector.<TileData>> = new Vector.<Vector.<TileData>>();
			var vec:Vector.<TileData>;
			var row:int = Math.ceil(worldHeight / tileSize);
			var col:int = Math.ceil(worldWidth / tileSize);
			var locStr:String = GameConfig.MAPS_URL + MapModel.getInstance().mapId + "/";
			for(var i:int = 0; i < row; i++)
			{
				vec = new Vector.<TileData>();
				tileVec.push(vec);
				var tileData:TileData;
				for(var j:int = 0; j < col; j++)
				{
					rect.setEmpty();
					rect.x = j * tileSize;
					rect.y = i * tileSize;
					rect.width = tileSize;
					rect.height = tileSize;
					
					tileData = new TileData();
					tileData.row = i;
					tileData.col = j;
					tileData.x = rect.x;
					tileData.y = rect.y;
					tileData.tileURL = locStr + "h" + i + "v" + j + ".swf";
					var bmpData:BitmapData = new BitmapData(tileSize,tileSize,true);
					bmpData.copyPixels(thumb,rect,pt);
					tileData.bmpData = bmpData;
					vec.push(tileData);
				}
			}
			return tileVec;
		}
		/**
		 * 切割一张图片 
		 * @param bd
		 * @param size
		 * @return 
		 * 
		 */		
		public function cutBitmap(bd:BitmapData,size:int):Vector.<Vector.<BitmapData>>
		{
			var bdVec:Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>();
			var row:int = bd.height / size;
			var col:int = bd.width / size;
			var rowVec:Vector.<BitmapData>;
			var bmd:BitmapData;
			for(var i:int = 0; i < row; i++)
			{
				rowVec = new Vector.<BitmapData>();
				for(var j:int = 0; j < col; j++)
				{
					bmd = new BitmapData(size,size,true,0);
					bmd.copyPixels(bd,new Rectangle(j * 128,i * 128,128,128),new Point(),null,null,true);
					rowVec.push(bmd);
				}
				bdVec.push(rowVec);
			}
			return bdVec;
		}
	}
}