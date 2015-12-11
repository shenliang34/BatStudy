package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import bowser.utils.MovieClipPlayer;
	
	
	/**
	 * 战斗切换动画
	 * @author xuwenyi
	 * @create 2015-08-19
	 **/
	public class BattleChange extends Sprite
	{
		private static var _instance:BattleChange;
		private var movie:MovieClip;
		
		
		public function BattleChange()
		{
			movie = BattleSkin.BATTLE_CHANGE;
		}
		
		
		
		
		
		public static function get inst():BattleChange
		{
			return _instance ||= new BattleChange();
		}
		
		
		
		
		
		
		/**
		 * 播放前半段
		 * */
		public function play(father:DisplayObjectContainer , startFrame:int , endFrame:int , callback:Function = null):void
		{
			var self:BattleChange = this;
			this.addChild(movie);
			father.addChild(self);
			
			// 自适应
			this.resize();
			
			// 开始播放泼墨效果
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(movie , 0.9 , startFrame , endFrame);
			mp.addEventListener(Event.COMPLETE , over);
			
			
			function over():void
			{
				father.removeChild(self);
				self.removeChild(movie);
				mp.removeEventListener(Event.COMPLETE , over);
				
				if(callback != null)
				{
					callback();
				}
			}
		}
		
		
		
		
		
		
		
		
		private function resize():void
		{
			var stage:Stage = App.stage;
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			var S:Number = 16/9;
			// 宽度大于高度了
			if(w/h >= S)
			{
				movie.width = w;
				movie.height = w / S;
			}
			else
			{
				movie.width = h * S;
				movie.height = h;
			}
		}
		
		
	}
}