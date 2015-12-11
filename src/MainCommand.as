package
{
	import com.gamehero.sxd2.event.MainEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	
	/**
	 * 场景切换相关操作
	 * @author xuwenyi
	 * @create 2013-08-01
	 **/
	public class MainCommand extends Command
	{
		[Inject]
		public var appView:SXD2Main;
		
		[Inject]
		public var mainEvent:MainEvent;
		
		
		/**
		 * 构造函数
		 * */
		public function MainCommand()
		{
			super();
		}
		

		override public function execute():void 
		{
			var data:Object = mainEvent.data;
			// 切换场景 
			switch(mainEvent.type)
			{
				// 进入战斗
				case MainEvent.SHOW_BATTLE:
					appView.showBattle();
					break;
				// 战斗结束
				case MainEvent.BATTLE_END:
					appView.hideBattle();
					break;
			}
			
		}
		
		
	}
}