package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗地图名飘字
	 * @author xuwenyi
	 * @create 2015-08-12
	 **/
	public class BattleMapName extends Sprite
	{
		
		/**
		 * 构造函数
		 * */
		public function BattleMapName()
		{
			super();
		}
		
		
		
		
		
		
		
		/**
		 * 开始播放
		 * */
		public function play(mapName:String):void
		{
			var bg:Bitmap = new Bitmap(MapSkin.MAP_NAME_BG);
			bg.x = -bg.width>>1;
			bg.y = -bg.height>>1;
			this.addChild(bg);
			
			// 加载技能文字
			var textURL:String = GameConfig.BATTLE_NAME_TEXT_URL + mapName + ".swf";
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			loader.addWithListener(textURL , null , textLoaded);
			
			// 开始移动
			this.move();
		}
		
		
		
		
		
		/**
		 * 技能文字加载完成
		 * */
		private function textLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , textLoaded);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			// 居中显示
			bmp.x = -bmp.width>>1;
			bmp.y = -bmp.height>>1;
			this.addChild(bmp);
		}
		
		
		
		
		/**
		 * 开始移动
		 * */
		private function move():void
		{
			var self:BattleMapName = this;
			
			this.alpha = 0;
			
			TweenMax.to(this , 0.5 , {alpha:1,onComplete:next});
			
			function next():void
			{
				TweenMax.to(self , 0.5 , {delay:1,alpha:0,onComplete:over});
			}
		}
		
		
		
		
		/**
		 * 动画结束
		 * */
		private function over():void
		{
			if(parent && parent.contains(this) == true)
			{
				parent.removeChild(this);
			}
		}
	}
}