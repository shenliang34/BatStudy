package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗中漂浮技能文字
	 * @author xuwenyi
	 * @create 2014-04-10
	 **/
	public class BattleSkText extends Sprite
	{
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSkText()
		{
			
		}
		
		
		
		/**
		 * 开始播放
		 * */
		public function play(skill:BattleSkill):void
		{
			var bg:Bitmap;
			var name:String = skill.name;
			// 根据文字长度判断采取哪种背景图
			if(name.length <= 2)
			{
				// 短背景
				//bg = new Bitmap(BattleSkin.SKILL_TEXT_BG1);
			}
			else
			{
				// 长背景
				//bg = new Bitmap(BattleSkin.SKILL_TEXT_BG2);
			}
			bg.x = -bg.width>>1;
			bg.y = -bg.height>>1;
			this.addChild(bg);
			
			// 加载技能文字
			var textURL:String = GameConfig.BATTLE_SKILL_TEXT_URL + skill.groupId + ".swf";
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
			this.scaleX = 0;
			this.scaleY = 0;
			this.alpha = 0;
			
			TweenMax.to(this , 0.3 , {scaleX:1,scaleY:1,alpha:1});
			TweenMax.to(this , 0.4 , {y:"-100",ease:Back.easeOut,onComplete:moveOver});
			
			var self:BattleSkText = this;
			function moveOver():void
			{
				// 渐隐
				TweenMax.to(self , 0.3 , {delay:2,alpha:0,onComplete:over});
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