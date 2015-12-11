package com.gamehero.sxd2.world.display
{
	
	
	/**
	 * 角色基本类
	 * 主要设置方向
	 * @author xuwenyi
	 * @create 2013-11-08
	 **/
	public class SceneFigureItem extends DefaultFigureItem
	{	
		/**
		 * 构造函数
		 * */
		public function SceneFigureItem(clearMemory:Boolean = true)
		{
			super(clearMemory);
		}
		
		
		
		public function get face():String
		{	
			return _face;
		}
		
		/**
		 * Set Face 
		 */
		public function set face(value:String):void
		{
			_face = value;	
		}
		
		
		/**
		 * 渲染关键字
		 * */
		override protected function get renderKey():String
		{
			return _status + "_" + _face + "_";
		}
		
		
		
		
		/**
		 * 渲染
		 * */
		override protected function render():void
		{
			super.render();
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
			super.gc(true);
		}
	}
}