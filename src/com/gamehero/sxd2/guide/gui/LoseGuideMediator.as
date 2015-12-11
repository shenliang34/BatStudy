package com.gamehero.sxd2.guide.gui
{
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 战斗失败快速引导窗口
	 * @author xuwenyi
	 * @create 2014-05-09
	 **/
	public class LoseGuideMediator extends Mediator
	{
		[Inject]
		public var view:LoseGuideWindow;
		
		
		
		/**
		 * 构造函数
		 * */
		public function LoseGuideMediator()
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
			// 切换场景
			this.addContextListener(MainEvent.CHANGE_MAP , changeView);
			this.addContextListener(MainEvent.SHOW_GLOBAL_WORLD , changeView);
			this.addContextListener(MainEvent.SHOW_FULLSCREEN_VIEW , changeView);
			this.addContextListener(MainEvent.SHOW_BATTLE , changeView);
			// 打开其他窗口
			this.addContextListener(WindowEvent.OPEN_WINDOW , changeView);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 移除事件
			this.removeContextListener(MainEvent.CHANGE_MAP , changeView);
			this.removeContextListener(MainEvent.SHOW_GLOBAL_WORLD , changeView);
			this.removeContextListener(MainEvent.SHOW_FULLSCREEN_VIEW , changeView);
			this.removeContextListener(MainEvent.SHOW_BATTLE , changeView);
			this.removeContextListener(WindowEvent.OPEN_WINDOW , changeView);
		}
		
		
		
		
		
		/**
		 * 切换场景时触发
		 * */
		private function changeView(e:Event):void
		{
			view.closeWindow();
		}
		
	}
}