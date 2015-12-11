package com.gamehero.sxd2.world.model.vo
{
	
	public class MapLayerVo
	{
		public function MapLayerVo()
		{
		}
		
		public var index:int;
		
		public var name:String = "新图层";
		
		/**
		 * 图层偏移量 
		 */		
		public var x:int;
		
		public var y:int;
		
		public var speedX:Number = .0;
		public var speedY:Number = .0;
		
		/**
		 * 是否为主场景 
		 */		
		public var isMain:Boolean;
		/**
		 * 是否是背景层 
		 */		
		public var isBack:Boolean;
		/**
		 * 挂件数组 
		 */		
		public var decoVec:Vector.<MapDecoVo>;
		
		public function fromXML(xml:XML):void
		{
			index = xml.@index;
			name = xml.@name;
			x = xml.@x;
			y = xml.@y;
			
			speedX = xml.@speedX;
			speedY = xml.@speedY;
			
			isMain = xml.@isMain == 1 ? true : false;
			isBack = xml.@isBack == 1 ? true : false;
			decoVec = new Vector.<MapDecoVo>();
			var deco:MapDecoVo;
			for each(var item:XML in xml.item)
			{
				deco = new MapDecoVo();
				deco.fromXML(item);
				decoVec.push(deco);
			}
			
		}
		
		public function getMapVo(id:int):MapDecoVo
		{
			for each (var item:MapDecoVo in decoVec) 
			{
				if(item.ent == id.toString())
					return item;
			}
			
			return null;
		}
	}
}