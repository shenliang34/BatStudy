package com.gamehero.sxd2.gui.player.hero
{
	import robotlegs.bender.bundles.mvcs.Mediator;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-6 上午11:11:20
	 * 
	 */
	public class HeroDetailWindowMediator extends Mediator
	{
		[Inject]
		public var view:HeroDetailWindow
		
		
		public static var _instance:HeroDetailWindowMediator;
		public function HeroDetailWindowMediator()
		{
			super();
		}
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			
		}
		
		public static function get instance():HeroDetailWindowMediator
		{
			return _instance ||= new HeroDetailWindowMediator();
		}
		
		public function set refreshHeroInfo(date:Object):void
		{
			
		}
	}
}