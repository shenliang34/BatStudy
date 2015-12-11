package com.gamehero.sxd2.guide.script
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	
	import flash.events.Event;
	
	
	/**
	 * 第二场战斗引导,单位1触发剧情
	 * @author xuwenyi
	 * @create 2014-10-10
	 **/
	public class Guide_10012 extends Guide
	{
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10012()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function = null , param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 触发剧情
			var dramaID:int = int(info.param3);
			DramaManager.instance.playDramaById(dramaID, null, finish);
		}
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{
			if(completecallBack)
			{
				completecallBack();
				completecallBack = null;
			}
			
			// 战斗结束才记录到服务器
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var battleView:BattleView = dataCenter.battleView;
			if(battleView)
			{
				battleView.addEventListener(BattleEvent.BATTLE_END , onBattleEnd);
			}
		}
		
		
		
		
		
		/**
		 * 战斗结束后才结束引导
		 * */
		protected function onBattleEnd(e:Event):void
		{
			e.currentTarget.removeEventListener(BattleEvent.BATTLE_END , onBattleEnd);
			// 完成引导
			this.guideCompleteHandler();
		}
		
	}
}