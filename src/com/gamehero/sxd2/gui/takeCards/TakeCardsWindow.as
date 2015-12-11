package com.gamehero.sxd2.gui.takeCards
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.core.components.UnderlineLabel;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.player.hero.model.HeroDict;
	import com.gamehero.sxd2.gui.takeCards.components.TakeCardsBtn;
	import com.gamehero.sxd2.gui.takeCards.components.TakeCardsHasHeroPanel;
	import com.gamehero.sxd2.gui.takeCards.components.TakeCardsLuckyBar;
	import com.gamehero.sxd2.gui.takeCards.event.TakeCardsEvent;
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSG_UPDATE_PRAY_ACK;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bowser.utils.MovieClipPlayer;

	/**
	 * 抽卡界面
	 * @author weiyanyu
	 * 创建时间：2015-10-14 15:17:35
	 * 
	 */
	public class TakeCardsWindow extends GeneralWindow
	{
		/**
		 * 拥有伙伴了，未领取 
		 */		
		private const HAS:int = 1;
		/**
		 * 没有开始抽 
		 */		
		private const NO:int = 2;
		
		public function TakeCardsWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, "TakeCardsWindow.swf", 994, 608);
		}
		
		private var _model:TakeCardsModel;
		
		private var _status:int;

		/**
		 * 伙伴令数量 
		 */		
		private var _luckChip:MoneyLabel;

		/**
		 * 幸运值 
		 */		
		private var _luckBar:TakeCardsLuckyBar;
		
		/**
		 * 已经领取伙伴的界面 
		 */		
		private var _hasHeroPanel:TakeCardsHasHeroPanel;
		
		/**
		 * 《神仙道2》书动画 
		 */		
		private var _bookMc:MovieClip;
		private var _bookMp:MovieClipPlayer;
		
		/**
		 * 书的动作列表  
		 * 关闭； 从关闭到打开； 翻页 ；静静的书本；合上书本； 
		 */		
		private var _bookActionVec:Vector.<McAction> = new <McAction>[new McAction(1,1),new McAction(1,11),new McAction(11,22),new McAction(23,42),new McAction(43,52)];
	
		
		
		/**
		 * 获取伙伴后，魂魄飞起的动画 
		 */		
		private var _soulMc:MovieClip;
		/**
		 * 翻页时候获得卡牌的动画（冒烟） 
		 */		
		private var _hadCardMc:MovieClip;
		/**
		 * 闪烁的背景 
		 */		
		private var _blinkMc:MovieClip;
		/**
		 * 背景闪烁动作列表  ：   紫色闪烁；橙色闪烁 
		 */		
		private var _blinkActionVec:Vector.<McAction> = new <McAction>[new McAction(1,8),new McAction(9,22)];
		
		private var _data:MSG_UPDATE_PRAY_ACK;
		
		/**
		 * 求神按钮 
		 */		
		protected var _takeBtn:TakeCardsBtn;
		
		/**
		 * 领取 伙伴(确定按钮)
		 */		
		private var _getBtn:TakeCardsBtn;
		
		private var _handBookLb:UnderlineLabel;
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			_model = TakeCardsModel.inst;
			_model.domain = uiResDomain;
			
			var innerBg:InnerBg = new InnerBg();
			innerBg.setSize(978,557);
			add(innerBg,8,37);
			innerBg = new InnerBg();
			innerBg.setSize(958,537);
			add(innerBg,18,47);
			var bg:Bitmap = new Bitmap();
			add(bg,23,53);
			bg.bitmapData = getSwfBD("BG");
			
			
			_bookMc = getSwfInstance("Book");
			add(_bookMc,500,276);
			_bookMc.stop();
			_bookMc.mouseChildren = false;
			_bookMc.mouseEnabled = false;
			

			_blinkMc = getSwfInstance("BgBlink") as MovieClip;
			add(_blinkMc,23,52);
			
			_handBookLb = new UnderlineLabel();
			addChild(_handBookLb);
			_handBookLb.text = "图鉴";
			_handBookLb.x = 38;
			_handBookLb.y = 70;
		
			_luckBar = new TakeCardsLuckyBar();
			add(_luckBar,360,78);
			_luckBar.visible = false;
			
			_bookMp = new MovieClipPlayer();
			
			_hasHeroPanel = new TakeCardsHasHeroPanel();
			addChild(_hasHeroPanel);
			
			_luckChip = new MoneyLabel();
			add(_luckChip,873,70);
			_luckChip.lb.color = GameDictionary.ORANGE;
			
			_takeBtn = new TakeCardsBtn();
			addChild(_takeBtn);
			
			_getBtn = new TakeCardsBtn();
			add(_getBtn,556,530);
			_getBtn.type = TakeCardsBtn.OK;
			
			_soulMc = getSwfInstance("Soul") as MovieClip;
			_soulMc.x = 50;
			_soulMc.y = 75;
			_hadCardMc = getSwfInstance("HadCardMc") as MovieClip;
			_hadCardMc.x = 500;
			_hadCardMc.y = 276;
			
			this.interrogation = Lang.instance.trans("tips_searchhero");
		}
		override public function onShow():void
		{
			super.onShow();
			if(_model.msg && _model.msg.items && _model.msg.items.length == TakeCardsModel.HERO_NUM)//如果已经有了伙伴，则不用再请求了
			{
				updata();
			}
			else
			{
				dispatchEvent(new UpdataEvent(UpdataEvent.WINDOW_ON_SHOW));
			}
			setHeroItemNum();
			
			addEventListener(TakeCardsEvent.CARDS_OPEN,onCardsOpen);
			
			_handBookLb.addEventListener(MouseEvent.CLICK,onOpenHandBook);
			
		}
		
		protected function onOpenHandBook(event:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.HERO_HANDBOOK_WINDOW);
		}
		/**
		 * 翻开一张伙伴卡牌 
		 * @param event
		 * 
		 */		
		protected function onCardsOpen(event:TakeCardsEvent):void
		{
			setComponentVisble();
			if(String(event.data) == HeroDict.PURPLE)//紫色伙伴
			{
				playMc(_blinkMc,_blinkActionVec[0].beginFrame,_blinkActionVec[0].endFrame);
			}
			else if(String(event.data) == HeroDict.ORANGE)//橙色伙伴
			{
				playMc(_blinkMc,_blinkActionVec[1].beginFrame,_blinkActionVec[1].endFrame);
			}
		}
		/**
		 * 抽卡成功后的刷新 
		 * @param msg
		 * 
		 */		
		public function takeBackUpdata():void
		{
			_hasHeroPanel.clear();
			if(_status == NO)
			{
				setBookStatus(1);
				_bookMp.addEventListener(Event.COMPLETE , opened);
				function opened():void
				{
					_bookMp.removeEventListener(Event.COMPLETE , opened);
					setBookStatus(2);
					playMc(_hadCardMc,1,_hadCardMc.totalFrames,function():void{updata();});// 播放抽到伙伴卡时候，书本冒烟的动画 
				}
			}
			else if(_status == HAS)
			{
				setBookStatus(2);
				playMc(_hadCardMc,1,_hadCardMc.totalFrames,function():void{updata();});// 播放抽到伙伴卡时候，书本冒烟的动画 
				playMc(_soulMc,1,_soulMc.totalFrames);//获得魂魄的动画
			}
			barBtnVisible = false;
			
		}
		/**
		 *  
		 * @param status  0关闭； 1从关闭到打开；2 翻页 ；3静静的书本；4合上书本； 
		 * @param backFunc
		 * 
		 */		 
		private function setBookStatus(status:int):void
		{
			_bookMp.play(_bookMc , (_bookActionVec[status].endFrame - _bookActionVec[status].beginFrame) / 24 , _bookActionVec[status].beginFrame , _bookActionVec[status].endFrame);//书本打开，翻页
			_bookMc.play();
			_bookMp.loop = status == 3 ? true : false;
		}
		/**
		 * 点击确定获得伙伴按钮的返回 
		 * @param msg
		 * 
		 */		
		public function onGetCardsBack():void
		{
			setBookStatus(4);
			_bookMp.addEventListener(Event.COMPLETE , bookOver);
			function bookOver(e:Event):void
			{
				_bookMp.removeEventListener(Event.COMPLETE , bookOver);
				updata();
			}
			
			_hasHeroPanel.clear();
			barBtnVisible = false;
			playMc(_soulMc,1,_soulMc.totalFrames);
			
		}
		//只播放一次mc
		private function playMc(mc:MovieClip,beginFrame:int,endFrame:int,callBack:Function = null):void
		{
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(mc,(endFrame - beginFrame) / 24 ,beginFrame,endFrame);
			mp.addEventListener(Event.COMPLETE , playOvered);
			mc.gotoAndPlay(1);
			addChild(mc);
			function playOvered(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , playOvered);
				removeChild(mc);
				if(callBack) callBack();
			}
		}
		
		/**
		 * 设置伙伴令数量 
		 * 
		 */		
		public function setHeroItemNum():void
		{
			try//物品有改变的时候也会设置这个位置的数据，而有可能窗口还没有初始化完全，_luckChip会报空
			{
				var propVo:PropBaseVo = ItemManager.instance.getPropById(TakeCardsModel.heroItemId);
				_luckChip.text = propVo.name + "：" + BagModel.inst.getItemNum(TakeCardsModel.heroItemId);
				_luckChip.setyByLabel(_luckChip.y);
				setComponentVisble();
			}
			catch(e:Error){}
		}
		
		public function updata():void
		{
			var msg:MSG_UPDATE_PRAY_ACK = _model.msg;
			
			_luckBar.luck = msg.lucky;
			
			if(_model.msg && _model.msg.items && _model.msg.items.length == TakeCardsModel.HERO_NUM)//抽到了五个伙伴
			{
				setBookStatus(3);
				_status = HAS;
				_hasHeroPanel.init();
			}
			else
			{
				_bookMc.gotoAndStop(1);
				_status = NO;
				_hasHeroPanel.clear();
			}
			setComponentVisble();
		}
		/**
		 * 伙伴开卡状态改变后需要设置 幸运值\按钮 的显示
		 * 
		 */		
		private function setComponentVisble():void
		{
			switch(_status)
			{
				case HAS:
					if(_model.heroIsOpenVec.indexOf(false) == -1)//所有卡片都已经打开
					{
						barBtnVisible = true;
						_takeBtn.x = 350;
						_takeBtn.y = 530;//抽卡的按钮位置要调整
						if(!_getBtn.hasEventListener(MouseEvent.CLICK))
							_getBtn.addEventListener(MouseEvent.CLICK,onGetCards);
					}
					else
					{
						barBtnVisible = false;
					}
					break;
				case NO:
					_takeBtn.visible = true;
					_takeBtn.x = 443;
					_takeBtn.y = 530;
					_getBtn.visible = false;
					break;
			}
			
			if(_takeBtn.visible)
			{
				if(BagModel.inst.getItemNum(TakeCardsModel.heroItemId) >= TakeCardsModel.heroItemCost)//有抽卡道具的时候,则显示令牌抽卡
				{
					_takeBtn.type = TakeCardsBtn.LINGPAI;
				}
				else
				{
					_takeBtn.type = TakeCardsBtn.YUANBAO;
				}
				if(!_takeBtn.hasEventListener(MouseEvent.CLICK))
					_takeBtn.addEventListener(MouseEvent.CLICK,onTakeCards);
			}
		}
		
		/**
		 * 统一隐\现组件 
		 * @param value
		 * 
		 */		
		private function set barBtnVisible(value:Boolean):void
		{
			_luckBar.visible = value;
			_getBtn.visible = value;
			_takeBtn.visible = value;
		}
		/**
		 * 获取抽卡的奖励 
		 * @param event
		 * 
		 */		
		private function onGetCards(event:MouseEvent):void
		{
			dispatchEvent(new TakeCardsEvent(TakeCardsEvent.GET_CARD,true));
		}
		/**
		 * 抽卡 
		 * @param event
		 * 
		 */		
		protected function onTakeCards(event:MouseEvent):void
		{
			if(_takeBtn.type == TakeCardsBtn.YUANBAO)
			{
				if(ItemCost.canUseSingItem([MoneyDict.YUANBAO,TakeCardsModel.moneyCost]))
				{
					dispatchEvent(new TakeCardsEvent(TakeCardsEvent.TAKE_CARD));
				}
			}
			else if(_takeBtn.type == TakeCardsBtn.LINGPAI)
			{
				if(ItemCost.canUseSingItem([TakeCardsModel.heroItemId,TakeCardsModel.heroItemCost]))
				{
					dispatchEvent(new TakeCardsEvent(TakeCardsEvent.TAKE_CARD));
				}
			}
		}
		
		
		override public function close():void
		{
			super.close();
			if(_hasHeroPanel != null)
			{
				_hasHeroPanel.clear();
			}
			_bookMp.stop();
			_luckBar.visible = true;
			
			_takeBtn.removeEventListener(MouseEvent.CLICK,onTakeCards);
			_getBtn.removeEventListener(MouseEvent.CLICK,onGetCards);
			removeEventListener(TakeCardsEvent.CARDS_OPEN,onCardsOpen);
			
			_handBookLb.removeEventListener(MouseEvent.CLICK,onOpenHandBook);
		}
	}
}

class McAction
{
	public function McAction(begin:int,end:int)
	{
		beginFrame = begin;
		endFrame = end;
	}
	public var beginFrame:int = 0;
	public var endFrame:int = 0;
	
}