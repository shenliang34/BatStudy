package com.gamehero.sxd2.battle.gui
{
	import com.greensock.TweenMax;
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 全屏泛红
	 * @author xuwenyi
	 * @create 2014-04-15
	 **/
	public class BBlood extends Sprite
	{
		private var canvas:MovieClip;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BBlood()
		{
			//canvas = BattleSkin.SCREEN_RED;
			canvas.alpha = 1;
			this.addChild(canvas);
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
		}
		
		
		
		
		/**
		 * 添加到舞台
		 * */
		public function onAdd(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdd);
			
			// 计算战斗场景尺寸
			var w:int = Math.max(stage.stageWidth , BattleView.MIN_WIDTH);
			w = Math.min(w , BattleView.MAX_WIDTH);
			var h:int = Math.max(stage.stageHeight , BattleView.MIN_HEIGHT);
			h = Math.min(h , BattleView.MAX_HEIGHT);
			
			// 确定画布大小
			canvas.width = w;
			canvas.height = h;
			
			// 开始播放效果
			this.play();
		}
		
		
		
		
		/**
		 * 播放
		 * */
		private function play():void
		{
			TweenMax.to(canvas , 0.24 , {alpha:0,delay:0.5,onComplete:end});
		}
		
		
		
		
		/**
		 * 结束
		 * */
		private function end():void
		{
			if(parent && parent.contains(this) == true)
			{
				parent.removeChild(this);
			}
		}
		
		
	}
}