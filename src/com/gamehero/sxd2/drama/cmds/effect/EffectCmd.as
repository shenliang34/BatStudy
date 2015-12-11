package com.gamehero.sxd2.drama.cmds.effect
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	
	
	/**
	 * 播放特效 
	 */
	public class EffectCmd extends BaseCmd
	{
		private var x:Number;
		private var y:Number;
		private var url:String;
		
		
		
		
		public function EffectCmd()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			x = xml.@x;
			y = xml.@y;
			url = GameConfig.DRAMA_EFFECT_URL + xml.@url + ".swf";
		}
		
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			// 开始加载动画资源
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(url , null , onLoad);
		}
		
		
		
		
		
		private function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoad);
			
			var cls:Class = imageItem.getDefinitionByName("EFFECT") as Class;
			if(cls)
			{
				var view:SceneViewBase = SXD2Main.inst.currentView;
				var world:GameWorld = view.gameWorld;
				var pos:Point = world.getStagePoint(x , y);
				
				var mc:MovieClip = new cls() as MovieClip;
				mc.x = pos.x
				mc.y = pos.y;
				view.addChild(mc);
				
				var mp:MovieClipPlayer = new MovieClipPlayer();
				mp.play(mc , mc.totalFrames/24 , 0 , mc.totalFrames);
				mp.addEventListener(Event.COMPLETE , over);
				
				function over(evt:Event):void
				{
					mp.removeEventListener(Event.COMPLETE , over);
					mp = null;
					
					SXD2Main.inst.currentView.removeChild(mc);
					
					complete();
				}
			}
		}
	}
}