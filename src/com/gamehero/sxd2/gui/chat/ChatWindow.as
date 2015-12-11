package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.BaseWindow;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.ChatScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.MSG_FRIEND_CHAT_REQ;
	import com.gamehero.sxd2.pro.PRO_ChatContents;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.netease.protobuf.UInt64;
	import com.riaidea.text.RichTextField;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import alternativa.gui.controls.text.Label;
	
	import bowser.utils.time.TimeTick;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 私聊窗口
	 * @author cuixu
	 * @create 2015-11-19
	 **/
	public class ChatWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 665;
		private const WINDOW_HEIGHT:int = 508;
		private const INPUT_MAX_CHARS:int = 150;//限制最大输入字符数
		private const MEMBER_HEIGHT:int = 31;//联系人列表项高度
		
		private var global:Global;//全局对象
		// 表情按钮
		private var faceBtn:Button;
		// 表情面板
		private var expressionPanel:ChatExpressionPanel;
		
		// 输入输出框
		private var outputPanel:ChatScrollPane;
		private var output:RichTextField;
		private var input:RichTextField;
		
		// 文本
		private var nameLabel:Label;
		private var levelLabel:Label;
		private var maxCharsLabel:Label;
		// 头像
		private var headIcon:Bitmap;
		
		// 联系人面板
		private var chaterPanel:NormalScrollPane;
		private var chaterContainer:Sprite;
		// 联系人列表
		private var chaters:Array = [];
		// 当前选中的联系人
		private var selectedChater:ChatMember;
		// 上一次选中的联系人
		private var lastChater:ChatMember;
		
		private var isOpen:Boolean = false;
		
		/**
		 * 构造函数
		 * */
		public function ChatWindow(windowPosition:int , resourceURL:String = "chatWindow.swf")
		{
			super(windowPosition, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		
		/**
		 * 复写
		 * */
		override protected function initWindow():void
		{
			super.initWindow();
			// 初始化固定UI
			initUI();
		}
		
		private function initUI():void
		{
			global = Global.instance;
			// 九宫格框
			var innerBg:ScaleBitmap = createCommonScaleBitmap(CommonSkin.windowInner2Bg,CommonSkin.windowInner2BgScale9Grid,645,462);
			innerBg.x = 10;
			innerBg.y = 35;
			addChild(innerBg);
			
			var bmp:Bitmap;
			//头像背景
			bmp = new Bitmap(this.getSwfBD("HEAD_BG_BD"));
			bmp.x = 17;
			bmp.y = 43;
			addChild(bmp);
			
			// 头像
			headIcon = new Bitmap();
			headIcon.x = 20;
			headIcon.y = 46;
			addChild(headIcon);
			
			// 输出框背景
			bmp = new Bitmap(this.getSwfBD("OUTPUT_BG_BD"));
			bmp.x = 20;
			bmp.y = 101;
			addChild(bmp);
			
			//输入框背景
			bmp = new Bitmap(this.getSwfBD("INPUT_BG_BD"));
			bmp.x = 20;
			bmp.y = 374;
			addChild(bmp);
			
			// 当前联系人背景
			innerBg = this.createCommonScaleBitmap(CommonSkin.windowInner2Bg,CommonSkin.windowInner2BgScale9Grid,214,440);
			innerBg.x = 435;
			innerBg.y = 45;
			addChild(innerBg);
			
			// 当前联系人title
			bmp = new Bitmap(this.getSwfBD("CONTACTER_BD"));
			bmp.x = 438;
			bmp.y = 45;
			addChild(bmp);
			
			// 分割线
//			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
//			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
//			lineBM.setSize(150, 2);
//			lineBM.x = 454;
//			lineBM.y = 86;
//			addChild(lineBM);
			
			// 表情背景
			bmp = new Bitmap(this.getSwfBD("FACE_BG_BD"));
			bmp.x = 20;
			bmp.y = 340;
			addChild(bmp);
			
			// 功能按钮
			var btn:Button = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			btn.label = "添加关注";
			btn.setLabelColor(GameDictionary.WHITE);
			btn.x = 190;
			btn.y = 340;
			btn.width = 80;
			btn.height = 30;
			btn.addEventListener(MouseEvent.CLICK , addFriend);
			addChild(btn);
			
			btn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			btn.label = "查看信息";
			btn.setLabelColor(GameDictionary.WHITE);
			btn.x = 270;
			btn.y = 340;
			btn.width = 80;
			btn.height = 30;
			btn.addEventListener(MouseEvent.CLICK , anotherPlayerInfoClick);
			addChild(btn);
			
			btn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			btn.label = "聊天记录";
			btn.setLabelColor(GameDictionary.WHITE);
			btn.x = 350;
			btn.y = 340;
			btn.width = 80;
			btn.height = 30;
			btn.addEventListener(MouseEvent.CLICK , historyClick);
			addChild(btn);
			
			btn = new Button(getSwfBD("MIN_UP"), getSwfBD("MIN_DOWN"), getSwfBD("MIN_OVER"));
			btn.x = 612;
			btn.y = 20;
			btn.addEventListener(MouseEvent.CLICK , minimize);
			addChild(btn);
			
			btn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			btn.label = "发送";
			btn.x = 352;
			btn.y = 460;
			btn.width = 78;
			btn.height = 28;
			btn.addEventListener(MouseEvent.CLICK , sendChat);
			addChild(btn);
			
			// 输出面板
			/*var mask:Shape = new Shape();
			mask.x = 20;
			mask.y = 103;
			mask.graphics.beginFill(0,0);
			mask.graphics.drawRect(0,0,408,234);
			mask.graphics.endFill();
			addChild(mask);*/
			
			//与OUTPUT_BG_BD保持一致
			outputPanel = new ChatScrollPane("right");
			outputPanel.x = 20;
			outputPanel.y = 101;
			outputPanel.width = 408;
			outputPanel.height = 234;
			//outputPanel.mask = mask;
			addChild(outputPanel);
			
			// 输出文本框
			var outputFormat:TextFormat = new TextFormat();
			outputFormat.leading = 6;
			output = new RichTextField();
			output.setSize(388, 214);
			output.type = TextFieldType.DYNAMIC;
			output.autoScroll = true;
			output.html = true;
			output.domain = ChatData.mainDomain;
			output.x = 6;
			output.y = 6;
			output.defaultTextFormat = outputFormat;
			output.lineHeight = 21;
			output.placeholderMarginV = -4;
			output.textfield.addEventListener(TextEvent.LINK, onTextLink);
			output.textfield.mouseWheelEnabled = false; // 不响应滚轮
			output.textfield.wordWrap = true;
			outputPanel.content = output;
			
			// 输入文本框
			var inputFormat:TextFormat = new TextFormat();
			inputFormat.size = 12;
			inputFormat.color = GameDictionary.WHITE;
			input = new RichTextField();
			input.setSize(400, 50);
			input.x = 28;
			input.y = 378;
			input.domain = ChatData.mainDomain;
			input.type = TextFieldType.INPUT;
			input.textfield.maxChars = INPUT_MAX_CHARS;
			input.textfield.wordWrap = true;
			input.placeholderMarginV = -4;// 表情位置偏移
			input.defaultTextFormat = inputFormat;
			input.addEventListener(KeyboardEvent.KEY_DOWN, onInputEnter);
			input.addEventListener(Event.CHANGE,showInputMaxs);
			addChild(input);
			
			// 表情按钮
			faceBtn = new Button(new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_UP"))() , new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_DOWN"))() , new (global.getClass(ChatData.mainDomain,"FACE_BUTTON_OVER"))());
			faceBtn.x = 27;
			faceBtn.y = 347;
			faceBtn.addEventListener(MouseEvent.CLICK , onFacesButtonClick);
			addChild(faceBtn);
			
			// 表情面板
			expressionPanel = new ChatExpressionPanel();
			expressionPanel.x = 31;
			expressionPanel.y = 198;
			expressionPanel.visible = false;
			expressionPanel.addEventListener(ChatEvent.FACE_SELECT , onFaceSelectd);
			addChild(expressionPanel);
			
			// 文本
			nameLabel = new Label(false);
			nameLabel.width = 160;
			nameLabel.height = 30;
			nameLabel.color = GameDictionary.ORANGE;
			nameLabel.size = 12;
			nameLabel.x = 78;
			nameLabel.y = 52;
			addChild(nameLabel);
			
			levelLabel = this.createCommonLabel("10" , GameDictionary.WHITE);
			levelLabel.x = 78;
			levelLabel.y = 73;
			addChild(levelLabel);
			
			// 联系人面板
			chaterContainer = new Sprite();
			
			/*mask = new Shape();
			mask.x = 454;
			mask.y = 94;
			mask.graphics.beginFill(0,0);
			mask.graphics.drawRect(0,0,160,364);
			mask.graphics.endFill();
			addChild(mask);*/
			
			chaterPanel = new NormalScrollPane();
			chaterPanel.x = 439;
			chaterPanel.y = 79;
			chaterPanel.width = 207;
			chaterPanel.height = 403;//最好是MEMBER_HEIGHT的整数倍，否则会显示出部分的chatMember
			//chaterPanel.mask = mask;
			chaterPanel.content = chaterContainer;
			addChild(chaterPanel);
			
			maxCharsLabel = this.createCommonLabel("10" , GameDictionary.GRAY);
			maxCharsLabel.x = 27;
			maxCharsLabel.y = 465;
			addChild(maxCharsLabel);
			showInputMaxs();
		}
		
		
		
		/**
		 * 每次打开都会执行
		 * */
		override public function onShow():void
		{
			super.onShow();
			isOpen = true;
			
			// 更新当前联系人列表
			updateChaterList();
			setFocusLocation();
//			NotiUI.inst.addEventListener(ChatEvent.AWARD_INFO,onChat);
		}
		
		/**
		 * 更新当前联系人列表
		 * */
		private function updateChaterList():void
		{
			//先清空联系人面板
			clearChatMembers();
			
			//创建联系人列表
			var chater:ChatMember;
			var i:int = 0;
			for(var role:PRO_PlayerBase in ChatData.privateChat)
			{
				//创建联系人组件
				chater = createChater(role);
				chater.y = i * MEMBER_HEIGHT;
				chaterContainer.addChild(chater);
				chaters.push(chater);
				i++;
			}
			
			// 若没有选中联系人 , 则默认第一个为选中者
			if(selectedChater == null)
			{
				selectedChater = chaters[0];
			}
			else
			{
				// 因为数据已清空,需要重新寻找上一次选中的联系人
				var selectBase:PRO_PlayerBase = selectedChater.base;
				for(i=0;i<chaters.length;i++)
				{
					chater = chaters[i];
					var base:PRO_PlayerBase = chater.base;
					if(selectBase.name == base.name)
					{
						selectedChater = chater;
						break;
					}
				}
			}
			selectChater();
			
			// 刷新联系人面板
			chaterPanel.refresh();
		}
		
		/**
		 * 添加新的联系人
		 * */
		private function createChater(role:PRO_PlayerBase):ChatMember
		{
			//创建联系人组件
			var chater:ChatMember = new ChatMember(role , this.uiResDomain);
			chater.addEventListener(MouseEvent.CLICK , selectChater);
			chater.addEventListener(ChatEvent.REMOVE_MEMBER , removeChater);
			return chater;
		}
		
		/**
		 * 选择当前联系人
		 * */
		private function selectChater(e:MouseEvent = null):void
		{
			if(e)
			{
				selectedChater = e.currentTarget as ChatMember;
			}
			
			// 存在选中联系人
			if(selectedChater)
			{
				//现将所有联系人置为未选中
				for(var i:int=0;i<chaters.length;i++)
				{
					var chater:ChatMember = chaters[i];
					chater.selected = false;
				}
				selectedChater.selected = true;
				
				// 更新面板信息
				var base:PRO_PlayerBase = selectedChater.base;
				nameLabel.text = base.name;
				levelLabel.text = base.level+"级";
				
				// 加载头像
				var iconIndex:String = base.sexOrJob ? "102" : "101";
				loader.addWithListener(GameConfig.ICON_URL + "playerhead/"+ iconIndex + ".png" , null , onHeadLoaded);
				
				// 显示当前聊天信息
				updateChatMessage();
				
				// 更新聊天记录窗口(窗口已打开的情况下，并且联系人不是同一个)
				if(lastChater != selectedChater)
				{
					updateHistoryWindow();	
				}
			}
			// 保存上一次选中的联系人
			lastChater = selectedChater;
		}
		
		/**
		 * 移除所选联系人
		 * */
		private function removeChater(e:ChatEvent):void
		{
			// 剩余联系人必须大于1
			if(chaters.length > 1)
			{
				// 目标联系人
				var targetChater:ChatMember = e.currentTarget as ChatMember;
				for(var role:PRO_PlayerBase in ChatData.privateChat)
				{
					if(role.name == targetChater.base.name)
					{
						// 删除该联系人所有数据
						ChatData.privateChat[role] = null;
						delete ChatData.privateChat[role];
						break;
					}
				}
				
				// 若所选联系人是当前联系人,则置空
				if(selectedChater && selectedChater == targetChater)
				{
					selectedChater = null;
				}
				
				// 更新联系人列表
				updateChaterList();
			}
			// 只剩下一个联系人时点关闭,需要关掉聊天窗口
			else
			{
				this.close();
			}
		}
		
		/**
		 * 更新聊天记录窗口
		 * */
		private function updateHistoryWindow():void
		{
			if(WindowManager.inst.isWindowOpened(ChatHistoryWindow) == true)
			{
				chatHistory();
			}
		}
		
		/**
		 * 获取聊天记录
		 * */
		private function chatHistory():void
		{
			if(this.enabled == true)
			{
				// 发送请求
				var data:Object = new Object();
				data.id = selectedChater.base.id;
				this.dispatchEvent(new ChatEvent(ChatEvent.CHAT_HISTORY , data));
				this.enabled = false;
			}
		}
		
		/**
		 * 私聊消息
		 * @param chats [PRO_ChatContents]
		 * 
		 */
		public function friendChatHandle(chats:Array):void{
			ChatData.privateChatCache.concat(chats);
			if(WindowManager.inst.isWindowOpened(ChatWindow))
			{
				ChatData.savePrivateChat();
				//当前联系人有数据更新
				if(selectedChater){
					for each(var chat:PRO_ChatContents in chats){
						if(chat.base.name == selectedChater.base.name){
							appendOutputMessage(chat);
							//不要Break;因为消息可能累积，要把每一条数据都遍历
						}
						//判断是否要更新联系人列表
						addNewChater(chat.base);
					}
				}
			}
		}
		
		/**
		 * 更新当前聊天信息
		 * */
		private function updateChatMessage():void
		{
			//清空当前聊天
			output.clear();
			
			//遍历所有当前聊天
			var curRole:PRO_PlayerBase = selectedChater.base;
			var vos:Array = ChatData.getCurrentHistory(curRole.id);
			for(var i:int=0;i<vos.length;i++)
			{
				var vo:PRO_ChatContents = vos[i];
				this.appendOneMessage(vo);
			}
			
			outputPanel.refresh();
		}
		
		/**
		 * output新增聊天信息
		 * */
		private function appendOutputMessage(chatVO:PRO_ChatContents):void
		{
			var curRole:PRO_PlayerBase = selectedChater.base;
			var vos:Array = ChatData.getCurrentHistory(selectedChater.base.id);
			// 聊天数量超过限制条数
			if(vos.length > ChatData.OUTPUTMAXLINE)
			{
				// 去除前20条
				vos.splice(0,20);
				output.clear();
				for(var i:int=0;i<vos.length;i++)
				{
					this.appendOneMessage(vos[i] as PRO_ChatContents);
				}
			}
			else
			{
				// 仅添加一条聊天
				this.appendOneMessage(chatVO);
			}
			
			// 刷新面板
			outputPanel.refresh();
		}
		
		/**
		 * 添加一条聊天
		 * */
		private function appendOneMessage(vo:PRO_ChatContents):void
		{
			var obj:Object = ChatFormat.getMessage(ChatData.PRIVATE , vo);
			output.importXML(obj.title);
			output.importXML(obj.message);
		}
		
		/**
		 * 头像加载完成
		 * */
		private function onHeadLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onHeadLoaded);
			
			headIcon.bitmapData = imageItem.content.bitmapData;
		}
		
		/**
		 * 选择用户（聊天内容中链接）
		 * @param event
		 */
		private function onTextLink(evt:TextEvent):void
		{
			
		}
		
		/**
		 * 键盘
		 * */
		private function onInputEnter(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				sendChat(null);
			}
		}
		
		private function showInputMaxs(e:Event = null):void{
			maxCharsLabel.text = "剩余" + (INPUT_MAX_CHARS - input.textfield.length) + "字";
		}
		
		/**
		 * 表情开关Handler 
		 */
		private function onFacesButtonClick(e:MouseEvent):void
		{
			// 开关表情面板
			expressionPanel.visible = !expressionPanel.visible;
		}
		
		/**
		 * 选择表情后的响应
		 * */
		private function onFaceSelectd(e:ChatEvent):void
		{
			// 隐藏表情面板
			expressionPanel.visible = false;
			// 表情mc类名
			var classname:String = e.data as String;
			// 输入框加入表情
			var clazz:Class = ChatData.mainDomain.getDefinition(classname) as Class;
			var face:MovieClip = new clazz() as MovieClip
			input.insertSprite(face , input.caretIndex);
			// 索引+1
			if(input.isSpriteAt(input.caretIndex))
			{				
				input.caretIndex++;
			}
			showInputMaxs();
			//焦点
			this.setFocusLocation();
		}
		
		/**当舞台上有私聊窗口时，舞台焦点按Enter键定位至私聊输入框*/
		public function setFocusLocation():void
		{
			stage.focus = input.textfield;
		}
		
		/**
		 * 添加新联系人
		 * */
		public function addNewChater(sender:PRO_PlayerBase):void
		{
			// 发送者不在联系人列表中
			if(this.checkInChaters(sender.name) == false)
			{
				// 新建联系人
				var chater:ChatMember = this.createChater(sender);
				chater.y = chaters.length * MEMBER_HEIGHT;
				chaterContainer.addChild(chater);
				chaters.push(chater);
				// 刷新联系人面板
				chaterPanel.refresh();
				
				// 新建联系人聊天记录
				ChatData.addCurrentHistory(sender);
			}
		}
		
		/**
		 * 判断当前联系人中是否有该角色
		 * */
		private function checkInChaters(name:String):Boolean
		{
			for(var i:int=0;i<chaters.length;i++)
			{
				var chater:ChatMember = chaters[i];
				var base:PRO_PlayerBase = chater.base;
				if(base.name == name)
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 点击聊天记录按钮
		 * */
		private function historyClick(e:MouseEvent):void
		{
			// 若之前已打开,先关闭
			if(WindowManager.inst.isWindowOpened(ChatHistoryWindow) == true)
			{
				// 关闭聊天记录窗口
				this.closeHistoryWindow();
			}
			else
			{
				// 请求聊天记录
				//this.chatHistory();
				var arr:Array = [];
				for(var i:int = 0; i < 83; i ++){
					var chat:PRO_ChatContents = new PRO_ChatContents();
					var otherPlayerInfo:PRO_PlayerBase = new PRO_PlayerBase();
					otherPlayerInfo.name = "我是主角好朋友" + i;
					otherPlayerInfo.id = UInt64.parseUInt64(i.toString());
					otherPlayerInfo.sexOrJob = i % 2;
					chat.base = otherPlayerInfo;
					chat.message = "message"+i;
					chat.time = UInt64.fromNumber(TimeTick.inst.getCurrentTime()*0.001);
					arr.push(chat);
				}
				onChatHistory(arr);
			}
		}
		
		/**
		 * 发送聊天
		 * */
		private function sendChat(e:MouseEvent):void
		{
			var messageXML:XML = input.exportXML();
			var textXML:XML = messageXML.text[0];
			var text:String = textXML.toString();
			if(text == "" && messageXML.sprites.sprite.length() == 0)
			{
				return;
			}
			var messageXMLStr:String = messageXML;//.toXMLString();
			// 清空输入框
			input.clear();
			showInputMaxs();
			setFocusLocation();
			// 选中的联系人 和 我
			var receiver:PRO_PlayerBase = selectedChater.base;
			var sender:PRO_PlayerBase = GameData.inst.playerInfo;
			
			// 将说的话添加到当前聊天记录中
			var vo:PRO_ChatContents = new PRO_ChatContents();
			vo.base = sender;
			vo.message = messageXMLStr;
			vo.time = UInt64.fromNumber(TimeTick.inst.getCurrentTime()*0.001);
			ChatData.addCurrentHistory(sender , vo);
			appendOutputMessage(vo);
			
			var chatReq:MSG_FRIEND_CHAT_REQ = new MSG_FRIEND_CHAT_REQ();
			chatReq.contents = new PRO_ChatContents();
			chatReq.contents.base = receiver;
			chatReq.contents.message = messageXMLStr;
			//chatReq.contents.time = vo.time;
			this.dispatchEvent(new ChatEvent(ChatEvent.CHAT , chatReq));
		}
		
		/**
		 * 获取聊天记录响应
		 * @param chats [PRO_ChatContents]
		 * 
		 */
		public function onChatHistory(chats:Array):void
		{
			this.enabled = true;
			ChatData.historys = chats;
			// 若聊天记录窗口已打开
			if(WindowManager.inst.isWindowOpened(ChatHistoryWindow) == true)
			{
				this.dispatchEvent(new ChatEvent(ChatEvent.CHAT_HISTORY_UPDATE));
				//var window:BaseWindow = WindowManager.inst.getWindowInstance(ChatHistoryWindow , WindowPostion.CENTER_RIGHT);
				//ChatHistoryWindow(window).initHistoryData();
				//ChatHistoryWindow(window).updateHistory();
			}
			else
			{
				// 打开聊天记录窗口
				MainUI.inst.openWindow(WindowEvent.CHATHISTORY_WINDOW);
			}
		}
		
		/**
		 * 添加好友
		 * */
		private function addFriend(e:MouseEvent):void
		{
			
		}
		
		/**
		 * 点击查看玩家信息
		 * */
		private function anotherPlayerInfoClick(e:MouseEvent):void
		{
			var userID:UInt64 = selectedChater.base.id;
			this.dispatchEvent(new ChatEvent(ChatEvent.ANOTHER_PLAYER_INFO_CLICK , userID));
		}
		
		/**
		 * 最小化窗口
		 * */
		private function minimize(e:MouseEvent):void
		{
			// 关掉聊天记录窗口
			this.closeHistoryWindow();
			// 点亮主UI的提醒按钮
//			NotiUI.inst.showNoticeButton(NotiUI.NoticeButton_Chat);
			super.close();
		}
		
		/**
		 * 关闭聊天记录窗口
		 * */
		private function closeHistoryWindow():void
		{
			if(WindowManager.inst.isWindowOpened(ChatHistoryWindow) == true)
			{
				var window:BaseWindow = WindowManager.inst.getWindowInstance(ChatHistoryWindow , WindowPostion.CENTER_RIGHT);
				window.close();
				WindowManager.inst.closeWindow(window);
			}
		}
		
		/**
		 * 关闭窗口
		 * */
		override public function close():void
		{
			// 关掉聊天记录窗口
			this.isOpen = false;
			this.closeHistoryWindow();
			this.clear();
			super.close();
		}
		
		//窗口是否打开
		public function get open():Boolean
		{
			return this.isOpen;
		}
		
		/**
		 * 清空联系人面板
		 * */
		private function clearChatMembers():void
		{
			var chater:ChatMember;
			var iLen:int = chaters.length;
			for(var i:int=0;i<iLen;i++)
			{
				// 移除事件
				chater = chaters[i];
				chater.clear();
				chater.removeEventListener(MouseEvent.CLICK , selectChater);
				chater.removeEventListener(ChatEvent.REMOVE_MEMBER , removeChater);
				chaterContainer.removeChild(chater);
			}
			chaters = [];
		}
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			// 选中联系人
			selectedChater = null;
			lastChater = null;
			// 清空数据
			output.clear();
			outputPanel.refresh();
			ChatData.historys = [];
			ChatData.privateChat = new Dictionary();
			ChatData.privateChatCache = [];
			//清空联系人面板
			this.clearChatMembers();
			headIcon.bitmapData = null;
		}
		
	}
}