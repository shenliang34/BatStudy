package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.BattleView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	
	/**
	 * 战斗闪屏特效
	 * @author xuwenyi
	 * @create 2014-04-15
	 **/
	public class BFlash extends Sprite
	{
		private static var canvas:Bitmap;
		
		
		/**
		 * 构造函数
		 * */
		public function BFlash()
		{
			// 确定画布大小
			if(canvas == null)
			{
				var bmd:BitmapData = new BitmapData(BattleView.MAX_WIDTH,BattleView.MAX_HEIGHT,false,0xffffff);
				canvas = new Bitmap(bmd);
			}
			canvas.alpha = 0;
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
			var frameTime:Number = 34;
			
			phase0();
			
			function phase0():void
			{
				setTimeout(phase2 , frameTime);
			}
			
			function phase1():void
			{
				canvas.alpha = 0.5;	
				setTimeout(phase2 , frameTime);
			}
			
			function phase2():void
			{
				canvas.alpha = 1;
				setTimeout(phase3 , frameTime);
			}
			
			function phase3():void
			{
				canvas.alpha = 1;
				setTimeout(end , frameTime);
			}
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