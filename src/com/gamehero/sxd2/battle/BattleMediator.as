package com.gamehero.sxd2.battle
{
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.services.GameService;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 战斗模块的mediator
	 * @author xuwenyi
	 * @create 2013-07-18
	 **/
	public class BattleMediator extends Mediator
	{
		[Inject]
		public var view:BattleView;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleMediator()
		{
			super();
		}
		
		
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			super.initialize();
			
			this.addContextListener(BattleEvent.BATTLE_END , battleEnd);
			this.addContextListener(BattleEvent.BATTLE_REPLAY , battleReplay);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 移除事件
			this.removeContextListener(BattleEvent.BATTLE_END , battleEnd);
			this.removeContextListener(BattleEvent.BATTLE_REPLAY , battleReplay);
		}
		
		
		
		
		
		/**
		 * 战斗回放
		 * */
		private function battleReplay(e:BattleEvent):void
		{
			view.replay();
		}
		
		
		
		
		
		/**
		 * 发送战斗结束请求
		 * */
		private function battleEnd(e:BattleEvent):void
		{
			//proxy.battleEnd(end);
			
			// 退出战斗
			this.quit();
		}
		
		
		
		
		
		
		/**
		 * 退出战斗
		 * */
		private function quit():void
		{
			// 退出外部战斗结束
			this.dispatch(new MainEvent(MainEvent.BATTLE_END));
			
			// 清理战斗视图
			view.quit();
		}
		
		
		
		
		
		/**
		 * 战斗加载完成
		 * */
		private function onBattleLoaded(e:BattleEvent):void
		{
			this.dispatch(e);
		}
		
		
	}
}