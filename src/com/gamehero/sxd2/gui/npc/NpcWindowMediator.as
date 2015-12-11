package com.gamehero.sxd2.gui.npc
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * npc窗口Mediator
	 * @author zhangxueyou
	 * @create-date 2015-8-25
	 */
	public class NpcWindowMediator extends Mediator
	{
		[Inject]
		public var view:NpcWindow
		
		public static var _instance:NpcWindowMediator;
		public function NpcWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}

		public static function get instance():NpcWindowMediator
		{
			return _instance ||= new NpcWindowMediator();
		}
	}
}