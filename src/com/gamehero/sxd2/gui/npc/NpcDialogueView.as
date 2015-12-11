package com.gamehero.sxd2.gui.npc
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;

	/**
	 * npc冒泡窗口
	 * @author zhangxueyou
	 * @create-date 2015-8-25
	 */
	
	public class NpcDialogueView extends Sprite
	{
		private static var _instance:NpcDialogueView;
		private var text:TextField;//对话文本对象
		private var speed:int = 30;//定时器速度
		private var timerCount:int;//用于字符串计数
		private var textStr:String;//对话的字符串对象
		
		public function NpcDialogueView()
		{
		}
		
		public function init():void
		{
			var dialogueBg:Bitmap = new Bitmap(MapSkin.NPC_DIALOGUE);
			this.addChild(dialogueBg);
			text = new TextField();
			text.wordWrap = true; 
			text.multiline = true;
			text.selectable = false;
			text.autoSize=TextFieldAutoSize.LEFT;//LEFT/RIGHT/CENTER
			text.width = 180;
			text.x = 20;
			text.y = 25;
			this.addChild(text);
		}
		
		
		public function setText(value:String):void
		{
			timerCount = 0;
			text.text = "";
			textStr = value;
			var timer:Timer = new Timer(speed,textStr.length);
			timer.addEventListener(TimerEvent.TIMER,timerHandle);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandle);
			timer.start();
			
		}
		
		/**
		 * 定时器进行中
		 * */
		private function timerHandle(e:Event):void
		{
			text.text += textStr.charAt(timerCount);
			text.y = (this.height - text.height) / 2 - 6;
			timerCount ++;
		}	
		
		/**
		 * 定时器完成
		 * */
		private function timerCompleteHandle(e:Event):void
		{
			e.currentTarget.removeEventListener(TimerEvent.TIMER,timerHandle);
			e.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandle);
		}
		
		/**
		 * 获取单例
		 * */
		static public function get inst():NpcDialogueView {
			return _instance ||= new NpcDialogueView();
		}
	}
}
