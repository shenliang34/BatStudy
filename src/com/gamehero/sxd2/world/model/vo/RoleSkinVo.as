package com.gamehero.sxd2.world.model.vo
{
	/**
	 * 角色皮肤的一些配置
	 * @author weiyanyu
	 * 创建时间：2015-8-17 下午1:40:47
	 * 
	 */
	public class RoleSkinVo
	{
		/**
		 * 资源路径 
		 */		
		public var url:String;
		/**
		 * 站立宽度 
		 */		
		public var standWidth:int;
		/**
		 * 站立高度 
		 */		
		public var standHeight:int;
		/**
		 * 跑动宽度 
		 */		
		public var runWidth:int;
		/**
		 * 跑动高度 
		 */		 
		public var runHeight:int;
		
		public function RoleSkinVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			url = xml.@url;
			standWidth = xml.@standWidth == "" ? 80 : xml.@standWidth;
			standHeight = xml.@standHeight == "" ? 130 : xml.@standHeight;
			runWidth = xml.@runWidth;
			runHeight = xml.@runHeight;
		}
	}
}