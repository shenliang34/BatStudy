package com.gamehero.sxd2.world.display.data
{
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.utils.Dictionary;
	
	import bowser.loader.BulkLoaderSingleton;
	
	
	/**
	 * 人物特效等渲染数据管理
	 * @author xuwenyi
	 * @create 2014-01-13
	 **/
	public class GameRenderCenter
	{
		private static var _instance:GameRenderCenter;
		
		// 渲染数据字典
		private var renderDataList:Dictionary = new Dictionary();
		
		// 需要清理的key
		private var clearKeys:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function GameRenderCenter()
		{
		}
		
		
		public static function get instance():GameRenderCenter
		{
			if(_instance == null)
			{
				_instance = new GameRenderCenter();
			}
			return _instance;
		}
		
		
		
		/**
		 * 添加数据
		 * */
		public function addData(data:GameRenderData , clearMemory:Boolean = true):void
		{
			if(data.url && data.url != "")
			{
				renderDataList[data.url] = data;
				
				// 是否会被清理
				if(clearMemory == true)
				{
					this.addClearKey(data.url);
				}
			}
		}
		
		
		
		/**
		 * 加载数据
		 * */
		public function loadData(key:String , clearMemory:Boolean = true, loader:BulkLoaderSingleton = null):GameRenderData
		{
			// 若之前已有此效果,则不加载
			var data:GameRenderData = this.getData(key);
			if(data == null)
			{
				data = new GameRenderData(loader);
				data.load(key);
				
				// 添加到列表中
				this.addData(data , clearMemory);
			}
			
			return data;
		}
		
		
		
		
		/**
		 * 获取数据
		 * */
		public function getData(key:String):GameRenderData
		{
			return renderDataList[key];
		}
		
		
		
		
		/**
		 * 清除某数据
		 * */
		public function clearData(key:String):void
		{
			var data:GameRenderData = renderDataList[key];
			
			// 数据存在,并且此数据允许被删除
			var needClear:Boolean = false;
			if(clearKeys.hasOwnProperty(key) == true)
			{
				needClear = clearKeys[key];
			}
			
			if(data && needClear == true)
			{
				data.clear();
				data = null;
				
				renderDataList[key] = null;
				delete renderDataList[key];	
			}
		}
		
		
		
		
		
		/**
		 * 添加不会被清理的key
		 * */
		public function addClearKey(key:String):void
		{
			clearKeys[key] = true;
		}
		
		
		
		
		
		/**
		 * 移除不会被清理的key
		 * */
		public function removeClearKey(key:String):void
		{
			if(clearKeys.hasOwnProperty(key) == true)
			{
				delete clearKeys[key];
			}
		}
		
		
		
		
		
		/**
		 * 获取缓存数据的数量
		 * */
		public function get resourceQuantity():int
		{
			var quantity:int = 0;
			for(var key:String in renderDataList)
			{
				quantity++;
			}
			return quantity;
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			if(renderDataList)
			{
				for(var key:String in renderDataList)
				{
					this.clearData(key);
				}
			}
		}
		
		
		
		/**
		 * 打印所有renderDataList
		 * 
		 */
		public function __debug_list():String {
			
			var str:String = "";
			var data:GameRenderData;
			var arr:Array = [];
			for(var key:String in renderDataList)
			{
				data = renderDataList[key];
				
				arr.push(data.url.replace(GameConfig.RESOURCE_URL, ""));
			}
			
			arr.sort();
			for (var i:int = 0; i < arr.length; i++) {
				
				str += arr[i] + "\n"
			}
			arr = null;
			
			return str;
		}
		
		
		/**
		 * 清空
		 * */
		public function __clearAll():void {
			
			if(renderDataList) {
				
				var data:GameRenderData;
				for(var key:String in renderDataList) {
					
					data = renderDataList[key];
					
					data.clear();
					data = null;
					
					renderDataList[key] = null;
					delete renderDataList[key];	
				}
			}
		}
		
		
	}
}