package com.gamehero.sxd2.drama.cmds
{
    import com.gamehero.sxd2.drama.base.BaseCmd;
    
    import flash.events.Event;

	/**
	 *战斗剧情 
	 */
	public class BattleCmd extends BaseCmd
	{
		private var _battleId:int;
		
		
		
		
		public function BattleCmd()
		{
			super();
		}
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_battleId = xml.@battleId;
		}
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			
			/*DramaManager.instance.addEventListener(BattleEvent.BATTLE_LOADED,onBattleLoaded);
			BattleDataCenter.instance.hasDrama=true;
			
			MainUI.inst.createBattle(_battleId);
			Logger.debug(BattleCmd,"进入战斗:"+_battleId);*/
		}
		
		protected function onBattleLoaded(event:Event):void
		{
			//DramaManager.instance.removeEventListener(BattleEvent.BATTLE_LOADED,onBattleLoaded);
			complete();
		}
	}
}