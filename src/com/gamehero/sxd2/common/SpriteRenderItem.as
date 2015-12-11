package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.gamehero.sxd2.world.display.data.GameRenderData;
	import com.gamehero.sxd2.world.display.data.RenderSourceData;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import bowser.render.utils.TextureAtlas;
	
	
	
	/**
	 * 专用于TextureAltas素材的位图动画 
	 * @author xuwenyi
	 */	
	public class SpriteRenderItem extends MovieBitmap
	{
		protected var _isLoaded:Boolean = false;
		protected var _url:String;
		
		// 素材库
		protected var _textureAtlas:Object;
		
		protected var _movieNameLib:Dictionary;
		protected var _movieName:String;
		
		// 刷新timer
		private var updateTimer:Timer;
		private var _frameRate:int = 12;
		
		// 是否在clear的时候会清除资源
		private var clearMemory:Boolean;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function SpriteRenderItem(url:String , clearMemory:Boolean = true , complete:Function = null)
		{
			super(complete);
			
			this.clearMemory = clearMemory;
			
			if(url != "")
			{
				this.load(url);
			}
			
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		/**
		 *移除刷新 
		 */		
		private function onRemove(e:Event):void
		{
			this.stop();
			this.clear();
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		public function load(url:String):void
		{
			_url = url;
			
			var center:GameRenderCenter = GameRenderCenter.instance;
			var data:GameRenderData = center.getData(_url);
			if(data == null || data.atlas == null)
			{	
				data = center.loadData(_url);
				data.addEventListener(RenderItemEvent.RESOURCE_LOADED , onResourceLoaded , false , 0 , true);
			}
			else
			{
				// 已经加载完成
				if(data.atlas)
				{
					this.onResourceLoaded();
				}
				// 正在加载中
				else
				{
					data.addEventListener(RenderItemEvent.RESOURCE_LOADED , onResourceLoaded , false , 0 , true);
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 所有资源加载完成
		 * */
		protected function onResourceLoaded(e:RenderItemEvent = null):void
		{
			// 移除事件
			if(e)
			{
				e.currentTarget.removeEventListener(RenderItemEvent.RESOURCE_LOADED , onResourceLoaded);
			}
			
			_isLoaded = true;
			
			var center:GameRenderCenter = GameRenderCenter.instance;
			var data:GameRenderData = center.getData(_url);
			_textureAtlas = data.atlas.frameTotal > 0 ? data.atlas : data.textures;
			
			_movieNameLib = new Dictionary();
			
			if(isPlaying == true)
			{
				this.play();
			}
		}
		
		
		
		
		
		
		/**
		 * 开始播放
		 */		
		override public function play(totalLoop:int = int.MAX_VALUE):void
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
			
			if(_isLoaded == true)
			{
				if(updateTimer == null)
				{
					var delay:int = int(1000/_frameRate);
					updateTimer = new Timer(delay);
					updateTimer.addEventListener(TimerEvent.TIMER , update);
				}
				updateTimer.reset();
				updateTimer.start();
				
				this.flushView();
			}
			super.play(totalLoop);
		}
		
		
		
		
		
		/**
		 * 停止播放
		 */		
		override public function stop():void
		{
			if(updateTimer)
			{
				updateTimer.stop();
				updateTimer.removeEventListener(TimerEvent.TIMER , update);
			}
			updateTimer = null;
			
			this.flushView();
			
			super.stop();
		}
		
		
		
		
		
		/**
		 * 每帧刷新
		 * */
		private function update(e:TimerEvent):void
		{
			this.nextFrame();
		}
		
		
		
		
		
		
		/**
		 *设置需要播放的动画名称 
		 * @param value
		 * 
		 */		
		public function setMovieName(value:String):void
		{
			// 判断是否加载完成
			if(_isLoaded == false) 
			{
				return;
			}
			
			var bitmaps:Vector.<BitmapData>;
			var bitmapOffs:Vector.<Point>;
			
			if(_movieNameLib[value] == null)
			{
				// 生产序列位图和偏移量
				bitmaps = new Vector.<BitmapData>;
				bitmapOffs = new Vector.<Point>;
				
				var frameList:Object;
				// 若素材库未被GameRenderCenter清除(全部渲染过后会为了内存优化而清除)
				if(_textureAtlas is TextureAtlas)
				{
					frameList = _textureAtlas.getTextures(value);
				}
				else
				{
					var renderSourceData:RenderSourceData = _textureAtlas[_movieName];
					frameList = renderSourceData.renderList;
				}
				
				var offsetX:int;
				var offsetY:int;
				for each(var frameData:Object in frameList)
				{
					bitmaps.push(frameData.texture);
					
					/*if(frameData.frame.width == 512) {
					
						offsetX = DefaultFigureItem.BOTTOM_CENTER_512_X;
						offsetY = DefaultFigureItem.BOTTOM_CENTER_512_Y;
					}
					else if(frameData.frame.width == 1024) {
				
						offsetX = DefaultFigureItem.BOTTOM_CENTER_1024_X;
						offsetY = DefaultFigureItem.BOTTOM_CENTER_1024_Y;
					}*/
				
					bitmapOffs.push(new Point(frameData.frame.x, frameData.frame.y));
				}
			
				//保存数据，以便下次使用
				_movieNameLib[value] = {bitmaps:bitmaps, bitmapOffs:bitmapOffs};
			}
			else
			{
				bitmaps = _movieNameLib[value].bitmaps;
				bitmapOffs = _movieNameLib[value].bitmapOffs;
			}
		
			bitDataOffs = bitmapOffs;
			bitmapDatas = bitmaps;
		
			reset();
		}
		
		
		
		
		
		/**
		 * 帧频
		 * */
		public function set frameRate(value:int):void
		{
			_frameRate = value;
			
			if(updateTimer)
			{
				updateTimer.delay = int(1000/value);
				updateTimer.reset();
			}
		}
		
		
		
	
	
		/**
		 * Clear 
		 */
		override public function clear():void
		{
			super.clear();
			
			_isLoaded = false;
			
			if(clearMemory == true)
			{	
				GameRenderCenter.instance.clearData(_url);
			}
			_textureAtlas = null;
			
			_movieNameLib = null;
			_movieNameLib = new Dictionary();
		}
	
	}
}