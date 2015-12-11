package com.gamehero.sxd2.guide.script
{
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
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import bowser.logging.Logger;
	
	
	/**
	 * 第二场战斗引导,boss触发剧情并变身
	 * @author xuwenyi
	 * @create 2014-10-10
	 **/
	public class Guide_10015 extends Guide
	{
		private var player:BPlayer;
		private var drama1:int;
		private var drama2:int;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_10015()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 开始播放引导
		 * */
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 剧情id
			var dramas:Array = info.param3.split("^");
			drama1 = int(dramas[0]);
			drama2 = int(dramas[1]);
			
			// 触发剧情
			DramaManager.instance.playDramaById(drama1, null, next1);
		}
		
		
		
		
		/**
		 * 第一步
		 * */
		private function next1():void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			// 需要变身的角色
			var monsterID:String = guideInfo.param2;// monsterID
			
			// 找到触发角色
			var players:Array = dataCenter.getRole(GS_ClassStatus_Pro.MONSTER , monsterID);
			if(players.length > 0)
			{
				player = players[0];
			}
			else
			{
				Logger.error(BattleView , "新手引导找不到该伙伴 id = " + monsterID);
				//结束引导
				this.finish();
				return;
			}
			
			this.next2();
		}
		
		
		
		
		/**
		 * 变身
		 * */
		private function next2():void
		{
			// 聚气
			player.showJuqi(burst);
			
			// 变身效果
			function burst():void
			{
				var url:String = GameConfig.BATTLE_NEW_PLAYER_URL + "trans_honglong.swf";
				BattleEfCanvas.instance.playSwf(url,"EFFECT",player.x,player.y,1);
				
				setTimeout(transform , 1200);
			}
			
			
			// 变换模型
			function transform():void
			{
				var modelURL:String = "monster_xinshousiwangzhiyibianshen01_b";
				player.transform(next3 , modelURL);
			}
		}
		
		
		
		
		
		/**
		 * 再次播放剧情
		 * */
		private function next3():void
		{
			// 触发剧情
			DramaManager.instance.playDramaById(drama2, null, next4);
		}
		
		
		
		
		
		
		/**
		 * boss变身后释放技能
		 * */
		private function next4():void
		{
			var url:String = GameConfig.BATTLE_NEW_PLAYER_URL + "skill_honglong_sk.swf";
			// 定位
			var grid1:BattleGrid = BattleDataCenter.instance.grid1;
			var player:BPlayer = grid1.getPlayerByPos(2);
			BattleEfCanvas.instance.playSwf(url,"EFFECT",player.x,player.y,1);
			
			this.finish();
		}
		
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{
			player = null;
			drama1 = 0;
			drama2 = 0;
			
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