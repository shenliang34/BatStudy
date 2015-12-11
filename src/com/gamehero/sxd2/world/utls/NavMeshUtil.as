package com.gamehero.sxd2.world.utls
{
	import bowser.iso.pathfinding.navmesh.findPath.Cell;
	import bowser.iso.pathfinding.navmesh.geom.Vector2f;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-6-3 上午11:08:20
	 * 
	 */
	public class NavMeshUtil
	{
		public function NavMeshUtil()
		{
		}
		/**
		 * 创建寻路网格 
		 * @param tri
		 * @return 
		 * 
		 */		
		public static function createNavMesh(tri:String):Vector.<Cell> {
			// 三角形顶点
			if(tri == null || tri == "") return null;
			var triArray:Array = tri.split(",");
			var aTri:Array;
			var xy:String;
			var ind:int
			var xx:Number, yy:Number;
			var pV:Vector.<Vector2f> = new Vector.<Vector2f>();	// 一个三角形顶点数据
			var cell:Cell;
			var cellV:Vector.<Cell> = new Vector.<Cell>();
			var k:int;
			var triString:String;
			var cellIndex:int = 0;
			for (var j:int = 0; j < triArray.length; j++) {
				
				// 一个三角形3个顶点
				triString = String(triArray[j]);
				
				aTri = triString.split(">");
				
				if(aTri.length < 3) 	continue;
				
				/*pV = new Vector.<Vector2f>();*/
				for(k = 0; k < aTri.length; k++) {
					
					xy = aTri[k];
					ind = xy.indexOf(":");
					xx = int(xy.substr(0, ind));
					yy = int(xy.substr(ind + 1));
					
					pV.push(new Vector2f(xx, yy));
				}
				
				/** 构建寻路数据 */
				cell = new Cell(pV[0], pV[1], pV[2]);
				cell.index = cellIndex++;
				cellV.push(cell);
				
				pV.length = 0;
				
			}
			return cellV;
		}
	}
}