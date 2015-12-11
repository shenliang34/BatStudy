package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战意爆发时的全屏效果
	 * @author xuwenyi
	 * @create 2014-01-20
	 **/
	public class BattleBurstEf extends Sprite
	{
		// 头像第一阶段位置
		private static const HEAD_FIR_X:int = -100;
		// 文字第一阶段位置
		private static const TEXT_FIR_X:int = 300;
		// 头像第二阶段位置
		private static const HEAD_SEC_X:int = -200;
		// 文字第二阶段位置
		private static const TEXT_SEC_X:int = 200;
		
		
		// 背景
		protected var bgPanel:Sprite;
		protected var bgMovie:MovieClip;
		protected var bgURL:String;
		
		// 头像
		protected var headPanel:Sprite;
		protected var headURL:String;
		
		// 技能文字
		protected var textPanel:Sprite;
		protected var textURL:String;
		
		// 全屏遮罩
		protected var model:Shape;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleBurstEf()
		{
			// 全屏遮罩
			model = new Shape();
			this.addChild(model);
			
			// 背景容器
			bgPanel = new Sprite();
			this.addChild(bgPanel);
			
			// 头像容器
			headPanel = new Sprite();
			this.addChild(headPanel);
			
			// 文字容器
			textPanel = new Sprite();
			this.addChild(textPanel);
			
			this.visible = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
		}
		
		
		
		
		
		/**
		 * 加入场景
		 * */
		private function onAdd(e:Event):void
		{
			if(stage)
			{
				// 计算场景尺寸
				var viewWidth:int = Math.max(stage.stageWidth , BattleView.MIN_WIDTH);
				viewWidth = Math.min(viewWidth , BattleView.MAX_WIDTH);
				var viewHeight:int = Math.max(stage.stageHeight , BattleView.MIN_HEIGHT);
				viewHeight = Math.min(viewHeight , BattleView.MAX_HEIGHT);
				
				model.x = -viewWidth>>1;
				model.y = -viewHeight>>1;
				model.graphics.beginFill(0,0.6);
				model.graphics.drawRect(0,0,viewWidth,viewHeight);
				model.graphics.endFill();
			}
		}
		
		
		
		
		
		/**
		 * 加载
		 * */
		public function load(player:BPlayer , skillEf:BattleSkillEf , head:String = ""):void
		{
			/*var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			
			// 加载动画背景
			bgURL = GameConfig.BATTLE_BURST_EFFECT_URL + "bg/" + player.career + ".swf";
			loader.addWithListener(bgURL , null , onBGLoaded);
			
			// 加载头像
			var headName:String;
			if(head == "")
			{
				headName = player.career+"";
			}
			else
			{
				headName = head;
			}
			headURL = GameConfig.BATTLE_BURST_EFFECT_URL + "head/" + headName + ".swf";
			loader.addWithListener(headURL , null , onHeadLoaded);*/
			
			// 加载技能文字
			//textURL = GameConfig.BATTLE_BURST_EFFECT_URL + "text/" + skillEf.groupId + ".swf";
			//loader.addWithListener(textURL , null , onTextLoaded);
		}
		
		
		
		
		
		/**
		 * 背景加载完成
		 * */
		private function onBGLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onBGLoaded);
			
			var cls:Class = imageItem.getDefinitionByName("BG") as Class;
			bgMovie = new cls() as MovieClip;
			// 居中
			//bgMovie.x = -269;
			bgMovie.y = 91;
			//bgMovie.stop();
			bgPanel.addChild(bgMovie);
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
			
			bmp.x = -bmp.width>>1;
			bmp.y = -bmp.height>>1;
			headPanel.addChild(bmp);
		}
		
		
		
		
		
		/**
		 * 技能文字加载完成
		 * */
		private function onTextLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onTextLoaded);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			
			bmp.x = -bmp.width>>1;
			bmp.y = -bmp.height>>1;
			textPanel.addChild(bmp);
		}
		
		
		
		
		
		/**
		 * 播放
		 * */
		public function play():void
		{
			this.visible = true;
			
			// 播放背景动画
			/*if(bgMovie)
			{
				var player:MovieClipPlayer = new MovieClipPlayer();
				player.play(bgMovie , 1.5 , 0 , bgMovie.totalFrames);
			}*/
			
			var playSpeed:Number = BattleDataCenter.instance.playSpeed;//播放速度系数
			
			// 快速移入场景
			TweenMax.fromTo(headPanel , .3*playSpeed , {x:100,alpha:0,blurFilter:{blurX:10,blurY:10}} , {x:HEAD_FIR_X,alpha:1,blurFilter:{blurX:0,blurY:0}});
			TweenMax.fromTo(textPanel , .3*playSpeed , {x:500,alpha:0,blurFilter:{blurX:10,blurY:10}} , {x:TEXT_FIR_X,alpha:1,blurFilter:{blurX:0,blurY:0},onComplete:midMove});
			
			// 开始缓慢移动
			function midMove():void
			{
				TweenMax.to(headPanel , .8*playSpeed , {x:HEAD_SEC_X});
				TweenMax.to(textPanel , .8*playSpeed , {x:TEXT_SEC_X , onComplete:endMove});
			}
			
			// 快速移出场景
			function endMove():void
			{
				TweenMax.to(headPanel , .25*playSpeed , {x:-500,alpha:0,blurFilter:{blurX:10,blurY:10}});
				TweenMax.to(textPanel , .25*playSpeed , {x:-100,alpha:0,blurFilter:{blurX:10,blurY:10},onComplete:over});
			}
			
			// 结束播放
			function over():void
			{
				if(bgMovie)
				{
					bgMovie.stop();
				}
				
				// 清空并移除出场景
				clear();
				removeThis();
			}
		}
		
		
		
		
		/**
		 * 移除自己
		 * */
		private function removeThis():void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			var global:Global = Global.instance;
			global.removeChildren(bgPanel);
			global.removeChildren(headPanel);
			global.removeChildren(textPanel);
			
			this.visible = false;
		}
		
		
	}
}