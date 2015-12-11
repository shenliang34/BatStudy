package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	
	/**
	 * 战斗回合数面板
	 * @author xuwenyi
	 * @create 2015-08-11
	 **/
	public class BattleRoundPanel extends Sprite
	{
		private var roundPanel:Sprite;
		private var roundLabel:BitmapNumber;
		
		
		/**
		 * 构造函数
		 * */
		public function BattleRoundPanel()
		{
			super();
		}
		
		
		
		
		
		public function initUI():void
		{
			// 当前回合数
			roundPanel = new Sprite();
			this.addChild(roundPanel);
			
			// 墨水背景
			var bg:Bitmap = new Bitmap(BattleSkin.BATTLE_ROUND_BG);
			bg.x = 4;
			bg.y = 11;
			roundPanel.addChild(bg);
			
			// 当前回合数文字
			var lb:Bitmap = new Bitmap(BattleSkin.BATTLE_ROUND_LB);
			lb.x = 15;
			lb.y = 9;
			roundPanel.addChild(lb);
			
			// 回合数字
			roundLabel = new BitmapNumber();
			roundLabel.x = 152;
			roundLabel.y = 1;
			roundPanel.addChild(roundLabel);
		}
		
		
		
		
		
		/**
		 * 更新当前回合数
		 * */
		public function updateRound(round:int):void
		{
			roundLabel.update(BitmapNumber.M_YELLOW , round.toString());
		}
		
		
		
		
		
		/**
		 * clear
		 * */
		public function clear():void
		{
			
		}
	}
}