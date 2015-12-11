package com.gamehero.sxd2.drama.cmds.scene
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	
	
	/**
	 * 进入一场战斗
	 * @author xuwenyi
	 * @create 
	 **/
	public class CreateBattleCmd extends BaseCmd
	{
		private var battleId:int;
		
		
		
		public function CreateBattleCmd()
		{
			super();
		}
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			battleId = xml.@battleId;
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			SXD2Main.inst.createBattle(battleId);
			
			complete();
		}
	}
}