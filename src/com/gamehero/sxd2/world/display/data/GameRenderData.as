package com.gamehero.sxd2.world.display.data
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.RenderItemEvent;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.utils.TextureAtlas;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	
	/**
	 * 保存渲染数据的TextureAtlas
	 * @author xuwenyi
	 * @create 2014-01-13
	 **/
	public class GameRenderData extends EventDispatcher
	{
		// 素材item
		private var pngItem:LoadingItem;
		private var xmlItem:LoadingItem;
		
		// 图片和xml是否已加载完
		private var imageLoaded:Boolean = false;
		private var xmlLoaded:Boolean = false;
		
		public var url:String;
		public var atlas:TextureAtlas;
		private var _textures:Dictionary;
		private var copyTotal:uint = 0;				// 从图片集中绘制单帧图片的次数(达到最大帧数时清空textureAtlas)
		private var resURL:String;					// 资源最终的url(swf文件还是png文件)
		
		private var loader:BulkLoaderSingleton;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function GameRenderData(loader:BulkLoaderSingleton = null)
		{
			this.loader = (loader != null) ? loader : BulkLoaderSingleton.instance;
		}
		
		
		/**
		 * 开始加载资源
		 * */
		public function load(url:String):void
		{
			this.url = url;
			
			// 资源url
			resURL = url + ".swf";
			
			// 加载外形素材
			// 加载前先删除之,防止上一次的加载坏了导致之后的加载都完成不了
			loader.remove(resURL);
			loader.addWithListener(resURL , {priority: GameConfig.PLAYER_LOAD_PRIORITY}, onImageLoaded);
			
			// 加载xml
			var xmlURL:String = url;
			var props:Object = {};
			props.priority = GameConfig.PLAYER_LOAD_PRIORITY;
			props.type = BulkLoader.TYPE_BINARY;
			xmlURL += ".gh";
			
			loader.addWithListener(xmlURL , props, onXmlLoaded);
		}
		
		
		
		
		/**
		 * 图片加载完成
		 * */
		private function onImageLoaded(e:Event):void
		{
			pngItem = e.target as LoadingItem;
			
			if(pngItem)
			{
				imageLoaded = true;
				pngItem.removeEventListener(Event.COMPLETE , onImageLoaded);
				
				this.onResourceLoaded();
			}
		}
		
		
		/**
		 * XML加载完成
		 * */
		private function onXmlLoaded(e:Event):void
		{
			xmlItem = e.target as LoadingItem;
			
			if(xmlItem)
			{
				xmlLoaded = true;
				xmlItem.removeEventListener(Event.COMPLETE , onXmlLoaded);
				
				this.onResourceLoaded();
			}
		}
		
		
		/**
		 * Figure Loaded Handler 
		 * @param event
		 */
		private function onResourceLoaded():void
		{
			if(imageLoaded == false || xmlLoaded == false)
			{
				return;
			}
			
			
			// 动画大图
			var pngData:BitmapData;
			var PNGDataClass:Class;
			if(pngItem)
			{
				var swf:MovieClip = pngItem.content;
				var domain:ApplicationDomain = swf.loaderInfo.applicationDomain;
				PNGDataClass = domain.getDefinition("PNGData") as Class;
			}
			else
			{
				PNGDataClass = loader.getClass(url +  ".swf", "PNGData");
			}
			
			if(PNGDataClass)
			{
				pngData = new PNGDataClass();
			}
			
			// 动画配置
			var xml:XML;
			// 解压XML文件
			var ba:ByteArray = xmlItem.content as ByteArray;
			ba.uncompress();
			xml = new XML(ba);
			
			// 生成TextureAtlas
			atlas = new TextureAtlas(pngData, xml);
			
			pngItem = null;
			xmlItem = null;
			
			// 必须从bulkloader中移除 , 否则下一次load会不触发
			loader.remove(resURL);
			loader.remove(url + ".gh");
			
			
			// 派发完成事件
			this.dispatchEvent(new RenderItemEvent(RenderItemEvent.RESOURCE_LOADED));
		}
		
		
		
		
		
		/**
		 * 更新单帧绘制的次数
		 * */
		public function updateCopy():void
		{
			if(atlas != null)
			{
				copyTotal++;
				
				// 缓存的单帧图片数量达到最大(说明原图已经都被复制下来了)
				if(copyTotal >= atlas.frameTotal)
				{
					atlas.dispose();
				}
			}
		}
		
		
		
		
		
		/**
		 * 清除
		 * */
		public function clear():void
		{
			imageLoaded = false;
			xmlLoaded = false;
			
			if(pngItem)
			{
				pngItem.removeEventListener(Event.COMPLETE , onImageLoaded);
				pngItem = null;
			}
			
			if(xmlItem)
			{
				xmlItem.removeEventListener(Event.COMPLETE , onXmlLoaded);
				xmlItem = null;
			}
			
			// 清除缓存
			if(atlas)
			{
				atlas.dispose();
				atlas = null;
			}
			
			if(_textures)
			{
				for (var key:String in _textures) {
					
					delete _textures[key];
				}
				_textures = null;
			}
		}

		
		
		
		public function get textures():Dictionary
		{
			if(_textures == null) {
				
				_textures = new Dictionary();
			}
			
			return _textures;
		}

		
		
		
		public function set textures(value:Dictionary):void
		{
			_textures = value;
		}

		
	}
}