package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.PRO_ArenaLog;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_RankingInfo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * 竞技场排行榜其中一条
	 * @author xuwenyi
	 * @create 2015-10-27
	 **/
	public class ArenaRankLog extends ListItemObject
	{
		private var lb1:Label;
		private var lb2:HtmlText;
		private var lb3:Label;
		private var lb4:Label;
		private var lb5:Label;
		
		private var bg:Bitmap;
		
		
		// 数据
		public var log:PRO_ArenaLog;
		
		public function ArenaRankLog()
		{
			bg = new Bitmap();
			this.addChild(bg);
			
			lb1 = new Label(false);
			lb1.x = 24;
			lb1.y = 9;
			lb1.width = 50;
			lb1.color = GameDictionary.ORANGE;
			this.addChild(lb1);
			
			lb2 = new HtmlText();
			lb2.x = 72;
			lb2.y = 6;
			lb2.width = 200;
			this.addChild(lb2);
			
			lb3 = new Label(false);
			lb3.x = 157;
			lb3.y = 9;
			lb3.width = 100;
			lb3.color = GameDictionary.ORANGE;
			this.addChild(lb3);
			
			lb4 = new Label(false);
			lb4.x = 215;
			lb4.y = 9;
			lb4.width = 100;
			lb4.color = GameDictionary.GRAY;
			this.addChild(lb4);
			
			lb5 = new Label(false);
			lb5.x = 282;
			lb5.y = 9;
			lb5.width = 100;
			lb5.color = GameDictionary.GRAY;
			this.addChild(lb5);
		}
		
		
		
		
		
		private function onRemove(e:Event):void
		{
			lb2.removeEventListener(MouseEvent.CLICK, popMenu);
			this.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		
		override public function set data(value:Object):void
		{
			_data = value;
			
			if(value)
			{
				var base:PRO_PlayerBase = value.player.base;
				lb1.text = value.rank + "";
				lb2.text = "<u>" + base.name + "</u>";
				lb3.text = "Lv" + base.level;
				lb4.text = base.power + "";
				lb5.text = "";
				
				//背景区分单双数
				if(value.rank % 2 == 0)
				{
					bg.bitmapData = Global.instance.getBD(ArenaRankWindow.domain , "BAR1");
				}
				else
				{
					bg.bitmapData = Global.instance.getBD(ArenaRankWindow.domain , "BAR2");
				}
				
				lb2.addEventListener(MouseEvent.CLICK, popMenu);
				this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
			}
		}
		
		
		
		
		
		
		
		private function popMenu(e:MouseEvent):void
		{
			if(_data)
			{
				var base:PRO_PlayerBase = PRO_RankingInfo(_data).player.base;
				
				var options:Array = [];
				options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , Lang.instance.trans(ChatData.ROLE_FILE)));
				MenuPanel.instance.initOptions(options);
				
				var paramObj:Object = new Object();
				paramObj.userID = base.id.toString();
				paramObj.username = base.name;
				
				MenuPanel.instance.show(paramObj , App.topUI);
			}
		}
		
		
		
		
		
		
		
		override public function get height():Number
		{
			return 30;
		}
		
	}
}