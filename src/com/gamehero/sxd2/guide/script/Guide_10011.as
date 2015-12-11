package com.gamehero.sxd2.guide.script
{
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.pro.GS_ClassStatus_Pro;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	
	/**
	 * 第二场战斗引导,敌我上阵
	 * @author xuwenyi
	 * @create 2014-10-10
	 **/
	public class Guide_10011 extends Guide
	{
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10011()
		{
			super();
		}
		
		
		
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			
			var players:Array;
			var player:BPlayer;
			var i:int;
			
			// 需要出现的伙伴
			var heros:Array = info.param2.split("^");
			for(i=0;i<heros.length;i++)
			{
				players = dataCenter.getRole(GS_ClassStatus_Pro.MONSTER , heros[i]);
				if(players && players.length > 0)
				{
					player = players[0];
					player.openingVisible = true;
					player.openingMove();
				}
			}
			
			setTimeout(finish , 1000);
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
			var battleView:BattleView = BattleDataCenter.instance.battleView;
			battleView.addEventListener(BattleEvent.BATTLE_END , onBattleEnd);
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