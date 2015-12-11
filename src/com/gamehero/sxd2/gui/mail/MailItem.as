package com.gamehero.sxd2.gui.mail
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.util.Time;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.utils.time.TimeTick;

	
	/**
	 * 邮箱左侧列表模块
	 * @author zhangxueyou
	 * @create 2015-10-9
	 **/
	
	public class MailItem extends ActiveObject
	{
		public var mailId:UInt64;//当前邮件Id
		private var mailName:TextField;//邮件名称文本对象
		private var mailDate:TextField;//邮件日期文本对象
		private var titleFormatStr:String;//邮件名称文本样式
		private var dateFormatStr:String;//邮件日期文本样式
		public var itemOverIcon:Bitmap;//鼠标移入图片对象
		public var isOver:Boolean;//是否选择标示
		private var itemMailIcon:Bitmap;//邮件状态图标
		private var itemAccathIcon:Bitmap;//附件状态图标
		private var itemBg:Bitmap;//邮件状态图标背景

		/**
		 *构造 
		 * 
		 */		
		public function MailItem()
		{
			super();
			
			initUI();
		}
		
		/**
		 *初始化UI 
		 * 
		 */		
		private function initUI():void
		{
			this.width = 186;
			this.height = 59;
			
			itemBg = new Bitmap(ItemSkin.BAG_ITEM_NORMAL_BG);
			itemBg.x = 8;
			itemBg.y = 2;
			addChild(itemBg);
			
			//固定文本样式
			titleFormatStr = "<font size='12' face='宋体' color='#" + GameDictionary.ORANGE.toString(16) + "'>";
			dateFormatStr = "<font size='12' face='宋体' color='#" + GameDictionary.WINDOW_BLUE.toString(16) + "'>";
			
			mailName = new TextField();
			mailName.selectable = false;
			mailName.x = 72;
			mailName.y = 10;
			mailName.height = 18;
			addChild(mailName);
			
			mailDate = new TextField();
			mailDate.selectable = false;
			mailDate.x = 72;
			mailDate.y = 30;
			mailDate.height = 18;
			addChild(mailDate);
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0x0000ff,0);
			sp.graphics.drawRect(0,0,this.width,this.height);
			sp.graphics.endFill();
			addChild(sp);
		}
		
		/**
		 *设置item数据 
		 * @param id
		 * @param mailIcon
		 * @param accathIcon
		 * @param titleStr
		 * @param dateStr
		 * @param overIcon
		 * 
		 */		
		public function setItemInfo(id:UInt64,mailIcon:BitmapData,accathIcon:BitmapData,titleStr:int,dateStr:int,overIcon:BitmapData):void
		{
			mailId = id;
			itemMailIcon = new Bitmap(mailIcon);
			itemMailIcon.x = 8;
			addChild(itemMailIcon);
			if(accathIcon)
			{
				itemAccathIcon = new Bitmap(accathIcon);
				itemAccathIcon.x = 38;
				itemAccathIcon.y = 32;
				addChild(itemAccathIcon);
			}
					
			mailName.htmlText = titleFormatStr + Lang.instance.trans(titleStr.toString());

			mailDate.htmlText = dateFormatStr + Time.getStringTime8(int(TimeTick.inst.getCurrentTime()*0.001) - dateStr);
			
			itemOverIcon = new Bitmap(overIcon);
			addChild(itemOverIcon);
		}
		
		/**
		 *邮件状态改变 
		 * @param mailIcon
		 * 
		 */		
		public function changeMailStatus(mailIcon:BitmapData):void
		{
			itemMailIcon.bitmapData = mailIcon;
		}
		
		/**
		 *附件状态改变 
		 * 
		 */		
		public function changeAccathStatus():void
		{
			if(itemAccathIcon)
				itemAccathIcon.visible = false;
		}
		
		/**
		 *设置移入移出状态 
		 * @param bool
		 * 
		 */		
		public function setOverHandle(bool:Boolean):void
		{
			if(!isOver)
				itemOverIcon.visible = bool;
		}
		
		/**
		 *清理 
		 * 
		 */		
		public function clear():void
		{
			removeChild(itemBg);
			itemBg = null;
			removeChild(itemMailIcon);
			itemMailIcon = null;
			if(itemAccathIcon)
			{
				removeChild(itemAccathIcon);
				itemAccathIcon = null;
			}
			mailName = null;
			mailDate = null;
			removeChild(itemOverIcon);
			itemOverIcon = null;
		}
	}
}