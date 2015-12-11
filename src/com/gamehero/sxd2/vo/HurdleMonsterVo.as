package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.local.Lang;
	
	import flash.geom.Point;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-29 上午11:06:01
	 * 
	 */
	public class HurdleMonsterVo
	{
		public function HurdleMonsterVo()
		{
		}
		
		public var id:int;
		
		public var name:String;
		
		public var type:int;
		/**
		 * 巡逻区域 
		 */		
		public var patralRect:Point;
		/**
		 * 警戒半径
		 */		
		public var alertRadius:int;
		/**
		 * 追击区域 
		 */		
		public var followRadius:int;
		
		/**
		 * 巡逻时间 ,说话时间的基数
		 */		
		public var time:int;
		/**
		 * 说话内容 
		 */		
		public var bubble:String;
		
		public var url:String;
		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			name = Lang.instance.trans(xml.@name);
			type = xml.@type;
			
			time = xml.@time;
			
			var arr:Array = String(xml.@patralRect).split("-");
			patralRect = new Point();
			patralRect.x = arr[0];
			patralRect.y = arr[1];
			
			alertRadius = xml.@alertRadius;
			followRadius = xml.@followRadius;
			
			url = xml.@url;
			bubble = xml.@bubble_text;
		}
		
	}
}