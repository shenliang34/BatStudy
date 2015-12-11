package com.gamehero.sxd2.world.model.vo
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
		
	public class MapDecoVo
	{
		public function MapDecoVo()
		{
		}
		/**
		 * 名字 
		 */		
		public var name:String;
		/**
		 * 地址 
		 */		
		public var url:String;
		/**
		 * 类型 
		 */		
		public var type:String;
		/**
		 * 坐标 
		 */		
		public var x:int;
		public var y:int;
		/**
		 */		
		public var id:int;
		
		/**
		 * 额外参数 
		 */		
		public var ent:String;
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id; 
			name = xml.@name;
			type = xml.@type;
			url = xml.@url;
			ent = xml.@ent;
			x = xml.@x;
			y = xml.@y;
		}
		
		public function clone():Object
		{
			var typeName:String		= getQualifiedClassName(this);//获取当前类完全类名
			var packageName:String	= typeName.split("::")[0];//截取命名空间之前的包名
			var type:Class			= getDefinitionByName(typeName) as Class;//获取当前类定义
			
			registerClassAlias(packageName, type);//使用当前类的包名作为类别名，类定义作为注册类
			
			var copier:ByteArray	= new ByteArray();
			copier.writeObject(this);
			copier.position			= 0;
			
			return copier.readObject();
		}
	}
}