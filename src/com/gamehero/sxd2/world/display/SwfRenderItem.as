package com.gamehero.sxd2.world.display
{
	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.world.display.data.SwfAtalsCenter;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.RenderItem;
	import bowser.render.vo.AnimationVO;
	import bowser.utils.MathUtil;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * swf 解析
	 * @author weiyanyu
	 * 创建时间：2015-7-13 下午2:35:05
	 * 
	 */
	public class SwfRenderItem extends RenderItem
	{
		/**
		 * 引用的swf动画数据 
		 */		
		private var _swfAtlas:SwfAtlas;

		protected var loader:BulkLoaderSingleton;
		/**
		 * 动作响应配置 
		 */		
		public function get actionXml():XML
		{
			return _swfAtlas.actionXML;
		}
		
		/**
		 * 当前动作播放次数
		 */		
		private var _frameCount:int;
		/**
		 * 当前循环播放次数 
		 */		
		private var _playNum:int;
		/**
		 * 当前帧所在的位置 
		 */		
		private var _frameLoc:int;
		/**
		 * 循环次数 
		 */		
		private var _loop:int;
		
		private var _isLoaded:Boolean;
		/**
		 * 帧率 
		 */		
		private var _frameRate:int;		// 帧率
		
		private var _frameMS:int;		// 每帧毫秒数
		private var _pastMS:int;		// 已经过去的毫秒数
		private var _time:int;
		/**
		 * 资源是否已经存在 
		 * @return 
		 * 
		 */		
		public function get isLoaded():Boolean
		{
			return _isLoaded;
		}
		
		public function get loop():int
		{
			return _loop;
		}
		public function set loop(value:int):void
		{
			_loop = value;
		}
		/**
		 * 总帧数 
		 */		
		private var _totalFrames:int = 0;			// 
		// 当前动画状态
		protected var _status:String;
		
		private var _animationVo:AnimationVO;
		public var regPoint:Point = new Point();// 注册点
		/**
		 * 是否是单帧的swf 
		 */		
		public var isSimpleSwf:Boolean;
		
		/**
		 * 是否需要抛出播放完成事件 
		 */		
		public var isOverEvent:Boolean;
		
		/**
		 *  
		 * @param url 位置
		 * @param isSS 是否是简单单帧的swf
		 * @param clearMemory
		 * @param loader
		 * @param loadProps
		 * @param isSWF
		 * 
		 */		
		public function SwfRenderItem(url:String,isSS:Boolean = false,clearMemory:Boolean = true, loader:BulkLoaderSingleton = null, loadProps:Object = null, 
									  isSWF:Boolean = true) 
		{
			super(isBackground);
			changeSource(url,isSS);
		}
		/**
		 * 改变swfrender的内容 
		 * @param url
		 * @param isSS
		 * 
		 */		
		public function changeSource(url:String,isSS:Boolean = false):void
		{
			if(url == null) return;
			frameRate = MapConfig.FRAME_RATE;	// 默认帧率24
			status = "a0";//默认第一个状态
			
			this._url = url;
			this.isSimpleSwf = isSS;
			if(url.indexOf(".png") > -1)
			{
				this.isSimpleSwf = true;
				_url = url.replace(".png",".swf");
			}
			if(url.indexOf(".jpg") > -1)
			{
				this.isSimpleSwf = true;
				_url = url.replace(".jpg",".swf");
			}
			
			this.loader = BulkLoaderSingleton.instance;
			this.load(_url);
		}
		
		/**
		 * 加载资源 
		 * @param url
		 * 
		 */		
		private function load(url:String = null):void
		{
			if(isSimpleSwf && SwfAtalsCenter.bmpDict[_url])
			{
				renderSource = SwfAtalsCenter.bmpDict[_url];
				_isLoaded = true;
			}
			else if(!isSimpleSwf && SwfAtalsCenter.swfAtlasDict[_url])
			{
				_swfAtlas = SwfAtalsCenter.swfAtlasDict[_url];
				_isLoaded = true;
			}
			else
			{
				loader.addWithListener(_url, null, onLoaded);
				loader.start();
			}
		}
		
		private function onLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			if(isSimpleSwf)
			{	
				//如果简单swf直接设置renderSource
				var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
				SwfAtalsCenter.bmpDict[_url] = new PNGDataClass();
				renderSource = SwfAtalsCenter.bmpDict[_url];
			}
			else
			{
				var movieClip:MovieClip = imageItem.content;
				_swfAtlas = new SwfAtlas(movieClip);
				SwfAtalsCenter.swfAtlasDict[_url] = _swfAtlas;

				this.rectangle.width = movieClip.width;
				this.rectangle.height = movieClip.height;
			}
			_isLoaded = true;
			dispatchEvent(new SwfRenderEvent(SwfRenderEvent.LOADED));
		}
		
		
		/**
		 * Override preDraw 
		 */
		override public function preDraw():void
		{	
			// 是否可渲染
			if(this.visible == true)
			{
				// 动画
				if(_swfAtlas)
				{
					if(status == null) return;
					// 渲染标志还原,之后根据状态来设置
					_isNeedRender = false;
					
					// 播放中，并符合帧率
					_time = getTimer();
					if((_time - _pastMS) < _frameMS) return;
					
					if(isOverEvent)
					{
						if(_frameCount == _swfAtlas.totalFrame)
						{
							_frameCount = 0;
							dispatchEvent(new SwfRenderEvent(SwfRenderEvent.ISOVER));
						}
							
					}
					
					if(_swfAtlas.hasLabels)
					{
						_totalFrames = _swfAtlas.getStatusLen(status);
						_playNum = _frameCount / _totalFrames;
						
						if(_loop == 0 || _playNum < _loop)//循环播放 或者 播放次数不足
						{
							_frameLoc = _frameCount % _totalFrames;
							_animationVo = _swfAtlas.getAnimation(status,_frameLoc);
							setFrame();
						}
						else
						{
							dispatchEvent(new SwfRenderEvent(SwfRenderEvent.ISOVER));
						}
					}
					else
					{						
						_animationVo = _swfAtlas.getCurAnimation(_frameCount % _swfAtlas.totalFrame);
						setFrame();
					}
					
				}
			}
		}
		/**
		 * 设置帧图像 
		 * 
		 */		
		private function setFrame():void
		{
			if(_animationVo)
			{
				renderSource = _animationVo.bitmapData;
				
				// 调整注册点
				regPoint = _animationVo.regPoint;
				this.x = x;
				this.y = y;
				_frameCount ++;
				_pastMS = _time;
			}
		}
		
		/**
		 * 旋转逻辑
		 * */
		override protected function processRotate(matrix:Matrix , r:Number):void
		{
			if(r != 0)
			{
				matrix.translate(-regPoint.x, -regPoint.y);
				matrix.rotate(r * Math.PI / 180);
				matrix.translate(regPoint.x, regPoint.y);
			}
		}
		
		
		
		
		override public function set x(value:Number):void
		{
			_setX = value;
			
			// 不取整会抖动
			var tempX:Number = _setX - regPoint.x * (scaleX * (parent ? parent.scaleX : 1));
			_x = int(tempX);
			
			// 最终绘制的时候需要还原回去的小数
			var cha:Number = tempX - _x;
			if(cha != 0)
			{
				_adjustX = MathUtil.decimalPoint(cha); 
			}
			else
			{
				_adjustX = 0;
			}
			
			isNeedRender = true;
		}
		
		
		
		
		override public function set y(value:Number):void
		{
			_setY = value;
			
			// 不取整会抖动
			var tempY:Number = _setY - regPoint.y * (scaleY * (parent ? parent.scaleY : 1));
			_y = int(tempY);
			
			// 最终绘制的时候需要还原回去的小数
			var cha:Number = tempY - _y;
			if(cha != 0)
			{
				_adjustY = MathUtil.decimalPoint(cha); 
			}
			else
			{
				_adjustX = 0;
			}
			
			isNeedRender = true;
		}
		
		public function get frameRate():int {
			
			return _frameRate;
		}
		
		
		public function set frameRate(value:int):void {
			if(value == 0) return;
			_frameRate = value;
			_frameMS = 1000 / _frameRate;
		}
		
		/**
		 * 动画状态
		 * */
		public function set status(value:String):void
		{
			if(value != _status)
			{	
				_status = value;
				_frameCount = 0;
			}
		}
		
		public function get status():String
		{
			return _status;
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			_swfAtlas = null;
			_isNeedRender = false;
			_animationVo = null;
			regPoint = null;
			_playNum = 0;
			_frameLoc = 0;
			_loop = 0;
			_pastMS = 0;
			super.gc();
		}
		
	}
}