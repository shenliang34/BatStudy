package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bowser.utils.effect.TextEf;
	
	
	/**
	 * 黑屏显示文字
	 * @author xuwenyi
	 * @create 2015-09-16
	 **/
	public class DramaBlackStoryWindow extends GameWindow
	{
		// 用于全屏点击触发
		private var clickPanel:Sprite;
		// 对话文字
		private var textEf:TextEf;	
		// 对话完毕后的回调
		private var callback:Function;
		
		
		/**
		 * 构造函数
		 * */
		public function DramaBlackStoryWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, resourceURL, width, height);
			
			canOpenTween = false;
		}
		
		
		
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			clickPanel = new Sprite();
			this.addChild(clickPanel);
			
			// 对话文字
			textEf = new TextEf();
			this.addChild(textEf);
		}
		
		
		
		
		override public function onShow():void
		{
			super.onShow();
			
			clickPanel.addEventListener(MouseEvent.CLICK , onClick);
			this.addEventListener(Event.RESIZE , resize);
			
			this.resize();
		}
		
		
		
		
		
		
		public function showMessage(message:String , callback:Function):void
		{
			// 对话内容
			var lb:Label = new Label();
			lb.width = 500;
			lb.height = 100;
			lb.size = 18;
			textEf.show(lb , message);
			
			this.callback = callback;
		}
		
		
		
		
		
		
		
		
		/**
		 * 点击快速结束对话
		 * */
		private function onClick(e:MouseEvent):void
		{
			if(textEf.isEnd == false)
			{
				textEf.showFull();
			}
			else
			{
				this.close();
				
				if(callback)
				{
					callback();
					
					callback = null;
				}
			}
		}
		
		
		
		
		
		
		
		/**
		 * 自适应
		 * */
		private function resize(e:Event = null):void
		{
			if(stage)
			{
				clickPanel.x = -x;
				clickPanel.y = -y;
				
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				clickPanel.graphics.clear();
				clickPanel.graphics.beginFill(0);
				clickPanel.graphics.drawRect(0 , 0 , w , h);
				clickPanel.graphics.endFill();
				
				// 文字位置
				textEf.x = - 250;
				textEf.y = - 40;
			}
			
			
		}
		
		
		
		
		private function clear():void
		{
			textEf.clear();
			
			clickPanel.removeEventListener(MouseEvent.CLICK , onClick);
			this.removeEventListener(Event.RESIZE , resize);
		}
		
		
		
		
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
	}
}