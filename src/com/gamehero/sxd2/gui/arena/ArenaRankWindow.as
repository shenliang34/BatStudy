package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.event.ArenaEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.List;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.MSG_RANKING_LIST_ACK;
	
	import flash.display.Bitmap;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.data.DataProvider;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 竞技场排行榜
	 * @author xuwenyi
	 * @create 2015-10-27
	 **/
	public class ArenaRankWindow extends GeneralWindow
	{
		public static var domain:ApplicationDomain;
		
		private var list:List;
		private var listData:DataProvider;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaRankWindow(position:int, resourceURL:String = "ArenaRankWindow.swf")
		{
			super(position, resourceURL, 396, 396);
		}
		
		
		
		
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(380, 339);
			innerBg.x = 8;
			innerBg.y = 39;
			this.addChild(innerBg);
			
			// 背景
			var bg:Bitmap = new Bitmap(this.getSwfBD("RANK_TITLE"));
			bg.x = 7;
			bg.y = 45;
			this.addChild(bg);
			
			// 战报记录
			list = new List();
			list.itemRenderer = ArenaRankLog;
			listData = new DataProvider();
			list.dataProvider = listData;
			list.x = 7;
			list.y = 75;
			list.resize(372, 300);
			addChild(list);
			
			domain = uiResDomain;
		}
		
		
		
		
		override public function onShow():void
		{
			super.onShow();
			
			// 请求获取竞技场排行榜数据
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_RANKING_LIST));
			
			/*var ack:MSG_RANKING_LIST_ACK = new MSG_RANKING_LIST_ACK();
			for(var i:int=0;i<15;i++)
			{
				var base:PRO_PlayerBase = new PRO_PlayerBase();
				base.id = new UInt64();
				base.name = "排行榜";
				base.level = 10;
				base.power = 100000;
				var player:PRO_Player = new PRO_Player();
				player.base = base;
				var rank:PRO_RankingInfo = new PRO_RankingInfo();
				rank.rank = i;
				rank.player = player;
				ack.infos.push(rank);
			}
			updateRankList(ack);*/
		}
		
		
		
		
		
		
		/**
		 * 更新排行榜数据 
		 */		
		public function updateRankList(ack:MSG_RANKING_LIST_ACK):void
		{
			listData.removeAll();
			
			var list:Array = ack.infos;
			for(var i:int=0; i < list.length; i++)
			{
				listData.addItem(list[i]);
			}
		}
		
		
		
		
		
		
		
		
		
		
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
		
		
		
		
		public function clear():void
		{
			listData.removeAll();
		}
	}
}