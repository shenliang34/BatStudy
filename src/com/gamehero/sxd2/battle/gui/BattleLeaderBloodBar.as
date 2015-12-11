package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.pro.GS_RoleBase_Pro;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MathUtil;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 战斗UI上的主角血条
	 * @author xuwenyi
	 * @create 2013-08-26
	 **/
	public class BattleLeaderBloodBar extends Sprite
	{
		// 缓动步长
		private static const STEP:Number = 0.02;
		
		// boss头像
		private var headPanel:Sprite;
		private var headURL:String;
		
		// 遮罩
		private var mask:Shape;
		private var shadowMask:Shape;
		// 当前百分比
		private var currentRate:Number = 1;
		// 目标百分比
		private var targetRate:Number = 1;
		// 血条
		private var blood:Bitmap;
		// 血条阴影
		private var shadow:Bitmap;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleLeaderBloodBar()
		{
			super();
		}
		
		
		
		/**
		 * 初始化
		 * */
		public function init(headBD:BitmapData , bloodBD:BitmapData , shadowBD:BitmapData , bloodbgBD:BitmapData):void
		{
			// 血条背景
			var bloodbg:ScaleBitmap = new ScaleBitmap(bloodbgBD);
			var rect:Rectangle = new Rectangle(8,5,21,12);
			bloodbg.scale9Grid = rect;
			bloodbg.setSize(bloodBD.width , bloodBD.height);
			bloodbg.x = 93;
			bloodbg.y = 10;
			this.addChild(bloodbg);
			
			// 血条阴影
			shadow = new Bitmap(shadowBD);
			shadow.x = bloodbg.x;
			shadow.y = bloodbg.y
			this.addChild(shadow);
			
			// 血条
			blood = new Bitmap(bloodBD);
			blood.x = bloodbg.x;
			blood.y = bloodbg.y
			this.addChild(blood);
			
			// 阴影遮罩
			shadowMask = new Shape();
			shadowMask.x = blood.x;
			shadowMask.y = blood.y;
			this.addChild(shadowMask);
			
			// 血条遮罩
			mask = new Shape();
			mask.x = blood.x;
			mask.y = blood.y;
			this.addChild(mask);
			
			// 大背景
			var bg:Bitmap = new Bitmap(headBD);
			this.addChild(bg);
			
			// 头像面板
			headPanel = new Sprite();
			headPanel.x = 8;
			headPanel.y = -3;
			this.addChild(headPanel);
		}
		
		
		
		
		/**
		 * 显示主角头像
		 * */
		public function initLeaderInfo(base:GS_RoleBase_Pro):void
		{
			// 加载头像
			headURL = GameConfig.PLAYER_HEAD_URL + base.career + "_b.swf";
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			loader.addWithListener(headURL , null , onHeadLoaded);
		}
		
		
		
		
		
		
		/**
		 * 头像加载完成
		 * */
		private function onHeadLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onHeadLoaded);
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			
			Global.instance.removeChildren(headPanel);
			headPanel.addChild(bmp);
		}
		
		
		
		
		
		
		/**
		 * 更新当前血量百分比
		 * */
		public function update(rate:Number):void
		{
			targetRate = Math.max(rate , 0);
			targetRate = Math.min(targetRate , 1);
			// 保留3位小数
			targetRate = MathUtil.decimalPoint(targetRate , 3);
			
			// 改变血条遮罩
			var graphics:Graphics = mask.graphics;
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0 , 0 , blood.width*targetRate , blood.height);
			graphics.endFill();
			blood.mask = mask;
			
			// 改变阴影遮罩(动画)
			this.addEventListener(Event.ENTER_FRAME , onUpdate);
		}
		
		
		
		
		/**
		 * 每帧更新
		 * */
		private function onUpdate(e:Event):void
		{
			var num:Number = targetRate - currentRate;
			// 趋近与0时
			if(Math.abs(num) < STEP)
			{
				// 停止
				this.removeEventListener(Event.ENTER_FRAME , onUpdate);
				currentRate = targetRate;
			}
			else if(num > 0)
			{
				currentRate += STEP;
			}
			else if(num < 0)
			{
				currentRate -= STEP;
			}
			// 改变阴影遮罩
			var graphics:Graphics = shadowMask.graphics;
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0 , 0 , shadow.width*currentRate , shadow.height);
			graphics.endFill();
			shadow.mask = shadowMask;
		}
		
	}
}