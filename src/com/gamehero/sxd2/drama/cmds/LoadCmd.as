package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.gui.progress.MapLoadingUI;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.BulkLoader;
	
	
	/**
	 * 加载资源指令
	 * @author xuwenyi
	 * @create 2015-11-07
	 **/
	public class LoadCmd extends BaseCmd
	{
		private var resources:Array;
		private var total:Number;
		
		
		public function LoadCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			resources = xml.@resources.split("^");
			total = resources.length;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			for(var i:int=0;i<resources.length;i++)
			{
				var url:String = resources[i];
				
				var props:Object;
				if(url.indexOf(".gh") >= 0)
				{
					props = {};
					props.type = BulkLoader.TYPE_BINARY;
				}
				else
				{
					props = null;
				}
				
				loader.addWithListener(GameConfig.RESOURCE_URL + resources[i] , props , onLoaded , onProgress , onError);
			}
			
			MapLoadingUI.inst.show();
		}
		
		
		
		
		private function onLoaded(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE , onLoaded);
			e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			e.currentTarget.removeEventListener(ErrorEvent.ERROR , onError);
			
			resources.shift();
			MapLoadingUI.inst.updateProgress(Math.floor((1 - resources.length/total) * 100));
			
			if(resources.length == 0)
			{
				MapLoadingUI.inst.hide();
				
				complete();
			}
		}
		
		
		
		
		private function onProgress(e:ProgressEvent):void
		{
			var rate:Number = 100/total;
			var d:int = total - resources.length;
			
			// 进度(每一个资源都会均分一个百分比)
			var progress:Number = e.bytesLoaded / e.bytesTotal;
			progress = rate * (d + progress);
			
			MapLoadingUI.inst.updateProgress(Math.floor(progress));
		}
		
		
		
		
		private function onError(e:ErrorEvent):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE , onLoaded);
			e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			e.currentTarget.removeEventListener(ErrorEvent.ERROR , onError);
			
			resources.shift();
			MapLoadingUI.inst.updateProgress(Math.floor((1 - resources.length/total) * 100));
			
			if(resources.length == 0)
			{
				MapLoadingUI.inst.hide();
				
				complete();
			}
		}
	}
}