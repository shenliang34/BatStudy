package com.gamehero.sxd2.gui.notice
{
	import com.gamehero.sxd2.event.MailEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.fate.FateWindow;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.NoticeSkin;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_NOTIFY_INFO_3_ACK;
	import com.gamehero.sxd2.pro.NotifyInfo3Type;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class NoticeArea3 extends Sprite
	{
		private var mailBtn:Button;//邮件提示按钮
		private var mailCountLab:Label;//邮件数量文本对象
		private var mailCount:int;//提示邮件数量计数
		private var iconGap:int = 20;
		private var fateBtn:Button;
		
		/**
		 *构造 
		 * 
		 */				
		public function NoticeArea3()
		{
			super();
			
			GameService.instance.send(MSGID.MSGID_NOTIFY_INFO_3_REQ);			
			
		}

		/**
		 *显示提示3号区域 
		 * @param noti
		 * 
		 */		
		public function showTips(noti:MSGID_NOTIFY_INFO_3_ACK):void
		{
			this.visible = true;
			var type:int = noti.type;
			switch(type)
			{
				case NotifyInfo3Type.TYPE_MAIL:
				{
					if(noti.val)
					{
						var count:int = noti.val.toNumber();
						mailCount += count
					}
					if(mailCountLab)
					{
						mailCountLab.text = mailCount.toString();
					}
					else
					{
						mailBtn = new Button(NoticeSkin.NOTIAREA3BTNUP,NoticeSkin.NOTIAREA3BTNDOWN,NoticeSkin.NOTIAREA3BTNOVER);
						addChild(mailBtn);
						var sp:Sprite = new Sprite();
						var countIcon:Bitmap = new Bitmap(NoticeSkin.NOTIAREA3MAILCOUNT);
						var mailIcon:Bitmap = new Bitmap(NoticeSkin.NOTIAREA3MAIL);
						sp.addChild(mailIcon);
						countIcon.x = 25;
						countIcon.y = 5;
						mailCountLab = new Label();
						mailCountLab.x = 32;
						mailCountLab.y = 8;
						mailCountLab.text = mailCount.toString();
						sp.addChild(countIcon);
						sp.addChild(mailCountLab);
						
						mailBtn.icon = sp;
						mailBtn.addEventListener(MouseEvent.CLICK,mailBtnClickHandle);
						
						areaSort();
					}
					if(mailCount > 9)
						mailCountLab.x = 30;
					if(mailCount > 99)
						mailCountLab.x = 28;
					break;
				}
				case NotifyInfo3Type.TYPE_FATE:
					if(WindowManager.inst.isWindowOpenedByWindowName("FateWindow"))
						return;
					if(fateBtn) 
						return;
					if(!FunctionManager.inst.isFuncOpen(10060))
						return;
					
					fateBtn = new Button(NoticeSkin.NOTIAREA3BTNUP,NoticeSkin.NOTIAREA3BTNDOWN,NoticeSkin.NOTIAREA3BTNOVER);
					addChild(fateBtn);
					fateBtn.icon = new Bitmap(NoticeSkin.NOTIAREA3FATE);;
					fateBtn.addEventListener(MouseEvent.CLICK,fateBtnClickHandle);
					break;
				default:
				{
					break;
				}
			}
		}
		
		/**
		 *隐藏提示3号区域 
		 * @param noti
		 * 
		 */	
		public function hideTips(type:int):void
		{
			switch(type)
			{
				case NotifyInfo3Type.TYPE_MAIL:
				{
					mailClear();
					break;
				}
				case NotifyInfo3Type.TYPE_FATE:
				{
					fateBtnClear();
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		/**
		 *邮件点击事件 
		 * @param e
		 * 
		 */		
		private function mailBtnClickHandle(e:MouseEvent):void
		{
			mailClear();
			var bool:Boolean = WindowManager.inst.getOpenWindow(WindowEvent.MAIL_WINDOW);
			if(bool)
				dispatchEvent(new MailEvent(MailEvent.MAIL_GET_LIST,1));
			else
				MainUI.inst.openWindow(WindowEvent.MAIL_WINDOW);
		}
		
		/**
		 *邮件清理 
		 * 
		 */		
		private function mailClear():void
		{
			if(mailBtn)
			{
				mailBtn.removeEventListener(MouseEvent.CLICK,mailBtnClickHandle);
				mailBtn.visible = false;
				removeChild(mailBtn);
				mailBtn = null;
				mailCountLab = null;
				mailCount = 0;
				areaSort();
			}
		}
		
		/**
		 *命途按钮点击事件 
		 * @param e
		 * 
		 */		
		private function fateBtnClickHandle(e:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.FATE_WINDOW);
		}
		
		private function fateBtnClear():void
		{
			if(fateBtn)
			{
				fateBtn.removeEventListener(MouseEvent.CLICK,mailBtnClickHandle);
				fateBtn.visible = false;
				removeChild(fateBtn);
				fateBtn = null;
				
				areaSort();
			}
		}
		
		/**
		 *区域排序 
		 * 
		 */		
		private function areaSort():void
		{
			if(!this.width)
				this.visible = false;
			
			NoticeUI.inst.onResize();
		}
	}
}