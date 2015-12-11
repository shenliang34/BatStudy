package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import alternativa.gui.theme.defaulttheme.controls.text.Label;
	
	import bowser.utils.effect.TextEf;
	
	
	/**
	 * 角色思考
	 * @author xuwenyi
	 * @create 2015-11-10
	 **/
	public class DramaThink extends Sprite
	{
		// 闲话泡泡
		protected var bubbleItem:MovieClip;
		private var textItem:TextEf;
		private var lb:Label
		private var message:String;
		
		private var hideTimerID:int;
		private var callback:Function;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function DramaThink()
		{
			super();
		}
		
		
		
		
		
		
		/**
		 * 显示闲话
		 * @param dialog
		 * @param duration 显示冒泡时间（毫秒）
		 */
		public function showThink(message:String , duration:int = 0 , direct:int = 1 , callback:Function = null):void 
		{	
			this.callback = callback;
			this.message = message;
			
			bubbleItem = new GuideSkin.DRAMA_THINK_BG();
			bubbleItem.gotoAndPlay(0);
			this.addChild(bubbleItem);
			
			// 对话内容
			lb = new Label(false);
			lb.width = 135;
			lb.height = 40;
			lb.leading = 0.4;
			lb.color = 0x000000;
			textItem = new TextEf();
			textItem.show(lb , message);
			this.addChild(textItem);
			
			// 若存在duration,一定时间后关闭
			if(duration > 0)
			{
				hideTimerID = setTimeout(hide , duration);
			}
			
			this.updatePosition(direct);
		}
		
		
		
		
		
		
		
		/**
		 * 显示全部文字
		 * */
		public function showFullText():void
		{
			textItem.showFull();
			bubbleItem.gotoAndStop(bubbleItem.totalFrames);
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
				textItem.x = 25;
				textItem.y = 35;
				
				bubbleItem.scaleX = 1;
			}
			else
			{
				textItem.x = -160;
				textItem.y = 35;
				
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
			
			Global.instance.removeChildren(this);
		}
	}
}