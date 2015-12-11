package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.ChatScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.PageButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.PRO_ChatContents;
	import com.greensock.events.TweenEvent;
	import com.riaidea.text.RichTextField;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 
	 * @author cuixu
	 * @create：2015-11-19
	 **/
	public class ChatHistoryWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 287;
		private const WINDOW_HEIGHT:int = 508;
		private const PAGE_NUMS:int = 40;//每页消息数目
		
		// 聊天记录框
		private var outputPanel:ChatScrollPane;
		private var output:RichTextField;
		private var pageButton:PageButton;//翻页按钮
		// 总数据
		private var historys:Array;
		
		/**
		 * 构造函数
		 * */
		public function ChatHistoryWindow(position:int , resourceURL:String = "ChatHistoryWindow.swf")
		{
			super(position, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);	
		}
		
		/**
		 * 复写
		 * */
		override protected function initWindow():void
		{
			super.initWindow();
			// 固定UI
			this.initUI();
			this.addEventListener(TweenEvent.COMPLETE,tweenEventHandle);
		}
		
		private function tweenEventHandle(e:Event):void
		{
			if(e is TweenEvent){//窗口缓动效果结算再处理数据
				showChatHistory();
			}
		}
		
		/**
		 * 初始化固定UI
		 * */
		private function initUI():void
		{
			// 九宫格框
			var innerBg:ScaleBitmap = this.createCommonScaleBitmap(CommonSkin.windowInner2Bg,CommonSkin.windowInner2BgScale9Grid,269,458);
			innerBg.x = 8;
			innerBg.y = 40;
			this.addChild(innerBg);
			
			// 聊天记录框九宫格背景
			innerBg = this.createCommonScaleBitmap(CommonSkin.windowInner2Bg,CommonSkin.windowInner2BgScale9Grid,255,414);
			innerBg.x = 15;
			innerBg.y = 47;
			this.addChild(innerBg);
			
			var mask:Shape = new Shape();
			mask.x = 20;
			mask.y = 58;
			mask.graphics.beginFill(0,0);
			mask.graphics.drawRect(0,0,240,395);
			mask.graphics.endFill();
			this.addChild(mask);
			
			outputPanel = new ChatScrollPane("right");
			outputPanel.x = 15;
			outputPanel.y = 50;
			outputPanel.width = 250;
			outputPanel.height = 410;
			//outputPanel.mask = mask;
			this.addChild(outputPanel);
			
			// 输出文本框
			var outputFormat:TextFormat = new TextFormat();
			outputFormat.leading = 6;
			output = new RichTextField();
			output.type = TextFieldType.DYNAMIC;
			output.autoScroll = true;
			output.html = true;
			output.domain = ChatData.mainDomain;
			output.x = 5;
			output.y = 5;
			output.setSize(240, 400);
			output.defaultTextFormat = outputFormat;
			//output.textfield.addEventListener(TextEvent.LINK, onTextLink);
			output.textfield.mouseWheelEnabled = false; // 不响应滚轮
			outputPanel.content = output;
			
			pageButton = new PageButton();
			pageButton.x = 96;
			pageButton.y = 470;
			addChild(pageButton);
		}
		
		public function showChatHistory():void{
			historys = ChatData.historys;
			pageButton.init(PAGE_NUMS,historys.length,pageBtnHandle);
			pageButton.page = pageButton.pages - 1;//刷新数据后，默认指向最后一页,set page自动触发pageBtnHandle()
		}
		
		private function pageBtnHandle():void
		{
			var page:int = pageButton.page;
			// 清空输出框
			output.clear();
			// 计算显示数据
			var start:int = page * PAGE_NUMS;
			var end:int = Math.min(historys.length,(page + 1) * PAGE_NUMS);
			var list:Array = historys.slice(start , end);
			for(var i:int=0;i<list.length;i++)
			{
				var vo:PRO_ChatContents = list[i];
				var xmlData:Object = ChatFormat.getMessage(ChatData.PRIVATE , vo);
				var titleXML:XML = xmlData.title;
				var messageXML:XML = xmlData.message;
				output.importXML(titleXML);
				output.importXML(messageXML);
			}
			outputPanel.refresh();
		}
		
	}
}