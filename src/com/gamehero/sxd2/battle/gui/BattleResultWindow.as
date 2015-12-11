package com.gamehero.sxd2.battle.gui
{
    import com.gamehero.sxd2.battle.data.BattleDataCenter;
    import com.gamehero.sxd2.battle.data.BattleResult;
    import com.gamehero.sxd2.battle.data.LastBattleData;
    import com.gamehero.sxd2.core.Global;
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.event.BattleEvent;
    import com.gamehero.sxd2.gui.SButton;
    import com.gamehero.sxd2.gui.core.GameWindow;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.local.Lang;
    import com.gamehero.sxd2.manager.JSManager;
    import com.gamehero.sxd2.pro.PRO_BattleResult;
    
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
	
	
	/**
	 * 战报UI
	 * @author xuwenyi
	 * @create 2013-08-20
	 **/
	public class BattleResultWindow extends GameWindow
	{
		
		// 胜利面板
		private var winTitle:Bitmap;
		// 失败面板
		private var loseTitle:Bitmap;
		private var loseTips:Bitmap;
		// 经验金币面板
		private var numPanel:Sprite;
		
		// 经验,金币
		/*private var label1:Label;
		private var label2:Label;
		private var num1:SpecialBitmapNumber;
		private var num2:SpecialBitmapNumber;*/
		
		// 临时命魂
		private var soulLb:Label;
		
		// 确定按钮
		private var yesBtn:SButton;
		// 回放按钮
		private var replayBtn:SButton;
		// 分享战报
		private var noticeBtn:SButton;
		
		// 奖励物品itemcell
		/*private var drops:Array = [];
		// 功能列表
		private var funcList:Array = [];*/
		
		// 全屏透明层
		private var fullLayer:Shape;
		
		// 战斗结束计时器,一定时间不点击结算面板自动退出战斗
		private var endTimer:Timer;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleResultWindow(position:int, resourceURL:String = "BattleResultWindow.swf")
		{
			super(position, resourceURL, 550, 207);
			
			endTimer = new Timer(5000 , 1);
			
			// 加入移除场景时的事件
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		/**
		 * 加入场景
		 * */
		private function onAdd(e:Event):void
		{
			// 自适应
			stage.addEventListener(Event.RESIZE , resize);
		}
		
		
		
		
		
		/**
		 * 移除场景
		 * */
		private function onRemove(e:Event):void
		{
			// 自适应
			stage.removeEventListener(Event.RESIZE , resize);
		}
		
		
		
		
		
		/**
		 * 初始化窗口
		 * */
		override protected function initWindow():void 
		{
			super.initWindow();
			
			var global:Global = Global.instance;
			
			// 背景
			var bg:Bitmap = new Bitmap(global.getBD(uiResDomain , "BG"));
			bg.x = 93;
			bg.y = 27;
			this.addChild(bg);
			
			// 墨点
			var bg2:Bitmap = new Bitmap(global.getBD(uiResDomain , "BG2"));
			bg2.x = 0;
			bg2.y = 0;
			this.addChild(bg2);
			
			// 胜利
			winTitle = new Bitmap(global.getBD(uiResDomain , "WIN"));
			winTitle.x = 9;
			winTitle.y = 24;
			this.addChild(winTitle);
			
			// 失败
			loseTitle = new Bitmap(global.getBD(uiResDomain , "LOSE"));
			loseTitle.x = 9;
			loseTitle.y = 24;
			this.addChild(loseTitle);
			
			// 全频透明层
			fullLayer = new Shape();
			this.addChild(fullLayer);
			
			// 大侠请重新来过
			loseTips = new Bitmap(global.getBD(uiResDomain , "LOSE_TIPS"));
			loseTips.x = 207;
			loseTips.y = 73;
			this.addChild(loseTips);
			
			// 确定
			yesBtn = new SButton(global.getRes(uiResDomain , "YES") as SimpleButton);
			yesBtn.x = 267;
			yesBtn.y = 125;
			this.addChild(yesBtn);
			
			// 回放
			replayBtn = new SButton(global.getRes(uiResDomain , "REPLAY") as SimpleButton);
			replayBtn.x = 377;
			replayBtn.y = 127;
			replayBtn.hint = "重播";
			this.addChild(replayBtn);
			
			// 分享战报
			noticeBtn = new SButton(global.getRes(uiResDomain , "SYSTEM_LOG") as SimpleButton);
			noticeBtn.x = 406;
			noticeBtn.y = 127;
			noticeBtn.hint = "分享战报";
			this.addChild(noticeBtn);
			
			// 命魂
			soulLb = new Label(false);
			soulLb.width = 200;
			soulLb.height = 20;
			soulLb.x = 280;
			soulLb.y = 90;
			soulLb.text = "命魂*100";
			soulLb.visible = false;
			this.addChild(soulLb);
		}
		
		
		
		/**
		 * 显示
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			// 清空
			this.clear();
			
			// 战报数据
			var result:BattleResult = LastBattleData.battleResult;
			var resultData:PRO_BattleResult = result.battleResult;
			
			// 是否需要显示奖励内容的面板
			var needShowPanel:Boolean = false;
			
			// 胜利还是失败
			var titleBG:Bitmap;
			if(result.win == true)
			{
				winTitle.visible = true;
				loseTitle.visible = false;
				loseTips.visible = false;
				
				soulLb.visible = true;
			}
			else
			{
				winTitle.visible = false;
				loseTitle.visible = true;
				loseTips.visible = true;
				
				soulLb.visible = false;
			}
			
			yesBtn.addEventListener(MouseEvent.CLICK , quit);
			replayBtn.addEventListener(MouseEvent.CLICK , replay);
			noticeBtn.addEventListener(MouseEvent.CLICK , notice);
			
			// 战斗结束计时器
			endTimer.addEventListener(TimerEvent.TIMER_COMPLETE , onEndTimerHandler);
			endTimer.reset();
			endTimer.start();
			
			// 全屏透明层
			this.resize();
		}
		

		
		
		/**
		 * 点击复制链接
		 * */
		private function copyLink(e:MouseEvent):void
		{
			var url:String = JSManager.getBrowserURL();
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT , url , false);
		}
		
		
		
		
		/**
		 * 点击回放
		 * */
		private function replay(e:MouseEvent):void
		{
			this.dispatchEvent(new BattleEvent(BattleEvent.BATTLE_REPLAY));
			
			this.close();
		}
		
		
		
		
		
		/**
		 * 分享战报
		 * */
		private function notice(e:MouseEvent):void
		{
			var content:String = Lang.instance.trans("10001");
			content = content.replace("{user}" , BattleDataCenter.instance.leader.name);
			content = content.replace("{battlename}" , BattleDataCenter.instance.battleName);
			content = "<font color='#35e612'>" + content + GameDictionary.COLOR_TAG_END2;
			
			var chatView:Object = BattleDataCenter.instance.chatView;
			chatView.showBattleHandle(LastBattleData.replayID.toString() , content);
		}
		
		
		
		
		
		/**
		 * 点击确定退出
		 * */
		private function quit(e:MouseEvent = null):void
		{
			this.dispatchEvent(new BattleEvent(BattleEvent.BATTLE_END));
			
			this.close();
		}
		
		
		
		
		
		/**
		 * 战斗结束计时器处理
		 * */
		private function onEndTimerHandler(e:TimerEvent):void
		{
			this.quit();
		}
		
		
		
		
		
		/**
		 * 浏览器缩放
		 * */
		private function resize(e:Event = null):void
		{
			fullLayer.x = -x;
			fullLayer.y = -y;
			
			fullLayer.graphics.clear();
			fullLayer.graphics.beginFill(0,0);
			fullLayer.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			fullLayer.graphics.endFill();
		}
		
		
		
		
		
		/**
		 * 关闭窗口
		 * */
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			// 所有物品清空不可见
			/*for(var i:int=0;i<drops.length;i++)
			{
				var drop:BattleDrop = drops[i];
				drop.clear();
				drop.visible = false;
			}
			
			// 移除所有引导按钮
			for(i=0;i<funcList.length;i++)
			{
				var vo:WantStrVO = funcList[i];
				var menuBtn:DisplayObject = vo.menuBtn;
				if(this.contains(menuBtn) == true)
				{
					menuBtn.removeEventListener(MouseEvent.CLICK , onGuideClick);
					this.removeChild(menuBtn);
				}
			}*/
			
			yesBtn.removeEventListener(MouseEvent.CLICK , quit);
			replayBtn.removeEventListener(MouseEvent.CLICK , replay);
			noticeBtn.removeEventListener(MouseEvent.CLICK , notice);
			
			endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE , onEndTimerHandler);
			endTimer.stop();
		}
		
	}
}