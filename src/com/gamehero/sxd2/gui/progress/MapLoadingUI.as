package com.gamehero.sxd2.gui.progress
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	/**
	 * 地图loading
	 * @author xuwenyi
	 * @create 2015-07-15
	 **/
	public class MapLoadingUI extends Sprite
	{
		private static var _instance:MapLoadingUI;
		
		private var progress:MovieClip;
		
		
		
		public function MapLoadingUI()
		{
			super();
		}
		
		
		
		
		
		static public function get inst():MapLoadingUI
		{	
			return _instance ||= new MapLoadingUI();
		}
		
		
		
		
		
		public function updateProgress(percent:Number , tips:String = ""):void 
		{
			
			this.percent = percent;
		}
		
		
		
		
		
		
		public function set percent(value:Number):void
		{	
			if(progress != null)
			{
				progress.gotoAndStop(value);
			}
		}
		
		
		
		
		
		
		public function show():void
		{	
			App.ui.addChild(this);
			
			var loading:MovieClip = MainSkin.sceneLoading;
			progress = loading.progress;
			progress.gotoAndStop(0);
			
			this.addChild(loading);
			
			if(stage)
			{
				this.x = (stage.stageWidth) >> 1;
				this.y = (stage.stageHeight) >> 1;
			}
		}
		
		
		
		
		
		
		public function hide():void 
		{
			if(App.ui.contains(this)) 
			{
				App.ui.removeChild(this);
			}
		}
	}
}