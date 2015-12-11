package com.gamehero.sxd2.battle.gui
{
	import com.greensock.TweenMax;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 守护天使技能全屏效果
	 * @author xuwenyi
	 * @create 2014-07-28
	 **/
	public class BAngel extends Sprite
	{
		// 头像
		protected var headPanel:Sprite;
		protected var headURL:String;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BAngel()
		{
			// 头像容器
			headPanel = new Sprite();
			this.addChild(headPanel);
			
			this.visible = false;
		}
		
		
		
		
		
		/**
		 * 加载
		 * */
		public function load(player:BPlayer , skillEf:BattleSkillEf , head:String = ""):void
		{
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			
			// 加载头像
			var headName:String;
			headURL = GameConfig.BATTLE_BURST_EFFECT_URL + "head/" + headName + ".swf";
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
			
			bmp.x = -bmp.width>>1;
			bmp.y = -bmp.height>>1;
			headPanel.addChild(bmp);
		}
		
		
		
		
		
		/**
		 * 播放
		 * */
		public function play():void
		{
			this.visible = true;
			
			// 快速移入场景
			TweenMax.fromTo(headPanel , .3 , {x:100,alpha:0,blurFilter:{blurX:10,blurY:10}} , {x:HEAD_FIR_X,alpha:1,blurFilter:{blurX:0,blurY:0}});
			TweenMax.fromTo(textPanel , .3 , {x:500,alpha:0,blurFilter:{blurX:10,blurY:10}} , {x:TEXT_FIR_X,alpha:1,blurFilter:{blurX:0,blurY:0},onComplete:midMove});
			
			// 开始缓慢移动
			function midMove():void
			{
				TweenMax.to(headPanel , .8 , {x:HEAD_SEC_X});
				TweenMax.to(textPanel , .8 , {x:TEXT_SEC_X , onComplete:endMove});
			}
			
			// 快速移出场景
			function endMove():void
			{
				TweenMax.to(headPanel , .25 , {x:-500,alpha:0,blurFilter:{blurX:10,blurY:10}});
				TweenMax.to(textPanel , .25 , {x:-100,alpha:0,blurFilter:{blurX:10,blurY:10},onComplete:over});
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
			global.removeChildren(headPanel);
			
			this.visible = false;
		}
	}
}