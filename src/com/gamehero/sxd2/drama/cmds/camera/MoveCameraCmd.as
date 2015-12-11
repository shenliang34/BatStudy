package com.gamehero.sxd2.drama.cmds.camera {
	
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.Camera;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	
	/**
	 * 移动镜头 
	 */
	public class MoveCameraCmd extends BaseCmd
	{
		private var x:Number;
		private var y:Number;
		private var duration:Number;
		
		private var movePointList:Array;
		private var world:GameWorld;
		private var timer:Timer;
		
		
		
		public function MoveCameraCmd() 
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			x = xml.@x;
			y = xml.@y;
			duration = xml.@duration;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function = null):void
		{	
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			world = view.gameWorld;
			var c:Camera = world.camera;
			
			// 总持续帧数
			var totalFrame:int = int(duration * 0.001 * 50);//50帧的速度
			// 原焦点
			var oriX:int = c.getFocusX() + c.x;
			var oriY:int = c.getFocusY() + c.y;
			// 步长
			var stepX:int = (x - oriX) / totalFrame;
			var stepY:int = (y - oriY) / totalFrame;
			// 计算序列点
			movePointList = [];
			for(var i:int=0;i<totalFrame;i++)
			{
				oriX += stepX;
				oriY += stepY;
				movePointList.push(new Point(oriX , oriY));
			}
			
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER , update);
			timer.start();
		}
		
		
		
		
		
		private function update(e:TimerEvent):void
		{
			if(movePointList.length > 0)
			{
				var p:Point = movePointList.shift();
				world.setCameraFocus(p.x , p.y);
			}
			else
			{
				this.complete();
			}
		}
		
		
		
		
		
		
		override public function clear():void 
		{
			super.clear();
			
			world = null;
			
			if(timer)
			{
				timer.removeEventListener(TimerEvent.TIMER , update);
				timer.stop();
				timer = null;
			}
		}
		
		
		
		
		
	}
}