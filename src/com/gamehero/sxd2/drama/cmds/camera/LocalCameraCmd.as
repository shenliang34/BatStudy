package com.gamehero.sxd2.drama.cmds.camera
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.utils.setTimeout;

	
	
	
	/**
	 *摄像头定位 
	 */
	public class LocalCameraCmd extends BaseCmd
	{
		private var x:int;
		private var y:int;
		private var duration:Number;
		private var type:int;
		
		
		
		public function LocalCameraCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			x = xml.@x;
			y = xml.@y;
			duration = xml.@duration;
			type = xml.@type;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			world.setCameraFocus(x , y);
			
			if(type == 1)
			{
				world.isMoveCamera = false;
			}
			else
			{
				world.isMoveCamera = true;
			}
			
			if(duration == 0)
			{
				this.complete();
			}
			else
			{
				setTimeout(complete , duration);
			}
		}
		
	}
}