package com.gamehero.sxd2.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 *位图加载容器 
	 * @author wulongbin
	 * 
	 */	
	public class BitmapLoader extends Bitmap
	{
		public var resetFunc:Function;
		protected var _url:String;
		
		
		
		
		public function BitmapLoader(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}

		
		
		
		public function get url():String
		{
			return _url;
		}

		
		
		
		/**
		 *资源路径，自动加载 
		 * @param value
		 * 
		 */		
		public function set url(value:String):void
		{
			_url = value;
			if(_url)
			{
				BulkLoaderSingleton.instance.addWithListener(_url , null , onLoaded);
			}
			else
			{
				bitmapData = null;
			}
		}
		
		
		
		
		private function onLoaded(e:Event = null):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onLoaded);
			
			if(_url)
			{
				if(_url.indexOf(".swf")>=0)
				{
					var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
					this.bitmapData = new PNGDataClass();
				}
				else
				{
					this.bitmapData = imageItem.content.bitmapData;
				}
			}
			if(resetFunc != null)
			{
				resetFunc();
			}
			
		}
		
	}
}