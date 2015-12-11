package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.event.BattleEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 战斗录像结算mediator
	 * @author xuwenyi
	 * @create 2015-09-10
	 **/
	public class BattleReportMediator extends Mediator
	{
		[Inject]
		public var view:BattleReportWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleReportMediator()
		{
			super();
		}
		
		
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			super.initialize();
			
			// 监听事件
			this.addViewListener(BattleEvent.BATTLE_END , quit);
			this.addViewListener(BattleEvent.BATTLE_REPLAY , replay);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 监听事件
			this.removeViewListener(BattleEvent.BATTLE_END , quit);
			this.removeViewListener(BattleEvent.BATTLE_REPLAY , replay);
		}
		
		
		
		
		/**
		 * 回放
		 * */
		private function replay(e:BattleEvent):void
		{
			this.dispatch(e);
		}
		
		
		
		
		/**
		 * 退出战斗
		 * */
		private function quit(e:BattleEvent):void
		{
			this.dispatch(e);
		}
	}
}