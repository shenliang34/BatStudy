package com.gamehero.sxd2.battle.gui
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.pro.GS_RoleBase_Pro;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	import bowser.utils.effect.color.ColorTransformUtils;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗中的怒气球
	 * @author xuwenyi
	 * @create 2013-08-27
	 **/
	public class BattleAngerBall extends Sprite
	{
		// 缓动步长
		private static const STEP:Number = 0.01;
		
		// 人物半身像
		private var playerHeadPanel:Sprite;
		
		// 怒气文本
		private var angerLabel:BitmapNumber;
		
		// 遮罩
		private var angerMask:Shape;
		// 怒气球
		private var anger:MovieClip;
		private var angerFire:MovieClip;
		private var angerUpdateMp:MovieClipPlayer;
		private var angerUpMp:MovieClipPlayer;// 怒气上升时的火焰效果
		
		// 当前怒气值
		private var nowRate:Number = 0;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleAngerBall()
		{
			// 怒气缓动播放器
			angerUpdateMp = new MovieClipPlayer();
			angerUpdateMp.addEventListener(Event.COMPLETE , onAngerUpdateOver);
			
			// 怒气缓动播放器
			angerUpMp = new MovieClipPlayer();
			angerUpMp.addEventListener(Event.COMPLETE , onAngerUpOver);
		}
		
		
		
		/**
		 * 初始化UI
		 * */
		public function initUI(res:Object):void
		{	
			// 怒气球
			anger = res.mc1;
			anger.gotoAndStop(0);
			this.addChild(anger);
			
			// 怒气火焰
			angerFire = res.mc2;
			angerFire.gotoAndStop(0);
			this.addChild(angerFire);
			
			// 主角半身像容器
			playerHeadPanel = new Sprite();
			playerHeadPanel.x = 233;
			playerHeadPanel.y = -40;
			this.addChild(playerHeadPanel);
			
			// 怒气文本
			angerLabel = new BitmapNumber();
			var tipsPanel2:ActiveObject = new ActiveObject();
			tipsPanel2.hint = Lang.instance.trans("AS_2");
			tipsPanel2.addChild(angerLabel);
			this.addChild(tipsPanel2);
		}
		
		
		
		
		
		/**
		 * 加载主角半身像
		 * */
		public function loadLeaderHead(base:GS_RoleBase_Pro):void
		{
			// 加载
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.PLAYER_HEAD_URL + base.career + "_195.swf" , null , onLoad);
		}
		
		
		
		
		
		
		/**
		 * 主角半身像加载完
		 * */
		private function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoad);
			
			// 移除角色头像
			Global.instance.removeChildren(playerHeadPanel);
			// 添加头像
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			playerHeadPanel.addChild(bmp);
		}
		
		
		
		
		
		
		/**
		 * 主角死亡后UI变灰
		 * */
		public function set alive(value:Boolean):void
		{
			if(value == false)
			{
				ColorTransformUtils.instance.addSaturation(playerHeadPanel , -100);
			}
			else
			{
				// 恢复半身像灰态
				ColorTransformUtils.instance.clear(playerHeadPanel);
			}
		}
		
		
		
		
		
		
		/**
		 * 更新怒气数值
		 * */
		public function updateAngerNum(anger:int , maxAnger:int):void
		{
			angerLabel.update(BitmapNumber.B , anger);
			
			if(anger < 10)
			{
				angerLabel.x = 320;
				
			}
			else if(anger < 100)
			{
				angerLabel.x = 313;
			}
			else
			{
				angerLabel.x = 306;
			}
			angerLabel.y = 126;
		}
		
		
		
		
		
		
		/**
		 * 更新怒气比例
		 * */
		public function updateAnger(nextAnger:int , maxAnger:int):void
		{
			var totalFrames:int = anger.totalFrames;
			
			var nextRate:int = Math.min(nextAnger , maxAnger);
			nextRate = int((nextRate / maxAnger) * totalFrames);
			
			// 播放怒气缓动
			this.onAngerUpdateOver();
			
			var duration:Number = Math.abs(((nextRate - nowRate)/totalFrames) * 5);
			angerUpdateMp.play(anger , duration , nowRate , nextRate);
			
			// 播放怒气上升时的火焰效果(该效果未在播放)
			if(angerUpMp.movie == null && nextRate > nowRate)
			{
				angerUpMp.stop();
				angerUpMp.play(angerFire , 1.5 , 0 , angerFire.totalFrames);
			}
		}
		
		
		
		
		
		
		/**
		 * 怒气缓动结束
		 * */
		private function onAngerUpdateOver(e:Event = null):void
		{
			angerUpdateMp.stop();
			
			nowRate = anger.currentFrame;
		}
		
		
		
		
		
		/**
		 * 怒气上升时的火焰效果播放结束
		 * */
		private function onAngerUpOver(e:Event):void
		{
			angerUpMp.stop();
		}
		
		
		
		
		
		
		
		
		/**
		 * 画多边形遮罩(功能类似扇形,但大大优化了性能)
		 * */
		private function drawVolitionMask(g:Graphics , centerX:int , centerY:int , radius:Number , angle:Number):void
		{
			g.clear();
			// 角度为0
			if(angle == 0)
			{
				// 都不显示
				return;
			}
			// 角度等于360
			else if(angle%360 == 0)
			{
				// 全部显示
				g.beginFill(0);
				g.drawRect(0,0,radius*2,radius*2);
				g.endFill();
				return;
			}
			
			// 角度转弧度系数
			var toPI:Number = Math.PI/180;
			// 计算扇形目标点
			var newAngle:Number = angle - 90;
			var targetX:Number = Math.cos(newAngle*toPI) * radius + centerX;
			var targetY:Number = Math.sin(newAngle*toPI) * radius + centerY;
			
			// 图形经过的点
			var points:Array = [];
			points[0] = new Point(centerX , centerY - radius);// 上方点
			points[1] = new Point(centerX + radius , centerY - radius);// 右上角的点
			// 角度小于180度
			if(angle > 90 && angle <= 180)
			{
				points[2] = new Point(centerX + radius , centerY + radius);// 右下角的点
			}
			// 角度小于270度
			else if(angle > 180 && angle <= 270)
			{
				points[2] = new Point(centerX + radius , centerY + radius);// 右下角的点
				points[3] = new Point(centerX - radius , centerY + radius);// 左下角的点
			}
			// 角度大于270 小于 360
			else if(angle > 270 && angle < 360)
			{
				points[2] = new Point(centerX + radius , centerY + radius);// 右下角的点
				points[3] = new Point(centerX - radius , centerY + radius);// 左下角的点
				points[4] = new Point(centerX - radius , centerY - radius);// 左上角的点
			}
			// 目标点
			points.push(new Point(targetX , targetY));
			// 原点
			points.push(new Point(centerX , centerY));
			
			// 开始制图
			g.clear();
			g.beginFill(0);
			g.moveTo(centerX , centerY);
			for(var i:int=0;i<points.length;i++)
			{
				g.lineTo(points[i].x , points[i].y);
			}
			g.endFill();
		}
		
		
		
		
		
		
		/**
		 * clear
		 * */
		public function clear():void
		{
			nowRate = 0;
			
			angerUpdateMp.stop();
			angerUpMp.stop();
			
			anger.gotoAndStop(0);
			angerFire.gotoAndStop(0);
			
			// 恢复半身像灰态
			ColorTransformUtils.instance.clear(playerHeadPanel);
		}
		
	}
}