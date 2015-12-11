package com.gamehero.sxd2.drama.cmds
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.drama.Drama;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.events.Event;
	
	import bowser.logging.Logger;
	import com.gamehero.sxd2.drama.base.BaseCmd;

	/**
	 *战斗继续命令 
	 * @author wulongbin
	 * 
	 */
	public class BattleContinueCmd extends BaseCmd
	{
		public function BattleContinueCmd()
		{
			super();
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			/*DramaManager.instance.addEventListener(MainEvent.BATTLE_END,onBattleEnd);
			DramaManager.instance.dispatchEvent(new BattleEvent(BattleEvent.BATTLE_CONTINUE));
			Logger.debug(BattleContinueCmd,"战斗继续");*/
		}
		
		
		
		private function onBattleEnd(event:Event):void
		{
			/*DramaManager.instance.removeEventListener(MainEvent.BATTLE_END,onBattleEnd);
			WasynManager.instance.addFuncByTimer(function():void
			{
//				Drama.hideUIView();
				Drama.setUIView(false);
				
				complete();
			});*/
				
		}
	}
}