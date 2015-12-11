package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 剧情过场动画
	 * @author xuwenyi
	 * @modify 2015-10-14
	 */
	public class PlayMovieCmd extends BaseCmd
	{
		private var url:String;
		private var center:Boolean;
		
		private var mc:MovieClip;
		
		
		
		public function PlayMovieCmd()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			url = GameConfig.DRAMA_MOVIE_URL + xml.@url + ".swf";
			center = xml.@center == "1" ? true : false;
		}
		
		
		override public function triggerCallBack(callBack:Function = null):void
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
				mc = new cls() as MovieClip;
				mc.gotoAndStop(0);
				
				// 在当前stage上添加此动画
				var stage:Stage = App.stage;
				stage.addChild(mc);
				stage.addEventListener(Event.RESIZE , resize);
				
				// 背景黑色
				/*mc.graphics.beginFill(0);
				mc.graphics.drawRect(0,0,stage.stageWidth,stage.height);
				mc.graphics.endFill();*/
				
				var mp:MovieClipPlayer = new MovieClipPlayer();
				mp.play(mc , mc.totalFrames/24 , 0 , mc.totalFrames);
				mp.addEventListener(Event.COMPLETE , over);
				
				function over(evt:Event):void
				{
					mp.removeEventListener(Event.COMPLETE , over);
					mp = null;
					
					stage.removeChild(mc);
					
					complete();
				}
				
				resize();
			}
			else
			{
				complete();
			}
		}
		
		
		
		
		
		
		private function resize(e:Event = null):void
		{
			if(center == true && mc != null)
			{
				var stage:Stage = App.stage;
				mc.x = (stage.stageWidth - 1920) >> 1;
				mc.y = (stage.stageHeight - 1080) >> 1;
			}
		}
		
		
		
		
		
		override protected function complete():void
		{
			super.complete();
			
			var stage:Stage = App.stage;
			stage.removeEventListener(Event.RESIZE , resize);
			
			mc = null;
		}
	}
}