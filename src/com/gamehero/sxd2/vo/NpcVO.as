package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.local.Lang;
	
	/**
	 * 
	 * @author xuwenyi
	 * @create 
	 **/
	public class NpcVO
	{
		/**
		 * id 
		 */		
		public var id:int;
		/**
		 * 名字 
		 */		
		public var name:String;
		
		public var initial_forward:String;
		
		public var x:int;
		
		public var y:int;
		/**
		 * 类型 
		 */		
		public var type:String;
		public var bubble_text:String;
		public var url:String;
		
		
		public var funcId:int;
		
		public var mapId:int;
		
		public function NpcVO()
		{
		}
		
		public function fromXML(x:XML):void
		{
			id = x.@id;
			name = Lang.instance.trans(x.@name);
			initial_forward = x.@initial_forward;
			type = x.@type;
			bubble_text = Lang.instance.trans(x.@bubble_text);
			url = x.@url;
			funcId = x.@func_id;
			mapId = x.@mapID;
		}
	}
}