package com.gamehero.sxd2.world.views
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-17 下午6:32:22
	 * 
	 */
	public class MapTitle extends Sprite
	{
		
		
		/**
		 * 加载器 
		 */		
		protected var _loader:BulkLoaderSingleton;
		
		private var _mapNameBmp:Bitmap;
		private var _nameUrl:String;
		
		private var _tween:TweenMax;
		
		public function MapTitle(url:String)
		{
			super();
			_nameUrl = url;
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			_loader = BulkLoaderSingleton.instance;
			_loader.addWithListener(_nameUrl,{id:_nameUrl},onNameLoaded);
			_loader.start();
		}
		
		private function onNameLoaded(event:Event):void
		{
			var bg:Bitmap = new Bitmap(MapSkin.MAP_NAME_BG);
			addChild(bg);
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onNameLoaded);
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			_mapNameBmp = new Bitmap(new PNGDataClass);
			addChild(_mapNameBmp);
			dispatchEvent(new MapEvent(MapEvent.MAP_NAME_LOAD_COMPLETE,_mapNameBmp));
			
			_mapNameBmp.x = (bg.width - _mapNameBmp.width) >> 1;
			_mapNameBmp.y = (bg.height - _mapNameBmp.height) >> 1;
						

			var widthOffset:int; //宽的偏移量			
			//最大尺寸
			if(App.stage.stageWidth > MapConfig.STAGE_MAX_WIDTH) widthOffset = (App.stage.stageWidth - MapConfig.STAGE_MAX_WIDTH)/2;
			
			this.x = (App.stage.stageWidth - bg.width >> 1) - widthOffset;
			this.y = 100 * int(App.stage.stageHeight / 600);
			
			_tween = TweenMax.to(this , 6 , {alpha:0 , onComplete:gc});
		}
		
		
		public function gc():void
		{
			_mapNameBmp = null;
			_loader = null;
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
			if(this.parent)
				this.parent.removeChild(this);
		}
	}
}