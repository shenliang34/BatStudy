package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	import bowser.utils.effect.color.ColorTransformUtils;
	
	/**
	 * 漂浮文字UI
	 * @author xuwenyi
	 * @version 1.0
	 * @created 2010-10-14
	 * */
	public class NumberFloatingText extends Sprite
	{
		// 普通伤害变色序列
		private static const COLORS:Array = [[33,16],[66,32],[100,47],[66,32],[33,16]];
		
		// 总容器
		private var container:Sprite;
		// 图片数字组件
		private var bitmapNumber:BitmapNumber;
		// 加减号
		private var plus:Bitmap;
		private var minus:Bitmap;
		// 血迹
		private var BLOOD:Bitmap;
		// 文字
		private var CRT:Bitmap;
		private var PAY:Bitmap;
		private var AVD:Bitmap;
		private var ABB:Bitmap;
		
		
		/**
		 * 构造函数
		 * */
		public function NumberFloatingText()
		{
			this.cacheAsBitmap = true;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			bitmapNumber = new BitmapNumber();
			container = new Sprite();
		}
		
		
		
		/**
		 * 设置文字
		 * */
		public function setText(type:int , num:int = 0):void
		{
			var move:Function;
			
			bitmapNumber.x = 0;
			bitmapNumber.indentX = 1;
			
			// 普通伤害
			if(type == 0)
			{
				// 数字
				bitmapNumber.update(BitmapNumber.BATTLE_S_RED , "-" + num);
				container.addChild(bitmapNumber);
				
				move = this.move2;
			}
			// 治疗
			else if(type == 1)
			{
				// 数字
				bitmapNumber.update(BitmapNumber.BATTLE_S_GREEN , num+"");
				container.addChild(bitmapNumber);
				
				move = this.move2;
			}
			// 暴击伤害
			else if(type == 2)
			{
				BLOOD = new Bitmap(BattleSkin.BLOOD);
				container.addChild(BLOOD);
				
				var sp:Sprite = new Sprite();
				sp.x = 40;
				sp.y = 52;
				container.addChild(sp);
				
				CRT = new Bitmap(BattleSkin.CRT);
				sp.addChild(CRT);
				
				bitmapNumber.update(BitmapNumber.BATTLE_B_YELLOW , num+"");
				bitmapNumber.x = CRT.x + CRT.width + 9;
				bitmapNumber.y = 0;
				sp.addChild(bitmapNumber);
				
				move = this.move1;
			}
			
			// 居中
			container.x = -container.width*0.5;
			container.y = -container.height*0.5;
			this.addChild(container);
			
			// 开始缓动
			move();
		}
		
		
		
		
		
		
		/**
		 * 战斗暴击
		 * */
		private function move1():void
		{
			var self:NumberFloatingText = this;
			// 暴击文字和数字的容器
			var crt:Sprite = container.getChildAt(1) as Sprite;
			
			//从大变小
			TweenMax.fromTo(self , 0.15 , {alpha:0,scaleX:2,scaleY:2} , {alpha:1,scaleX:1,scaleY:1,onComplete:next1});
			
			//抖动
			function next1():void
			{
				crt.y -= 4;
				setTimeout(next2 , 50);
			}
			function next2():void
			{
				crt.y += 4;
				setTimeout(next3 , 450);
			}
			//渐隐
			function next3():void
			{
				TweenMax.to(self , 0.25 , {alpha:0,onComplete:over});	
			}
			// 结束
			function over():void
			{
				if(parent!=null && parent.contains(self)==true )
				{
					parent.removeChild(self);
				}
			}
		}
		
		
		
		
		
		/**
		 * 战斗普通伤害
		 * */
		private function move2():void
		{
			var self:NumberFloatingText = this;
			var colorUtils:ColorTransformUtils = ColorTransformUtils.instance;
			var colors:Array = COLORS.concat();
			
			//从小变大
			TweenMax.fromTo(self , 0.1 , {alpha:0,scaleX:0.2,scaleY:0.2} , {alpha:1,scaleX:1.7,scaleY:1.7,onComplete:next1});
			
			//变小并变色
			function next1():void
			{
				TweenMax.to(self , 0.15 , {scaleX:1,scaleY:1});
				
				changeColor();
			}
			//改变颜色
			function changeColor():void
			{
				colorUtils.clear(self);
				
				if(colors.length > 0)
				{
					var color:Array = colors.shift();
					colorUtils.changeColor(self , color[0] , color[1]);
					
					// 一帧变一次色
					setTimeout(changeColor , 50);
				}
				else
				{
					next2();
				}
			}
			//飞走
			function next2():void
			{
				TweenMax.to(self , 0.35 , {y:"-100",alpha:0,/*ease:Cubic.easeIn,*/onComplete:over});
			}
			// 结束
			function over():void
			{
				if(parent!=null && parent.contains(self)==true )
				{
					parent.removeChild(self);
				}
			}
		}
		
		
		
		
		
	}
}