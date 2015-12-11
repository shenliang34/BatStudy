package com.gamehero.sxd2.gui.friend.model
{
	import com.gamehero.sxd2.pro.PRO_AD;
	import com.gamehero.sxd2.pro.PRO_Friend;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.util.SortonUtil;
	import com.netease.protobuf.UInt64;

	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-18 下午4:56:34
	 * 
	 */
	public class FriendModel
	{
		private static var _instance:FriendModel;
		
		private var _myIconId:int = 1;
		private var _tempIconId:int = 1;
		
		private var _friends:Array = [];
		private var _blacklist:Array = [];
		private var _contacts:Array = [];
		private var _listeners:Array = [];
		
		private var _chineseName:Array = ["销量","效率发","我发","发是","中国人","好不好","一部发","就是","就是发","染发","伐啦","大法官","众人","中文十九","时候噶发觉","就是","就是发","染发","伐啦","大法官","众人","中文十九","时候噶发觉","就是","就是发","染发","伐啦","大法官","众人","中文十九","时候噶发觉"];
		private var _audience:int;

		/**
		 *听众 
		 */
		public function get listeners():Array
		{
			_listeners.splice(0,_listeners.length);
			for (var j:int = 1; j < 10; j++) 
			{
				var player:PRO_Friend = new PRO_Friend();
				var base:PRO_PlayerBase = new PRO_PlayerBase();
				base.id = UInt64.fromNumber(j);
				base.name = _chineseName[j];
				base.level = 1;
				player.base = base
				player.isOnline = true;
				player.isFriend = true;
				player.isAttention = true;
				_listeners.push(player);
			}
			_audience = _listeners.length;
			_listeners = sortArray(_listeners);
			return _listeners;
		}

		/**
		 * @private
		 */
		public function set listeners(value:Array):void
		{
			_listeners = value;
		}

		/**
		 *听众数量 
		 */
		public function get audience():int
		{
			return _audience;
		}

		/**
		 * @private
		 */
		public function set audience(value:int):void
		{
			_audience = value;
		}

		/**
		 *私聊列表 
		 */
		public function get contacts():Array
		{
			_contacts.splice(0,_contacts.length);
			for (var j:int = 1; j < 10; j++) 
			{
				var player:PRO_Friend = new PRO_Friend();
				var base:PRO_PlayerBase = new PRO_PlayerBase();
				base.id = UInt64.fromNumber(j);
				base.name = _chineseName[j];
				base.level = 1;
				player.base = base
				player.isOnline = true;
				player.isFriend = true;
				player.isAttention = true;
				_contacts.push(player);
			}
			_contacts = sortArray(_contacts);
			return _contacts;
		}

		/**
		 * @private
		 */
		public function set contacts(value:Array):void
		{
			_contacts = value;
		}

		/**
		 *黑名单 
		 */
		public function get blacklist():Array
		{
			_blacklist.splice(0,_blacklist.length);
			for (var i:int = 11; i < 20; i++) 
			{
				var player:PRO_Friend = new PRO_Friend();
				var base:PRO_PlayerBase = new PRO_PlayerBase();
				base.id = UInt64.fromNumber(i);
				base.name = _chineseName[i-11];
				base.level = 1;
				player.base = base;
				player.isOnline = false;
				player.isFriend = false;
				player.isAttention = false;
				_blacklist.push(player);
			}
			_blacklist = sortArray(_blacklist);
			return _blacklist;
		}
		
		private function sortArray(arr:Array):Array
		{
			arr = SortonUtil.sortByChinese(arr,["level"],[Array.DESCENDING|Array.NUMERIC],"base","name");
			return arr;
		}
		/**
		 * @private
		 */
		public function set blacklist(value:Array):void
		{
			_blacklist = value;
		}
		/**
		 *好友列表 
		 */		
		public function get friends():Array
		{
			_friends.splice(0,_friends.length);
			for (var i:int = 0; i < 10; i++) 
			{
				var player:PRO_Friend = new PRO_Friend();
				var base:PRO_PlayerBase = new PRO_PlayerBase();
				base.id = UInt64.fromNumber(i);
				base.name = _chineseName[i];
				base.level = 1;
				player.base = base
				player.isOnline = true;
				player.isFriend = true;
				player.isAttention = true;
				_friends.push(player);
			}
			_friends = sortArray(_friends);
			return _friends;
		}
		/**
		 * @private
		 */
		public function set friends(value:Array):void
		{
			_friends = value;
		}

		public function get tempIconId():int
		{
			return _tempIconId;
		}

		public function set tempIconId(value:int):void
		{
			_tempIconId = value;
		}

		public function get myIconId():int
		{
			return _myIconId;
		}

		public function set myIconId(value:int):void
		{
			_myIconId = value;
		}

		public static function get inst():FriendModel
		{
			if(_instance == null)
			{
				_instance = new FriendModel();
			}
			return _instance;
		}
		
		public function FriendModel()
		{
			if(_instance != null)
				throw "FriendModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
	}
}