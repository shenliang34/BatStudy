package com.gamehero.sxd2.drama.cmds.effect {
	
	import com.gamehero.sxd2.drama.base.BaseCmd;
	
	import bowser.utils.effect.ShakeEffect;

	
	/**
	 * 屏幕抖动Cmd 
	 * @author xuwenyi
	 * @create-date 2015-9-16
	 */	
	public class ShakeEffectCmd extends BaseCmd {
		
		// 震动频率
		private var frequency:int;
		
		
		public function ShakeEffectCmd() {
			
			super();
		}
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			frequency = (xml.@frequency != undefined) ? xml.@frequency : 10;
		}
		
		
		override public function triggerCallBack(callBack:Function = null):void {
			
			super.triggerCallBack(callBack);
			
			ShakeEffect.instance.start(SXD2Main.inst.currentView, 5, frequency);
			
			complete();
		}
	}
}