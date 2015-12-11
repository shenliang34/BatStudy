package com.gamehero.sxd2.world.model.vo
{
	/**
	 * @author weiyanyu
	 * 创建时间：2015-5-16 下午9:18:54
	 * 场景信息 
	 */
	public class SceneVo
	{
		/**
		 * 场景id 
		 */		
		public var sceneId:int;
		/**
		 * 场景宽 
		 */		
		public var width:int;
		/**
		 * 场景高 
		 */		
		public var height:int;
		
		public var birthX:int;
		
		public var birthY:int;
		
		/**
		 * 可走区域 
		 */		
		public var tri:String;
		/**
		 * 不可走区域、遮罩区域 
		 */		
		public var mask:String;
		
		/**
		 * 层级 
		 */		
		public var layerVec:Vector.<MapLayerVo>;
		/**
		 * 马赛克定位X
		 */		
		public var maskX:int;
		/**
		 * 马赛克定位Y 
		 */		
		public var maskY:int
		
		public function SceneVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			sceneId = xml.@sceneId;
			width = xml.@width;
			height = xml.@height;
			birthX = xml.@birth_x;
			birthY = xml.@birth_y;
			mask = xml.@mask;
			maskX = xml.@maskX
			maskY = xml.@maskY
			tri = xml.@tri;
			
			layerVec = new Vector.<MapLayerVo>;
			var layer:MapLayerVo;
			for each(var item:XML in xml.layer)
			{
				layer = new MapLayerVo();
				layer.fromXML(item);
				layerVec.push(layer);
			}
		}
	}
}