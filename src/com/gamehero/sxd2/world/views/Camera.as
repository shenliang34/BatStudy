package com.gamehero.sxd2.world.views
{
	import flash.geom.Point;

	/**
	 * 摄像机
	 * 舞台窗口属性设置，包括窗口的坐标，焦点 
	 * @author weiyanyu
	 * 
	 */	
	public class Camera
	{
		/**
		 * 摄像机的坐标 
		 */		
		private var _x:int;
		private var _y:int;
		
		/**
		 * 摄像机可以移动的区域
		 */		
		private var _sceWidth:int;
		private var _sceHeight:int;
		
		private var _targetPt:Point;
		/**
		 * 摄像机大小 
		 */		
		private var _width:int;
		private var _height:int;
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function get x():int
		{
			return _x;
		}
		public function get y():int
		{
			return _y;
		}
		
		
		public function Camera()
		{
			_targetPt = new Point();
		}
		/**
		 * 设置场景大小 <br>
		 * 即摄像机移动的范围，注意，场景的宽高必须大于最大屏幕  1920 * 1080
		 * @param sceWid
		 * @param sceHeight
		 * 
		 */		
		public function setSceneSize(sceWid:int,sceHeight:int):void
		{
			_sceWidth = sceWid;
			_sceHeight = sceHeight;
		}
		
		/**
		 * 设置当前摄像机窗口大小
		 * @param wid
		 * @param heig
		 * 
		 */		
		public function setWinSize(wid:int,heig:int):void
		{
			_width = wid;
			_height = heig;
		}
		
		public function setFocus(px:int,py:int):void
		{
			_targetPt.x = px;
			_targetPt.y = py;
			acclimatize();
		}
		
		/**
		 * 动态更改窗口属性 
		 */		
		private function acclimatize():void
		{
			
			_x = _targetPt.x - (_width >> 1);
			//偏移量 = 距离底部的最小高度 + （当前高度 - 最小高度） / （最大高度 - 最小高度） / (距离底部的最大高度 - 最小高度)
			var offset:int = 230 + (_height - 600) / ((1080 - 600) / (300 - 230));
			_y = _targetPt.y - (_height - offset);
			validate();
		}
		
		/**
		 * 边界检测 
		 * 
		 */		
		private function validate():void
		{
			if(_x < 0)
			{
				_x = 0;
			}
			else if(_x > (_sceWidth - _width))
			{
				_x = (_sceWidth - _width);
			}
			if(_y < 0)
			{
				_y = 0;
			}
			else if(_y > (_sceHeight - _height))
			{
				_y = _sceHeight - _height;
			}
		}
		/**
		 * 角色相对窗口的位置 
		 * @return 
		 * 
		 */		
		public function getFocusX():int
		{
			return _targetPt.x -_x;
		}
		
		public function getFocusY():int
		{
			return _targetPt.y -_y;
		}
		
		public function destroy():void
		{
		}
	}
}