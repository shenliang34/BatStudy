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
	import com.gamehero.sxd2.manager.JSManager;
	import com.gamehero.sxd2.pro.PRO_BattleResult;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.enum.Align;
	
	
	/**
	 * 用于显示战斗录像的战报
	 * @author xuwenyi
	 * @create 2015-09-10
	 **/
	public class BattleReportWindow extends GameWindow
	{
		// 胜利描述
		private var winLabel:Label;
		
		// 确定按钮
		private var yesBtn:SButton;
		// 复制链接按钮
		private var copyBtn:SButton;
		// 回放按钮
		private var replayBtn:SButton;
		
		// 全屏透明层
		private var fullLayer:Shape;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleReportWindow(position:int, resourceURL:String = "BattleReportWindow.swf")
		{
			super(position, resourceURL, 286, 141);
			
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
			bg.x = 0;
			bg.y = 0;
			this.addChild(bg);
			
			// 全频透明层
			fullLayer = new Shape();
			this.addChild(fullLayer);
			
			// 大侠请重新来过
			var bmp:Bitmap = new Bitmap(global.getBD(uiResDomain , "WIN_LABEL_BG"));
			bmp.x = 59;
			bmp.y = 41;
			this.addChild(bmp);
			
			// 胜利描述文本
			winLabel = new Label(false);
			winLabel.x = 67;
			winLabel.y = 43;
			winLabel.width = 150;
			winLabel.align = Align.CENTER;
			this.addChild(winLabel);
			
			// 确定
			yesBtn = new SButton(global.getRes(uiResDomain , "YES") as SimpleButton);
			yesBtn.x = 102;
			yesBtn.y = 89;
			this.addChild(yesBtn);
			
			// 复制链接
			copyBtn = new SButton(global.getRes(uiResDomain , "COPY") as SimpleButton);
			copyBtn.x = 238;
			copyBtn.y = 95;
			copyBtn.hint = "复制链接";
			this.addChild(copyBtn);
			
			// 回放
			replayBtn = new SButton(global.getRes(uiResDomain , "REPLAY") as SimpleButton);
			replayBtn.x = 211;
			replayBtn.y = 95;
			replayBtn.hint = "重播";
			if(BattleDataCenter.instance.inGame == true)
			{
				this.addChild(replayBtn);
			}
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
			
			// 胜利失败描述
			var str:String;
			var leaderName:String = result.leaderName;
			str = GameDictionary.createCommonText(leaderName , GameDictionary.YELLOW);
			if(result.win == true)
			{
				str += GameDictionary.createCommonText("胜利了！");
			}
			else
			{
				str += GameDictionary.createCommonText("失败了！");
			}
			winLabel.text = str;
			
			yesBtn.addEventListener(MouseEvent.CLICK , quit);
			copyBtn.addEventListener(MouseEvent.CLICK , copyLink);
			replayBtn.addEventListener(MouseEvent.CLICK , replay);
			
			// 全屏透明层
			this.resize();
		}
		
		
		
		
		/**
		 * 点击复制链接
		 * */
		private function copyLink(e:MouseEvent):void
		{
			var url:String;
			// 游戏内逻辑
			if(BattleDataCenter.instance.inGame == true)
			{
				url = JSManager.getBrowserURL();
				url = url.replace("test.php" , "");
				var serverId:int = 1;
				url += "sxd2_video.php?zoneid=" + serverId + "&blid=" + LastBattleData.replayID.toNumber();
			}
			else
			{
				url = JSManager.getBrowserURL();
			}
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
		 * 点击确定退出
		 * */
		private function quit(e:MouseEvent = null):void
		{
			// 游戏内逻辑
			if(BattleDataCenter.instance.inGame == true)
			{
				this.dispatchEvent(new BattleEvent(BattleEvent.BATTLE_END));
				this.close();
			}
			else
			{
				JSManager.refreshGame();
			}
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
			yesBtn.removeEventListener(MouseEvent.CLICK , quit);
			copyBtn.removeEventListener(MouseEvent.CLICK , copyLink);
			replayBtn.removeEventListener(MouseEvent.CLICK , replay);
		}
	}
}