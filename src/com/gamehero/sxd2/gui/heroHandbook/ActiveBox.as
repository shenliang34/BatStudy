package com.gamehero.sxd2.gui.heroHandbook
{
	
	import alternativa.gui.base.ActiveObject;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-12 下午8:32:45
	 * 宝箱盒子相应Tips
	 */
	public class ActiveBox extends ActiveObject
	{
		public var boxId:int
		public var boxRwd:Object;
		public function ActiveBox()
		{
			super();
		}
		
		public function initBox(w:int , h:int , x:int = 0 , y:int = 0):void
		{
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(x , y , w , h);
			this.graphics.endFill();
		}
		
		public function updata(data:Object = null):void
		{
			this.boxRwd = Object;
			this.hint = "宝箱";
		}
	}
}