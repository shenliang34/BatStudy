package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	import com.gamehero.sxd2.world.display.GameRenderItem;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	
	/**
	 * 死亡特效item
	 * @author xuwenyi
	 * @create 2015-07-09
	 **/
	public class BattleDeathItem extends GameRenderItem
	{
		// 死亡动作位图和位置信息
		private var deathData:Object;
		
		// 朝向
		protected var _face:String = DefaultFigureItem.RIGHT;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleDeathItem(clearMemory:Boolean = true)
		{
			super(clearMemory);
		}
		
		
		
		
		
		/**
		 * Set Face 
		 */
		public function set face(value:String):void
		{
			_face = value;
		}
		
		
		
		
		
		public function get face():String
		{	
			return _face;
		}
		
		
		
		
		
		/**
		 * 获取渲染key
		 * */
		override protected function get renderKey():String
		{
			if(this.face == "")
			{
				return this.status + "_";
			}
			else
			{
				return this.status + "_" + this.face + "_";
			}
		}
		
		
		
		
		
		/**
		 * 播放
		 * */
		public function playDead(deathData:Object):void
		{
			this.deathData = deathData;
			
			this.play(false);
		}
		
		
		
		
		
		
		
		/**
		 * 复写渲染方法,获取renderdata的时候将火星图和死亡图做blendmode混合
		 * */
		override protected function render():void
		{
			super.render();
			
			if(renderSource != null)
			{
				renderSource = this.getBlend(renderSource , deathData.texture);
				
				var frame:Rectangle = deathData.frame;
				if(frame)
				{
					this.x = frame.x;
					this.y = frame.y;
				}
			}
		}
		
		
		
		
		
		
		
		/**
		 * 将死亡动作与火星图做blendmode
		 * */
		private function getBlend(sourceBmd:BitmapData , deathBmd:BitmapData):BitmapData
		{
			var t:Number = getTimer();
			
			var w:int = deathBmd.width;
			var h:int = deathBmd.height;
			
			// 死亡动作图
			var deathBmp:Bitmap = new Bitmap(deathBmd);
			deathBmp.cacheAsBitmap = true;
			
			// 火星图
			var source:BitmapData = new BitmapData(w , h , true , 0);
			source.copyPixels(sourceBmd , new Rectangle(0,0,w,h) , new Point());
			var sourceBmp:Bitmap = new Bitmap(source);
			sourceBmp.cacheAsBitmap = true;
			
			// 临时容器
			var sp:Sprite = new Sprite();
			sp.addChild(sourceBmp);
			sp.addChild(deathBmp);
			
			// 设置遮罩
			sourceBmp.mask = deathBmp;
			
			// 生成最终效果图
			var newBmd:BitmapData = new BitmapData(w , h , true , 0);
			newBmd.draw(sp);
			
			return newBmd;
		}
		
		
		
		
		
		
		
		/**
		 * 清空
		 * */
		override public function clear():void
		{
			deathData = null;
			
			super.clear();
		}
		
		
		
		
		
		/**
		 * Gabage Collect  
		 * @param isCleanAll 是否完全清理
		 * 
		 */
		override public function gc(isCleanAll:Boolean = false):void
		{
			this.clearRender();
			this.clear();
		}
		
	}
}