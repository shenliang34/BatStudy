package com.gamehero.sxd2.gui.notice
{
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.chat.ChatFormat;
	import com.gamehero.sxd2.gui.chat.ChatItemTips;
	import com.gamehero.sxd2.gui.chat.ChatView;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.NoticeSkin;
	import com.gamehero.sxd2.gui.tips.ItemTipsManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import bowser.utils.effect.MarqueeText;
	
	/**
	 * 游戏提示层1号区域
	 * @author zhangxueyou
	 * @create 2015-09-25
	 **/
	public class NoticeArea1 extends Sprite
	{
		private static const MAX_DISPLAY_TIMER:int = 5000;//每条公告显示时间
		private var displayTimer:Timer;//单条公告定时器
		private static const MAX_NOTICE_NUM:int = 10;//最大保存条数
		private var notiTextList:Array = [];//公告数组
		private var notiText:MarqueeText;//显示文本对象
		private var noticeBg:Bitmap;//公告背景
		private var closeBtn:Button;//公告关闭按钮
		private var itemTips:ChatItemTips; //物品tips对象
		
		/**
		 * 构造函数
		 */
		public function NoticeArea1():void		
		{
			super();
			initUI();
		}
		
		/**
		 * 初始化UI
		 */
		public function initUI():void
		{
			noticeBg = new Bitmap(NoticeSkin.NOTICEAREABG);
			addChild(noticeBg);
			
			closeBtn = new Button(NoticeSkin.NOTICEAREA_CLOSEBTN_UP,NoticeSkin.NOTICEAREA_CLOSEBTN_DOWN);
			closeBtn.x = this.width - closeBtn.width;
			closeBtn.y = this.height - closeBtn.height >> 1;
			addChild(closeBtn);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnClickHandle);
			
			addEventListener(TextEvent.LINK, taskTextLinkHandle);
			// 物品tips
			itemTips = new ChatItemTips();
			this.addChild(itemTips);
			
		}
		
		/**
		 * 初始化跑马灯文本
		 */
		private function initNoticeText():void
		{
			notiText = new MarqueeText();
			notiText.delay = 100;
			notiText.width = 350;
			notiText.y = 22;
			addChild(notiText);
			
			notiText.addEventListener(MouseEvent.MOUSE_OVER,notiTextMouseOverHandle);
			notiText.addEventListener(MouseEvent.MOUSE_OUT,notiTextMouseOUtHandle);	
		}

		private function taskTextLinkHandle(e:TextEvent):void
		{
			var texts:Array = String(e.text).split("^");
			var type:String = texts[0]; //点击类型
			var params:String = texts[1];//对应的数据
			switch(type)
			{
				//点击为玩家名称
				case ChatFormat.LINK_TYPE_PLAYER:
					break;
				//点击为道具
				case ChatFormat.LINK_TYPE_ITEM:
					// 显示tips
					var itemCellData:ItemCellData = new ItemCellData();
					var item:PRO_Item = ChatView.inst.getProItemHandle(int(params));
					itemCellData.data = item;
					if(item == null) 
					{
						itemCellData.propVo = ItemManager.instance.getPropById(int(params));
					}
					
					var sprite:Sprite = ItemTipsManager.getTips(itemCellData) as Sprite;
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
			}
		}
		
		/**
		 * 关闭按钮点击事件
		 */
		private function closeBtnClickHandle(e:MouseEvent):void
		{
			clearDisplayTimer();
			closeNoticeHandle();
		}
		
		/**
		 * 鼠标移入事件 跑马灯停止播放
		 */
		private function notiTextMouseOverHandle(e:MouseEvent):void
		{
			if(notiText)
				notiText.stop();
		}
		
		/**
		 * 鼠标移出事件 跑马灯继续播放
		 */
		private function notiTextMouseOUtHandle(e:MouseEvent):void
		{
			if(notiText)
				notiText.play();
		}
		
		/**
		 * 添加公告
		 */
		public function addNoti(str:String):void
		{
			if(!this.visible)
				this.visible = true;
			
			notiTextList.push(str);
			if(notiTextList.length == 1)
				play();
		}
		
		/**
		 * 播放公告
		 */
		private function play():void
		{
			var xx:Number = this.x;
			var yy:Number = this.y;
			
			var buttonPoint:Point = new Point(App.windowUI.stage.stageWidth/2,120 + this.height / 2);
			this.x = buttonPoint.x;
			this.y = buttonPoint.y;
			this.scaleX = this.scaleY = 0;
			this.alpha = 0;
			
			TweenMax.to(this, .5, {x: xx,y: yy,scaleX: 1, scaleY: 1, alpha: 1, onComplete:
				function():void {
					initNoticeText();
					notiText.text = notiTextList[0];
					
					if(notiText.width  > 350)
						notiText.x = 30;
					else
						notiText.x = noticeBg.width - notiText.width >> 1;
					displayTimer = new Timer(MAX_DISPLAY_TIMER,1);
					displayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,displayTimerCompleteHandle);
					displayTimer.start();
				}
			});
		}
		
		/**
		 * 定时器 5秒自动关闭
		 */
		private function displayTimerCompleteHandle(e:TimerEvent):void
		{
			clearDisplayTimer();
			closeNoticeHandle();
		}
		
		/**
		 * 清理定时器
		 */
		private function clearDisplayTimer():void
		{
			if(!displayTimer) return;

			displayTimer.stop();
			displayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,displayTimerCompleteHandle);
			displayTimer = null;
		}
		
		/**
		 * 关闭当前公告
		 */
		private function closeNoticeHandle():void
		{
			clear();
			notiTextList.shift();
			if(!notiTextList.length)
				this.visible = false;
			else
				play();
		}
		
		/**
		 * 清理
		 */
		private function clear():void
		{
			if(!notiText) return;
			notiText.clear();
			notiText.removeEventListener(MouseEvent.MOUSE_OVER,notiTextMouseOverHandle);
			notiText.removeEventListener(MouseEvent.MOUSE_OUT,notiTextMouseOUtHandle);
			this.removeChild(notiText);
			notiText = null;
		}

	}
}