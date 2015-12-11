package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.ChatScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.gui.tips.ItemTipsManager;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSG_CHAT_NOTICE_ACK;
	import com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK;
	import com.gamehero.sxd2.pro.MSG_CHAT_SEND_REQ;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.netease.protobuf.UInt64;
	import com.riaidea.text.RichTextField;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import bowser.remote.RemoteResponse;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 聊天表情面板
	 * @author zhangxueyou
	 * @create 2015-7-28
	 **/
	public class ChatView extends Sprite
	{
		private static var _instance:ChatView;//聊天面板单例对象
		private var global:Global;//全局对象
		private var inputText:RichTextField;//聊天输入对象
		private var format:TextFormat;//字体样式
		private var outputPanel:ChatScrollPane;//聊天输出面板对象
		private var output:RichTextField;//聊天输出对象
		private var outputBG:ScaleBitmap;//聊天输出背景框
		private var faceBtn:Button; //表情按钮
		private var expressionPanel:ChatExpressionPanel; //表情面板
		private var chatMc:MovieClip;//聊天面板名称
		private var chatWorldList:Array = [];//世界频道数据源
		private var chatFamilyList:Array = [];//帮派频道数据源
		private var chatSystemList:Array = [];//公告频道数据源
		private var currentChannel:int;//默认频道
		private var currentChatList:Array = [];//默认数据源
		private var currentSendTimer:int; //上一条聊天信息发送事件
		private var currentPlanelSize:int = 1; //当时面板尺寸
		private var currentCharsNum:int; //当前输入字数
		private var userNameWidth:int; //玩家名字宽度 用来判断输出换行
		private var checkedBtn:Button;//频道选中按钮
		private var chatRedPoint:Bitmap; //聊天提示红点
		private var unreadChannel:Array = []; //记录未读频道数据
		private var errorCodeList:XMLList; //错误提示配置xml
		private var itemTips:ChatItemTips; //显示tips对象
		private var WORLD:String;   //世界
		private var FAMILY:String;  //帮派
		private var SYSTEM:String;  //系统
		private var TOOLTIP:String; //提示
		private var chatPaneUpBtn:Button;//向上btn
		private var chatPaneDownBtn:Button;//向下Btn
		/**
		 * 构造函数
		 * */
		public function ChatView()
		{	
		}
		
		/**
		 * 初始化UI
		 * */
		public function init(domain:ApplicationDomain):void
		{
			ChatData.mainDomain = domain; //获取资源作用域
			
			global = Global.instance; //获取全局变量
			
			currentChannel = ChatData.WORLD;//默认设置频道为世界
			
			currentChatList = chatWorldList;//默认设置数据源为世界list
			
			initLanguage();
			
			chatMc = global.getRes(domain,"chatView") as MovieClip;//获取聊天mc 
			
			addChild(chatMc);//添加聊天mc到舞台
			
			initOutPutUIHandle();//初始化输出UI
			
			initInputUIHandle();//初始化输入UI
			
			initExpressionUIHandle();//初始化表情面板
			
			initBtnUIHandle();//初始化按钮UI
			
			initNameWidthHadnle()//获取玩家名字宽度 用来判断换行
			
			//添加面板移入移出事件
			this.addEventListener(MouseEvent.MOUSE_OVER,chatPanelMouseOverHandle); 
			this.addEventListener(MouseEvent.MOUSE_OUT,chatPanelMouseOutHandle);  
			
			initErrorCodeListHandle(); //初始化聊天错误提示信息
			
		}
		
		/**
		 * 初始化配置表
		 * */
		private function initLanguage():void
		{
			WORLD = Lang.instance.trans(ChatData.CHAT_WORLD);
			FAMILY = Lang.instance.trans(ChatData.CHAT_FAMILY);
			SYSTEM = Lang.instance.trans(ChatData.CHAT_SYSTEM);
			TOOLTIP = Lang.instance.trans(ChatData.CHAT_TOOLTIP);
		}
		
		/**
		 * 初始化输出UI
		 * */
		private function initOutPutUIHandle():void
		{
			// 输出框背景
			outputBG = new ScaleBitmap(ChatSkin.CHAT_OUTPUT_BG_BD);
			outputBG.scale9Grid = new Rectangle(0, 0, ChatData.SMALLCHATOUTPUTBG.width, ChatData.SMALLCHATOUTPUTBG.height);
			outputBG.setSize(ChatData.SMALLCHATOUTPUTBG.width, ChatData.SMALLCHATOUTPUTBG.height); 
			outputBG.x = ChatData.SMALLCHATOUTPUTBG.x;
			outputBG.y = ChatData.SMALLCHATOUTPUTBG.y;
			outputBG.alpha = 0; //初始化透明度为0
			this.addChildAt(outputBG,0); //添加到最底层
			
			
			
			//带滚动条的聊天面板 滚动条居左
			outputPanel = new ChatScrollPane("left");
			outputPanel.width = ChatData.SMALLCHATOUTPUTPANEL.width;
			outputPanel.height = ChatData.SMALLCHATOUTPUTPANEL.height;
			outputPanel.x = ChatData.SMALLCHATOUTPUTPANEL.x;
			outputPanel.y = ChatData.SMALLCHATOUTPUTPANEL.y;
			this.addChild(outputPanel);
			
			//输出文本样式
			var outputFormat:TextFormat = new TextFormat();
			outputFormat.leading = 3;
			outputFormat.color=GameDictionary.CHAT_DETAILS;
			
			//输出文本对象
			output = new RichTextField();
			output.setSize(ChatData.SMALLCHATOUTPUT.width,ChatData.SMALLCHATOUTPUT.height); 
			output.x = ChatData.SMALLCHATOUTPUT.x;
			output.type = TextFieldType.DYNAMIC;
			output.textfield.selectable = false; 
			output.html = true;
			output.domain = ChatData.mainDomain;
			output.y = ChatData.SMALLCHATOUTPUT.y;
			//			output.lineHeight = 15; 
			output.defaultTextFormat = outputFormat;
//			output.textfield.mouseWheelEnabled = true; 
			output.textfield.addEventListener(TextEvent.LINK, textLinkClickHandle); 
			//			output.placeholderMarginH = -5; //表情水平间距
			outputPanel.content = output;
			
			// 物品tips
			itemTips = new ChatItemTips();
			this.addChild(itemTips);
		}
		
		/**
		 * 根据输出框的宽度手动添加/n换行
		 * */
		private function outputTextChangeHandle():void
		{
			var inputStr:String = inputText.textfield.text;
			var addLen:int = 0;
			var maxLength:int = 190 - userNameWidth;//220为显示宽度 显示宽度减去玩家名字宽度
			for(var i:int = 0;i<inputStr.length;i++)
			{
				/*
				if(inputText.isSpriteAt(i))
				{
				if(inputText.getSprite(i) != null)
				{
				addLen += inputText.getSprite(i).width;
				}
				}
				*/
				if(inputText.textfield.getCharBoundaries(i) != null)
				{
					var inputWidth:int = inputText.textfield.getCharBoundaries(i).width;
					addLen += inputWidth
				}
				else
				{
					addLen += getCharWidthHandle(inputStr.substr(i,1));
				}
				
				if(addLen > maxLength)
				{
					getCharWidthHandle(inputStr);
					var ss:String = inputStr.charAt(i-1) + "\n";
					inputText.replace(i-1,i,ss);//在指定位置插入换行
					addLen = 0;//初始化
					maxLength = 270; //270为显示宽度 第二行开始 去掉名字的宽度
					inputText.caretIndex = inputText.textfield.length;
				}
			}
		}
		
		/**
		 * 获取字符串宽度
		 * */
		private function getCharWidthHandle(str:String):int{
			var strText:TextField = new TextField();
			strText.text = str;
			var strWidth:int;
			for(var i:int;i<str.length;i++){
				if(strText.getCharBoundaries(i) != null)
				{
					strWidth += strText.getCharBoundaries(i).width;
				}
			}
			return strWidth;
		}
		
		/**
		 * 获取玩家名字宽度
		 * */
		private function initNameWidthHadnle():void{
			var nameStr:String = GameData.inst.playerInfo.name;
			var nameText:TextField = new TextField();
			nameText.text = nameStr;
			var nameWidth:int;
			for(var i:int;i<nameStr.length;i++){
				nameWidth += nameText.getCharBoundaries(i).width;
			}
			userNameWidth = nameWidth;
		}
		
		/**
		 * 初始化输入UI
		 * */
		private function initInputUIHandle():void
		{
			// 输入文本框
			format = new TextFormat();
			format.color = GameDictionary.WHITE;
			format.size = 12;
			inputText = new RichTextField();
			inputText.setSize(ChatData.INPUTPANEL.width,ChatData.INPUTPANEL.height);
			inputText.x = ChatData.INPUTPANEL.x;
			inputText.y = ChatData.INPUTPANEL.y;
			inputText.type = TextFieldType.INPUT;
			inputText.textfield.maxChars = ChatData.INPUTMAXCHARS;
			inputText.textfield.multiline = true;
			inputText.textfield.wordWrap = true;
			inputText.defaultTextFormat = format;
			inputText.addEventListener(KeyboardEvent.KEY_DOWN, inputEnterHandle);
			inputText.addEventListener(Event.CHANGE,inputTextChangeHandle);
			this.addChild(inputText);
		}
		
		/**
		 * 表情算作输入字符 判断输入长度
		 * 暂不需要
		 * 
		 
		 private function inputTextChangeHandle(e:Event):void{
		 checkInputTextLengthHandle();
		 }
		 
		 private function checkInputTextLengthHandle():Boolean{
		 currentCharsNum = inputText.text.length + inputText.numSprites;
		 
		 if(currentCharsNum >= inputText.textfield.maxChars){
		 return true;
		 }
		 return false;
		 }
		 */
		
		/**
		 * 聊天按钮初始化 
		 * 添加按钮和按钮的点击事件
		 * */
		private function initBtnUIHandle():void
		{
			//发送按钮 
			var sendBtn:Button = new Button(ChatSkin.ENTERBTN_UP,ChatSkin.ENTERBTN_DOWN,ChatSkin.ENTERBTN_OVER);
			sendBtn.x = 256;
			sendBtn.y = 174;
			addChild(sendBtn);
			sendBtn.addEventListener(MouseEvent.CLICK,sendBtnClickHandle);
			//输出面板向上按钮 
			chatPaneUpBtn = new Button(ChatSkin.UPBTN_UP,ChatSkin.UPBTN_DOWN,ChatSkin.UPBTN_OVER);
			chatPaneUpBtn.x = 240;
			chatPaneUpBtn.y = 148;
			addChild(chatPaneUpBtn);
			chatPaneUpBtn.name = "chatPaneUpBtn";
			chatPaneUpBtn.addEventListener(MouseEvent.CLICK,chatOutputPanelSize);
			//输出面板向下按钮 
			chatPaneDownBtn = new Button(ChatSkin.DOWNBTN_UP,ChatSkin.DOWNBTN_DOWN,ChatSkin.DOWNBTN_OVER);
			chatPaneDownBtn.x = 270;
			chatPaneDownBtn.y = 148;
			addChild(chatPaneDownBtn);
			chatPaneDownBtn.name = "chatPaneDownBtn";
			chatPaneDownBtn.addEventListener(MouseEvent.CLICK,chatOutputPanelSize);
			//世界按钮 
			addChild(setActionBtnHandle(WORLD,2,148)).addEventListener(MouseEvent.CLICK,channelBtnClickHandle);
			//帮派按钮 
			//			addChild(setActionBtnHandle(FAMILY,47,148)).addEventListener(MouseEvent.CLICK,channelBtnClickHandle);
			//公告 
			//			addChild(setActionBtnHandle(SYSTEM,92,148)).addEventListener(MouseEvent.CLICK,channelBtnClickHandle);
			//默认世界被选中
			checkedBtn = setSelectActionBtnHandle(WORLD,2,148);
			addChild(checkedBtn);
			checkedBtn.addEventListener(MouseEvent.CLICK,channelBtnClickHandle);
			//提示红点
			chatRedPoint = new Bitmap(ChatSkin.CHAT_REDPOINT);
		}
		
		/**
		 * 频道按钮点击事件
		 * */
		private function channelBtnClickHandle(e:MouseEvent):void
		{
			
			var btn:Button = e.currentTarget as Button;
			var lab:String = e.currentTarget.label;
			var channel:int;
			switch(lab)
			{
				case WORLD:
				{
					channel = ChatData.WORLD
					currentChatList = chatWorldList;
					break;
				}
				case FAMILY:
				{
					channel = ChatData.FAMILY
					currentChatList = chatFamilyList;
					break;
				}
				case SYSTEM:
				{
					channel = ChatData.SYSTEM
					currentChatList = chatSystemList;
					break;
				}
			}
			
			if(channel != currentChannel || currentPlanelSize < 1){
				checkedBtn.removeEventListener(MouseEvent.CLICK,channelBtnClickHandle);
				removeChild(checkedBtn);
				checkedBtn = setSelectActionBtnHandle(lab,btn.x,btn.y);
				addChild(checkedBtn);
				checkedBtn.addEventListener(MouseEvent.CLICK,channelBtnClickHandle);
				setUnreadChannelHandle(channel);
				setOutputInfo(channel);
			}
		}
		
		/**
		 * 设置常态按钮
		 * */
		private function setActionBtnHandle(lab:String,btnX:int,btnY:int):*{
			var button:Button = new Button(MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_SELECT_UP,MainSkin.MAINUI_BLUE_BTN_OVER,MainSkin.MAINUI_BLUE_BTN_DISABLED);
			button.label = lab;
			button.x = btnX;
			button.y = btnY;
			return button;
		}
		
		/**
		 * 设置选中按钮
		 * */
		private function setSelectActionBtnHandle(lab:String,btnX:int,btnY:int):*{
			var button:Button = new Button(MainSkin.MAINUI_BLUE_BTN_SELECT_UP,MainSkin.MAINUI_BLUE_BTN_SELECT_DOWN,MainSkin.MAINUI_BLUE_BTN_SELECT_OVER,MainSkin.MAINUI_BLUE_BTN_DISABLED);
			button.label = lab;
			button.x = btnX;
			button.y = btnY;
			return button;
		}
		
		/**
		 * 初始化output面板数据
		 * */
		private function setOutputInfo(channel:int):void
		{
			output.clear();
			
			currentChannel = channel;
			var len:int = currentChatList.length;
			if(len != 0)
			{
				var i:int = 0;
				for(i;i<len;i++){
					var type:int;
					if(currentChatList[i] is MSG_CHAT_NOTICE_ACK)
						type = ChatData.SYSTEM;
					else
						type = currentChannel;
					
					var messageXml:XML = ChatFormat.getMessage(type,currentChatList[i]).xml;
					output.importXML(messageXml);
				}
			}
			
			output.autoScroll = true;
			outputPanel.refresh();
		}
		
		/**
		 * 初始化表情UI
		 * */
		private function initExpressionUIHandle():void
		{
			faceBtn = new Button(new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_UP"))() , new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_DOWN"))() , new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_OVER"))());
			faceBtn.x = ChatData.FACEBTN.x;
			faceBtn.y = ChatData.FACEBTN.y;
			faceBtn.addEventListener(MouseEvent.CLICK , facesbtnMouseClickHanlde);
			this.addChild(faceBtn);
			
			// 表情面板
			expressionPanel = new ChatExpressionPanel();
			expressionPanel.x = ChatData.EXPRESSIONPANEL.x;
			expressionPanel.y = ChatData.EXPRESSIONPANEL.y;
			expressionPanel.visible = false;
			expressionPanel.addEventListener(ChatEvent.FACE_SELECT , faceSelectdHandle);
			this.addChild(expressionPanel);
		}
		
		/**
		 * 选择表情后的响应
		 * */
		private function faceSelectdHandle(e:ChatEvent):void
		{
			// 隐藏表情面板
			expressionPanel.visible = false;
			
			if(inputText.numSprites > 7)
			{
				var str:String = "输入表情不能超过8个"
				chatToolTipHandle(str);
				return; //暂定最多添加8个表情
			}
			
			//			if(checkInputTextLengthHandle()) return;  //判断输入框长度达到最大 不再添加
			
			// 表情mc类名
			var classname:String = e.data as String;
			// 输入框加入表情
			var face:MovieClip = Global.instance.getRes(ChatData.mainDomain , classname) as MovieClip;
			inputText.insertSprite(face , inputText.caretIndex);
			// 索引+1
			if(inputText.isSpriteAt(inputText.caretIndex))
			{				
				inputText.caretIndex++;
			}
			
			//焦点
			inputText.y = 173; //添加表情后 位置上移
			
			stage.focus = inputText.textfield;
			
		}
		
		/**
		 * 如果输入框没有表情 位置初始化 
		 */
		private function inputTextChangeHandle(e:Event):void{
			if(!inputText.numSprites)
			{
				inputText.y = ChatData.INPUTPANEL.y
			}
		}
		
		/**
		 * 表情开关Handler 
		 */
		private function facesbtnMouseClickHanlde(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			// 开关表情面板
			expressionPanel.visible = !expressionPanel.visible;
		}
		
		/**
		 * 发送按钮点击事件
		 * */
		private function sendBtnClickHandle(e:MouseEvent):void
		{
			sendChatHandle();
		}
		
		/**
		 * 文本框回车事件
		 * */
		private function inputEnterHandle(e:KeyboardEvent):void
		{	
			if(e.keyCode == Keyboard.ENTER)
			{
				sendChatHandle();
				
			}
		}
		
		/**
		 * 显示道具
		 * */
		public function chatShowItemTipsHandle(pro_item:PRO_Item):void{
			var itemId:int = pro_item.itemId;
			var item:PropBaseVo = ItemManager.instance.getPropById(itemId);
			var text:RichTextField = new RichTextField();
			text.text = "item^" + item.name + "^" +  itemId;
			
			var messageXML:XML = text.exportXML();
			var chatReq:MSG_CHAT_SEND_REQ = new MSG_CHAT_SEND_REQ();
			chatReq.message = messageXML;
			chatReq.channel = currentChannel;
			chatReq.data = pro_item;
			this.dispatchEvent(new ChatEvent(ChatEvent.CHAT , chatReq));
		}
		
		/**
		 * 隐藏道具
		 * */
		public function chatHideItemHandle():void{
			itemTips.visible = false;
		}
		
		/**
		 * 聊天发送事件
		 * */
		public function sendChatHandle():void
		{
			
			
			
			//输入框无内容 并且 无表情
			//inputText.text == "" && 
			var text:String = inputText.text;
			if(text.replace(/\r*\s*/gi , "") == "" && !inputText.numSprites){
				chatToolTipHandle(getErrorTipsHandle(30008));//30008空信息
			}
			else if(text.indexOf("@") != -1)
			{
				this.dispatchEvent(new MainEvent(MainEvent.GM , text));
				inputText.clear();
			}
			else if(getTimer() - currentSendTimer > ChatData.SENGGAP || !currentSendTimer){
				outputTextChangeHandle();
				var messageXML:XML = inputText.exportXML();
				var chatReq:MSG_CHAT_SEND_REQ = new MSG_CHAT_SEND_REQ();
				chatReq.message = messageXML;
				chatReq.channel = currentChannel;
				this.dispatchEvent(new ChatEvent(ChatEvent.CHAT , chatReq));
				
				inputText.clear();
				inputText.y = ChatData.INPUTPANEL.y;
				stage.focus = inputText.textfield;
				currentSendTimer = getTimer();
				currentCharsNum = 0;
			}
			else
			{
				//不满足时间间隔
				chatToolTipHandle(getErrorTipsHandle(30009));//30009间隔时间不满足
			}
		}
		
		/**
		 * 聊天发送提示信息
		 * */
		private function chatToolTipHandle(errorStr:String):void
		{
			var chatAck:MSG_CHAT_NOTIFY_ACK = new MSG_CHAT_NOTIFY_ACK();
			chatAck.senderName = "";
			inputText.text = errorStr;
			var messageXML:XML = inputText.exportXML();
			chatAck.message = messageXML;
			chatAck.channel = ChatData.TOOLTIP;
			inputText.clear();
			var messageXml:XML = ChatFormat.getMessage(ChatData.TOOLTIP,chatAck).xml;
			output.importXML(messageXml);
			
			output.autoScroll = true;
			outputPanel.refresh();
		}
		/**
		 * 聊天发送事件返回
		 * */
		public function sendChatCallbackHandle(obj:Object):void{
			var respones:RemoteResponse = obj as RemoteResponse;
			if(respones.errcode != "0") chatToolTipHandle(getErrorTipsHandle(int(respones.errcode)));
		}
		
		/**
		 * 聊天接收事件
		 * */
		public function receiveChatHandle(obj:Object):void
		{
			var respones:RemoteResponse = obj as RemoteResponse;
			var chatVo:MSG_CHAT_NOTIFY_ACK = new MSG_CHAT_NOTIFY_ACK();
			chatVo.mergeFrom(respones.protoBytes);
			
			switch(chatVo.channel)
			{
				case ChatData.WORLD:
				{
					chatWorldList.push(chatVo);
					if(chatWorldList.length > ChatData.OUTPUTMAXLINE) chatWorldList.shift();
					break;
				}
				case ChatData.FAMILY:
				{
					chatFamilyList.push(chatVo);
					if(chatFamilyList.length > ChatData.OUTPUTMAXLINE) chatWorldList.shift();
					break;
				}
			}
			if(chatVo.channel == currentChannel && currentPlanelSize > 0)
			{
				var messageXml:XML = ChatFormat.getMessage(currentChannel,chatVo).xml;
				output.importXML(messageXml);
				
				output.autoScroll = true;
				outputPanel.refresh();
			}
			else{
				if(getUnreadChannel(chatVo.channel)){
					var bitmap:Bitmap = new Bitmap(chatRedPoint.bitmapData);
					switch(chatVo.channel)
					{
						case 1:
						{
							bitmap.x = 34; 
							break;
						}
						case 2:
						{
							bitmap.x = 79; 
							break;
						}
						case 3:
						{
							bitmap.x = 124; 
							break;
						}
					}
					bitmap.y = 145;
					this.addChild(bitmap);
					
					var tipsObj:Object = new Object();
					tipsObj.bitmap = bitmap;
					tipsObj.channel = chatVo.channel;
					
					unreadChannel.push(tipsObj);
				}
				
			}
		}
		/**
		 * 根据频道Id获取当前频道是否有未读信息
		 * */
		private function getUnreadChannel(channel:int):Boolean{
			var i:int;
			for(i;i<unreadChannel.length;i++){
				if(unreadChannel[i].channel == channel)
				{
					return false;
				}						
			}
			return true;
		}
		
		/**
		 * 聊天面板鼠标移入时alpha为0.8
		 * */
		private function chatPanelMouseOverHandle(e:MouseEvent):void
		{
			outputBG.alpha = ChatData.OUTPUTBGALPHA[1];
		}
		
		/**
		 * 聊天面板鼠标移出时alpha为0
		 * */
		private function chatPanelMouseOutHandle(e:MouseEvent):void
		{
			outputBG.alpha = ChatData.OUTPUTBGALPHA[0];
		}
		
		/**
		 * 改变聊天输出背景大小的点击事件
		 * */
		private function chatOutputPanelSize(e:MouseEvent):void
		{
			chatPaneUpBtn.visible = true;
			chatPaneDownBtn.visible = true;
			var btnName:String = e.currentTarget.name;
			switch(btnName)
			{
				case "chatPaneUpBtn":
				{
					if(currentPlanelSize == 1)
					{
						chatPaneUpBtn.visible = false;
					}
					if(currentPlanelSize < 2){
						currentPlanelSize ++;
					}
					break;
				}
				case "chatPaneDownBtn":
				{
					if(currentPlanelSize == 1)
					{
						chatPaneDownBtn.visible = false;
					}
					if(currentPlanelSize > 0){
						currentPlanelSize --;
					}
					break;
				}	
			}
			
			setChatOutputPanelSize();
		}
		
		/**
		 * 聊天输出背景大小改变
		 * */
		private function setChatOutputPanelSize():void{
			if(!currentPlanelSize){
				outputBG.visible = false;
				outputPanel.visible = false;
				output.visible = false;
			}else{
				outputBG.visible = true;
				outputPanel.visible = true;
				output.visible = true;
				var size:int = currentPlanelSize - 1; //数组从0开始
				outputBG.setSize(ChatData.OUTPUTBGLIST[size].width, ChatData.OUTPUTBGLIST[size].height);
				outputBG.y = ChatData.OUTPUTBGLIST[size].y;
				outputPanel.height = ChatData.OUTPUTPANELLIST[size].height;
				outputPanel.y = ChatData.OUTPUTPANELLIST[size].y;
				output.setSize(ChatData.OUTPUTLIST[size].width,ChatData.OUTPUTLIST[size].height);
				output.x = ChatData.OUTPUTLIST[size].x;
				output.y = ChatData.OUTPUTLIST[size].y;
				
				setUnreadChannelHandle(currentChannel);
				setOutputInfo(currentChannel);
			}
		}
		
		/**
		 * 当前频道未读消息处理
		 * */
		private function setUnreadChannelHandle(channel:int):void
		{
			var obj:Object;
			if(unreadChannel.length != 0)
			{
				var i:int;
				for(i;i<unreadChannel.length;i++){
					if(unreadChannel[i].channel == channel)
					{
						obj = unreadChannel[i];
						unreadChannel.splice(i,1);
					}						
				}
				if(obj != null){
					this.removeChild(obj.bitmap);
					if(currentPlanelSize < 1) {
						currentPlanelSize = 1;
						setChatOutputPanelSize();
					}
				}
			}
		}
		
		/**
		 * 文本链接点击
		 * */
		private function textLinkClickHandle(e:TextEvent):void
		{
			var texts:Array = String(e.text).split("^");
			var type:String = texts[0];
			var params:Array = String(texts[1]).split("&");
			var paramObj:Object;
			
			switch(type)
			{
				//点击为玩家名称
				case ChatFormat.LINK_TYPE_PLAYER:
				{
					if(params != null)
					{
						if(GameData.inst.checkLeader(params[0])) return;					
					}
					
					var options:Array = [];
					/*
					options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , "查看信息"));
					options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , "发送私聊"));
					options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , "加为关注"));
					options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , "移至黑名单"));
					*/
					options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , Lang.instance.trans(ChatData.ROLE_FILE)));
					MenuPanel.instance.initOptions(options);
					
					paramObj = new Object();
					paramObj.userID = params[0]
					paramObj.username = params[1];
					
					MenuPanel.instance.show(paramObj , App.topUI);
					break;
				}
					//点击为道具
				case ChatFormat.LINK_TYPE_ITEM:
					// 显示tips
					var itemCellData:ItemCellData = new ItemCellData();
					var item:PRO_Item = getProItemHandle(params[0]);
					itemCellData.data = item;
					if(item == null) 
					{
						itemCellData.propVo = ItemManager.instance.getPropById(params[0]);
					}
					
					var sprite:Sprite = ItemTipsManager.getTips(itemCellData) as Sprite;
					if(!sprite) return;
					// 显示tips
					itemTips.show(sprite);
					// 定位
					itemTips.x = this.mouseX + 12;
					itemTips.y = this.mouseY + 7;
					if(stage.mouseY + itemTips.height > stage.stageHeight)
					{
						itemTips.y -= itemTips.height;
					}
					break;
				//点击为战报
				case ChatFormat.LINK_TYPE_BATTLE:
					if(GameData.inst.isBattle == false)
					{
						var str:String = params[0];
						SXD2Main.inst.battleReport(UInt64.parseUInt64(str));
					}
					else
					{
						DialogManager.inst.showPrompt("请先离开战斗");
					}
					break
				//点击为公告
				case ChatFormat.LINK_TYPE_SYSTEM:
					
					break;
			}
		}
		
		/**
		 * 初始化聊天错误提示信息
		 * */
		private function initErrorCodeListHandle():void{
			errorCodeList = GameSettings.instance.settingsXML.errcodes.errcode;
		}
		
		/**
		 * 根据错误ID获取错误提示
		 * */
		private function getErrorTipsHandle(errorId:int):String{
			var len:int = errorCodeList.length();
			for (var i:int = 0; i < len; i++) {
				var errorCodeXML:XML = errorCodeList[i]
				if(errorCodeXML.@key == errorId) {
					return errorCodeXML.@value;
				}
			}
			
			return null;
		}
		
		/**
		 * 获取道具信息
		 * */
		public function getProItemHandle(id:int):PRO_Item
		{
			var len:int = currentChatList.length;
			var i:int;
			for(i;i<len;i++)
			{
				if(currentChatList[i] is MSG_CHAT_NOTICE_ACK)
					return null;
				
				var chatVo:MSG_CHAT_NOTIFY_ACK = currentChatList[i];
				var item:PRO_Item = chatVo.data
				if(item)
				{
					if(item.itemId == id)
						return item
				}
			}
			return null;
		}
		
		/**
		 * 显示公告
		 * */
		public function showNoticeHandle(obj:Object):void
		{
			var respones:RemoteResponse = obj as RemoteResponse;
			if(respones.errcode == "0") 
			{
				var noticeAck:MSG_CHAT_NOTICE_ACK = new MSG_CHAT_NOTICE_ACK();
				noticeAck.mergeFrom(respones.protoBytes);
				
				var messageXml:XML = ChatFormat.getMessage(ChatData.SYSTEM,noticeAck).xml;
				output.importXML(messageXml);
				
				chatWorldList.push(noticeAck);
				/*
				var type:String = NoticeManager.inst.getNoticeAreaById(noticeAck.notice.id);
				var typeList:Array = type.split("^");
				for(var i:int;i<typeList.length;i++)
				{
				
				}
				
				if(chatVo.channel == currentChannel && currentPlanelSize > 0)
				{
				var messageXml:XML = ChatFormat.getMessage(currentChannel,chatVo);
				output.importXML(messageXml);
				
				output.autoScroll = true;
				outputPanel.refresh();
				}
				*/
				output.autoScroll = true;
				outputPanel.refresh();
			}
		}
		
		/**
		 * 显示战斗
		 * */
		public function showBattleHandle(id:String,content:String):void
		{
			var battleId:String = id;
			var text:RichTextField = new RichTextField();
			text.text = "battle^" + content + "^" +  battleId;
			
			var messageXML:XML = text.exportXML();
			var chatReq:MSG_CHAT_SEND_REQ = new MSG_CHAT_SEND_REQ();
			chatReq.message = messageXML;
			chatReq.channel = currentChannel;
			
			this.dispatchEvent(new ChatEvent(ChatEvent.CHAT , chatReq));
		}
		
		/**
		 * 获取单例
		 * */
		public static function get inst():ChatView
		{
			return _instance ||= new ChatView();
		}
	}
}