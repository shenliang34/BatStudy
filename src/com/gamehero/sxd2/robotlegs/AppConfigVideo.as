package com.gamehero.sxd2.robotlegs
{
	import com.gamehero.sxd2.battle.BattleMediator;
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.gui.BattleReportMediator;
	import com.gamehero.sxd2.battle.gui.BattleReportWindow;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	
	
	/**
	 * 用于战斗录像的robotlegs配置
	 * @author xuwenyi
	 * @create 
	 **/
	public class AppConfigVideo implements IConfig
	{
		[Inject]
		public var context:IContext;
		[Inject]
		public var commandMap:IEventCommandMap;
		[Inject]
		public var mediatorMap:IMediatorMap;
		[Inject]
		public var contextView:ContextView;
		
		
		public function AppConfigVideo()
		{
		}
		
		
		
		
		/**
		 * 注册MVC各组件
		 * */
		public function configure():void
		{	
			
			/** model层 */
			var injector:IInjector = context.injector;
			
			mediatorMap.map(BattleView).toMediator(BattleMediator);
			mediatorMap.map(BattleReportWindow).toMediator(BattleReportMediator);
		}
	}
}