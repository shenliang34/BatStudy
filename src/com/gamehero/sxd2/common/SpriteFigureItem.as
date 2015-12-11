package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	
	import flash.display.Bitmap;

	
	
	/**
	 * 基于TextureAltas格式的角色动画 (传统sprite)
	 * @author xuwenyi
	 */
	public class SpriteFigureItem extends SpriteRenderItem
	{
		[Embed(source="/assetsembed/figure/blackman.png")]
		private var BLACK_MAN:Class;
		
		//动作状态
		private var _status:String;
		//朝向
		private var _face:String = DefaultFigureItem.RIGHT;
		
		// 小黑人
		private var blackMan:Bitmap;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function SpriteFigureItem(url:String , clearMemory:Boolean , status:String)
		{
			this.status = status;
			
			// 小黑人
			blackMan = new BLACK_MAN() as Bitmap;
			blackMan.x = -blackMan.width >> 1;
			blackMan.y = -blackMan.height;
			this.addChild(blackMan);
			
			super(url , clearMemory);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		
		override protected function onResourceLoaded(e:RenderItemEvent=null):void
		{
			super.onResourceLoaded(e);
			
			if(blackMan && this.contains(blackMan) == true)
			{
				this.removeChild(blackMan);
			}
			
			this.setMovieName(this.renderKey);
		}
		
		
		
		
		public function get status():String
		{
			return _status;
		}

		
		public function set status(value:String):void
		{
			_status = value;
		}
		
		

		public function set face(value:String):void
		{
			if(value == DefaultFigureItem.RIGHT)
			{
				this.scaleX = 1;
			}
			else
			{
				this.scaleX = -1;
			}
		}
		
		
		
		/**
		 *更新动画序列 
		 */		
		public function get renderKey():String
		{
			return _status + "_" + _face + "_";
		}

		
	}
}
