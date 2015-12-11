package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * 战斗加速按钮面板
	 * @author xuwenyi
	 * @create 2015-08-10
	 **/
	public class BattleSpeedUpPanel extends Sprite
	{
		// 速度
		private static const X1:Number = 1;
		private static const X2:Number = 0.5;
		private static const X3:Number = 0.3;
		
		private var btn1:SButton;
		private var btn2:SButton;
		private var btn3:SButton;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSpeedUpPanel()
		{
			super();
		}
		
		
		
		
		public function initUI():void
		{
			btn1 = new SButton(BattleSkin.SPEED_UP_1_BTN);
			btn1.visible = false;
			this.addChild(btn1);
			
			btn2 = new SButton(BattleSkin.SPEED_UP_2_BTN);
			btn2.visible = false;
			this.addChild(btn2);
			
			btn3 = new SButton(BattleSkin.SPEED_UP_3_BTN);
			btn3.visible = false;
			this.addChild(btn3);
		}
		
		
		
		
		
		public function init(speed:Number):void
		{
			btn1.visible = false;
			btn2.visible = false;
			btn3.visible = false;
			
			switch(speed)
			{
				case X1:
					btn1.visible = true;
					break;
				case X2:
					btn2.visible = true;
					break;
				case X3:
					btn3.visible = true;
					break;
			}
			
			
			this.addEventListener(MouseEvent.CLICK , click);
		}
		
		
		
		
		
		private function click(e:MouseEvent):void
		{
			var speed:Number = 0;
			if(btn1.visible == true)
			{
				btn1.visible = false;
				btn2.visible = true;
				
				speed = X2;
			}
			else if(btn2.visible == true)
			{
				btn2.visible = false;
				btn3.visible = true;
				
				speed = X3;
			}
			else
			{
				btn3.visible = false;
				btn1.visible = true;
				
				speed = X1;
			}
			
			this.dispatchEvent(new BattleEvent(BattleEvent.BATTLE_SPEED_UP_CLICK , speed));
		}
		
		
		
		
		
		public function clear():void
		{
			btn1.visible = false;
			btn2.visible = false;
			btn3.visible = false;
			
			this.removeEventListener(MouseEvent.CLICK , click);
		}
		
	}
}