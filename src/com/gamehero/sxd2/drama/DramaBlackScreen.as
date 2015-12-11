package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import alternativa.gui.base.GUIobject;
	
	
	/**
	 * 剧情压屏
	 * @author xuwenyi
	 * @create 2015-11-05
	 **/
	public class DramaBlackScreen extends Sprite
	{
		private static var _instance:DramaBlackScreen;
		
		// 上下黑边
		private var top:Bitmap;
		private var down:Bitmap;
		
		// 左右黑边
		private var left:Shape;
		private var right:Shape;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function DramaBlackScreen()
		{
			// 上下黑边
			top = new Bitmap(GuideSkin.DRAMA_BLACK_SCREEN);
			down = new Bitmap(GuideSkin.DRAMA_BLACK_SCREEN);
			down.scaleY = -1;
			
			this.addChild(top);
			this.addChild(down);
			
			// 左右黑边
			var fillType:String = GradientType.LINEAR;
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(300, 1080, 0, 0, 0);
			
			left = new Shape();
			left.graphics.beginGradientFill(fillType , [0 , 0] , [1, 0] , [0x00, 0xFF] , mtx);
			left.graphics.drawRect(0 , 0 , 300 , 1080);
			left.graphics.endFill();
			
			right = new Shape();
			right.graphics.beginGradientFill(fillType , [0 , 0] , [0, 1] , [0x00, 0xFF] , mtx);
			right.graphics.drawRect(0 , 0 , 300 , 1080);
			right.graphics.endFill();
			
			this.addChild(left);
			this.addChild(right);
		}
		
		
		
		
		public static function get inst():DramaBlackScreen
		{
			return _instance ||= new DramaBlackScreen();
		}
		
		
		
		
		
		/**
		 * 压屏
		 * @param type 0:只有上下边,1:上下左右都有
		 * */
		public function play1(type:int , callback:Function = null):void
		{
			var windowUI:GUIobject = App.windowUI;
			var stage:Stage = App.stage;
			stage.addEventListener(Event.RESIZE , resize);
			
			windowUI.addChild(this);
			
			top.y = -88;
			down.y = stage.stageHeight + 88;
			
			TweenLite.to(top , 0.4 , {y:"88" , onComplete:stop1 , onCompleteParams:[callback]});
			TweenLite.to(down , 0.4 , {y:"-88"});
			
			left.visible = false;
			right.visible = false;
			// 是否需要左右黑边移动
			if(type == 1)
			{
				left.visible = true;
				right.visible = true;
				
				left.x = -300;
				right.x = stage.stageWidth;
				
				TweenLite.to(left , 0.4 , {x:"300"});
				TweenLite.to(right , 0.4 , {x:"-300"});
			}
		}
		
		
		
		
		
		/**
		 * 结束播放
		 * */
		private function stop1(callback:Function = null):void
		{
			var stage:Stage = App.stage;
			stage.addEventListener(Event.RESIZE , resize);
			
			if(callback)
			{
				callback();
			}
		}
		
		
		
		
		
		
		/**
		 * 解除压屏
		 * @param type 0:只有上下边,1:上下左右都有
		 * */
		public function play2(type:int , callback:Function = null):void
		{
			var stage:Stage = App.stage;
			stage.removeEventListener(Event.RESIZE , resize);
			
			TweenLite.to(top , 0.4 , {y:"-88" , onComplete:stop2 , onCompleteParams:[callback]});
			TweenLite.to(down , 0.4 , {y:"88"});
			
			// 是否需要左右黑边移动
			if(type == 1)
			{
				left.visible = true;
				right.visible = true;
				
				TweenLite.to(left , 0.4 , {x:"-300"});
				TweenLite.to(right , 0.4 , {x:"300"});
			}
		}
		
		
		
		
		
		/**
		 * 结束播放
		 * */
		private function stop2(callback:Function = null):void
		{
			var windowUI:GUIobject = App.windowUI;
			windowUI.removeChild(this);
			
			if(callback)
			{
				callback();
			}
		}
		
		
		
		
		
		private function resize(e:Event = null):void
		{
			var stage:Stage = App.stage;
			top.y = 0;
			down.y = stage.stageHeight;
			
			left.x = 0;
			right.x = stage.stageWidth - 300;
		}
	}
}