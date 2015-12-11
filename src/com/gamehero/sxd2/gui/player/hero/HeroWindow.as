package com.gamehero.sxd2.gui.player.hero
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.player.hero.components.ActiveLabel;
	import com.gamehero.sxd2.gui.player.hero.components.HeroEquipGrid;
	import com.gamehero.sxd2.gui.player.hero.components.HeroTabBox;
	import com.gamehero.sxd2.gui.player.hero.components.PropLabel;
	import com.gamehero.sxd2.gui.player.hero.event.HeroEvent;
	import com.gamehero.sxd2.gui.core.tab.TabEvent;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Property;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.CursorManager;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 伙伴玩家窗口
	 * @author xuwenyi
	 * @create 2015-06-25
	 **/
	public class HeroWindow extends GeneralWindow
	{
		private var _model:HeroModel;
		/**
		 * 页签盒子 
		 */		
		private var _heroTabBox:HeroTabBox;
		/**
		 * 伙伴面板
		 * */
		private var _heroPanel:Sprite;
		/**当前伙伴信息*/
		private var _heroInfo:PRO_Hero;
		/**
		 * 伙伴原画
		 * */
		private var _heroImgContainer:ActiveObject;
		/**
		 * 伙伴动画
		 * */
		private var _heroFigure:SpriteFigureItem;
		
		/**
		 * 伙伴名字
		 * */
		private var _nameLabel:Label;
		
		
		/**
		 * 图标容器（为了显示tips） 
		 */		
		private var _raceIconAo:ActiveObject;
		/**
		 * 伙伴阵营图标
		 * */
		private var _raceIcon:Bitmap;
		/**
		 * 技能Label
		 * */
		private var _skillLabel:ActiveLabel;
		
		/**装备*/
		private var _equipModel:Bitmap;
		/**
		 * 战力
		 * */
		/*private var _powerBp:BitmapNumber;*/
		
		/**底部功能容器*/
		private var _bottomContainer:Sprite;
		/**详细属性*/
		private var _statsAry:Vector.<PropLabel>;
		private var _functionBtn:Array = ["加油"];
		/**战力*/
		private var _powerBg:Bitmap;
		private var _battlePowerPanel:HeroBattlePowerPanel;
		
		
		/**
		 * 格子 
		 */		
		private var _equipGrid:HeroEquipGrid;
		/**
		 * 是否是打开后第一次接收数据
		 */		
		private var _isFirst:Boolean;
		/**
		 * 构造函数
		 * */
		public function HeroWindow(position:int, resourceURL:String = "HeroWindow.swf")
		{
			super(position, resourceURL, 430, 535);
		}

		override protected function initWindow():void
		{
			super.initWindow();
			_model = HeroModel.instance;
			_model.domain = this.uiResDomain;
			this.init();
		}
		
		/**窗口初始化*/
		private function init():void
		{
			
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(414, 479);
			innerBg.x = 8;
			innerBg.y = 39;
			addChild(innerBg);
			
			innerBg = new ScaleBitmap(CommonSkin.windowInner3Bg);
			innerBg.scale9Grid = CommonSkin.windowInner3BgScale9Grid;
			innerBg.setSize(398, 392);
			innerBg.x = 16;
			innerBg.y = 76;
			addChild(innerBg);
			
			_heroTabBox = new HeroTabBox();
			_heroTabBox.setSkin(this.getSwfBD("tabBtnOver"),this.getSwfBD("tabBtnUp"),this.getSwfBD("tabBtnDown"));
			_heroTabBox.x = -58;
			_heroTabBox.y = 54;
			addChild(_heroTabBox);
			
			this._nameLabel = new Label();//名字
			this._nameLabel.y = 53;
			this._nameLabel.size = 12;
			this._nameLabel.align = Align.CENTER;
			addChild(this._nameLabel);
			
			this._skillLabel = new ActiveLabel();//技能
			_skillLabel.cursorType = CursorManager.ARROW;
			this._skillLabel.label.align = Align.LEFT;
			this._skillLabel.label.color = GameDictionary.WINDOW_BLUE;
			this._skillLabel.hint = "";
			this._skillLabel.x = 365;
			this._skillLabel.y = 52;
			addChild(this._skillLabel);
			
			var powerBg:Bitmap = new Bitmap(Global.instance.getBD(HeroModel.instance.domain,"fazhen"));//法阵底子
			powerBg.x = 68;
			powerBg.y = 317;
			addChild(powerBg);
			powerBg = new Bitmap(Global.instance.getBD(HeroModel.instance.domain,"propBg"));//属性底子
			powerBg.x = 16;
			powerBg.y = 408;
			addChild(powerBg);

			
			//原画背景容器
			this._heroImgContainer = new ActiveObject();
			this._heroImgContainer.hint = Lang.instance.trans("hero_tips_14");
			_heroImgContainer.graphics.beginFill(0,0);
			_heroImgContainer.graphics.drawRect(-121,-280,242,280);
			_heroImgContainer.graphics.endFill();
			_heroImgContainer.x = 216;
			_heroImgContainer.y = 348;
			this._heroImgContainer.addEventListener(MouseEvent.CLICK,openHeroStatsWindow);
			addChild(this._heroImgContainer);
			_heroImgContainer.mouseChildren = false;
			
			_powerBg = powerBg = new Bitmap(Global.instance.getBD(HeroModel.instance.domain,"power"));//战力字
			powerBg.x = 107;
			powerBg.y = 350;
			addChild(powerBg);
			//装备格子
			_equipGrid = new HeroEquipGrid(Global.instance.getBD(HeroModel.instance.domain,"equipBg"));
			_equipGrid.width = 600;
			_equipGrid.height = 500;
			_equipGrid.mouseOverAble = true;
			_equipGrid.clickAble = true;
			_equipGrid.setRace("god_");
			addChild(_equipGrid);
			_equipGrid.initGrid(2,3,59,235,40);
			_equipGrid.x = 42;
			_equipGrid.y = 107;
			
			/*this._powerBp = new BitmapNumber();
			this._powerBp.y = 369;
			addChild(this._powerBp);*/
			
			//战力数字动画
			addChild(this._battlePowerPanel = new HeroBattlePowerPanel());
			this._battlePowerPanel.y = 355;
			this._battlePowerPanel.init();
			
			this._bottomContainer = new Sprite();
			this._bottomContainer.y = 477;
			addChild(this._bottomContainer);
			
			//阵营底图
			this._raceIcon = new Bitmap(Global.instance.getBD(HeroModel.instance.domain,"ellipseBG"));
			this._raceIcon.x = 333;
			this._raceIcon.y = 46;
			addChild(this._raceIcon);
			
			this._raceIcon = new Bitmap();
			_raceIconAo = new ActiveObject();
			addChild(_raceIconAo);
			_raceIconAo.x = 333;
			_raceIconAo.y = 46;
			_raceIconAo.addChild(_raceIcon);
			_raceIconAo.mouseChildren = false;
			_raceIconAo.cursorType = CursorManager.ARROW;
			
			_statsAry = new Vector.<PropLabel>();
			//"武力","智力","根骨"
			var infoArr:Vector.<String> = new <String>["武力","智力","根骨"];
			var baseInfoLabel:PropLabel;
			for(var i:int = 0; i < 3 ; i++)
			{
				baseInfoLabel = new PropLabel(infoArr[i],"",null);
				baseInfoLabel.label.color = GameDictionary.WINDOW_WHITE;
				baseInfoLabel.cursorType = CursorManager.ARROW;
				baseInfoLabel.hint = Lang.instance.trans("hero_tips_"+(i+1));
				baseInfoLabel.x = i*104 + 80;
				baseInfoLabel.y = 429;
				addChild(baseInfoLabel);
				_statsAry.push(baseInfoLabel);
			}
			
			var button:Button; 
			for(i = 0 ; i<this._functionBtn.length;i++)
			{
				button = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over,CommonSkin.blueButton1Disable);
				button.label = _functionBtn[i];
				button.x = i * 100;
//				button.addEventListener(MouseEvent.CLICK,actionBtnClickHandle);
				this._bottomContainer.addChild(button);
			}
			//底部按钮始终居中
			this._bottomContainer.x = (430 - this._bottomContainer.width) >> 1;
		}
		
		override public function onShow():void
		{
			_isFirst = true;
			super.onShow();
			/**请求上阵伙伴列表*/
			this.dispatchEvent(new HeroEvent(HeroEvent.REQ_HERO_LIST));
			/**伙伴切页*/
			_heroTabBox.addEventListener(TabEvent.SELECTED,onTabSelected);
		}
		
		
		override public function close():void
		{
			super.close();
			this._heroInfo = null;
			if(this._heroFigure)
			{
				this._heroFigure.clear();
				this.removeChild(this._heroFigure);
			}
			this._heroFigure = null;
			HeroModel.instance.clear();
			_heroTabBox.clear();
			_heroTabBox.removeEventListener(TabEvent.SELECTED,onTabSelected);
			//同时关闭详细属性面板
			WindowManager.inst.closeGeneralWindow(HeroDetailWindow);
			_isFirst = false;
		}
		
		//==============================数据================================================
		public function updateHeroInfo():void
		{
			if(_isFirst)
			{
				_model.heroListSort();
				_heroTabBox.init(_model.heroInfoList);
			}
			if(_heroTabBox && _heroTabBox.curBtn && _heroTabBox.curBtn.hero)
				updataUserInfo(_model.getHeroById(int(_heroTabBox.curBtn.hero.id)));
		}
		
		/**伙伴切页*/
		protected function onTabSelected(event:TabEvent):void
		{
			if(!_isFirst)
			{
				updataUserInfo(_model.getHeroById(int(_heroTabBox.curBtn.hero.id)));
			}
			HeroModel.instance.curSelectedId = int(_heroTabBox.curBtn.hero.id);
		}
		
		/**刷新伙伴信息*/
		private function updataUserInfo(value:PRO_Hero):void
		{
			if(value == null) return;
			var	heroVo:HeroVO = HeroManager.instance.getHeroByID(value.heroId.toString());
			
			if(this._heroFigure)
			{
				this._heroFigure.stop();
				this.removeChild(this._heroFigure);
			}
			var url:String = GameConfig.FIGURE_URL + "body_ui/" +  heroVo.id;
			HeroModel.instance.addResource(url);
			this._heroFigure = new SpriteFigureItem(url, false , BattleFigureItem.UI_STAND);
			this._heroFigure.frameRate = 12;
			this._heroFigure.play();
			this._heroFigure.x = 216;
			this._heroFigure.y = 348;
			this._heroFigure.mouseEnabled = false;
			this._heroFigure.mouseChildren = false;
			this.addChildAt(this._heroFigure,8);
			
			if((_heroInfo == null) || (_heroInfo.heroId != value.heroId))
			{
				this._heroInfo = value;
				/*if(this._heroImgContainer.numChildren > 0)
				{
					this._heroImgContainer.removeChildAt(0);
				}
				BulkLoaderSingleton.instance.addWithListener(GameConfig.HERO_URL + "body/" + this._heroInfo.heroId + ".swf",null,onIconloaded);
				BulkLoaderSingleton.instance.start()*/
			}
			
			this._heroInfo = value;
			this._nameLabel.text = heroVo.name;
			this._nameLabel.x = (430 - this._nameLabel.width) >> 1;
			this._nameLabel.color = GameDictionary.getColorByQuality(int(heroVo.quality));
			//阵营
			_raceIcon.bitmapData = HeroSkin.getRaceSkin(heroVo.race);
			_raceIconAo.hint = Lang.instance.trans("AS_race_" + heroVo.race);
			//技能
			this._skillLabel.hint = Lang.instance.trans("skill_des_" + heroVo.special_skill_id);
			this._skillLabel.label.text = Lang.instance.trans("skill_name_" + heroVo.special_skill_id);
			//战力
			/*this._powerBp.update(BitmapNumber.WINDOW_S_YELLOW,value.base.power.toString());
			this._powerBp.x = _powerBg.x + ((_powerBg.width - this._powerBp.width) >> 1);*/
			
			this._battlePowerPanel.bEfAnimation(value.base.power,value.heroId,0,_isFirst);
			_isFirst = false;
			this._battlePowerPanel.x = 172 - (this._battlePowerPanel.numLen >>1);
		
			_equipGrid.setData([value.ring,value.weapon,value.neck,value.head,value.cloth,value.shoes]);
			
			var property:PRO_Property = value.base.property;
			var propArr:Vector.<int> = new <int>[property.force,property.intellect,property.skeleton];
			for(var i:int in _statsAry)
			{
				_statsAry[i].propNum = propArr[i];
			}
			
			this.updateHeroDetailWindow();
			if(windowParam)
			{
				_model.itemHeroEquip(UInt64(windowParam),HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON);
				windowParam = null;
			}
		}
		private function onIconloaded(evt:Event):void
		{
			var imageItem:ImageItem = evt.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconloaded);
			
			//直接加在swf到舞台
			var heroBg:MovieClip = imageItem.content;
			if(heroBg)
			{
				this._heroImgContainer.addChild(heroBg);
			}
		}
		
		private function openHeroStatsWindow(e:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.PLAYER_STATS,_heroInfo);
		}
		
		/**切页刷新详细信息*/
		private function updateHeroDetailWindow():void
		{
			/**详细信息窗口若打开则更新*/
			var heroInfo:HeroDetailWindow = WindowManager.inst.getWindowInstance(HeroDetailWindow,WindowPostion.CENTER_RIGHT) as HeroDetailWindow
			if(heroInfo && heroInfo.isOpen)
			{
				heroInfo.updataHeroInfo(this._heroInfo);
			}
		}
	}
}