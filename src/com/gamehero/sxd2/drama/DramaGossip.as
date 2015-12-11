package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import alternativa.gui.theme.defaulttheme.controls.text.Label;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.effect.TextEf;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 用于剧情显示人物对话
	 * @author xuwenyi
	 * @create 2015-11-09
	 **/
	public class DramaGossip extends Sprite
	{
		// 闲话泡泡
		protected var bubbleItem:MovieClip;
		private var textItem:TextEf;
		private var lb:Label
		private var message:String;
		
		// 头像
		private var headPanel:Sprite;
		
		private var timer:Timer;
		private var showTimerID:int;
		private var hideTimerID:int;
		private var callback:Function;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function DramaGossip()
		{
			super();
		}
		
		
		
		
		
		
		/**
		 * 显示闲话
		 * @param dialog
		 * @param duration 显示冒泡时间（毫秒）
		 */
		public function showGossip(dialog:String , head:String , duration:int = 0 , direct:int = 1 , callback:Function = null):void 
		{	
			this.callback = callback;
			this.message = dialog;
			
			bubbleItem = new GuideSkin.DRAMA_GOSSIP_BG();
			bubbleItem.gotoAndPlay(0);
			this.addChild(bubbleItem);
			
			// 对话内容
			lb = new Label(false);
			lb.width = 130;
			lb.height = 60;
			lb.leading = 0.4;
			lb.color = 0x000000;
			textItem = new TextEf();
			this.addChild(textItem);
			
			// 头像先隐藏,等一定时间后再显示
			headPanel = new Sprite();
			headPanel.visible = false;
			this.addChild(headPanel);
			
			// 加载人物头像
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.DRAMA_URL + "gossiphead/" + head + ".swf" , null , onLoad);
			
			// 一定时间后显示头像和文字
			showTimerID = setTimeout(showText , 500);
			
			// 若存在duration,一定时间后关闭
			if(duration > 0)
			{
				hideTimerID = setTimeout(hide , duration);
			}
			
			this.updatePosition(direct);
		}
		
		
		
		
		
		
		private function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onLoad);
			
			if(headPanel)
			{
				var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
				var png:BitmapData = new PNGDataClass();
				var bmp:Bitmap = new Bitmap(png);
				headPanel.addChild(bmp);
			}
			
		}
		
		
		
		
		
		/**
		 * 显示头像和文字
		 * */
		private function showText():void
		{
			textItem.show(lb , message);
			
			headPanel.visible = true;
			TweenLite.fromTo(headPanel , 0.2 , {alpha:0} , {alpha:1});
		}
		
		
		
		
		
		/**
		 * 显示全部文字
		 * */
		public function showFullText():void
		{
			headPanel.visible = true;
			
			if(textItem.isStart == false)
			{
				textItem.show(lb , message);
			}
			textItem.showFull();
			bubbleItem.gotoAndStop(bubbleItem.totalFrames);
			
			if(showTimerID > 0)
			{
				clearTimeout(showTimerID);
				showTimerID = 0;
			}
		}
		
		
		
		
		
		
		/**
		 * 隐藏闲话
		 */
		public function hide():void 
		{	
			if(callback)
			{
				var tempfunc:Function = callback;
				callback = null;
				tempfunc(this);
			}
			
			this.clear();
		}
		
		
		
		
		
		
		
		
		/**
		 * 更新闲话泡泡位置
		 */
		protected function updatePosition(direct:int):void
		{	
			// 正向
			if(direct == 1)
			{
				headPanel.x = -70;
				headPanel.y = -130;
				headPanel.scaleX = 1;
				
				textItem.x = 116;
				textItem.y = 18;
				
				bubbleItem.scaleX = 1;
			}
			else
			{
				headPanel.x = 70;
				headPanel.y = -130;
				headPanel.scaleX = -1;
				
				textItem.x = -235;
				textItem.y = 18;
				
				bubbleItem.scaleX = -1;
			}
		}
		
		
		
		
		
		
		public function get isEnd():Boolean
		{
			return textItem.isEnd;
		}
		
		
		
		
		
		
		/**
		 * 清空
		 */
		public function clear():void
		{
			callback = null;
			
			if(hideTimerID > 0)
			{
				clearTimeout(hideTimerID);
				hideTimerID = 0;
			}
			if(showTimerID > 0)
			{
				clearTimeout(showTimerID);
				showTimerID = 0;
			}
			
			if(bubbleItem)
			{
				bubbleItem.gotoAndStop(0);
				bubbleItem = null;
			}
			
			if(textItem)
			{
				textItem.clear();
				textItem = null;
			}
			
			Global.instance.removeChildren(headPanel);
			Global.instance.removeChildren(this);
		}
		
	}
}