package com.gamehero.sxd2.gui.equips
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.EquipOprateCont;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipGroup;
	import com.gamehero.sxd2.gui.equips.equipStrengthen.component.EquipRenderItem;
	import com.gamehero.sxd2.gui.equips.event.EquipEvent;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.player.hero.components.HeroTabBox;
	import com.gamehero.sxd2.gui.player.hero.event.HeroEvent;
	import com.gamehero.sxd2.gui.core.tab.TabEvent;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.TabPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.PRO_Hero;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-10 11:15:14
	 * 
	 */
	public class EquipWindow extends GeneralWindow
	{
		
		
		private var _pagePanel:TabPanel;
		
		/** 强化按钮*/
		private var _strenBtn:SButton;
		
		/**
		 * 页签盒子 
		 */		
		private var _heroTabBox:HeroTabBox;
		/**
		 * 装备列表 
		 */		
		private var _equipGroup:EquipGroup;
		/**
		 * 操作区域 
		 */		
		private var _equipOprate:EquipOprateCont;
		
		private var _heroModel:HeroModel;
		
		private var _equipModel:EquipModel;
		
		/**
		 * 是否是打开后第一次接收数据
		 */		
		private var _isFirst:Boolean;
		
		public function EquipWindow(resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, "EquipWindow.swf", 678, 486);
		}
		override protected function initWindow():void
		{
			super.initWindow();
			_heroModel = HeroModel.instance;
			_equipModel = EquipModel.inst;
			_equipModel.domain = this.uiResDomain;
			
			var innerBg:InnerBg = new InnerBg();
			innerBg.setSize(658, 382);
			innerBg.x = 10;
			innerBg.y = 88;
			addChild(innerBg);
			var topBg:Bitmap = new Bitmap(getSwfBD("topBg"));
			addChild(topBg);
			topBg.x = 10;
			topBg.y = 39;
			var equipBg:ScaleBitmap = new ScaleBitmap();
			equipBg.bitmapData = CommonSkin.windowInner4Bg;
			equipBg.scale9Grid = CommonSkin.windowInner4BgScale9Grid;//左侧装备背景图的框
			add(equipBg,13,92);
			equipBg.setSize(187,371);
			equipBg = new ScaleBitmap();//右侧操作区的框
			equipBg.bitmapData = CommonSkin.windowInner4Bg;
			equipBg.scale9Grid = CommonSkin.windowInner4BgScale9Grid;
			add(equipBg,203,92);
			equipBg.setSize(462,371);
			
			var greyBg:Bitmap = new Bitmap(getSwfBD("EquipBg"));//左侧装备背景图
			add(greyBg,18,96);
			
			_pagePanel = new TabPanel(4,TabPanel.LayoutType_Vertical);
			
			_heroTabBox = new HeroTabBox();
			_heroTabBox.setSkin(getSwfBD("tabBtnOver"),getSwfBD("tabBtnUp"),getSwfBD("tabBtnDown"));
			_heroTabBox.x = -56;
			_heroTabBox.y = 95;
			addChild(_heroTabBox);
			
			_equipGroup = new EquipGroup(getSwfBD("EquipOver"),getSwfBD("EquipOver"));
			_equipGroup.gapY = 0;
			addChild(_equipGroup);
			_equipGroup.x = 18;
			_equipGroup.y = 98;
			
			_equipOprate = new EquipOprateCont();
			add(_equipOprate);
			
//			_strenBtn = new Button(getSwfBD("Stren_Over"),getSwfBD("Stren_Over"),getSwfBD("Stren_Up"));
			_strenBtn = new SButton(Global.instance.getRes(MainSkin.domain,"EquipMenuBtn") as SimpleButton);
			add(_strenBtn,28,20);
//			_pagePanel.addTab(new TabData(_strenBtn, _equipOprate));
//			add(_pagePanel, 193, 95, 482, 386);
			
			this.interrogation = Lang.instance.trans("tips_equip");
		}
		
		override public function onShow():void
		{
			super.onShow();
			_isFirst = true;
			/**请求上阵伙伴列表*/
			this.dispatchEvent(new HeroEvent(HeroEvent.REQ_HERO_LIST));
			/**伙伴切页*/
			_heroTabBox.addEventListener(TabEvent.SELECTED,onTabSelected);
			
			_equipGroup.addEventListener(EquipEvent.SELECTED,onEquipSelected);
		}
		override public function close():void
		{
			super.close();
			_equipOprate.clear();
			_heroTabBox.clear();
			_heroTabBox.removeEventListener(TabEvent.SELECTED,onTabSelected);
			_equipGroup.removeEventListener(EquipEvent.SELECTED,onEquipSelected);
		}
		
		//==================================================================================
		/**
		 * 选中装备位置 
		 * @param event
		 * 
		 */		
		protected function onEquipSelected(event:EquipEvent):void
		{
			var item:EquipRenderItem = (event.data as EquipRenderItem);
			_equipOprate.setData(item,true);
		}
		/**伙伴切页*/
		protected function onTabSelected(event:TabEvent):void
		{
			updateHeroInfo();
		}
		
		public function updateHeroInfo():void
		{
			if(_isFirst)//第一次打开的时候初始化tab
			{
				_heroModel.heroListSort();
				_isFirst = false;
				_heroTabBox.init(_heroModel.heroInfoList);
			}
			else if(_heroTabBox && _heroTabBox.curBtn && _heroTabBox.curBtn.hero)//自由切换页签的时候
			{
				var value:PRO_Hero = _heroModel.getHeroById(int(_heroTabBox.curBtn.hero.id));
				_equipGroup.data = ([value.weapon,value.head,value.cloth,value.neck,value.shoes,value.ring]);//武器、头盔、衣服、护符、鞋、战魂。
				_equipOprate.setData(_equipGroup.curSelectedItem);
			}
			if(_heroTabBox && _heroTabBox.curBtn && _heroTabBox.curBtn.hero)
				_equipModel.curSelectedId = int(_heroTabBox.curBtn.hero.id);
		}
		
		public function playMc():void
		{
			_equipOprate.playMc();
		}
	}
}