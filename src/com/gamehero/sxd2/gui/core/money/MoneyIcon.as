package com.gamehero.sxd2.gui.core.money
{
	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 * 消耗类物品图标
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午4:53:04
	 * 
	 */
	public class MoneyIcon extends Bitmap
	{
		
		protected var _iconId:int;
		
		public function MoneyIcon(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
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
			if(_iconId == MoneyDict.TONG_QIAN)
			{
				bitmapData = ItemSkin.TONGQIAN;
			}
			else if(_iconId == MoneyDict.YUANBAO)
			{
				bitmapData = ItemSkin.YUANBAO;
			}
			else if(_iconId == MoneyDict.LINT_YUN)
			{
				bitmapData = ItemSkin.LINGYUN;
			}
			else if(_iconId == MoneyDict.JING_YAN)
			{
				bitmapData = ItemSkin.JINGYAN;
			}
			else if(_iconId == MoneyDict.CAN_YE)
			{
				bitmapData = ItemSkin.CANYE;
			}
			else if(_iconId > 0)
			{
				BulkLoaderSingleton.instance.addWithListener( GameConfig.ITEM_ICON_URL  + _iconId + ".png" , null , onLoaded);
			}
			else
			{
				bitmapData = null;
			}
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