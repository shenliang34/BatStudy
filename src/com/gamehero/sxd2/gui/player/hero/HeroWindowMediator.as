package com.gamehero.sxd2.gui.player.hero
{
	import com.gamehero.sxd2.gui.player.hero.event.HeroEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	

	/**
	 * @author Wbin
	 * 创建时间：2015-8-6 上午10:23:02
	 * 
	 */
	public class HeroWindowMediator extends Mediator
	{
		[Inject]
		public var view:HeroWindow
		
		public function HeroWindowMediator()
		{
			super();
		}
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			this.addViewListener(HeroEvent.REQ_HERO_LIST,reqHeroList);
			GameProxy.inst.addEventListener(HeroEvent.HERO_INFO_UPDATA,onUpdata);
		}
		
		override public function destroy():void
		{
			super.destroy();
			this.removeViewListener(HeroEvent.REQ_HERO_LIST,reqHeroList);
			GameProxy.inst.removeEventListener(HeroEvent.HERO_INFO_UPDATA,onUpdata);
		}
		protected function onUpdata(event:Event):void
		{
			this.view.updateHeroInfo();
		}
		
		private function reqHeroList(evt:HeroEvent):void
		{
			GameService.instance.send(MSGID.MSGID_HREO_BATTLE);
		}
		
	}
}