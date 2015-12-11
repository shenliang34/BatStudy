package com.gamehero.sxd2.gui.mail
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.MailEvent;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.chat.ChatFormat;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MailStatus;
	import com.gamehero.sxd2.pro.PRO_Mail_Detail;
	import com.gamehero.sxd2.pro.PRO_Mail_Info;
	import com.gamehero.sxd2.pro.PRO_Page;
	import com.greensock.events.TweenEvent;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 邮箱窗口
	 * @author zhangxueyou
	 * @create 2015-10-9
	 **/
	public class MailWindow extends GeneralWindow
	{
		private static const WINDOW_WIDTH:Number = 540;//面板默认宽
		private static const WINDOW_HEIGHT:Number = 455;//面板默认高
		
		private var pageText:TextField;//翻页 页数文本对象
		private var pageFormatStr:String;//翻页样式
		private var mailTitle:TextField;//标题文本对象
		private var mailContentText:TextField;//正文文本对象
		public var curMailId:UInt64;//当前邮件Id
		private var curPage:int = 1;//当前列表页数
		private var totalPage:int = 1;//列表总页数
		private var titleFormatStr:String;//标题文本样式
		private var mailList:Array = [];//当前列表数组
		private var attacthList:Array = [];//当前附件数组
		private var getBtn:Button;//领取附件按钮
		private var allGetBtn:Button;//领取全部附件按钮
		private var tweenCount:int;//缓动计数
		private var mailInfoList:Array = [];//当前页邮件列表
		private var pageInfo:PRO_Page;//分页对象
		private var tipsText:TextField;//没有邮件时的提示文本
		private var titleText:TextField;//标题文本
		private var contentText:TextField;//内容文本 
		private var attachText:TextField;//附件文本
		
		/**
		 *构造 
		 * @param position
		 * 
		 */		
		public function MailWindow(position:int)
		{
			super(position, "MailWindow.swf", WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		/**
		 *初始化面板 
		 * 
		 */		
		override protected function initWindow():void
		{
			super.initWindow();
			
			this.addEventListener(TweenEvent.COMPLETE,tweenEventHandle);
			
			initUI();
		}

		/**
		 *防止窗口内容抖动，窗口缓动结束后赋值 
		 * @param e
		 * 
		 */		
		private function tweenEventHandle(e:Event):void
		{
			
			tweenCount++;
			if(tweenCount == 2)
			{
				setMailPageHandle(pageInfo);
				setMailListHandle(mailInfoList);
			}
		}
		
		/**
		 *设置面板信息 
		 * @param pageInfo
		 * @param mailList
		 * 
		 */		
		public function initWindowInfo(pageInfo:PRO_Page,mailList:Array):void
		{
			this.pageInfo = pageInfo;
			this.mailInfoList = mailList;
			
			if(tweenCount == 2)
			{
				setMailPageHandle(pageInfo);
				setMailListHandle(mailInfoList);
			}
		}
		
		/**
		 *初始化UI 
		 * 
		 */		
		private function initUI():void
		{
			
			
			// 列表九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(189, 405);
			innerBg.x = 9;
			innerBg.y = 39;
			addChild(innerBg);
			
			// 详情九宫格框
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(326, 405);
			innerBg.x = 204;
			innerBg.y = 39;
			addChild(innerBg);

			//列表背景
			var listBg:Bitmap = new Bitmap(this.getSwfBD("listBg"));
			listBg.x = 11;
			listBg.y = 44;
			addChild(listBg);

			//内容背景
			var contentBg:Bitmap = new Bitmap(this.getSwfBD("contentBg"));
			contentBg.x = 204;
			contentBg.y = 45;
			addChild(contentBg);

			//翻页按钮背景
			var pageBg:Bitmap = new Bitmap(this.getSwfBD("pageBg"));
			pageBg.x = 20;
			pageBg.y = 406;
			addChild(pageBg);
			
			//上翻页
			var upPageBtn:Button = new Button(this.getSwfBD("upPageUp"),this.getSwfBD("upPageDown"),this.getSwfBD("upPageOver"));
			upPageBtn.x = 20;
			upPageBtn.y = 406;
			addChild(upPageBtn);
			upPageBtn.addEventListener(MouseEvent.CLICK,upPageBtnClickHandle);
			
			//下翻页
			var downPageBtn:Button = new Button(this.getSwfBD("downPageUp"),this.getSwfBD("downPageDown"),this.getSwfBD("downPageOver"));
			downPageBtn.x = 84;
			downPageBtn.y = 406;
			addChild(downPageBtn);
			downPageBtn.addEventListener(MouseEvent.CLICK,downPageBtnClickHandle);
			
			//一键领取按钮
			allGetBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			allGetBtn.label = "一键领取";
			allGetBtn.width = 84;
			allGetBtn.height = 32;
			allGetBtn.x = 106;
			allGetBtn.y = 404;
			addChild(allGetBtn);
			allGetBtn.addEventListener(MouseEvent.CLICK,allGetBtnClickHandle);
			
			//领取按钮
			getBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			getBtn.label = "领取";
			getBtn.width = 68;
			getBtn.height = 32;
			getBtn.x = 333;
			getBtn.y = 404;
			addChild(getBtn);
			getBtn.addEventListener(MouseEvent.CLICK,getBtnClickHandle);
			
			//页数文本样式
			pageFormatStr = "<font size='12' face='宋体' color='#" + GameDictionary.CHAT_DETAILS.toString(16) + "'>";
			
			//页数文本
			pageText = new TextField();
			pageText.width = 50;
			pageText.x = 38;
			pageText.y = 412;
			addChild(pageText);
			
			//固定文本样式
			var formatStr:String = "<font size='12' face='宋体' color='#" + GameDictionary.ORANGE.toString(16) + "'>";
			
			titleText = new TextField();
			titleText.x = 220;
			titleText.y = 58;
			titleText.htmlText = formatStr + "标题:";
			addChild(titleText);
			contentText = new TextField();
			contentText.x = 220;
			contentText.y = 79;
			contentText.htmlText = formatStr + "内容:";
			addChild(contentText);
			attachText = new TextField();
			attachText.x = 217;
			attachText.y = 349;
			attachText.htmlText = formatStr + "附件:";
			addChild(attachText);
			
			var contentTextFormat:TextFormat = new TextFormat();
			contentTextFormat.leading = 18;
			contentTextFormat.indent = 30;
			contentTextFormat.color = GameDictionary.CHAT_DETAILS;
			contentTextFormat.size = 12;
			contentTextFormat.font = "宋体";
			
			
			//邮件标题 
			titleFormatStr = "<font size='12' face='宋体' color='#" + GameDictionary.WINDOW_BLUE.toString(16) + "'>";
			mailTitle = new TextField();
			mailTitle.x = 262;
			mailTitle.y = 59;
			addChild(mailTitle);
			
			//邮件正文
			mailContentText = new TextField();
			mailContentText.selectable = false;
			mailContentText.defaultTextFormat = contentTextFormat;
			mailContentText.width = 270;
			mailContentText.height = 180;
			mailContentText.x = 235;
			mailContentText.y = 125;
			mailContentText.multiline = true;
			mailContentText.wordWrap = true;
			addChild(mailContentText);
			
			this.interrogation = "无附件邮件保留7天\n有附件邮件保留30天";
			
			//没有邮件时提示文本
			tipsText= new TextField();
			tipsText.selectable = false;
			tipsText.width = 500;
			tipsText.x = 60;
			tipsText.y = 200;
			tipsText.htmlText = "<font size='14' face='宋体' color='#d7deed'><B>没有收到邮件</B></font>";
			addChild(tipsText);
			
			//设置提示文本
			setWindowTextTips(false);	
		}
		
		/**
		 * 上翻页点击事件
		 * @param e
		 * 
		 */		
		private function upPageBtnClickHandle(e:MouseEvent):void
		{
			curPage --;
			updataMailListHandle()
		}
		
		/**
		 *下翻页点击事件 
		 * @param e
		 * 
		 */		
		private function downPageBtnClickHandle(e:MouseEvent):void
		{
			curPage ++;
			updataMailListHandle()
		}
		
		/**
		 *领取全部附件 
		 * @param e
		 * 
		 */		
		private function allGetBtnClickHandle(e:MouseEvent):void
		{
			dispatchEvent(new MailEvent(MailEvent.MAIL_GET_ATTACH,0));
			setListItemAttach(true);
		}
		
		/**
		 *领取附件 
		 * @param e
		 * 
		 */		
		private function getBtnClickHandle(e:MouseEvent):void
		{
			dispatchEvent(new MailEvent(MailEvent.MAIL_GET_ATTACH,curMailId));
			setListItemAttach(false);
			
		}
		
		/**
		 *左侧列表模块附件状态更改  
		 * @param bool 是否全部领取
		 * 
		 */				
		private function setListItemAttach(bool:Boolean):void
		{
			var i:int;
			var len:int = mailList.length;
			for(i; i<len; i++)
			{
				var item:MailItem = mailList[i];
				if(bool)
				{
					item.changeAccathStatus();
					item.changeMailStatus(this.getSwfBD("readIcon"));
				}
				else
				{
				
					if(item.mailId.toString() == curMailId.toString())
					{
						item.changeAccathStatus();
					}
				}
				
				
			}
		}
		
		/**
		 *设置翻页 
		 * @param pageInfo
		 * 
		 */		
		public function setMailPageHandle(pageInfo:PRO_Page):void
		{
			if(!pageInfo.curPage || !pageInfo.totalPage) 
			{
				pageText.htmlText ="<p align='center'>" + pageFormatStr + "0/1</p>";
				setWindowTextTips(false);	
			}
			else
			{
				setWindowTextTips(true);
				curPage = pageInfo.curPage;
				totalPage = pageInfo.totalPage;
				pageText.htmlText ="<p align='center'>" + pageFormatStr + pageInfo.curPage + "/" + pageInfo.totalPage + "</p>";
			}
		}
		
		/**
		 *清理左侧列表 
		 * 
		 */		
		private function clearMailListHandle():void
		{
			var i:int;
			var len:int = mailList.length;
			for(i; i<len; i++)
			{
				var item:MailItem = mailList[i];
				item.clear();
				removeChild(item);
				item.removeEventListener(MouseEvent.CLICK,itemClickHandle);
				item.removeEventListener(MouseEvent.MOUSE_OVER,itemOverHandle);
				item.removeEventListener(MouseEvent.MOUSE_OUT,itemOutHandle);
				item = null;
			}
			mailList.splice(0);
		}
		
		/**
		 *设置左侧列表 
		 * @param mailInfo
		 * 
		 */		
		public function setMailListHandle(mailInfo:Array):void
		{
			clearMailListHandle();
			
			var i:int = 0;
			var len:int = mailInfo.length;
			
			if(!len)
			{
				allGetBtn.visible = false;
				getBtn.visible = false;
			}
			else
			{
				allGetBtn.visible = true;
				
				for(i; i<len; i++)
				{
					
					var info:PRO_Mail_Info = mailInfo[i] as PRO_Mail_Info;
					var item:MailItem = new MailItem();
					var mailIcon:BitmapData;
					if(info.status == MailStatus.MAIL_UNREAD && i != 0)
						mailIcon = this.getSwfBD("unreadIcon");
					else
						mailIcon = this.getSwfBD("readIcon");
					
					var attachIcon:BitmapData;
					if(info.status != MailStatus.MAIL_FINISH)
					{
						if(info.hasAttach != 0)
						{
							attachIcon = this.getSwfBD("attatchIcon")
						}
						else
						{
							attachIcon = null;
						}
					}
					else
					{
						attachIcon = null;
					}
					
					var overIcon:BitmapData = this.getSwfBD("overIcon");
					item.setItemInfo(info.id,mailIcon,attachIcon,info.title,info.sendTime,overIcon);
					
					if(!i)
					{
						item.setOverHandle(true);
						item.isOver = true;
						dispatchEvent(new MailEvent(MailEvent.MAIL_GET_DETAIL,item.mailId));
					}
					else
						item.setOverHandle(false);
					
					item.addEventListener(MouseEvent.CLICK,itemClickHandle);
					item.addEventListener(MouseEvent.ROLL_OVER,itemOverHandle);
					item.addEventListener(MouseEvent.ROLL_OUT,itemOutHandle);
					
					item.x = 12;
					item.y = 45 + i * 58;
					this.addChild(item);
					
					mailList.push(item);
				}
			}
			
			
			
		}
		
		/**
		 *左侧邮件模块点击事件 
		 * @param e
		 * 
		 */		
		private function itemClickHandle(e:MouseEvent):void
		{
			var mailId:UInt64;
			var i:int;
			var len:int = mailList.length;
			for(i; i<len; i++)
			{
				var item:MailItem = mailList[i];
				if(item == e.currentTarget)
				{
					item.setOverHandle(true);
					item.isOver = true;
					mailId = item.mailId;
					item.changeMailStatus(this.getSwfBD("readIcon"));
				}
				else
				{
					item.setOverHandle(false);
					item.isOver = false;
				}
			}
			dispatchEvent(new MailEvent(MailEvent.MAIL_GET_DETAIL,mailId));
		}
		
		/**
		 *左侧列表邮件模块 鼠标移入事件 
		 * @param e
		 * 
		 */		
		private function itemOverHandle(e:MouseEvent):void
		{
			e.currentTarget.setOverHandle(true);
		}
		
		/**
		 *左侧列表邮件模块 鼠标移出事件 
		 * @param e
		 * 
		 */
		private function itemOutHandle(e:MouseEvent):void
		{
			e.currentTarget.setOverHandle(false);
		}
		
		/**
		 *设置邮件正文 
		 * @param mailContent
		 * 
		 */		
		public function setMailContentHamdle(mailContent:PRO_Mail_Detail):void
		{
			clearAttachHandle();
			
			curMailId = mailContent.id;
			mailTitle.htmlText = titleFormatStr + Lang.instance.trans(mailContent.title.toString());
			var xml:XML = ChatFormat.getSystemXML(mailContent.content,false).xml;
			mailContentText.htmlText = xml.text;
			
			setAttacthHandle(mailContent.itemId1,mailContent.itemNum1,0);
			setAttacthHandle(mailContent.itemId2,mailContent.itemNum2,1);
			setAttacthHandle(mailContent.itemId3,mailContent.itemNum3,2);
			setAttacthHandle(mailContent.itemId4,mailContent.itemNum4,3);
			setAttacthHandle(mailContent.itemId5,mailContent.itemNum5,4);
			
			var status:int = mailContent.status;
			
			if(status == MailStatus.MAIL_FINISH || !mailContent.itemId1)
				getBtn.visible = false;
			else
				getBtn.visible = true;
		}
		
		/**
		 *设置邮件附件 
		 * @param itemId 
		 * @param count
		 * @param pos
		 * 
		 */		
		private function setAttacthHandle(itemId:int,count:int,pos:int):void
		{
			if(!itemId) return;
			var itemCell:ItemCell = new ItemCell();
			var propVo:PropBaseVo = ItemManager.instance.getPropById(itemId);
			itemCell.propVo = propVo;
			itemCell.num = count.toString();
			itemCell.x = 250 + pos * 55;
			itemCell.y = 339;
			addChild(itemCell);
			attacthList.push(itemCell);
		}
		
		/**
		 *清理附件 
		 * 
		 */		
		private function clearAttachHandle():void
		{
			var i:int;
			var len:int = attacthList.length;
			for(i; i<len; i++)
			{
				var item:ItemCell = attacthList[i];
				item.gc();
				removeChild(item);
			}
			attacthList.splice(0);
		}
		
		/**
		 *显示面板 
		 * 
		 */		
		override public function onShow():void
		{
			super.onShow();
			
			updataMailListHandle();
		}
		
		/**
		 *左侧列表翻页事件 
		 * 
		 */		
		private function updataMailListHandle():void
		{
			if(curPage < 1)
			{
				curPage = 1;
				return;
			}
			if(curPage > totalPage)
			{
				curPage = totalPage;
				return;
			}
			dispatchEvent(new MailEvent(MailEvent.MAIL_GET_LIST,curPage));
		}
		
		/**
		 *关闭面板 
		 * 
		 */		
		override public function close():void {
			super.close();
			
			tweenCount = 0;
			clearMailListHandle();
			clearAttachHandle();
			
			mailTitle.htmlText = "";
			mailContentText.htmlText = "";
		}
		
		/**
		 *设置面板的文本提示 
		 * @param bool
		 * 
		 */		
		private function setWindowTextTips(bool:Boolean):void
		{
			tipsText.visible = !bool;
			titleText.visible = bool;
			contentText.visible = bool;
			attachText.visible = bool;	
		}
			

	}
}