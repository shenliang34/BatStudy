package com.gamehero.sxd2.world.display
{
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	
	import bowser.render.display.Animation;
	import bowser.render.display.RenderItem;
	import bowser.render.utils.AnimationMgr;
	
	
	/**
	 *用于支持movieClip动画 
	 * @author wulongbin
	 * @edited xuwenyi 重新封装此类 2014-01-07
	 */	
	public class MovieItem extends RenderItem
	{
		private var movie:MovieClip;
		private var animCompHandler:Function;
		
		// 默认播放帧频
		public var frameRate:int = 30;
		// 总帧数
		private var totalFrames:int = 0;
		
		
		
		/**
		 * 构造函数
		 * */
		public function MovieItem(movie:MovieClip , totalFrames:int = 0)
		{
			this.totalFrames = totalFrames;
			this.movie = movie;
			movie.stop();
			
			var movieName:String = getQualifiedClassName(movie);
			super(movieName);
		}
		
		override public function load(url:String=null):void
		{
			if(url) 
			{
				_url = url;
			}
			
			animation = new Animation();
			animation.frameRate = frameRate;
			animation.isPlaying = false;
			animation.loop = true;
			animation.id = _url;
			
			
			AnimationMgr.generateBitmpas(_url , movie , totalFrames);
			movie.gotoAndPlay(0);
		}
		
		
		
		
		/**
		 * 开始播放
		 * */
		public function play(loop:Boolean , callBack:Function = null):void
		{
			animation.isPlaying = true;
			animation.loop = loop;
			animation.frameRate = frameRate;
			
			// 回调
			animCompHandler = callBack;
		}
		
		
		
		
		/**
		 * 停止播放
		 * */
		public function stop():void
		{
			animation.isPlaying = false;
			animation.currentFrame = 1;
			
			// 回调
			animCompHandler = null;
		}
		
		
		
		
		/**
		 * 复写draw , 为了处理动画完成事件
		 * */
		override public function draw():void {
			
			super.draw();
			
			if(animation.totalFrames > 0 && animation.loop == false)
			{
				// 是否处理播放完成事件
				if(animCompHandler && animation.currentFrame >= animation.totalFrames)
				{
					//先置null，再回调：为防止animCompHandler函数回调再次操作animCompHandler本身后被置null引发冲突
					var tempFunc:Function = animCompHandler;
					animCompHandler = null;
					tempFunc();// 回调函数
				}
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			this.renderSource = null;
		}
		
		
		
		
		
		/**
		 * 复写gc
		 * */
		/*override public function gc():void
		{
			//renderSource = null;
			//drawRectangle = null;
			
			if(animation)
			{
				AnimationMgr.clear(animation.id);
				animation.gc();
			}
		}*/
		
	}
}