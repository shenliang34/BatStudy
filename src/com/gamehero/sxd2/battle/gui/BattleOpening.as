package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.BattleUIEvent;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import bowser.utils.MovieClipPlayer;
	
	
	/**
	 * 战斗开场动画组件
	 * @author xuwenyi
	 * @create 
	 **/
	public class BattleOpening extends Sprite
	{
		// 战斗场景切换
		private const MOVR_OFFSET:int = 50;
		private const MASK_WIDTH:int = 100;
		
		public var paroketEffect:MovieClip;
		
		private var paroket1:Sprite = new Sprite();
		private var paroket2:Sprite = new Sprite();
		
		private var pMask1:Shape = new Shape();
		private var pMask2:Shape = new Shape();
		
		private var paroketBP1:Bitmap = new Bitmap();
		private var paroketBP2:Bitmap = new Bitmap();
		
		// 外部场景拷贝图
		private var stageBitmap:Bitmap;
		
		/**
		 * 切割的方向
		 * 0， 纵向；1，横向 
		 */	
		private var _direction:int;
		/**
		 *  纵向
		 */	
		private const VERTICAL:int = 0;
		/**
		 * 横向 
		 */	
		private const HORIZON:int = 1;
		
		private var _angle:Number;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleOpening()
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
		}
		
		
		
		
		
		/**加入显示列表*/
		private function onAdd(e:Event):void
		{
			// 战斗场景切换：添加场景位图
			var bmd:BitmapData = GameData.inst.stageBD;
			if(bmd)
			{
				stageBitmap = new Bitmap(bmd);
				this.addChild(stageBitmap);
			}
			
		}
		
		
		
		
		
		/**
		 * 播放开场动画
		 * */
		public function play():void
		{
			/** 战斗场景切换 */
			if(paroketEffect)
			{
				var bp:BitmapData = GameData.inst.stageBD;
				
				paroketEffect.gotoAndStop(0);
				paroketEffect.alpha = 1;
				_angle = 2 * Math.PI * Math.random();
				paroketEffect.rotation = _angle * 180 / Math.PI;
				paroketEffect.x = stageBitmap.width >> 1;
				paroketEffect.y = stageBitmap.height >> 1;
				
				//paroketEffect.rotation = -(Math.atan(MASK_WIDTH / this.stage.stage.stageHeight) * 180 / Math.PI);
				this.addChild(paroketEffect);
				
				var mp:MovieClipPlayer = new MovieClipPlayer();
				mp.play(paroketEffect , 0.4 , 0 , paroketEffect.totalFrames);
				mp.addEventListener(Event.COMPLETE , movieOver);
				
				function movieOver(e:Event):void
				{
					mp.removeEventListener(Event.COMPLETE, movieOver);
					
					setTimeout(beginParoket , 200);
					TweenMax.fromTo(paroketEffect , 0.5, {alpha:1} , {alpha:0, onComplete:alphaOver});
				}
				
				function alphaOver():void
				{
					if(paroketEffect && contains(paroketEffect) == true)
					{
						removeChild(paroketEffect);
					}
				}
			}
		}
		
		
		
		/**
		 * 屏幕切割
		 * */
		private function beginParoket():void
		{	
			beginParoket2();
			return;
			
			var bp:BitmapData = GameData.inst.stageBD;
			/*var matrix:Matrix = new Matrix();
			matrix.translate(ProgressUI.instance.x, ProgressUI.instance.y);
			bp.draw(ProgressUI.instance, matrix);*/
			
			var point:Point = new Point();
			var stageWidth:int = bp.width;
			var stageHeight:int = bp.height;
			
			var ww:int = (stageWidth >> 1) + MASK_WIDTH;
			var xx:int = (stageWidth >> 1) - MASK_WIDTH;
			
			var bp1:BitmapData = new BitmapData(ww, stageHeight);
			var bp2:BitmapData = new BitmapData(ww, stageHeight);
			
			var rect:Rectangle = new Rectangle();
			rect.width = ww;
			rect.height = stageHeight;
			
			bp1.copyPixels(bp, rect, point);
			
			rect.x = xx;
			bp2.copyPixels(bp, rect, point);
			
			// 左半边
			pMask1.graphics.clear();
			pMask1.graphics.beginFill(0xff00ff);
			pMask1.graphics.lineTo(0, stageHeight);
			pMask1.graphics.lineTo(ww, stageHeight);
			pMask1.graphics.lineTo(xx , 0);
			pMask1.graphics.endFill();
			paroket1.addChild(pMask1);
			
			paroketBP1.bitmapData = bp1;
			paroketBP1.mask = pMask1;
			paroket1.addChild(paroketBP1);
			
			// 右半边
			pMask2.graphics.clear();
			pMask2.graphics.beginFill(0xff00ff);
			pMask2.graphics.lineTo(ww, 0);
			pMask2.graphics.lineTo(ww, stageHeight);
			pMask2.graphics.lineTo(2 * MASK_WIDTH, stageHeight);
			pMask2.graphics.endFill();
			paroket2.addChild(pMask2);
			
			paroketBP2.bitmapData = bp2;
			paroketBP2.mask = pMask2;
			paroket2.addChild(paroketBP2);
			
			paroket1.x = 0;
			paroket1.alpha = 1;
			this.addChild(paroket1);
			paroket2.x = xx;
			paroket2.alpha = 1;
			this.addChild(paroket2);
			
			// 移除外部场景拷贝图
			if(stageBitmap && this.contains(stageBitmap) == true)
			{
				this.removeChild(stageBitmap);
			}
			
			this.addEventListener(Event.ENTER_FRAME, onParoketEnterFrame);
			
			/*var toX:int = - paroket1.width;
			TweenMax.to(paroket1 , 1.5 , {x:toX,alpha:0 , onComplete:moveOver});
			toX = paroket2.x + paroket2.width;
			TweenMax.to(paroket2 , 1.5 , {x:toX,alpha:0});
			
			function moveOver():void
			{
			removeChild(paroket1);
			removeChild(paroket2);
			
			dispatchEvent(new Event(Event.ACTIVATE));
			}*/
		}
		
		public function beginParoket2():void
		{
			var bp:BitmapData = GameData.inst.stageBD;
			
			var point:Point = new Point();
			var stageWidth:int = bp.width;
			var stageHeight:int = bp.height;
			
			var ANGLE:Number = Math.atan2(stageWidth, stageHeight);
			const pi:Number = Math.PI;
			//_angle = pi * 290/180;
			var ww:Number;
			//纵向
			if((0 < _angle && _angle <= ANGLE) || ((pi - ANGLE) <= _angle && _angle < (pi + ANGLE)) || ((2 * pi - ANGLE) <= _angle && _angle < 2 * pi))
			{
				_direction = VERTICAL;
				ww  = Math.tan(_angle) * stageHeight / 2;
				//左半边
				pMask1.graphics.clear();			
				pMask1.graphics.beginBitmapFill(bp);
				pMask1.graphics.lineTo(stageWidth / 2 + ww,0);
				pMask1.graphics.lineTo(stageWidth / 2 - ww,stageHeight);
				pMask1.graphics.lineTo(0,stageHeight);
				pMask1.graphics.endFill();
				paroket1.addChild(pMask1);
				
				// 右半边
				pMask2.graphics.clear();
				pMask2.graphics.beginBitmapFill(bp);
				pMask2.graphics.moveTo(stageWidth / 2 + ww,0);
				pMask2.graphics.lineTo(stageWidth, 0);
				pMask2.graphics.lineTo(stageWidth, stageHeight);
				pMask2.graphics.lineTo(stageWidth / 2 - ww,stageHeight);
				pMask2.graphics.endFill();
				paroket2.addChild(pMask2);
			}
			//横向
			else
			{
				ww = stageWidth / (2 * Math.tan(_angle));
				
				_direction = HORIZON;
				
				//上半边
				pMask1.graphics.clear();			
				pMask1.graphics.beginBitmapFill(bp);
				pMask1.graphics.lineTo(stageWidth,0);
				pMask1.graphics.lineTo(stageWidth,stageHeight / 2 - ww);
				pMask1.graphics.lineTo(0,stageHeight / 2 + ww);
				pMask1.graphics.endFill();
				paroket1.addChild(pMask1);
				
				// 下半边
				pMask2.graphics.clear();
				pMask2.graphics.beginBitmapFill(bp);
				pMask2.graphics.moveTo(0,stageHeight / 2 + ww);
				pMask2.graphics.lineTo(stageWidth, stageHeight / 2 - ww);
				pMask2.graphics.lineTo(stageWidth, stageHeight);
				pMask2.graphics.lineTo(0,stageHeight);
				pMask2.graphics.endFill();
				paroket2.addChild(pMask2);
			}
			
			paroket1.x = 0;
			paroket1.y = 0;
			paroket1.alpha = 1;
			//paroket1.cacheAsBitmap = true;
			this.addChild(paroket1);
			
			paroket2.x = 0;
			paroket2.y = 0;
			paroket2.alpha = 1;
			//paroket2.cacheAsBitmap = true;
			this.addChild(paroket2);
		
			// 移除外部场景拷贝图
			if(stageBitmap && this.contains(stageBitmap) == true)
			{
				this.removeChild(stageBitmap);
			}
			
			this.addEventListener(Event.ENTER_FRAME, onParoketEnterFrame);
		}
		
		/**
		 * 切割每帧处理
		 * */
		private function onParoketEnterFrame(event:Event):void
		{
			paroket1.alpha -= 0.1;
			paroket2.alpha -= 0.1;
			
			if(_direction == VERTICAL)
			{
				paroket1.x -= MOVR_OFFSET;
				paroket2.x += MOVR_OFFSET;
			}
			else
			{
				paroket1.y -= MOVR_OFFSET;
				paroket2.y += MOVR_OFFSET;
			}
			if(paroket1.alpha <= 0)
				remove();
		}
		
		private function remove():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onParoketEnterFrame);
			
			this.removeChild(paroket1);
			this.removeChild(paroket2);
			
			if(paroketEffect && this.contains(paroketEffect) == true) {
				
				this.removeChild(paroketEffect);
			}
			
			paroket1.graphics.clear();
			paroket2.graphics.clear();
			
			paroket2.alpha = paroket2.alpha = 1;
			
			//play();
			
			// 通知BattleUI开场动画完成
			this.dispatchEvent(new BattleUIEvent(Event.COMPLETE));
		}
	}
	
	
}