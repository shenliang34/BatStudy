package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.battle.BattleView;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleGrid;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.layer.BattleEfCanvas;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.event.BattleEvent;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.pro.GS_ClassStatus_Pro;
	
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import bowser.logging.Logger;
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 第1场战斗引导,援军上阵
	 * @author xuwenyi
	 * @create 2014-04-17
	 **/
	public class Guide_10002 extends Guide
	{
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10002()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			setTimeout(next1 , 500);
		}
		
		
		
		
		
		/**
		 * 出场
		 * */
		private function next1():void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			// 需要出现的伙伴
			var monsterID:String = guideInfo.param2;
			var players:Array = dataCenter.getRole(GS_ClassStatus_Pro.MONSTER , monsterID);
			if(players.length > 0)
			{
				for(var i:int=0;i<players.length;i++)
				{
					var player:BPlayer = players[i];
					player.openingVisible = true;
					player.openingMove();
				}
				setTimeout(next2 , 1000);
				
				Logger.debug(BattleView , "援军出场");
			}
			else
			{
				Logger.error(BattleView , "新手引导找不到该伙伴 id = " + monsterID);
				//结束引导
				this.finish();
			}
		}
		
		
		
		
		
		/**
		 * 出场后触发剧情
		 * */
		private function next2():void
		{
			// 显示防御链
			var battleView:BattleView = BattleDataCenter.instance.battleView;
			battleView.setBattleChainEnabled(1 , true);
			battleView.setBattleChainEnabled(2 , true);
			
			battleView.showBattleChain(1 , true);
			battleView.showBattleChain(2 , true);
			
			// 播放7宫格泛光特效
			var url:String = GameConfig.BATTLE_NEW_PLAYER_URL + "chain_light.swf";
			// 定位
			var grid1:BattleGrid = BattleDataCenter.instance.grid1;
			var pos1:Vector2D = grid1.CAMP_POS_S[6];// 7号位
			pos1 = pos1.add(grid1.offset);
			
			var grid2:BattleGrid = BattleDataCenter.instance.grid2;
			var pos2:Vector2D = grid2.CAMP_POS_S[6];// 7号位
			pos2 = pos2.add(grid2.offset);
			
			BattleEfCanvas.instance.playSwf(url,"EFFECT",pos1.x,pos1.y,1,BlendMode.ADD);
			BattleEfCanvas.instance.playSwf(url,"EFFECT",pos2.x,pos2.y,1,BlendMode.ADD);
			
			
			setTimeout(next3 , 1500);
		}
		
		
		
		
		
		/**
		 * 触发剧情
		 * */
		private function next3():void
		{
			// 触发剧情
			var dramaID:int = int(guideInfo.param3);
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