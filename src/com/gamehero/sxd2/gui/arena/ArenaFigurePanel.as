package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ArenaEvent;
	import com.gamehero.sxd2.event.CloseEvent;
	import com.gamehero.sxd2.gui.GlobalAlert;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK;
	import com.gamehero.sxd2.util.Time;
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import bowser.utils.time.TimeTick;
	import bowser.utils.time.TimeTickData;
	
	
	/**
	 * 竞技场对手人物显示面板
	 * @author xuwenyi
	 * @create 2015-09-30
	 **/
	public class ArenaFigurePanel extends Sprite
	{
		private var domain:ApplicationDomain;
		
		private var figure1:ArenaFigure;
		private var figure2:ArenaFigure;
		
		// 回合数
		private var round:Bitmap;
		// 剩余时间
		private var timeLabel:Label;
		private var tick:TimeTick;
		
		// 开始竞技按钮
		private var startBtn:SButton;
		// 购买门票
		private var buyBtn:SButton;
		
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaFigurePanel(domain:ApplicationDomain)
		{
			this.domain = domain;
			
			figure1 = new ArenaFigure();
			figure1.x = -230;
			figure1.y = 0;
			this.addChild(figure1);
			
			figure2 = new ArenaFigure();
			figure2.x = 230;
			figure2.y = 0;
			this.addChild(figure2);
			
			// 开始竞技按钮
			startBtn = new SButton(Global.instance.getRes(domain , "BIG_BTN") as SimpleButton);
			startBtn.x = -152;
			startBtn.y = -46;
			var bmp:Bitmap = new Bitmap(Global.instance.getBD(domain , "START_BATTLE"));
			bmp.x = 66;
			bmp.y = 17;
			startBtn.addChild(bmp);
			this.addChild(startBtn);
			
			// 购买门票按钮
			buyBtn = new SButton(Global.instance.getRes(domain , "BIG_BTN") as SimpleButton);
			buyBtn.x = -152;
			buyBtn.y = -46;
			bmp = new Bitmap(Global.instance.getBD(domain , "BUY_TICKET"));
			bmp.x = 66;
			bmp.y = 17;
			buyBtn.addChild(bmp);
			this.addChild(buyBtn);
			
			// 回合数
			round = new Bitmap();
			round.x = -121;
			round.y = -260;
			this.addChild(round);
			
			// 倒计时
			timeLabel = new Label(false);
			timeLabel.x = -60;
			timeLabel.y = -200;
			timeLabel.width = 200;
			timeLabel.color = GameDictionary.RED;
			this.addChild(timeLabel);
			
			tick = new TimeTick();
		}
		
		
		
		
		
		
		public function update(players:Array):void
		{
			var data:MSG_UPDATE_ARENA_ACK = ArenaModel.inst.data;
			// 剩余时间
			var remainTime:Number = data.endTime - int(TimeTick.inst.getCurrentTime()*0.001);
			
			startBtn.visible = false;
			buyBtn.visible = false;
			
			// 挑战时间还未结束
			if(remainTime > 0 && players.length > 0)
			{
				// 换人动画
				var CHANGE_FIGURE:Class = Global.instance.getClass(domain , "CHANGE_FIGURE");
				
				figure1.update(players[0] , DefaultFigureItem.RIGHT , CHANGE_FIGURE);
				figure2.update(players[1] , DefaultFigureItem.LEFT , CHANGE_FIGURE);
				
				// 回合数
				round.bitmapData = Global.instance.getBD(domain , "ROUND_" + data.round);
				
				tick.clear();
				tick.addListener(new TimeTickData(remainTime , 1000 , updateTime , endTime));
			}
			else
			{
				figure1.clear();
				figure2.clear();
				
				tick.clear();
				timeLabel.text = "";
				
				round.bitmapData = null;
				
				// 门票没了
				if(data.freeNum <= 0)
				{
					startBtn.visible = false;
					buyBtn.visible = true;
				}
				// 开始竞技
				else
				{
					startBtn.visible = true;
					buyBtn.visible = false;
				}
			}
			
			startBtn.addEventListener(MouseEvent.CLICK , startClick);
			buyBtn.addEventListener(MouseEvent.CLICK , buyClick);
		}
		
		
		
		
		
		
		/**
		 * 倒计时更新
		 * */
		private function updateTime(data:TimeTickData):void
		{
			timeLabel.text = "剩余时间：" + Time.getStringTime1(int(data.remainTime*0.001));
		}
		
		
		
		
		
		
		/**
		 * 倒计时结束
		 * */
		private function endTime(data:TimeTickData):void
		{
			timeLabel.text = "";
			
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_INFO));
		}
		
		
		
		
		
		
		/**
		 * 点击开始竞技
		 * */
		private function startClick(e:MouseEvent):void
		{
			this.dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_START_FIGHT));
		}
		
		
		
		
		
		
		/**
		 * 点击购买门票
		 * */
		private function buyClick(e:MouseEvent):void
		{
			var data:MSG_UPDATE_ARENA_ACK = ArenaModel.inst.data;
			var money:int = Math.pow(2 , data.ticketNum) * 20;
			
			if(GameData.inst.gameConfig["arenaBuyTicket"])
			{
				doBuy();
			}
			else
			{
				var str:String = "是否花费" + GameDictionary.createCommonText(money + "元宝",GameDictionary.ORANGE) + "，购买1次竞技场门票？";
				GlobalAlert.checkSelected = false;
				GlobalAlert.checkLabel = "下次不再提示";
				DialogManager.inst.show(str, GlobalAlert.OK|GlobalAlert.NO|GlobalAlert.CHECK, function(e:CloseEvent):void
				{
					// 点击确认
					if(e.detail == GlobalAlert.OK)
					{
						if(GlobalAlert.checkSelected)
						{
							GameProxy.inst.saveGameConfig("arenaBuyTicket",true);
						}
						doBuy();
					}
				},GlobalAlert.RED,null,250,145);
			}
			
			function doBuy():void
			{
				dispatchEvent(new ArenaEvent(ArenaEvent.ARENA_BUY_TICKET));
			}
		}
		
		
		
		
		
		
		
		public function clear():void
		{
			figure1.clear();
			figure2.clear();
			
			tick.clear();
			timeLabel.text = "";
			
			round.bitmapData = null;
			
			startBtn.removeEventListener(MouseEvent.CLICK , startClick);
			buyBtn.removeEventListener(MouseEvent.CLICK , buyClick);
		}
	}
}