package com.gamehero.sxd2.gui.fate
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * 命途格子对象
	 * @author zhangxueyou
	 * @create 2015-11-15
	 **/
	public class FateItem extends Sprite
	{
		/**
		 * 属性图标
		 */		
		protected var dataIcon:Bitmap;
		/**
		 *加号图标 
		 */		
		protected var addIcon:Bitmap;
		/**
		 * 数量图标 
		 */		
		protected var numIcon:BitmapNumber;
		
		public function FateItem()
		{
			super();
			initUI()
		}
		
		/**
		 *初始化UI 
		 * 
		 */		
		private function initUI():void
		{
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,72,72);
			this.graphics.endFill();
			
			dataIcon = new Bitmap();
			dataIcon.x = 10;
			dataIcon.y = 20;
			addChild(dataIcon);
			
			addIcon = new Bitmap();
			addIcon.x = 15;
			addIcon.y = 48;
			addChild(addIcon);
			
			numIcon = new BitmapNumber();
			numIcon.x = 25;
			numIcon.y = 45;
			this.addChild(numIcon);
		}
		
		/**
		 *设置UI 
		 * @param dataIcon
		 * @param color
		 * @param num
		 * 
		 */		
		public function setUI(dataIcon:String,color:String,num:String):void
		{
			
			var url:String
			if(color == "gray")
				dataIcon = dataIcon + "_p";
			
			url = GameConfig.FATE_ICON_URL + "icon_data/" + dataIcon + ".png";
			BulkLoaderSingleton.instance.addWithListener(url, null, onDataIconLoaded);
			
			url = GameConfig.FATE_ICON_URL + "icon_data/add_" + getColor(color) + ".png";
			BulkLoaderSingleton.instance.addWithListener(url, null, onAddIconLoaded)
			
			numIcon.update(getColerType(color), num);
		}
		
		/**
		 *根据颜色或者icon资源后缀 
		 * @param color
		 * @return 
		 * 
		 */		
		private function getColor(color:String):String
		{
			switch(color)
			{
				case "yellow":
				{
					return "y";
				}
				case "green":
				{
					return "g";
				}
				case "blue":
				{
					return "b";
				}
				case "gray":
				{
					return "p";
				}
			}
			return null;
		}
		
		/**
		 *根据资源获取类型 
		 * @param color
		 * @return 
		 * 
		 */		
		private function getColerType(color:String):String
		{
			switch(color)
			{
				case "yellow":
				{
					return BitmapNumber.FATE_S_YELLOW;
				}
				case "green":
				{
					return BitmapNumber.FATE_S_GREEN;
				}
				case "blue":
				{
					return BitmapNumber.FATE_S_BIUE;
				}
				case "gray":
				{
					return BitmapNumber.FATE_S_GRSY;
				}
			}
			return null;
		}
		
		/**
		 *加载数据Icon对象 
		 * @param event
		 * 
		 */		
		private function onDataIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onDataIconLoaded);
			dataIcon.bitmapData = imageItem.content.bitmapData;
		}
		
		/**
		 *加载加号图标 
		 * @param event
		 * 
		 */		
		private function onAddIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onDataIconLoaded);
			addIcon.bitmapData = imageItem.content.bitmapData;
		}
		
		/**
		 * 
		 * 清除数据相关的内容
		 * （一般用于界面内清除，背景_backGroud保留）
		 *  @see gc()
		 */		
		public function clear():void
		{
			dataIcon.bitmapData = null;
			addIcon.bitmapData = null;
			numIcon.clear();
		}
	}
}