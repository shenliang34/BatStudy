package com.gamehero.sxd2.world.display
{
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.gamehero.sxd2.world.display.data.GameRenderData;
	import com.gamehero.sxd2.world.display.data.RenderSourceData;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.RenderItem;
	import bowser.render.utils.TextureAtlas;
	
	
	/**
	 * 游戏渲染对象基类(用于渲染角色,npc,怪物,特效等)
	 * @author xuwenyi
	 * @create 2013-12-23
	 **/
	public class GameRenderItem extends RenderItem
	{
		// 基准播放速度
		public static const DF_FR:int = 12;
		
		protected var _frameTime:int;				// 记录上一帧结束时的时间点
		protected var _frameInterval:int = 0;		// 每帧耗时(ms)
		protected var _adjustTime:int = 0;			// 调整每帧时间
		protected var _frameRate:int = 0;			// 帧频
		protected var _currentFrame:int = 0;		// 播放头位置
		
		// 起始结束时间
		protected var startTime:Number = 0;
		protected var endTime:Number = 0;
		
		// 模型宽度高度
		protected var _itemWidth:Number = 0;
		protected var _itemHeight:Number = 0;
		
		// 动画播放完一轮后的回调函数(根据帧判断)
		public var animCompHandler:Function;
		
		public var url:String;// 外形url
		protected var renderData:Object;// 当前渲染素材
		
		// 当前动画状态
		protected var _status:String;
		
		// TODO: 以后修改使用Animation		
		public var isPlaying:Boolean = true;	// 播放状态
		public var loop:Boolean = true;			// 是否循环
		public var totalFrames:int = 0;			// 总帧数
		
		// 资源没加载完时是否直接播放完成
		public var noResourceHandleMode:Boolean = false;// 默认关闭
		
		// 是否会清除缓存
		private var clearMemory:Boolean;
		
		
		
		/**
		 * 构造函数
		 * */
		public function GameRenderItem(clearMemory:Boolean = true)
		{
			super(false);
			
			// 是否清除缓存
			this.clearMemory = clearMemory;
			// 默认帧频
			this.frameRate = DF_FR;
		}
		
		
		
		
		
		
		/**
		 * 加载资源
		 */
		public function load(url:String , loader:BulkLoaderSingleton):void
		{	
			this.url = url;
			
			if(url != null && url != "")
			{
				_itemWidth = 0;
				_itemHeight = 0;
				
				// 加载外形素材
				var center:GameRenderCenter = GameRenderCenter.instance;
				var data:GameRenderData = center.getData(url);
				// 之前有加载过
				if(data)
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
				else
				{
					// 创建新的数据,并加载
					data = center.loadData(url , clearMemory, loader);
					data.addEventListener(RenderItemEvent.RESOURCE_LOADED , onResourceLoaded , false , 0 , true);
				}
			}
		}
		
		
		
		
		/**
		 * 素材已加载完成
		 */
		protected function onResourceLoaded(e:RenderItemEvent = null):void
		{
			// 移除事件
			if(e)
			{
				e.currentTarget.removeEventListener(RenderItemEvent.RESOURCE_LOADED , onResourceLoaded);
			}
			
			// Add Animation Handler
			_frameTime = getTimer();
			
			this.dispatchEvent(new RenderItemEvent(RenderItemEvent.LOADED , this));
		}
		
		
		
		
		/**
		 * 开始播放
		 * */
		public function play(loop:Boolean):void
		{
			this.isPlaying = true;
			this.loop = loop;
			this.startTime = getTimer();
		}
		
		
		
		
		/**
		 * 停止播放
		 * */
		public function stop():void
		{
			this.isPlaying = false;
			this.loop = false;
			
			this.reset();
		}
		
		
		
		
		/**
		 * 动画状态
		 * */
		public function set status(value:String):void
		{
			if(value != _status)
			{	
				_status = value;
				
				// 重置动画播放
				_currentFrame = 0;
			}
		}
		
		
		
		
		
		public function get status():String
		{
			return _status;
		}
		
		
		
		
		
		
		/**
		 * 获取渲染key
		 * */
		protected function get renderKey():String
		{
			return status;
		}
		
		
		
		
		
		
		/**
		 * 渲染前准备，检查是否可继续渲染
		 * */
		protected function checkRender():Boolean
		{
			// 播放停止
			if(isPlaying == false)
			{
				return false;
			}
			
			// 单词播放超过时间了
			if(endTime > 0 && loop == false)
			{
				// 超过了播放时间(宽限一帧的时间,40ms) , 则停止播放
				if(getTimer() > endTime + 40)
				{
					this.stop();
					// 派发完成事件
					dispatchEvent(new RenderItemEvent(RenderItemEvent.PLAY_COMPLETE , this));
					return false;
				}
			}
			
			var center:GameRenderCenter = GameRenderCenter.instance;
			var data:GameRenderData = center.getData(url);
			if(data && data.atlas)
			{
				_isNeedRender = false;
				
				// 播放头判断
				if(totalFrames > 0 && _currentFrame >= totalFrames)
				{
					// 单次播放结束了
					if(loop == false)
					{	
						this.stop();
						// 派发完成事件
						dispatchEvent(new RenderItemEvent(RenderItemEvent.PLAY_COMPLETE , this));
						return false;
					}
					else
					{
						_currentFrame = 0;
					}
				}
				
				return true;
			}
			else
			{
				// 没有资源,但又必须让逻辑进行下去的情况
				if(loop == false && noResourceHandleMode == true)
				{
					this.stop();
					// 派发完成事件
					dispatchEvent(new RenderItemEvent(RenderItemEvent.PLAY_COMPLETE , this));
					return false;
				}
			}
			return false;
		}
		
		
		
		
		
		
		/**
		 * 渲染图像
		 * */
		protected function render():void
		{
			/** 准备渲染数据 */
			var center:GameRenderCenter = GameRenderCenter.instance;
			var gameRenderData:GameRenderData = center.getData(url);
			if(gameRenderData != null)
			{
				// 渲染素材
				var textures:Dictionary = gameRenderData.textures;
				var atlas:TextureAtlas = gameRenderData.atlas;
				
				// 动作
				var key:String = this.renderKey;

				// 方向向左的话转成向右的
				var finalKey:String = key;
				if(key.indexOf(DefaultFigureItem.LEFT) >= 0)
				{
					finalKey = key.replace(DefaultFigureItem.LEFT , DefaultFigureItem.RIGHT);
				}
				
				var renderSourceData:RenderSourceData = textures[key];
				// 若此动作从来没有初始化过,则新建动作数组
				if(renderSourceData == null)
				{
					// 初始化单个动作的渲染数据
					renderSourceData = new RenderSourceData();
					// 获取此动作的总帧数
					var names:Vector.<String> = atlas.getNames(finalKey);
					renderSourceData.totalFrame = names.length;
					textures[key] = renderSourceData;
				}
				// 动画总帧数
				totalFrames = renderSourceData.totalFrame;
				
				if(totalFrames > 0)
				{
					// 帧频判断(计算本帧的耗时+上一帧多余的时间)
					var interval:int = getTimer() - _frameTime + _adjustTime;
					if(interval < _frameInterval)//本帧没有达到设定帧频一帧该有的时间,则跳过
					{	
						renderData = null;
						return;
					}
					
					// 获取当前帧的渲染数据
					var renderList:Array = renderSourceData.renderList;
					renderData = renderList[_currentFrame];
					if(renderData == null)
					{
						// 绘制当前帧的图片
						renderData = atlas.getTextureData(finalKey , _currentFrame , key != finalKey);//key != finalKey表示方向是朝左的
						renderList[_currentFrame] = renderData;
					}
					
					// 渲染图像
					if(renderData && renderData.texture != null)
					{	
						this.renderSource = renderData.texture;
						
						// 角色高度
						if(_itemWidth == 0 && _itemHeight == 0)
						{
							_itemWidth = renderSource.width;
							_itemHeight = renderSource.height;
							// 加载完成事件
							this.dispatchEvent(new RenderItemEvent(RenderItemEvent.FIRST_RENDER , this));
						}
					}
					
					// 下一帧
					_currentFrame++;
					
					// TRICKY: 防止_adjustTime超长2帧范围
					// 此时的interval必定 > _frameInterval一帧的时间
					if(interval < _frameInterval << 1)
					{	
						_adjustTime = interval - _frameInterval;
					}
					_frameTime = getTimer();
				}
				else
				{
					// 没有动画序列
					if(loop == false)
					{
						this.stop();
						// 派发完成事件
						dispatchEvent(new RenderItemEvent(RenderItemEvent.PLAY_COMPLETE , this));
						return;
					}
				}
			}
			
		}
		
		
		
		
		
		/**
		 * Override preDraw 
		 */
		override public function preDraw():void
		{
			// 是否可渲染
			if(this.visible == true)
			{
				var needRender:Boolean = this.checkRender();
				
				super.preDraw();
				
				if(needRender == true)
				{
					// 渲染
					this.render();
					
					// 设置endTime
					if(endTime == 0 && startTime > 0)
					{
						// 计算结束时间
						endTime = startTime + int((totalFrames*1000)/frameRate);
						trace("渲染结束时间---" + endTime);
					}
				}	
			}
		}
		
		
		
		
		
		
		/**
		 * 复写draw , 为了处理动画完成事件
		 * */
		override public function draw():void 
		{
			if(this.visible == true)
			{
				super.draw();
				
				if(totalFrames > 0)
				{
					// 派发更新事件
					//this.dispatchEvent(new RenderItemEvent(RenderItemEvent.PLAY_UPDATE , this));
					
					// 是否处理播放完成事件
					if(animCompHandler != null && _currentFrame >= totalFrames)
					{
						//先置null，再回调：为防止animCompHandler函数回调再次操作animCompHandler本身后被置null引发冲突
						var tempFunc:Function = animCompHandler;
						animCompHandler = null;
						tempFunc(this);// 回调函数
					}
				}
			}
		}
		
		
		
		/**
		 * 当前帧
		 * */
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		
		public function set currentFrame(value:int):void
		{
			_currentFrame = value;
		}
		
		
		/**
		 * Get FrameRate 
		 */
		public function get frameRate():int {
			
			return _frameRate;
		}
		
		
		/**
		 * Set FrameRate 
		 */
		public function set frameRate(value:int):void {
			
			_frameRate = value;
			_frameInterval = Math.round(1000 / _frameRate);
		}
		
		
		
		
		
		/**
		 * 渲染物件宽度
		 * */
		public function get itemWidth():Number
		{
			return _itemWidth;
		}
		
		
		
		
		/**
		 * 渲染物件高度
		 * */
		public function get itemHeight():Number
		{
			return _itemHeight;
		}
		
		
		
		
		
		/**
		 * 清除渲染画面
		 * */
		public function clearRender():void
		{
			this.renderSource = null;
		}
		
		
		
		
		
		
		/**
		 * 重置播放数据
		 * */
		public function reset():void
		{
			// 属性归0
			startTime = 0;
			endTime = 0;
			_currentFrame = 0;
			totalFrames = 0;
			renderData = null;
		}
		
		
		
		
		
		
		/**
		 * 清空数据
		 * */
		public function clear():void
		{
			this.reset();
			
			animCompHandler = null;
		}
		
		
		
		
		
		/**
		 * Gabage Collect  
		 * @param isCleanAll 是否完全清理
		 * 
		 */
		override public function gc(isCleanAll:Boolean = false):void
		{
			if(url && url != "")
			{
				// 移除加载事件
				var gameRenderData:GameRenderData = GameRenderCenter.instance.getData(url);
				if(gameRenderData)
				{
					gameRenderData.removeEventListener(RenderItemEvent.LOADED , onResourceLoaded);
				}
				
				// 清除缓存
				GameRenderCenter.instance.clearData(url);
			}
			
			this.clearRender();
			this.clear();
		}
		
		
	}
}