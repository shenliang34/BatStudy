package com.gamehero.sxd2.services
{
	import com.netease.protobuf.Message;
	
	import flash.utils.getDefinitionByName;
	
	import bowser.remote.RemoteClient;
	import bowser.remote.RemoteResponse;
	import bowser.remote.handlers.CHandler;
	
	
	/**
	 * 通信回调处理
	 * @author xuwenyi
	 * @create 2015-05-12
	 **/
	public class GameCHandler extends CHandler
	{
		
		/**
		 * 构造函数
		 * */
		public function GameCHandler()
		{
			super();
		}
		
		
		
		
		/**
		 * 复写回调处理函数
		 * */
		override public function handle(key:String , response:RemoteResponse):void
		{
			/*
			//通过反射获取proto类
			var protoName:String = response.protoName;
			if(protoName != "")
			{
				var cls:Class = getDefinitionByName(protoName) as Class;
				var proto:Message = new cls() as Message;
				proto.mergeFrom(response.protoBytes);
				response.proto = proto;
				
				
			}
			*/
			super.handle(key , response);
		}
		
	}
}