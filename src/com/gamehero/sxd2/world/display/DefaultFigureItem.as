package com.gamehero.sxd2.world.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	
	/**
	 * 默认小黑人形象
	 * @author xuwenyi
	 * @create 2013-12-07
	 **/
	public class DefaultFigureItem extends GameRenderItem
	{
		[Embed(source="/assetsembed/figure/blackman.png")]
		private var BLACK_MAN:Class;
		
		static protected var blackManBD:BitmapData;
		
		// 素材命名定义
		static public const RIGHT:String = "rr";
		static public const LEFT:String = "ll";
		
		// 小黑人默认宽高
		protected var defaultWidth:int;
		protected var defaultHeight:int;
		// 朝向
		protected var _face:String = RIGHT;
		

		
		
		
		/**
		 * 构造函数
		 * @param clearMemory
		 * @param loader
		 * @param loadProps
		 * @param isSWF	主角素材默认都是PNG格式文件
		 * 
		 */
		public function DefaultFigureItem(clearMemory:Boolean = true)
		{
			super(clearMemory);
			
			if(blackManBD == null)
			{	
				var bmp:Bitmap = new BLACK_MAN() as Bitmap;
				blackManBD = bmp.bitmapData;
			}
			this.renderSource = blackManBD;
			
			defaultWidth = blackManBD.width;
			defaultHeight = blackManBD.height;
			
			this.x = -defaultWidth >> 1;
			this.y = -defaultHeight;
		}
		
		
		
		
		/**
		 * 人形宽度
		 * */
		override public function get itemWidth():Number
		{
			return _itemWidth > 0 ? _itemWidth : defaultWidth;
		}
		
		
		
		
		/**
		 * 人形高度
		 * */
		override public function get itemHeight():Number
		{
			return _itemHeight > 0 ? _itemHeight : defaultHeight;
		}
		
		
		
		
		/**
		 * 复写render
		 * 
		 */
		override protected function render():void
		{
			super.render();
			
			// 调整位置
			if(renderData)
			{
				var frame:Rectangle = renderData.frame;
				if(frame)
				{	
					this.x = frame.x;
					this.y = frame.y;
				}
			}
		}
		
		
		/**
		 * 重置播放数据
		 * */
		override public function reset():void
		{
			super.reset();
		}
		
	}
}