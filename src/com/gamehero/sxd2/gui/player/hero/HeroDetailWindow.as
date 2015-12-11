package com.gamehero.sxd2.gui.player.hero
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.player.hero.components.PropLabel;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Property;
	import com.gamehero.sxd2.util.BitmapLoader;
	import com.gamehero.sxd2.vo.HeroFateVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import alternativa.gui.mouse.CursorManager;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-3 下午8:13:01
	 * 
	 */
	public class HeroDetailWindow extends GeneralWindow
	{
		/**文本间隔调整*/
		private static const OFFSET:Number = 0.5;
		/**伙伴名称*/
		private var _heroDetailName:Label;
		/**伙伴阵营*/
		private var _heroCamp:Label;
		/**伙伴职业*/
		private var _heroProfession:Label;
		/**伙伴头像*/
		private var _heroIcon:BitmapLoader;
		private var _capAndPro:Sprite;
		
		private var _race:Label;//种族
		
		private var _profession:Label;//职业
		/**
		 * 属性面板数组 
		 */		
		private var _propList:Vector.<PropLabel>;
		
		/**详细信息*/
		private var _heroDetailAry:Array = [];

		private var _heroInfoNumLb:Label;
		
		/**
		 * 战力
		 * */
		/*private var _powerBp:BitmapNumber;*/
		/**战力数字背景*/
		private var _powerBg:Bitmap;
		private var _battlePowerPanel:HeroBattlePowerPanel;
		
		/**天缘*/
		private var _fetterLabel:Label;
			
		private var _isopen:Boolean = false;
		
		private var _isfirst:Boolean;
		
		public function HeroDetailWindow(position:int, resourceURL:String = "HeroDetailWindow.swf")
		{
			super(position, resourceURL, 232, 535);
		}
		
		override public function onShow():void
		{
			super.onShow();
			this._isfirst = true;
			this._isopen = true;
			updataHeroInfo(this.windowParam as PRO_Hero);
		}
		
		override public function close():void
		{
			if(this._isopen)
			{
				super.close();
				this._isopen = !this._isopen;
			}
		}
		
		override protected function initWindow():void
		{
			super.initWindow();
			this.initBackground();
		}
		
		private function initBackground():void
		{
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(214, 479);
			innerBg.x = 10;
			innerBg.y = 39;
			addChild(innerBg);
			
			var iconBg:Bitmap = new Bitmap(this.getSwfBD("iconBg"));
			iconBg.x = 23;
			iconBg.y = 54;
			this.addChild(iconBg);
			//头像
			this._heroIcon = new BitmapLoader();
			this._heroIcon.x = 23;
			this._heroIcon.y = 54;
			this.addChild(this._heroIcon);
			
			var powerBg:MovieClip = this.getSwfInstance("power") as MovieClip;
			powerBg.y = 110;
			this.addChild(powerBg);
			
			this._powerBg = new Bitmap(this.getSwfBD("powerBG"));
			this._powerBg.y = 108;
			this.addChild(this._powerBg);
			
			/*this._powerBp = new BitmapNumber();
			this.addChild(this._powerBp);*/
			
			this.addChild(this._battlePowerPanel = new HeroBattlePowerPanel());
			this._battlePowerPanel.init();
			
			this._heroDetailName = new Label();
			this._heroDetailName.x = 80;
			this._heroDetailName.y = 60;
			this._heroDetailName.text = "";
			this.addChild(this._heroDetailName);
			
			this._heroCamp = new Label();
			this._heroCamp.x = 80;
			this._heroCamp.y = 90;
			this._heroCamp.color = GameDictionary.WINDOW_BLUE;
			this._heroCamp.text = Lang.instance.trans("team_ui_2");
			this.addChild(this._heroCamp);
			
			this._heroProfession = new Label();
			this._heroProfession.x = 145;
			this._heroProfession.y = 90;
			this._heroProfession.color = GameDictionary.WINDOW_BLUE;
			this._heroProfession.text = Lang.instance.trans("team_ui_1");
			this.addChild(this._heroProfession);
			
			var line_1:Bitmap = new Bitmap(this.getSwfBD("line"));
			line_1.x = 21;
			line_1.y = 167;
			this.addChild(line_1);
			
			var line_2:Bitmap = new Bitmap(this.getSwfBD("line"));
			line_2.x = 21;
			line_2.y = 349;
			this.addChild(line_2);
			
			//属性
			var detailIcon:Bitmap = new Bitmap(this.getSwfBD("detail_s"));
			detailIcon.x = 95;
			detailIcon.y = 160;
			this.addChild(detailIcon);
			//天缘
			var tyIcon:Bitmap = new Bitmap(this.getSwfBD("tianyuan_s"));
			tyIcon.x = 95;
			tyIcon.y = 342;
			this.addChild(tyIcon);
			
			this._fetterLabel = new Label();
			this._fetterLabel.x = 23;
			this._fetterLabel.y = 365;
			this._fetterLabel.leading = OFFSET;
			this._fetterLabel.letterSpacing = OFFSET;
			this._fetterLabel.color = GameDictionary.WHITE;
			this._fetterLabel.text = "功能暂未开放";
			this.addChild(this._fetterLabel);
			
			this._capAndPro = new Sprite();
			this.addChild(this._capAndPro);
			
			//阵营
			_race = new Label();
			_race.x = this._heroCamp.x + 28;
			_race.y = this._heroCamp.y;
			_race.color = GameDictionary.WINDOW_WHITE;
			this._capAndPro.addChild(_race);
			//职业
			_profession = new Label();
			_profession.x = this._heroProfession.x + 28;
			_profession.y = this._heroProfession.y;
			_profession.color = GameDictionary.WINDOW_WHITE;
			this._capAndPro.addChild(_profession);
			//根据语言包加载
			_propList = new Vector.<PropLabel>();
			
			
			var labels:Array = ["等级","攻击","物防","法防","内力","生命","闪避","格挡","暴击","穿透"];
			var propLabel:PropLabel;
			for( var i:int = 0;i < 10;i++)
			{
				propLabel = new PropLabel(labels[i],"",this.getSwfBD("detailBg"));
				propLabel.cursorType = CursorManager.ARROW;
				propLabel.setHint(Lang.instance.trans("hero_tips_" + (i+4)));
				propLabel.x = 18 + (Math.floor(i/5))*107;
				propLabel.y = (i%5)*29 + 193;
				addChild(propLabel);
				_propList.push(propLabel);
			} 
			
		}
		
		/**update hero Info*/
		public function updataHeroInfo(heroPro:PRO_Hero):void
		{
			this.clear();
			//当前伙伴详情
			var herovo:HeroVO = HeroManager.instance.getHeroByID(heroPro.heroId.toString());
			this._heroDetailName.text = herovo.name;
			this._heroDetailName.color = GameDictionary.getColorByQuality(int(herovo.quality));
			//头像
			this._heroIcon.url = GameConfig.HERO_URL + "head/" + herovo.id + ".swf";
			//阵营
			_race.text =  Lang.instance.trans("AS_race_s" + herovo.race);
			//职业
			_profession.text = Lang.instance.trans("AS_job_" + herovo.job);
			//战力
			/*this._powerBp.update(BitmapNumber.WINDOW_S_YELLOW,heroPro.base.power.toString());
			this._powerBp.x = 40 + (232 - this._powerBp.width) >> 1;
			this._powerBp.y = 113;
			this.addChild(this._powerBp);
			this._powerBg.x = this._powerBp.x + (this._powerBp.width/2 - this._powerBg.width/2);*/
			//战力
			this._battlePowerPanel.bEfAnimation(heroPro.base.power,heroPro.heroId,1,_isfirst);
			_isfirst = false;
			
			this._battlePowerPanel.x = 40 + (100 - this._battlePowerPanel.numLen) >> 1;
			this._battlePowerPanel.y = 105;
			//战力背景
			this._powerBg.x = this._battlePowerPanel.x + (this._battlePowerPanel.numLen >> 1) - this._powerBg.width/2 + 40;
			
			//获取返回的伙伴列表数据
			var property:PRO_Property = heroPro.base.property;
			var propArr:Array = [GameData.inst.playerInfo.level/*等级*/,
								property.attack/*攻击*/,
								property.pdef/*物理防御*/,
								property.mdef/*法术防御*/,	
								property.skillAtt/*内力*/,
								heroPro.base.maxhp/*生命*/,
								property.dog/*闪避*/,
								property.parry/*格挡*/,
								property.crit/*暴击*/,
								property.arp/*穿透*/];
			for(var i:int in _propList)
			{
				_propList[i].propNum = propArr[i];
			}
			
			//羁绊详情
			var heroFateInfo:HeroFateVo = HeroManager.instance.analysisFate(int(herovo.job));
			//获得所有羁绊相关伙伴，不管是否获得该伙伴
			var fateList:Array = FormationModel.inst.getFetterNum(heroPro.heroId.toString(),heroFateInfo);
			//羁绊所有信息
			if(fateList.length > 0)
			{
				for(i = 0 ; i < fateList.length ; i++)
				{
					var hero:HeroVO = fateList[i];
					//羁绊详情
					var hasHero:Boolean = this.checkHero(HeroModel.instance.fateHeroInfoList,hero);
					var str:String = "";
					if(hero.job.toString() == heroFateInfo.assistant_job1.toString())
					{
						str =  "【" + GameDictionary.getJobName(hero.job)  +"】"  + "\n与" + hero.name + "达成天缘" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_1)) + "+" + heroFateInfo.percent_1 + "%\n";
						this.fateDetail(str,hasHero);
					}
					else if(hero.job.toString() == heroFateInfo.assistant_job2.toString())
					{
						str =  "【" + GameDictionary.getJobName(hero.job)  +"】"  + "\n与" + hero.name + "达成天缘" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_2)) + "+" + heroFateInfo.percent_2 + "%\n";
						this.fateDetail(str,hasHero);
					}
					else if(hero.job.toString() == heroFateInfo.assistant_job3.toString())
					{
						str =  "【" + GameDictionary.getJobName(hero.job)  +"】"  + "\n与" + hero.name + "达成天缘" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_3)) + "+" + heroFateInfo.percent_3 + "%\n";
						this.fateDetail(str,hasHero);
					}
					else if(hero.job.toString() == heroFateInfo.assistant_job4.toString())
					{
						str =  "【" + GameDictionary.getJobName(hero.job)  +"】"  + "\n与" + hero.name + "达成天缘" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_4)) + "+" + heroFateInfo.percent_4 + "%\n";
						this.fateDetail(str,hasHero);
					}
				}
			}
			else
			{
				this._fetterLabel.text += ("此伙伴单枪匹马!\n");
				this._fetterLabel.color  = GameDictionary.WINDOW_BLUE_GRAY;
			}
		}
		
		
		/**
		 * 根据羁绊配置遍历当前阵中有无羁绊伙伴
		 * */
		private function checkHero(proList:Array,heroInfo:HeroVO):Boolean
		{
			var hasHero:Boolean = false;
			for(var m:int = 0; m < proList.length ;m++)
			{
				if(heroInfo.name == HeroManager.instance.getHeroByID(proList[m].heroId.toString()).name)
				{
					hasHero = true;
				}
			}
			return hasHero;
		}
		
		
		
		/**
		 * 羁绊详情信息展示
		 * @str1 
		 * @str2 
		 * @value  文本颜色控制
		 * */
		private function fateDetail(str:String,value:Boolean):void
		{
			if(value)
			{
				var strArr:Array = str.split("，");
				this._fetterLabel.text += (GameDictionary.WINDOW_BLUE_TAG + strArr.shift()  + "，" + GameDictionary.COLOR_TAG_END
					+ GameDictionary.GREEN_TAG + strArr.shift() + GameDictionary.COLOR_TAG_END);
			}
			else
			{
				this._fetterLabel.text += (GameDictionary.WINDOW_BLUE_GRAY_TAG + str + GameDictionary.COLOR_TAG_END);
			}
		}
		
		public function get isOpen():Boolean
		{
			return this._isopen;
		}
		
		public function clear():void
		{
			this._fetterLabel.text = "";
			this._heroDetailName.text = "";
		}
		
	}
}