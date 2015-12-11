package com.gamehero.sxd2.world.model.vo
{
	/**
	 * movieClip动作解析
	 * @author weiyanyu
	 * 创建时间：2015-7-13 上午11:45:31
	 * 
	 */
	public class SwfActionVo
	{
		
		public var index:int;
		/**
		 * 动作循环次数，0次代表无限循环 
		 */		
		public var loop:int;
		/**
		 * 触发类型 
		 */		
		public var trigType:int;
		/**
		 * 处理方式 
		 */
		public var resultType:int;
		
		/**
		 * 所需要参数 
		 */		
		public var pram:String;
		
		
		public function SwfActionVo()
		{
			
		}
		
		public function fromXml(xml:XML):void
		{
			resultType = xml.@resultType;
			loop = xml.@loop;
			index = xml.@index;
			trigType = xml.@trigType;
			pram = xml.@pram;
		}
	}
}