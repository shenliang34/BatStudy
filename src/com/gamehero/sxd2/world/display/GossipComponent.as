package com.gamehero.sxd2.world.display
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	
	
	/**
	 * 支持聊天泡泡的组件
	 * @author xuwenyi
	 * @create 2015-11-04
	 **/
	public class GossipComponent
	{
		// 闲话泡泡
		protected var bubbleItem:RenderItem;
		private var textItem:RichTextItem;
		private var currentText:String;
		private var chars:Array;
		
		private var timer:Timer;
		private var hideTimerID:int;
		private var callback:Function;
		
		// 父容器
		private var parent:SpriteItem;
		
		// 注册点高度
		public var registerHeight:int;
		
		
		
		/**
		 * 构造函数
		 * */
		public function GossipComponent()
		{
			super();
		}
		
		
		
		
		/**
		 * 注册
		 * */
		public function register(parent:SpriteItem):void
		{
			this.parent = parent;
			
			bubbleItem = new RenderItem();
			bubbleItem.visible = false;
			
			textItem = new RichTextItem();
			textItem.width = 160;
			textItem.height = 60;
			textItem.color = GameDictionary.STROKE;
			textItem.visible = false;
			
			parent.addChild(bubbleItem);
			parent.addChild(textItem);
		}
		
		
		
		
		
		/**
		 * 显示闲话
		 * @param dialog
		 * @param duration 显示冒泡时间（毫秒）
		 */
		public function showGossip(dialog:String , duration:int = 0 , direct:int = 1 , callback:Function = null):void 
		{	
			// 先停止之前的走马灯timer
			this.nativeStop();
			
			this.callback = callback;
			
			// 切割文字
			for(var i:int=0;i<dialog.length;i++)
			{
				chars.push(dialog.charAt(i));
			}
			
			timer = new Timer(42);
			timer.addEventListener(TimerEvent.TIMER , updateText);
			timer.start();
			
			bubbleItem.visible = true;
			textItem.visible = true;
			textItem.text = "";
			
			this.updatePosition(direct);
			
			if(hideTimerID > 0)
			{
				clearTimeout(hideTimerID);
				hideTimerID = 0;
			}
			// 若存在duration,一定时间后关闭
			if(duration > 0)
			{
				hideTimerID = setTimeout(hideGossip , duration);
			}
		}
		
		
		
		
		
		
		/**
		 * 隐藏闲话
		 */
		public function hideGossip():void 
		{	
			if(hideTimerID > 0)
			{
				clearTimeout(hideTimerID);
				hideTimerID = 0;
			}
			
			bubbleItem.visible = false;
			textItem.visible = false;
			
			this.nativeStop();
			
			if(callback)
			{
				var tempfunc:Function = callback;
				callback = null;
				tempfunc();
			}
		}
		
		
		
		
		
		
		
		/**
		 * 走马灯效果 
		 */		
		private function updateText(e:TimerEvent):void
		{
			if(chars.length > 0)
			{
				var char:String = chars.shift();
				currentText += char;
				textItem.text = currentText;
			}
			else
			{
				this.nativeStop();
			}
		}		
		
		
		
		
		
		/**
		 * 停止走马灯
		 * */
		private function nativeStop():void
		{
			currentText = "";
			chars = [];
			
			if(timer)
			{
				timer.removeEventListener(TimerEvent.TIMER , updateText);
				timer.stop();
				timer = null;
			}
		}
		
		
		
		
		
		
		/**
		 * 更新闲话泡泡位置
		 */
		protected function updatePosition(direct:int):void
		{	
			if(bubbleItem.visible == true)
			{
				var bmdW:int = MapSkin.NPC_DIALOGUE_1.width;
				var bmdH:int = MapSkin.NPC_DIALOGUE_1.height;
				
				bubbleItem.y = - bmdH - registerHeight;
				textItem.y = bubbleItem.y + 20;
				
				// 正面
				if(direct == 1)
				{
					bubbleItem.renderSource = MapSkin.NPC_DIALOGUE_1;
					
					textItem.x = 20;
				}
				// 反面
				else
				{
					bubbleItem.x = - bmdW;
					bubbleItem.renderSource = MapSkin.NPC_DIALOGUE_2;
					
					textItem.x = 20 - bmdW;
				}
			}
			
		}
		
		
		
		
		
		
		/**
		 * 清空
		 */
		public function clear():void
		{
			this.nativeStop();
			
			callback = null;
			
			if(hideTimerID > 0)
			{
				clearTimeout(hideTimerID);
				hideTimerID = 0;
			}
			
			bubbleItem.renderSource = null;
			
			if(parent.contains(bubbleItem) == true)
			{
				parent.removeChild(bubbleItem);
			}
			
			textItem.text = "";
			if(parent.contains(textItem) == true)
			{
				parent.removeChild(textItem);
			}
		}
		
	}
}