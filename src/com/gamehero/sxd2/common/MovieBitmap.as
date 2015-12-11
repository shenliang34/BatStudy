package com.gamehero.sxd2.common
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	

	[Event(name = "complete", type = "flash.events.Event")]
	
	/**
	 * 位图序列动画
	 * @author wulongbin
	 * 
	 */	
	public class MovieBitmap extends Sprite
	{
		public static var NULL:Vector.<BitmapData> = new Vector.<BitmapData>
		
		public var complete:Function;
		
		private var _bitmapDatas:Vector.<BitmapData>;
		private var _bitmapDataOffs:Vector.<Point>;
		private var _bitmap:Bitmap;
		
		private var _currentFrame:uint = 0;
		private var _totalFrames:uint = 0;
		private var _isPlaying:Boolean = false;
		
		private var _totalLoop:int = 1;
		private var _nowLoop:int = 0;
		
		private var _isReverse:Boolean;
		private var rOffsetX:Number;
		
		/**
		 * 构造函数
		 * */
		public function MovieBitmap(complete:Function = null)
		{
			super();
			
			this.complete = complete || function():void{};
			
			_bitmap = new Bitmap;
			addChild(_bitmap);
			
			bitmapDatas = NULL;
			
			rOffsetX = 0;
			
			this._isReverse = false;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		public function set bitmapDatas(value:Vector.<BitmapData>):void
		{
			if(value) 
				_bitmapDatas = value;
			else
				_bitmapDatas = NULL;
			
			reset();
		}
		
		
		public function get bitmapDatas():Vector.<BitmapData>
		{
			return _bitmapDatas;
		}
		
		
		public function reset():void
		{
			_nowLoop = 0;
			_totalFrames = _bitmapDatas.length;
			currentFrame = 0;
			isPlaying = false;
		}
		
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		
		public function set currentFrame(value:int):void
		{
			_currentFrame = (value%_totalFrames)
			flushView();
		}
		
		
		protected function flushView():void
		{
			if(_totalFrames == 0) {
				
				return;
			}
			_bitmap.smoothing = true;
			_bitmap.bitmapData = _bitmapDatas[_currentFrame];
			
			if(_bitmapDataOffs)
			{
				rOffsetX = 0;
				if(_isReverse)
				{
					rOffsetX =  - 2 * _bitmapDataOffs[_currentFrame].x;
				}
				
				_bitmap.x = _bitmapDataOffs[_currentFrame].x + rOffsetX;
				_bitmap.y = _bitmapDataOffs[_currentFrame].y;
			}
		}
		
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		
		public function set isPlaying(value:Boolean):void
		{
			if(_isPlaying == value) return;
			_isPlaying = value;
			if(_isPlaying)
			{
				currentFrame = _currentFrame;
			}
		}
		
		
		/**
		 *播放 
		 * @param totalLoop 循环次数
		 * 
		 */		
		public function play(totalLoop:int = int.MAX_VALUE):void
		{
			reset();
			_totalLoop = totalLoop;
			isPlaying = true;
		}
		
		
		public function stop():void
		{
			isPlaying = false;
		}
		
		
		public function end():void
		{
			currentFrame = _totalFrames-1;
			isPlaying = false;
		}
		
		
		public function get totalFrames():int
		{
			return _totalFrames;
		}
		
		
		public function nextFrame():void
		{
			var isComplete:Boolean = _currentFrame + 1 == _totalFrames;
			currentFrame++;
			
			if(isComplete)
			{
				_nowLoop++;
			
				if(_totalLoop >= 0 && _nowLoop >= _totalLoop)
				{
					stop();
					complete();
				}
			}
		}
		
		
		public function set bitmapData(value:BitmapData):void
		{
			_bitmap.bitmapData = value;
		}
		
		
		public function get bitmapData():BitmapData
		{
			return _bitmap.bitmapData;
		}
		
		
		public function get offX():Number
		{
			return _bitmap.x;
		}
		
		
		public function set offX(value:Number):void
		{
			_bitmap.x = value;
		}
		
		
		public function get offY():Number
		{
			return _bitmap.y;
		}
		
		
		public function set offY(value:Number):void
		{
			_bitmap.y = value;
		}
		

		public function get bitDataOffs():Vector.<Point>
		{
			return _bitmapDataOffs;
		}
		

		public function set bitDataOffs(value:Vector.<Point>):void
		{
			_bitmapDataOffs = value;
		}
		

		public function get totalLoop():int
		{
			return _totalLoop;
		}

		
		public function set totalLoop(value:int):void
		{
			_totalLoop = value;
		}
		
		public function set reverse(value:Boolean):void
		{
			_isReverse = value;
			
			if(_isReverse)
				_bitmap.scaleX = -1;	
		}
		
		
		/**
		 * Clear 
		 * 
		 */
		public function clear():void
		{
			if(bitmapDatas)
			{
				for each(var bd:BitmapData in bitmapDatas)
				{
					bd.dispose();
				}
				
				bitmapDatas = null;
				bitDataOffs = null;
				
				if(_bitmap && _bitmap.bitmapData)	_bitmap.bitmapData.dispose();
			}
		}

	}
}