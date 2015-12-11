package com.gamehero.sxd2.drama.cmds.dialog
{
	
	
	/**
	 * 统一管理NPC冒泡对话
	 * @author xuwenyi
	 * @create 2015-11-10
	 **/
	public class GossipManager
	{
		private static var _instance:GossipManager;
		private var gossips:Array = [];
		
		
		
		/**
		 * 构造函数
		 * */
		public function GossipManager()
		{
		}
		
		
		
		
		public static function get inst():GossipManager
		{
			return _instance ||= new GossipManager();
		}
		
		
		
		
		/**
		 * 添加
		 * */
		public function add(gossip:Object):void
		{
			if(gossips.indexOf(gossip) < 0)
			{
				gossips.push(gossip);
			}
		}
		
		
		
		
		
		public function remove(gossip:Object):void
		{
			var idx:int = gossips.indexOf(gossip);
			if(idx >= 0)
			{
				gossips.splice(idx , 1);
			}
		}
		
		
		
		
		
		
		/**
		 * stop
		 * */
		public function stop():void
		{
			var len:int = gossips.length;
			for(var i:int=0;i<len;i++)
			{
				var gossip:Object = gossips[i];
				if(gossip != null)
				{
					// 文字已结束，则移除
					if(gossip.isEnd == true)
					{
						gossip.hide();
					}
						// 文字还在播放, 直接显示全
					else
					{
						gossip.showFullText();
					}
				}
			}
		}
		
		
		
		
		
		
		public function clear():void
		{
			gossips = [];
		}
		
	}
}