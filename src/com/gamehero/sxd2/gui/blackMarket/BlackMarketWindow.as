package com.gamehero.sxd2.gui.blackMarket
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.blackMarket.model.BlackMarketModel;
	import com.gamehero.sxd2.gui.blackMarket.mystery.MysteryShop;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.TabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.TabPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import alternativa.gui.container.tabPanel.TabData;
	
	/**
	 * 黑市
	 * @author weiyanyu
	 * 创建时间：2015-9-17 15:59:07
	 * 
	 */
	public class BlackMarketWindow extends GeneralWindow
	{
		
		private var titleArr:Array = ["神秘商人"];
		
		private var tabBtnArr:Array;
		
		private var tabPanelArr:Vector.<IPanel>;
		/**
		 *  
		 */		
		private var _prePanel:IPanel;
		
		private var _mysteryShop:MysteryShop;
		/**
		 * 灵蕴数量 
		 */		
		private var _lingYunLb:MoneyLabel;
		
		public function BlackMarketWindow(position:int, resourceURL:String="BlackMarketWindow.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 816, 560);
		}
		override protected function initWindow():void
		{
			super.initWindow();
			
			BlackMarketModel.inst.domain = uiResDomain;
			
			var innerBg:InnerBg = new InnerBg();
			add(innerBg,10,40); 
			innerBg.setSize(792,502);
			
			var line:Bitmap = new Bitmap(getSwfBD("Line"));
			add(line,10,70,792,1);
			
			_lingYunLb = new MoneyLabel();
			add(_lingYunLb,700,45);
			_lingYunLb.iconId = MoneyDict.LINT_YUN;
			
			var tabPanel:TabPanel = new TabPanel(6);
			var tabButton:TabButton;
			tabBtnArr = [];
			tabPanelArr = new Vector.<IPanel>();
			_mysteryShop = new MysteryShop();
			addChild(_mysteryShop);
			tabPanelArr.push(_mysteryShop);
			
			var len:int = titleArr.length;
			var sp:Sprite = new Sprite();
			for(var i:int=0; i<len; i++)
			{
				tabButton = new TabButton(CommonSkin.blueButton2Up,CommonSkin.blueButton2Down,CommonSkin.blueButton2Down);
				tabButton.label = titleArr[i];
				tabButton.resize(68,27);
				tabButton.name = ""+i;
				
				tabPanel.addTab(new TabData(tabButton, sp));
				tabBtnArr.push(tabButton);
				tabButton.addEventListener(MouseEvent.CLICK, onTabClickHandler);
			}
			add(tabPanel, 30, 48, 219, 31);
			
			this.interrogation = Lang.instance.trans("tips_blackmarket");
		}
		
		override public function onShow():void
		{
			super.onShow();
			dispatchEvent(new UpdataEvent(UpdataEvent.WINDOW_ON_SHOW));
			_prePanel = _mysteryShop;
			_mysteryShop.init();
			
		}
		
		/**
		 * 灵蕴
		 */		
		public function setLingyun():void
		{
			try//物品有改变的时候也会设置这个位置的数据，而有可能窗口还没有初始化完全，_luckChip会报空
			{
				_lingYunLb.text = GameData.inst.playerExtraInfo.spirit + "";
				_lingYunLb.hint = Lang.instance.trans("tips_text_lingyun") + GameData.inst.playerExtraInfo.spirit;
			}
			catch(e:Error){}
		}
		/**
		 * 打开图鉴 
		 * @param event
		 * 
		 */		
		protected function onOpenHandBook(event:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.HERO_HANDBOOK_WINDOW);
		}
		
		private function onTabClickHandler(event:MouseEvent):void
		{
			var index:int = int(event.target.name);
			(tabBtnArr[index] as TabButton).selected = true;
			
			try
			{
				if(_prePanel != tabPanelArr[index])
				{
					if(_prePanel) _prePanel.clear();
					tabPanelArr[index].init();
					_prePanel = tabPanelArr[index];
				}
				
			}
			catch(e:Error)
			{
				
			}
		}	
		
		public function Updata(msg:MSG_UPDATE_BLACK_MARKET_ACK):void
		{
			_mysteryShop.Updata(msg);
			setLingyun();
		}
		
		
		override public function close():void
		{
			super.close();
			_mysteryShop.clear();
		}
	}
}