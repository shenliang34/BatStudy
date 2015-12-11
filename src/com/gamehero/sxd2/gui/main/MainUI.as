package com.gamehero.sxd2.gui.main {
    import com.gamehero.sxd2.data.GameData;
    import com.gamehero.sxd2.event.WindowEvent;
    import com.gamehero.sxd2.gui.chat.ChatView;
    import com.gamehero.sxd2.gui.main.coolingBar.CoolingBar;
    import com.gamehero.sxd2.gui.main.menuBar.MainMenuBar1;
    import com.gamehero.sxd2.gui.main.menuBar.MainMenuBar2;
    import com.gamehero.sxd2.gui.main.menuBar.MenuBar;
    import com.gamehero.sxd2.gui.notice.NoticeUI;
    import com.gamehero.sxd2.gui.npc.NpcWindow;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
    import com.gamehero.sxd2.manager.FunctionManager;
    import com.gamehero.sxd2.manager.JSManager;
    import com.gamehero.sxd2.world.model.MapConfig;
    import com.gamehero.sxd2.world.model.MapTypeDict;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.system.ApplicationDomain;
    import flash.text.TextField;
    
	
	
	
	/**
	 * 顶层UI 
	 * @author Trey
	 * @create-date 2013-8-8
	 */
	public class MainUI extends Sprite 
	{
		include "GMlogic.as";
		
		static private var _instance:MainUI;
		
		public var inited:Boolean = false;
		
		
		private var _uiResource:MovieClip;
		private var _uiResDomain:ApplicationDomain;
		// 左上角色头像面板
		public var leaderPanel:MainLeaderPanel;
		// 右上功能面板
		public var miniFuncPanel:MainMiniFuncPanel;
		//左下聊天
		public var chatView:ChatView;
		//右下经验
		public var expPanel:MainExpPanel;
		//右下菜单栏
		public var menuBar1:MenuBar;
		//右上菜单栏
		public var menuBar2:MenuBar;
		//左中功能入口菜单栏
		public var coolingBar:CoolingBar;
		//任务面板
		public var taskPanel:MainTaskPanel;
		//任务面板
		public var taskWindow:NpcWindow;
		//战斗力面板
		public var battlePanel:MainBattlePanel;
		
		private var _displayType:Object;
		
		/**
		 * 构造函数
		 */
		public function MainUI(singleton:Singleton)
		{
			this.addEventListener(Event.ADDED_TO_STAGE , init , false , -1);
		}

		/**
		 * Get Instancd
		 */
		public static function get inst():MainUI
		{	
			if(_instance == null)
			{	
				_instance = new MainUI(new Singleton());
			}
			
			return _instance;
		}
		
		/**
		 * Init 
		 */
		public function init(event:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		
			//测试代码
			var text:TextField = new TextField();
			text.selectable = false;
			text.width = 500;
			text.x = 100;
			text.y = 300;
//			addChild(text);
			var str:String =  "<TEXTFORMAT LEADING='3'><P ALIGN='LEFT'><FONT FACE='宋体' SIZE='12' COLOR='#F6E33F' LETTERSPACING='0' KERNING='0'><B>[公告]</B><FONT COLOR='#D7DEED'>恭喜<FONT COLOR='#949ED3'>钱卿塔</FONT>获得<FONT COLOR='#5FBE5C'>[<A HREF='event:item^16010003' TARGET=''><U>炎石</U></A>]</FONT>。</FONT></FONT>"
			text.htmlText = str;
			
			_uiResource = App.mainUIRes;
			_uiResDomain = _uiResource.loaderInfo.applicationDomain;
			
			/** Init Main UI */
			addChild(leaderPanel = MainLeaderPanel.inst);
			leaderPanel.init(_uiResDomain);
			
			addChild(expPanel = MainExpPanel.inst);
			expPanel.init(_uiResDomain);
			
			addChild(miniFuncPanel = MainMiniFuncPanel.inst);
			miniFuncPanel.init(_uiResDomain);
			
			addChild(chatView = ChatView.inst);
			chatView.init(_uiResDomain);
			
			addChild(taskPanel = MainTaskPanel.inst);
			taskPanel.init(_uiResDomain);
			
			addChild(taskWindow = NpcWindow.inst);
			taskWindow.init();
			taskWindow.visible = false;
			
			addChild(menuBar1 = new MainMenuBar1());
			addChild(menuBar2 = new MainMenuBar2());
			addChild(coolingBar = new CoolingBar());
			
			addChild(battlePanel = new MainBattlePanel());
			battlePanel.init(true,GameData.inst.playerInfo.power);
			
			
			// 初始化function数据
			FunctionManager.inst.initOpenFunction(GameData.inst.functions);
			GameData.inst.functions = null;
			
			inited = true;
			
			/** Register GM Command */
			CONFIG::DEBUG
			{
				if(JSManager.isDebug())
				{	
					registerGM();
				}
			}
			
			// Resize Event
			this.stage.addEventListener(Event.RESIZE, resize);
			this.resize();
		}
		
		/**
		 * 自适应
		 */
		public function resize(event:Event = null):void
		{
			var w:Number  = App.stage.stageWidth;
			var h:Number  = App.stage.stageHeight;
			var widthOffset:int; //宽的偏移量
			var heightOffset:int;//高的偏移量
			
			//最大尺寸
			if(w > MapConfig.STAGE_MAX_WIDTH) widthOffset = (w - MapConfig.STAGE_MAX_WIDTH)/2;
			if(h > MapConfig.STAGE_MAX_HEIGHT) heightOffset = (h - MapConfig.STAGE_MAX_HEIGHT)/2;
			
			var x:int  = widthOffset;
			var y:int  = heightOffset;

			//leader
			leaderPanel.x = x;
			leaderPanel.y = y;
			//chat
			if(this.contains(chatView))
			{
				chatView.x = x;
				chatView.y = h - 200 - heightOffset; //200为聊天框高度偏移
			}
			//miniFunction
			miniFuncPanel.x = w - miniFuncPanel.width - widthOffset - 6;
			miniFuncPanel.y = y + 3;
			//expPanel
			expPanel.x = w - expPanel.width - widthOffset;
			expPanel.y = h - expPanel.height - heightOffset;
			//menubar1
			menuBar1.x = w - menuBar1.width - 20 - widthOffset;
			menuBar1.y = h - 90;
			//menubar2
			menuBar2.x = w - menuBar2.width - miniFuncPanel.width - 40 - widthOffset;
			menuBar2.y = 0;
			
			coolingBar.x = 40 + widthOffset;
			coolingBar.y = 280;
			//task 以右上的功能窗口定位 宽高+偏移量
			taskPanel.x = miniFuncPanel.x; 
			taskPanel.y = miniFuncPanel.y + 180;
			//任务窗口
			/*
			taskWindow.width = 520;
			taskWindow.height = 310;
			*/
			taskWindow.x = w - 520 >> 1;
			taskWindow.y = h - 310 >> 1;
			
			battlePanel.x = w - 200 - widthOffset; 
			battlePanel.y = miniFuncPanel.y + miniFuncPanel.height + 20 - heightOffset;
		}		
		
		/**
		 * 设置主UI蓝底按钮
		 * */
		public function setActionBtnHandle(lab:String,btnX:int,btnY:int):*{
			var button:Button = new Button(MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_DOWN,MainSkin.MAINUI_BLUE_BTN_OVER,MainSkin.MAINUI_BLUE_BTN_DISABLED);
			button.label = lab;
			button.x = btnX;
			button.y = btnY;
			return button;
		}
		
		/**
		 * 聊天按钮的点击事件
		 * */
		private function chatBtnClickHandle(e:MouseEvent):void{
			
		}

		/**
		 * 打开某个窗口
		 * */
		public function openWindow(name:String , param:Object = null):void
		{
			var e:WindowEvent = new WindowEvent(WindowEvent.OPEN_WINDOW , name , param);
			
			this.dispatchEvent(e);
		}
		
		
		
		public function get displayType():Object
		{
			return _displayType;
		}
		
		/**
		 * MainUI上各组件显示状态
		 * */
		public function set displayType(type:Object):void
		{
			_displayType = type;
			switch(type)
			{
				case WindowEvent.ARENA_WINDOW:
					
					leaderPanel.visible = false;
					expPanel.visible = true;
					miniFuncPanel.visible = false;
					chatView.visible = true;
					taskPanel.visible = false;
					menuBar1.visible = true;
					menuBar2.visible = false;
					coolingBar.visible = false;
					battlePanel.visible = false;
					NoticeUI.inst.notiArea4.visible = true;
					break;
				case WindowEvent.ROLESKILL_VIEW:
					
					leaderPanel.visible = false;
					expPanel.visible = false;
					miniFuncPanel.visible = false;
					chatView.visible = true;
					taskPanel.visible = false;
					menuBar1.visible = false;
					menuBar2.visible = false;
					coolingBar.visible = true;
					battlePanel.visible = false;
					NoticeUI.inst.notiArea4.visible = true;
					break;
				case MapTypeDict.HURLDE_MAP:
				case MapTypeDict.FOG_LEVEL_MAP:
					leaderPanel.visible = true;
					expPanel.visible = true;
					miniFuncPanel.visible = true;
					chatView.visible = true;
					taskPanel.visible = true;
					menuBar1.visible = true;
					menuBar2.visible = false;
					coolingBar.visible = true;
					battlePanel.visible = true;
					
					NoticeUI.inst.notiArea4.visible = false;
					break;
				default:
					leaderPanel.visible = true;
					expPanel.visible = true;
					miniFuncPanel.visible = true;
					chatView.visible = true;
					taskPanel.visible = true;
					menuBar1.visible = true;
					menuBar2.visible = true;
					coolingBar.visible = true;
					battlePanel.visible = true;
					NoticeUI.inst.notiArea4.visible = true;
			}
		}
	}
}

class Singleton{}