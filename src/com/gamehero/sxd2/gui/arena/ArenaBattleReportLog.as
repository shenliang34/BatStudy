package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.PRO_ArenaLog;
	import com.gamehero.sxd2.util.Time;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import bowser.utils.time.TimeTick;
	
	
	/**
	 * 竞技场战报日志
	 * @author xuwenyi
	 * @create 2015-10-09
	 **/
	public class ArenaBattleReportLog extends Sprite
	{
		private var lb1:HtmlText;
		private var lb2:Label;
		private var timeLabel:Label;
		
		private var reportBtn:Button;
		private var copyBtn:Button;
		
		// 数据
		public var log:PRO_ArenaLog;
		
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaBattleReportLog()
		{
			lb1 = new HtmlText();
			lb1.x = 37;
			lb1.y = 8;
			lb1.width = 200;
			this.addChild(lb1);
			
			lb2 = new Label(false);
			lb2.x = 172;
			lb2.y = 12;
			lb2.width = 100;
			this.addChild(lb2);
			
			timeLabel = new Label(false);
			timeLabel.x = 41;
			timeLabel.y = 30;
			timeLabel.width = 100;
			timeLabel.color = GameDictionary.GRAY;
			this.addChild(timeLabel);
			
			reportBtn = new Button(CommonSkin.blueButton3Up , CommonSkin.blueButton3Down , CommonSkin.blueButton3Over);
			reportBtn.x = 256;
			reportBtn.y = 4;
			reportBtn.label = "查看";
			this.addChild(reportBtn);
			
			copyBtn = new Button(CommonSkin.blueButton3Up , CommonSkin.blueButton3Down , CommonSkin.blueButton3Over);
			copyBtn.x = 256;
			copyBtn.y = 26;
			copyBtn.label = "复制";
			this.addChild(copyBtn);
		}
		
		
		
		
		
		public function update(log:PRO_ArenaLog):void
		{
			this.log = log;
			
			lb1.text = "你挑战了" + GameDictionary.ORANGE_TAG2 + "<u>" + log.base.name + "</u>" + GameDictionary.COLOR_TAG_END2;
			
			if(log.win == true)
			{
				lb2.text = "你胜利了！";
				lb2.color = GameDictionary.GREEN;
			}
			else
			{
				lb2.text = "你失败了！";
				lb2.color = GameDictionary.GRAY;
			}
			
			timeLabel.text = Time.getStringTime8(int(TimeTick.inst.getCurrentTime()*0.001) - log.time);
			
			lb1.addEventListener(MouseEvent.CLICK , onLink);
			reportBtn.addEventListener(MouseEvent.CLICK , reportClick);
			copyBtn.addEventListener(MouseEvent.CLICK , copyClick);
		}
		
		
		
		
		/**
		 * 点击查看战报
		 * */
		private function reportClick(e:MouseEvent):void
		{
			if(log)
			{
				SXD2Main.inst.battleReport(log.battleReportId);
			}
		}
		
		
		
		
		/**
		 * 点击复制链接
		 * */
		private function copyClick(e:MouseEvent):void
		{
			
		}
		
		
		
		
		
		/**
		 * 文本链接点击
		 * */
		private function onLink(e:MouseEvent):void
		{
			var options:Array = [];
			options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , Lang.instance.trans(ChatData.ROLE_FILE)));
			MenuPanel.instance.initOptions(options);
			
			var paramObj:Object = new Object();
			paramObj.userID = log.base.id.toString();
			paramObj.username = log.base.name;
			
			MenuPanel.instance.show(paramObj , App.topUI);
		}
		
		
		
		
		
		public function clear():void
		{
			log = null;
			
			lb1.text = "";
			lb2.text = "";
			timeLabel.text = "";
			
			lb1.removeEventListener(MouseEvent.CLICK , onLink);
			reportBtn.removeEventListener(MouseEvent.CLICK , reportClick);
			copyBtn.removeEventListener(MouseEvent.CLICK , copyClick);
		}
	}
}