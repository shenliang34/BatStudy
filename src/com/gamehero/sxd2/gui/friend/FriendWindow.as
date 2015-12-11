package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.gui.friend.ui.FriendItemObject;
	import com.gamehero.sxd2.gui.friend.ui.FriendSkin;
	import com.gamehero.sxd2.gui.friend.ui.PlayerIconButton;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.List;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.GTextTabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.TabPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.container.tabPanel.TabData;
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.data.DataProvider;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-17 下午3:30:28
	 * 
	 */
	public class FriendWindow extends GeneralWindow
	{ 
		private const WINDOW_WIDTH:int = 228;
		private const WINDOW_HEIGHT:int = 447;
		
		/**
		 * 自己头像
		 * */
		public var _playerIcon:PlayerIconButton;
		private var _nameLb:Label;
		private var _levelLb:Label;
		/**粉丝*/
		private var listenerHT:HtmlText;
		/**
		 * 关注按钮
		 * */
		private var _followsBtn:GTextButton;
		/**
		 * 当前列表关系
		 * */
		private var _relationType:int = 0;
		
		private static const FRIENDS:int = 0;//好友
		private static const CONTACTS:int = 1;//联系人
		private static const BLACK:int = 2;//黑名单
		/**
		 * 面板
		 * */
		private var _relationListPanel:SimplePanel;
		/**
		 * 列表
		 * */
		private var _relationList:List;
		private var _relationListDataProvider:DataProvider;
		
		public function FriendWindow(position:int, resourceURL:String = "FriendWindow.swf")
		{
			super(position,resourceURL,WINDOW_WIDTH,WINDOW_HEIGHT);
		}
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			FriendSkin.init(this.uiResDomain);
			this.init();
		}
		
		private function init():void
		{
			// 背景、装饰
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 11, 39, 206, 397);
			
			// 背景、装饰
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 11, 108, 206, 289);
			
			//头像
			_playerIcon = new PlayerIconButton();
			_playerIcon.x = 18;
			_playerIcon.y = 50;
			_playerIcon._iconImage.iconId = FriendModel.inst.myIconId;
//			add(_headIcon, 18,50,50,50);
			addChild(_playerIcon);
			_playerIcon.addEventListener(MouseEvent.CLICK,onClickPlayerIcon);
			
			//玩家名字
			_nameLb = new Label();
			_nameLb.color = GameDictionary.YELLOW;
			_nameLb.bold = true;
			_nameLb.text = GameData.inst.roleInfo.base.name;
			_nameLb.size = 14;
			add(_nameLb, 79, 49, 85);
			
			//等级
			_levelLb = new Label();
			_levelLb.color = GameDictionary.YELLOW;
			_levelLb.text = GameData.inst.roleInfo.base.level.toString();
			_levelLb.size = 14;
			add(_levelLb, 79, 66, 160);
			
			//听众
			listenerHT = new HtmlText();
			listenerHT.x = 80;
			listenerHT.y = 85;
			listenerHT.text = "<a href='event:myEvent'><u>"+GameDictionary.GREEN_TAG2+ "听众0人" + GameDictionary.COLOR_TAG_END2+"</u></a>";
			this.addChild(listenerHT);
			
			_followsBtn = new GTextButton(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			_followsBtn.label = "添加关注";
			_followsBtn.x = 74;
			_followsBtn.y = 400;
			this.addChild(_followsBtn);
			
			//列表
			_relationList = new List();
			_relationList.itemRenderer = FriendItemObject;
			
			_relationListDataProvider = new DataProvider();
			_relationList.dataProvider = _relationListDataProvider;
			
			_relationListPanel = new SimplePanel();
			_relationListPanel.padding = 5;
			_relationListPanel.content = _relationList;
			
			// Tab
			var tabPanel:TabPanel = new TabPanel(1);
			var tabButton:GTextTabButton;
			var bitmap: Bitmap;
			
			var tempW:int=50;
			var tempH:int = 36;
			
			var up:BitmapData = getSwfBD("Up");
			var down:BitmapData = getSwfBD("Down");
//			var over:BitmapData
			// 1、好友
			tabButton = new GTextTabButton(up, CommonSkin.blueButton2Down, CommonSkin.blueButton2Over);
			bitmap = new Bitmap();
			bitmap.bitmapData = this.getSwfBD("FriendList");
			tabButton.icon = bitmap;
			tabButton.resize(tempW,27);
			tabButton.name = "0";
			tabPanel.addTab(new TabData(tabButton, _relationListPanel));
			tabButton.addEventListener(MouseEvent.CLICK, onTabClickHandler);
			
			// 2、最近
			tabButton = new GTextTabButton(up, CommonSkin.blueButton2Down, CommonSkin.blueButton2Over);
			bitmap = new Bitmap();
			bitmap.bitmapData = this.getSwfBD("ContactList");
			tabButton.icon = bitmap;
			tabButton.resize(tempW,27);
			tabButton.name = "1";
			tabPanel.addTab(new TabData(tabButton, _relationListPanel));
			tabButton.addEventListener(MouseEvent.CLICK, onTabClickHandler);
			
			// 2、黑名单
			tabButton = new GTextTabButton(up, CommonSkin.blueButton2Down, CommonSkin.blueButton2Over);
			bitmap = new Bitmap();
			bitmap.bitmapData = this.getSwfBD("BlackList");
			tabButton.icon = bitmap;
			tabButton.resize(tempW,27);
			tabButton.name = "2";
			tabPanel.addTab(new TabData(tabButton, _relationListPanel));
			tabButton.addEventListener(MouseEvent.CLICK, onTabClickHandler);
			
			add(tabPanel, 12, 111, 150, 285);
			
			
		}
		
		protected function onClickPlayerIcon(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			event.preventDefault();
			
			event.stopPropagation();
			MainUI.inst.openWindow(WindowEvent.HEAD_PORTSIT_WINDOW);
		}
		
		public function removeFriend(data:Object):void
		{
			var index:int = _relationListDataProvider.getItemIndexByDoubleFiled("base","id",data.id);
			index!=-1 && _relationListDataProvider.removeItemAt(index);
		}
		
		
		override public function onShow():void
		{
			super.onShow();
			listenerHT.addEventListener(MouseEvent.CLICK,onFansClick);
			_followsBtn.addEventListener(MouseEvent.CLICK,onAddFriend);
			
			this.updateRelationList();
			
			dispatchEvent(new FriendEvent(FriendEvent.GET_FRIEND_LIST));
		}
		
		/**
		 * 更新关系列表 
		 * @param relationList
		 * 
		 */
		public function updateRelationList(relationListPro:* = null):void {
			// 先清空列表
			_relationListDataProvider.removeAll();
			//测试代码
			switch(_relationType)
			{
				case FRIENDS:
				{
					_relationListDataProvider.addItems(FriendModel.inst.friends);
					break;
				}
				case CONTACTS:
				{
					_relationListDataProvider.addItems(FriendModel.inst.contacts);
					break;
				}
				case BLACK:
				{
					_relationListDataProvider.addItems(FriendModel.inst.blacklist);
					break;
				}
				default:
				{
					_relationListDataProvider.addItems(FriendModel.inst.friends);
					break;
				}
			}
			
			_relationList.dataProvider = _relationListDataProvider;
			
			_playerIcon._iconImage.iconId = FriendModel.inst.myIconId;
			listenerHT.text = "<a href='event:myEvent'><u>"+GameDictionary.GREEN_TAG2+ "听众"+FriendModel.inst.listeners.length+"人" + GameDictionary.COLOR_TAG_END2+"</u></a>";
		}
		
		/**
		 * 粉丝列表
		 * */
		private function onFansClick(evt:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.MY_AUDIENCE_WINDOW);
		}
		
		/**
		 * 添加关注
		 * */
		private function onAddFriend(evt:MouseEvent):void
		{
			var addFriendView:AddFriendWindow = WindowManager.inst.getWindowInstance(AddFriendWindow,WindowPostion.CENTER_ONLY) as AddFriendWindow;
			WindowManager.inst.openWindow(AddFriendWindow,WindowPostion.CENTER_ONLY,true,true);
		}
		
		/**
		 * Tab Click Handler 
		 * @param event
		 * 
		 */
		private function onTabClickHandler(event:MouseEvent):void {
			if(_relationType == int(event.target.name))
				return;
			_relationType = int(event.target.name);
			getRelationList();
		}	
		
		/**
		 * 获得关系列表 
		 * 
		 */
		public function getRelationList():void {
			var data:Object = new Object();
			this.updateRelationList();
//			data.relationtype=_relationType;
//			data.pagenum = 0;
//			dispatchEvent(new RelationEvent(RelationEvent.GET_RELATION_LIST_E, data));
		}
		
		override public function close():void
		{
			listenerHT.removeEventListener(MouseEvent.CLICK,onFansClick);
			_followsBtn.removeEventListener(MouseEvent.CLICK,onAddFriend);
			WindowManager.inst.closeGeneralWindow(MyAudienceWindow);
			WindowManager.inst.closeGeneralWindow(HeadPortraitWindow);
			WindowManager.inst.closeGeneralWindow(AudienceTipBoxWindow);
			super.close();
		}
	}
}