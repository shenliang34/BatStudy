package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	import bowser.utils.time.TimeTick;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 传统flash的mc播放类
	 * @author xuwenyi
	 * @create 2014-01-10
	 **/
	public class GameMovie extends Sprite
	{
		// 动画播放起始时间
		private var startTime:Number;
		// 动画播放结束时间
		private var endTime:Number;
		// 持续时间
		private var duration:int;
		// 播放速度
		private var speed:Number;
		// 是否循环播放
		private var loop:Boolean;
		
		// 动画
		private var movie:MovieClip;
		// 动画播放器
		private var pl:MovieClipPlayer;
		
		// 动画资源路径
		private var url:String;
		// 动画类名
		private var className:String;
		
		// 是否正在播放
		private var isPlay:Boolean;
		// 混合模式
		public var movieBlendMode:String = "";
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function GameMovie()
		{
			super();
		}
		
		
		
		
		/**
		 * 加载
		 * */
		public function load(url:String , className:String , loader:BulkLoaderSingleton = null):void
		{
			this.url = url;
			this.className = className;
			
			var ld:BulkLoaderSingleton = loader == null ? BulkLoaderSingleton.instance : loader;
			ld.addWithListener(url , null , onLoad);
		}
		
		
		
		
		/**
		 * 加载完成
		 * */
		public function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoad);
			
			var cls:Class = imageItem.getDefinitionByName(className) as Class;
			if(cls)
			{
				movie = new cls() as MovieClip;
				if(movieBlendMode != "")
				{
					movie.blendMode = movieBlendMode;
				}
				
				// 执行播放
				this.excutePlay();
			}
			else
			{
				// 没有指定类,提前结束播放
				this.stop();
				this.clear();
			}
			
		}
		
		
		
		
		/**
		 * 播放
		 * @duration 持续时长(毫秒)
		 * */
		public function play(duration:int = 0 , loop:Boolean = false , speed:Number = 1):void
		{
			this.startTime = TimeTick.inst.getCurrentTime();
			this.duration = duration;
			this.speed = speed;
			this.loop = loop;
			this.isPlay = true;
			
			this.excutePlay();
		}
		
		
		
		
		
		/**
		 * 执行播放
		 * */
		private function excutePlay():void
		{
			if(isPlay == true && movie)
			{
				// 播放时长
				duration = duration == 0 ? movie.totalFrames * 1000 / 24 : duration;
				duration *= speed;
				
				if(startTime > 0)
				{
					endTime = startTime + duration;
				}
				if(endTime > 0)
				{
					var nowTime:Number = TimeTick.inst.getCurrentTime();
					if(nowTime > endTime)
					{
						this.stop();
						this.clear();
						return;
					}
				}
				
				pl = new MovieClipPlayer();
				pl.loop = loop;
				pl.play(movie , duration*0.001 , 0 , movie.totalFrames);
				pl.addEventListener(Event.RENDER , onPlayRender);
				pl.addEventListener(Event.COMPLETE , onPlayOver);
				this.addChild(movie);
			}
		}
		
		
		
		
		
		/**
		 * 渲染动画时每帧处理
		 * */
		private function onPlayRender(e:Event):void
		{
			if(endTime > 0)
			{
				var nowTime:Number = TimeTick.inst.getCurrentTime();
				if(nowTime > endTime)
				{
					this.stop();
					this.clear();
				}
			}
		}
		
		
		
		
		
		/**
		 * 渲染动画结束
		 * */
		private function onPlayOver(e:Event):void
		{
			this.stop();
			this.clear();
		}
		
		
		
		
		
		/**
		 * 停止
		 * */
		public function stop():void
		{
			if(pl != null)
			{
				pl.removeEventListener(Event.RENDER , onPlayRender);
				pl.removeEventListener(Event.COMPLETE , onPlayOver);
				pl.stop();
				pl = null;
			}
			// 发送停止事件
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		
		/**
		 * 清空回收资源
		 * */
		public function clear():void
		{
			startTime = 0;
			endTime = 0;
			duration = 0;
			speed = 1;
			isPlay = false;
			movie = null;
			pl = null;
			url = "";
			className = "";
			movieBlendMode = "";
			
			if(pl != null)
			{
				pl.removeEventListener(Event.RENDER , onPlayRender);
				pl.removeEventListener(Event.COMPLETE , onPlayOver);
				pl.stop();
				pl = null;
			}
			
			Global.instance.removeChildren(this);
		}
		
	}
}