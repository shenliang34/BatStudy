package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	
	/**
	 * 场景中角色血条
	 * @author xuwenyi
	 * @create 2013-06-26
	 **/
	public class BattleRoleBloodBar extends SpriteItem
	{
		// 血条背景
		private var bg:RenderItem;
		// 血条颜色
		private var barBD:BitmapData;
		private var bar:RenderItem;
		// 扣血缓动的白色层
		private var barTweenBD:BitmapData;
		private var barTween:RenderItem;
		// 左边为了保持弧形的遮盖层
		private var barPoint:RenderItem;
		
		// 缓动
		private var tweenTimer:Timer;
		private var tweenTarget:int;
		private var tweenStep:Number;
		private var tweenCount:int;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleRoleBloodBar()
		{
			super();
			
			// 添加血条背景
			bg = new RenderItem();
			bg.renderSource = BattleSkin.ROLE_BLOOD_BG;
			this.addChild(bg);
			
			// 添加血条缓动层
			barTween = new RenderItem();
			barTweenBD = BattleSkin.ROLE_BLOOD_TWEEN;
			barTween.renderSource = barTweenBD;
			barTween.x = 1;
			barTween.y = 1;
			barTween.visible = false;
			this.addChild(barTween);
			
			// 添加血条颜色1
			bar = new RenderItem();
			barBD = BattleSkin.ROLE_BLOOD_1;
			bar.renderSource = barBD;
			bar.x = 1;
			bar.y = 1;
			this.addChild(bar);
			
			// 1个像素的弧形遮盖
			barPoint = new RenderItem();
			barPoint.renderSource = BattleSkin.ROLE_BLOOD_2;
			barPoint.x = 1;
			barPoint.y = 1;
			barPoint.visible = true;
			this.addChild(barPoint);
			
			// tween
			tweenTimer = new Timer(42);
		}
		
		
		
		
		/**
		 * 更新血条状态
		 * */
		public function update(hp:Number , maxhp:Number):void
		{
			// 当前血条长度
			var rate:Number = hp / maxhp;
			var widthTotal:int = barBD.width;
			tweenTarget = Math.floor(widthTotal*rate);// 最终长度
			
			// 重新绘制红色血条长度
			if(tweenTarget > 0)
			{
				var bd:BitmapData = new BitmapData(tweenTarget , barBD.height , true , 0);
				bd.copyPixels(barBD , new Rectangle(widthTotal - tweenTarget , 0 , tweenTarget , barBD.height) , new Point());
				bar.renderSource = bd;
				
				bar.visible = true;
				
				// 判断圆弧遮盖是否显示
				//barPoint.visible = hp > 0 ? false : false;
				
				// 计算缓动数据
				tweenStep = (tweenTarget - barTween.renderSource.width)*0.2;
				tweenCount = 5;
				
				// 扣血
				if(tweenStep < 0)
				{
					// 先清除上一次的缓动
					this.stop();
					
					// 扣血缓动
					tweenTimer.addEventListener(TimerEvent.TIMER , onUpdate);
					tweenTimer.reset();
					tweenTimer.start();
				}
					// 加血
				else if(tweenStep > 0)
				{
					tweenStep = tweenTarget - barTween.renderSource.width;
					tweenCount = 1;
					
					this.onUpdate();
				}
			}
			else
			{
				bar.visible = false;
				barTween.visible = false;
			}
		}
		
		
		
		
		
		/**
		 * 血条缓动
		 * */
		private function onUpdate(e:TimerEvent = null):void
		{
			var widthTotal:int = barTweenBD.width;
			var widthNow:int = barTween.renderSource.width;
			// 未达到目标点
			if(tweenCount > 0)
			{
				widthNow += tweenStep;
				
				// 重新绘制白色血条长度
				if(widthNow > 0)
				{
					var bd:BitmapData = new BitmapData(widthNow , barTweenBD.height , true , 0);
					bd.copyPixels(barTweenBD , new Rectangle(widthTotal - widthNow , 0 , widthNow , barTweenBD.height) , new Point());
					barTween.renderSource = bd;
					
					barTween.visible = true;
				}
				else
				{
					barTween.visible = false;
				}
			}
			// 已达到目标点
			else
			{
				barTween.visible = false;
				
				// 停止缓动
				this.stop();
			}
			
			tweenCount--;
		}
		
		
		
		
		
		/**
		 * 停止缓动
		 * */
		private function stop():void
		{
			tweenTimer.stop();
			tweenTimer.removeEventListener(TimerEvent.TIMER , onUpdate);
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			if(tweenTimer != null)
			{
				this.stop();
				tweenTimer = null;
			}
			
			barBD = null;
			barTweenBD = null;
			
			this.gc();
		}
		
	}
}