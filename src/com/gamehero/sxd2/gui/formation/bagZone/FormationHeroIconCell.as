package com.gamehero.sxd2.gui.formation.bagZone
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.ActiveBitmap;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.HeroFateVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.enum.Align;
	import alternativa.gui.event.DragEvent;
	import alternativa.gui.mouse.dnd.IDrag;
	import alternativa.gui.mouse.dnd.IDragObject;
	import alternativa.gui.mouse.dnd.IDrop;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import com.gamehero.sxd2.gui.formation.FormationDragObject;
	
	/**
	 * @author Wbin
	 * 创建时间：2015-8-21 下午4:27:48
	 * 
	 */
	public class FormationHeroIconCell extends ActiveObject implements IDrag, IDrop
	{
		private var bg:Bitmap;
		/**伙伴头像*/
		private var icon:Bitmap;
		/**伙伴种族*/
//		private var raceBg:Bitmap;
		private var raceActive:ActiveBitmap;
		/**伙伴是否上阵*/
		public var isInBattle:Boolean;	
		/**伙伴是否助阵*/
		public var isHelpBattle:Boolean;
		/**伙伴上阵标识*/
		private var inBattle:Bitmap;
		/**伙伴助阵标识*/
		private var helpBattle:Bitmap;
		/**伙伴名字*/
		private var name:Label;
		/**伙伴等级*/
		private var lv:Label;
		/**伙伴羁绊*/
		private var fetter:Label;
		
		
		/**高亮框*/
		private var overBmp:Bitmap;
		
		/**伙伴数据*/
		public var heroVO:HeroVO;
		public var heroInfo:PRO_Hero
		
		private var headUrl:String;
		private var raceUrl:String;
		
		/**
		 * 是否可以拖动 
		 */		
		private var _isDragable:Boolean;
		/**拖拽的数据*/
		private var _dragData:Object;
		
		public function FormationHeroIconCell()
		{
			super();
			this.doubleClickEnabled = true;
			this.init();
		}
		
		private function init():void
		{
			bg = new Bitmap(FormationSkin.headIcon);
			bg.visible = false;
			addChild(bg);
			
			overBmp = new Bitmap(FormationSkin.bagOverBmp);
			overBmp.visible = false;
			addChild(overBmp);
			
//			raceBg = new Bitmap();
			
			icon = new Bitmap();
			icon.x = 8;
			addChild(icon);
			
			inBattle = new Bitmap(FormationSkin.inBattle);
			addChild(inBattle);
			
			helpBattle = new Bitmap(FormationSkin.helpBattle);
			addChild(helpBattle);
			
			name = new Label();
			name.align = Align.LEFT;
			addChild(name);
			
			lv = new Label();
			lv.align = Align.LEFT;
			lv.color = GameDictionary.WINDOW_WHITE;
			addChild(lv);
			
			fetter = new Label();
			fetter.align = Align.LEFT;
			fetter.color = GameDictionary.WINDOW_BLUE;
			addChild(fetter);
			
			addEventListener(MouseEvent.CLICK,onClick);
//			addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
			addEventListener(MouseEvent.ROLL_OVER,onOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollout);
			
		}
		
		public function set data(heroPro:PRO_Hero):void
		{
			this.clear();
			if(heroPro)
			{
				this.hint = " ";
				//初始化底图显示
				bg.visible = true;
				//后端数据来源
				this.heroInfo = heroPro;
				//配置数据
				this.heroVO = HeroManager.instance.getHeroByID(heroPro.heroId.toString());
				//羁绊信息
				var heroFate:HeroFateVo = HeroManager.instance.analysisFate(int(this.heroVO.job));
				if(heroFate)
				{
					var fate:Array = FormationModel.inst.getFetterNumInBattle(heroPro,heroFate);
				}
				//是否上阵
				this.isInBattle = FormationModel.inst.checkHeroInBattle(this.heroInfo.base.id);
				this.inBattle.visible = this.isInBattle;
				//是否助阵
				this.isHelpBattle = FormationModel.inst.checkHeroInHelp(this.heroInfo.base.id);
				this.helpBattle.visible = this.isHelpBattle;
				//伙伴品质
				this.differentiateHero();
				
				lv.text = ""
				lv.x = name.x + name.width + 10;
				lv.y = name.y;
				
				var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(heroVO.special_skill_id);
				var skillName:String = skill ? skill.name : "";
				if(fate)
				{
					var actStr:String = "";
					if(this.isInBattle||this.isHelpBattle)
					{
						actStr = "已激活缘份 +";
					}
					else
					{
						actStr = "可激活缘份 +";
					}
					fetter.text = (fate.length > 0)?(actStr + fate.length):skillName;
					fetter.x = name.x;
					fetter.y = name.y + 25;
				}
				
				if( null == FormationModel.inst.headIconDic[this.heroVO.name])
				{
					//伙伴头像加载
					this.headUrl = GameConfig.HERO_URL + "formationIcon/" + heroVO.id + ".swf";
					BulkLoaderSingleton.instance.addWithListener(this.headUrl, null, onIconLoaded, null, onIconLoadError);
					BulkLoaderSingleton.instance.start();
				}
				else icon.bitmapData = FormationModel.inst.headIconDic[this.heroVO.name];
				
				this.checkRace(heroVO.race);
				
				// 取消拖拽
				this.addEventListener(DragEvent.CANCEL , dragCancel);
			}
		}
		
		
		/**伙伴种族标识*/
		private function checkRace(race:String):void
		{
			switch(race)
			{
				case "0":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_1);
					this.raceActive.hint = Lang.instance.trans("AS_race_0");
					break;
				
				case "1":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_1);
					this.raceActive.hint = Lang.instance.trans("AS_race_1");
					break;
				
				case "2":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_2);
					this.raceActive.hint = Lang.instance.trans("AS_race_2");
					break;
				
				case "3":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_3);
					this.raceActive.hint = Lang.instance.trans("AS_race_3");
					break;
				
				case "4":	
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_4);
					this.raceActive.hint = Lang.instance.trans("AS_race_4");
					break;
			}
			
			raceActive.x = 25;
			raceActive.y = 55;
			addChild(raceActive);
		}
		
		/**伙伴品质区分*/
		private function differentiateHero():void
		{
			//名字颜色区分
			name.color = GameDictionary.getColorByQuality(int(heroVO.quality));
			name.x = 75;
			name.y = 17;
			this.name.text = heroVO.name;
		}
		
		
		private function onIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			icon.bitmapData = png;
			if(this.heroVO)
				FormationModel.inst.headIconDic[this.heroVO.name] = png;
		}
		
		private function onIconLoadError(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
		}
		
		
		
		
		
		
		/**伙伴上阵的时候不能进行拖拽*/
		public function isDragable():Boolean
		{
			this.showWarning(); 
			return !this.isInBattle && !this.isHelpBattle;
//			return true;
		}
		
		
		
		
		public function getDragObject():IDragObject
		{
			FormationModel.inst.isDraging = true;
			
			// 拖拽格子的模型隐藏
			this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , false));
			
			if(_dragData == null)
			{
				_dragData = new Object();
			}
			
			_dragData.heroInfo = heroInfo;
			_dragData.fromPos = 0;
			
			return new FormationDragObject(_dragData);
		}
		
		
		public function canDrop(dragObject:IDragObject):Boolean
		{
			return false;
		}
		
		
		public function drop(dragObject:IDragObject):void
		{
			
		}
		
		
		
		/**伙伴是否上阵提示*/
		private function showWarning():void
		{
			//伙伴已上阵提示
			if(this.isInBattle)
			{
				DialogManager.inst.showWarning("30012");
			}
			//伙伴已助阵提示
			else if(this.isHelpBattle)
			{
				DialogManager.inst.showWarning("30040");
			}
		}
		
		
		
		/**
		 * 取消拖拽
		 * */
		private function dragCancel(e:DragEvent):void
		{
			FormationModel.inst.isDraging = false;
			
			this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , true));
		}
		
		/**单击*/
		private function onClick(e:MouseEvent):void
		{
			
		}
		
		
		/**滑过*/
		private function onOver(e:MouseEvent):void
		{
			bg.visible = false;
			overBmp.visible = true;
		}
		
		
		/**移除高亮*/
		private function onRollout(e:MouseEvent):void
		{
			bg.visible = true;
			overBmp.visible = false;
		}
		
		/**双击上阵*/
		private function onDoubleClick(e:MouseEvent):void
		{
			/*if(heroInfo && !isInBattle)
			{
				//获取当前阵上最高空顺位
				var index:int = FormationModel.inst.selected();
				var req:MSG_FORMATION_PUT_HERO_REQ = new MSG_FORMATION_PUT_HERO_REQ();
				req.pos = index;
				req.id = heroInfo.base.id;
				this.dispatchEvent(new FormationEvent(FormationEvent.DOUBLE_CLICK_HERO , req));
			}
			else showWarning(); */ //已上阵伙伴提示错误
		}
		
		
		
		/**清除数据*/
		private function clear():void
		{
			this.hint = "";
			
			this.heroVO = null;
			this.heroInfo = null;
			this.name.text = "";
			this.lv.text = "";
			this.fetter.text = "";
			this.icon.bitmapData = null;
			if(raceActive)
			{
				this.raceActive.clear();
			}
			
			this.removeEventListener(DragEvent.CANCEL , dragCancel);
		}
		
		/**关闭的时候移出事件*/
		public function close():void
		{
			this.clear();
			
			this.removeEventListener(MouseEvent.CLICK,onClick);
//			this.removeEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
			this.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT,onRollout);
		}
	}
}