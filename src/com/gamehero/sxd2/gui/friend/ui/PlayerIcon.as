package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午1:22:49
	 * 
	 */
	public class PlayerIcon extends Bitmap
	{
		protected var _iconId:int;
		
		public function PlayerIcon(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public function get iconId():int
		{
			return _iconId;
		}
		/**
		 *资源路径，自动加载 
		 * @param value 货币id
		 * 
		 */		
		public function set iconId(value:int):void
		{
			_iconId = value;
			if(_iconId > 0)
			{
				BulkLoaderSingleton.instance.addWithListener( GameConfig.FRIEND_ICON_URL  + _iconId + ".png" , null , onLoaded,null,onError);
			}
			else
			{
				BulkLoaderSingleton.instance.addWithListener( GameConfig.FRIEND_ICON_URL  + 1 + ".png" , null , onLoaded,null,onError);
			}
		}
		
		protected function onError(e:Event = null):void
		{
			// TODO Auto Generated method stub
			e.target.removeEventListener(Event.COMPLETE, onLoaded);
			BulkLoaderSingleton.instance.addWithListener( GameConfig.FRIEND_ICON_URL  + 1 + ".png" , null , onLoaded);
		}
		
		override public function set bitmapData(value:BitmapData):void
		{
			super.bitmapData = value;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		private function onLoaded(e:Event = null):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onLoaded);
			
			this.bitmapData = imageItem.content.bitmapData;
		}
	}
}