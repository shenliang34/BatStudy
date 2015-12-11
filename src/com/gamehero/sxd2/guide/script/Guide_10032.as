package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.gui.BattleSkIcon;
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * 第一个关卡第二回合技能引导
	 * @author xuwenyi
	 * @create 2015-01-22
	 **/
	public class Guide_10032 extends Guide
	{
		private var skillBtn:BattleSkIcon;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10032()
		{
			super();
		}
		
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var battleView:BattleView = dataCenter.battleView;
			if(battleView)
			{
				skillBtn = battleView.getSkIcon(1);
				this.popupClickGuide(skillBtn, false, Lang.instance.trans("AS_1400"), Direct_Down , finish);
				
				// 键盘
				App.stage.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			}
		}
		
		
		
		
		
		
		/**
		 * 使用键盘
		 * */
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.NUMBER_2:
				case Keyboard.NUMPAD_2:
					
					if(skillBtn.enabled == true)
					{
						skillBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					}
					break;
			}
		}
		
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{
			if(completecallBack)
			{
				completecallBack();
				completecallBack = null;
			}
			
			// 战斗结束才记录到服务器
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var battleView:BattleView = dataCenter.battleView;
			if(battleView)
			{
				battleView.addEventListener(BattleEvent.BATTLE_END , onBattleEnd);
			}
			
			this.clear();
		}
		
		
		
		
		
		/**
		 * 清除
		 * */
		private function clear():void
		{
			skillBtn = null;
			// 移除事件
			App.stage.removeEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
		}
		
		
		
		
		
		/**
		 * 战斗结束后才结束引导
		 * */
		protected function onBattleEnd(e:Event):void
		{
			e.currentTarget.removeEventListener(BattleEvent.BATTLE_END , onBattleEnd);
			// 完成引导
			this.guideCompleteHandler();
		}
		
		
		
		
		
		/**
		 * 复写
		 * */
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			this.clear();
			
			super.guideCompleteHandler(e);
		}
	}
}