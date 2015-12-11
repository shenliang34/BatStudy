package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.CheckBox;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-2 下午8:02:56
	 * 伙伴图鉴cell
	 */
	public class HerohandbookCell extends ActiveObject
	{
		private var _loader:BulkLoaderSingleton;
		/**
		 * 伙伴
		 * */
		public var heroPro:PRO_Hero;
		public var heroVo:HeroVO;
		/**
		 * 是否上阵
		 * */
		private var inBattle:Boolean = false;
		/**
		 * 是否助阵
		 * */
		private var inFatter:Boolean = false;
		
		/**
		 * 是否激活
		 * */
		private var isActive:Boolean = false;
		
		/**
		 * 头像
		 * */
		private var headIcon:Bitmap;
		private var heroNameLabel:Label;
		
		private var bg:Bitmap;
		private var pointBg:Bitmap;
		private var jbBg:Bitmap;
		private var chip:Bitmap;
		private var overBg:Bitmap;
		private var battle:Bitmap;
		private var fatter:Bitmap;
		private var gray:Bitmap;
		private var enableBmp:Bitmap;
		
		/**
		 *当前已有的
		 * */
		private var ownLabel:Label;
		private var ownNum:int;
		/**
		 * 激活所需
		 * */
		private var needLabel:Label;
		private var needNum:int;
		
		
		/**
		 * 伙伴职业
		 * */
//		private var careerLabel:Label;
		
		/**
		 * 伙伴技能
		 * */
//		private var skillLabel:Label;
		/**
		 * 查看详情按钮
		 * */
		private var detailBtn:HeroHandbookLookBtn;
		/**
		 * 分解勾选框
		 * */
		private var selectedBox:CheckBox;
		private var smallBar:MovieClip;
		
		/**
		 *是否可激活
		 * */
		public var enable:Boolean = false;
		
		/**
		 * 遮罩
		 * */
		private var iconMask:Bitmap;
		/**
		 * 碎片
		 * */
		private var heroChips:Bitmap;
		
		public function HerohandbookCell()
		{
			this._loader = BulkLoaderSingleton.instance;
			
			this.overBg = new Bitmap();
			this.overBg.x = -18;
			this.overBg.y = -18;
			this.overBg.visible = false;
			this.addChild(overBg);
			
			this.bg = new Bitmap(HeroHandbookSkin.NO_HERO_BG);
			this.addChild(bg);
			
			this.pointBg = new Bitmap(HeroHandbookSkin.PUR_POINT_BG);
			this.pointBg.x = 10;
			this.pointBg.y = 103;
			this.pointBg.visible = false;
			this.addChild(pointBg);
			
			this.jbBg = new Bitmap(HeroHandbookSkin.JB);
			this.jbBg.x = 30;
			this.jbBg.y = 115;
			this.jbBg.visible = false;
			this.addChild(this.jbBg);
			
			this.chip = new Bitmap(HeroHandbookSkin.CHIP);
			this.chip.x = 30;
			this.chip.y = 110;
			this.chip.visible = false;
			this.addChild(this.chip);
			
			this.headIcon = new Bitmap();
			this.headIcon.x = 35;
			this.headIcon.y = 41;
			this.headIcon.cacheAsBitmap = true;
			this.addChild(this.headIcon);
			
			this.heroNameLabel = new Label();
			this.heroNameLabel.text = GameDictionary.createCommonText(" ");
			this.heroNameLabel.x = 30;
			this.heroNameLabel.y = 19;
			this.addChild(this.heroNameLabel);
			
			this.ownLabel = new Label();
			this.ownLabel.text = GameDictionary.createCommonText("0/0");
			this.ownLabel.x = 15;
			this.ownLabel.y = 117;
			this.ownLabel.visible = false;
			this.addChild(this.ownLabel);
			
//			this.needLabel = new Label();
//			this.needLabel.text =  GameDictionary.createCommonText("/0");
//			this.needLabel.x = 70;
//			this.needLabel.y = 117;
//			this.addChild(this.needLabel);
			
//			this.careerLabel = new Label();
//			this.careerLabel.text =  GameDictionary.createCommonText("职业:金刚");
//			this.careerLabel.x = 20;
//			this.careerLabel.y = 100;
//			this.addChild(this.careerLabel);
			
//			this.skillLabel = new Label();
//			this.skillLabel.text =  GameDictionary.createCommonText("金刚金刚");
//			this.skillLabel.x = 15;
//			this.skillLabel.y = 115;
//			this.addChild(this.skillLabel);
			
			this.selectedBox = new CheckBox();
			this.selectedBox.x = 10;
			this.selectedBox.y = 20;
			this.selectedBox.locked = false;
			this.selectedBox.checked = false;
			this.selectedBox.visible = false;
			this.addChild(this.selectedBox);
			
			this.battle = new Bitmap(HeroHandbookSkin.IN_BATTLE);
			this.battle.x = 10;
			this.battle.y = 15;
			this.battle.visible = false;
			this.addChild(this.battle);
			
			this.fatter = new Bitmap(HeroHandbookSkin.IN_FETTER);
			this.fatter.x = 10;
			this.fatter.y = 15;
			this.fatter.visible = false;
			this.addChild(this.fatter);
			
			this.smallBar = new HeroHandbookSkin.SMALL_PROGRESS_BAR() as MovieClip;
			this.smallBar.x = 45;
			this.smallBar.y = 120;
			this.smallBar.scaleX = 0.3;
			this.smallBar.scaleY = 0.6;
			this.smallBar.gotoAndStop(0);
			this.smallBar.visible = false;
			this.addChild(this.smallBar);
			
			this.gray = new Bitmap(HeroHandbookSkin.GRAY);
			this.gray.visible = false;
			this.addChild(this.gray);
			
			this.iconMask = new Bitmap(ItemSkin.ChipBigMask);
			this.iconMask.x = 35;
			this.iconMask.y = 41;
			this.iconMask.cacheAsBitmap = true;
			this.iconMask.visible = false;
			this.addChild(this.iconMask);
			
			this.heroChips = new Bitmap(ItemSkin.ChipBig);
			this.heroChips.x = 35;
			this.heroChips.y = 41;
			this.heroChips.visible = false;
			this.addChild(this.heroChips);
			
			this.detailBtn = new HeroHandbookLookBtn(HeroHandbookSkin.FDJ_BG,HeroHandbookSkin.FDJ);
			this.detailBtn.x = 75;
			this.detailBtn.y = 40;
			this.detailBtn.visible = false;
			this.detailBtn.hint = " ";
			this.addChild(this.detailBtn);
			
			this.enableBmp = new Bitmap();
			this.enableBmp.x = -18;
			this.enableBmp.y = -18;
			this.enableBmp.visible = false;
			this.addChildAt(this.enableBmp,0);
			
			this.reLocation();
		}
		
		/**
		 * data 伙伴信息
		 * */
		public function setData(data:HeroVO = null):void
		{
			if(data && data.display == "1")
			{
				this.heroVo = data;
				
				//头像
				this._loader.addWithListener(GameConfig.ITEM_ICON_URL + this.heroVo.item_id + "_store.jpg", null, onIconLoaded, null, onIconError);
				this._loader.start();
				//名字
				this.heroNameLabel.text = GameDictionary.createCommonText(this.heroVo.name,GameDictionary.getColorByQuality(int(this.heroVo.quality)));
				//职业
//				this.careerLabel.text =  GameDictionary.createCommonText("职业：" + GameDictionary.getJobName(this.heroVo.job));
				//技能
//				var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(this.heroVo.special_skill_id);
//				this.skillLabel.text =  GameDictionary.createCommonText("技能：" + skill.name);
				
				//详细信息按钮
				this.detailBtn.setData(this.heroVo);
				
				this.detailBtn.addEventListener(MouseEvent.CLICK,onFigure);
				this.addEventListener(Event.ENTER_FRAME,onFrame);
				this.addEventListener(MouseEvent.CLICK,onSoul);
				
				this.heroPro = FormationModel.inst.getPHero(int(heroVo.id));
				if(heroPro)
				{
					this.isActive = true;
					this.inBattle = FormationModel.inst.checkHeroInBattle(heroPro.base.id);
					this.inFatter = FormationModel.inst.checkHeroInHelp(heroPro.base.id);
					this.battle.visible = this.inBattle;
					this.fatter.visible = this.inFatter;
					//当前阵营已激活的伙伴数量
					HerohandbookModel.inst.activeHeroNum ++ ;
				}
				
				this.active();
				this.reLocation();
			}
			this.choseBg();
		}
		
		/**
		 * 伙伴激活状态
		 * */
		private function active():void
		{
			this.jbBg.visible = this.isActive;
			this.gray.visible = !this.isActive;
			this.ownLabel.visible = !(this.heroVo == null);
			this.chip.visible = this.isActive;
			this.pointBg.visible = !this.chip.visible;
			
			//分解信息
			var heroItem:PropBaseVo = ItemManager.instance.getPropById(int(heroVo.item_id));
			this.need = heroItem.cost.itemCostNum;
			
			this.own = BagModel.inst.getSoulNum(int(heroVo.chips_id));
			this.enableBmp.visible = (this.own >= this.need)&&!this.isActive;
			this.enable = (this.own >= this.need)&&(!this.isActive);
			this.smallBar.gotoAndStop(int(this.smallBar.totalFrames*(this.own/this.need)));
			this.smallBar.visible = !this.isActive;
		}
		
		/**
		 * 选择需要分解的伙伴
		 * */
		public function set seleceted(sel:Boolean):void
		{
			if(this.heroVo)
			{
				this.heroChips.visible = sel;
				this.headIcon.mask =  sel?this.iconMask:null;
				this.selectedBox.visible = this.selectedBox.checked = sel && (!this.inBattle) && this.isActive && (this.own > 0)&&(!this.inFatter);
			}
		}
		
		/**
		 * 当前分解过程是否选中
		 * */
		public function get seleceted():Boolean
		{
			return this.selectedBox.checked;
		}
		
		private function onFigure(evt:MouseEvent = null):void
		{
			var data:Object = new Object();
			data.heroVo = this.heroVo;
			data.proHero = this.heroPro;
			this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.OPEN_FIGURE,data));
		}
		
		private function onSoul(evt:MouseEvent):void
		{
			if(evt.target != this.detailBtn)
			{
				if(!this.isActive && this.own >= this.need)
				{
					//保存当前要激活的伙伴
					HerohandbookModel.inst.activeHero = this.heroVo;
					DialogManager.inst.showCost(DialogManager.ONCE,"是否召唤当前选中伙伴！",function():void
					{
						sendActive();
					});
				}
				else
				{
					this.onFigure();
					/*DialogManager.inst.showCost(DialogManager.GO_FUBEN,"前往剧情副本获得碎片!",function():void
					{
						WindowManager.inst.openWindow(HurdleGuideWindow, WindowPostion.CENTER, false, false, true, 2);
					});*/
				}
			}
		}
		
		/**
		 * 伙伴激活发送当前伙伴碎片的配置id
		 * */
		private function sendActive():void
		{
			this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_ENABLE,this.heroVo.chips_id));
		}

		
		private function onIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			this.headIcon.bitmapData = imageItem.content.bitmapData == null?HeroHandbookSkin.NO_HEAD_ICON:imageItem.content.bitmapData;
		}
		
		private function onIconError(event:Event):void
		{
			this.headIcon.bitmapData = HeroHandbookSkin.NO_HEAD_ICON;
		}
		
		private function onFrame(evt:Event):void
		{
			if(this.mouseX < 0 || this.mouseX > 120 || this.mouseY < 0 || this.mouseY > 140 )
			{
				this.detailBtn.visible = false;	
				this.overBg.visible = false;
			}
			else
			{
				this.overBg.visible = true;
				this.detailBtn.visible = true;	
			}
		}
				
		public function set own(param:int):void
		{
			this.ownNum = param;
			if(this.isActive)
			{
				this.ownLabel.text = GameDictionary.createCommonText(""+ this.ownNum);
			}
			else
			{
				this.ownLabel.text =  GameDictionary.createCommonText(""+ this.ownNum) + GameDictionary.createCommonText("/" + this.need);
			}
		}
		
		public function get own():int
		{
			return this.ownNum;
		}
		
		public function set need(param:int):void
		{
			this.needNum = param;
		}
		
		public function get need():int
		{
			return this.needNum;
		}
		
		/**
		 * 根据伙伴品质选择背景
		 * */
		private function choseBg():void
		{
			if(this.heroVo)
			{
				switch (int(this.heroVo.quality))
				{
					case 0:
						this.overBg.bitmapData = HeroHandbookSkin.PUR_OVER;
						this.bg.bitmapData = HeroHandbookSkin.PUR_BG;
						this.pointBg.bitmapData = HeroHandbookSkin.PUR_POINT_BG;
						this.enableBmp.bitmapData = HeroHandbookSkin.PUR_OVER;
						break;
					case 1:
						this.overBg.bitmapData = HeroHandbookSkin.GREEN_BG_OVER;
						this.bg.bitmapData = HeroHandbookSkin.GREEN_BG;
						this.pointBg.bitmapData = HeroHandbookSkin.GREEN_BG_POINT;
						this.enableBmp.bitmapData = HeroHandbookSkin.GREEN_BG_OVER;
						break;
					case 2:
						this.overBg.bitmapData = HeroHandbookSkin.BLUE_BG_OVER;
						this.bg.bitmapData = HeroHandbookSkin.BLUE_BG;
						this.pointBg.bitmapData = HeroHandbookSkin.BLUE_BG_POINT;
						this.enableBmp.bitmapData = HeroHandbookSkin.BLUE_BG_OVER;
						break;
					case 3:
						this.overBg.bitmapData = HeroHandbookSkin.PUR_OVER;
						this.bg.bitmapData = HeroHandbookSkin.PUR_BG;
						this.pointBg.bitmapData = HeroHandbookSkin.PUR_POINT_BG;
						this.enableBmp.bitmapData = HeroHandbookSkin.PUR_OVER;
						break;
					case 4:
						this.overBg.bitmapData = HeroHandbookSkin.ORG_OVER;
						this.bg.bitmapData = HeroHandbookSkin.ORG_BG;
						this.pointBg.bitmapData = HeroHandbookSkin.ORG_POINT_BG;
						this.enableBmp.bitmapData = HeroHandbookSkin.ORG_OVER;
						break;
				}
			}
		}
		
		/**
		 * 文本自适应
		 * */
		private function reLocation():void
		{
			if(this.isActive)
			{
				this.ownLabel.x = 67 - this.ownLabel.width/2;
			}
			else
			{
				this.ownLabel.x = 28 - this.ownLabel.width/2;
			}
			this.heroNameLabel.x = 130 - this.heroNameLabel.width >> 1;
		}
		
		/**
		 * 销毁
		 * */
		public function clear():void
		{
			this.heroVo = null;
			this.pointBg.visible = false;
			this.chip.visible = false;
			this.ownLabel.visible = false;
			this.enable = false;
			this.detailBtn.removeEventListener(MouseEvent.CLICK,onFigure);
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
			this.removeEventListener(MouseEvent.CLICK,onSoul);
		}
	}
}