package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.formation.ActiveBitmap;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.hurdleGuide.HurdleGuideWindow;
	import com.gamehero.sxd2.gui.player.hero.components.ActiveLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.GTextTabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_BREAK_REQ;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.CursorManager;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-5 下午6:25:19
	 * 
	 */
	public class HeroHandbookFigurePanel extends Sprite
	{
		static private var _instance:HeroHandbookFigurePanel
		
		private var heroVo:HeroVO;
		private var heroPro:PRO_Hero;
		private var figure:SpriteFigureItem;
		private var url:String;
		
		private var nameLabel:Label;
		//当前元魂数量
		private var soulNumLabel:Label;
		//技能
		private var skillLabel:ActiveLabel;
		//获取元魂
		private var getSoulHT:HtmlText;
		//分解元魂
		private var breakSoulHT:HtmlText;
		//种族图标
		private var raceIcon:Bitmap;
		//战力
		private var powerBmdNum:BitmapNumber;
		//返回按钮
		private var backBtn:SButton;
		//箭头
		private var arrow1:SButton; 
		private var arrow2:SButton;
		//种族标识
		private var raceActive:ActiveBitmap;
		//页签按钮数组
		private var tabBtnArr:Array = [];
		//面板集合
		private var panelArr:Array = [];
		//基础属性面板
		private var basePanel:basicPanel;
		//天赋属性面板
		private var talPanel:talentPanel;
		//伙伴脚底站位图
		private var heroBg:MovieClip;
		//伙伴战力底图
		private var powerBg:MovieClip;
		//伙伴职业
		private var heroJob:Bitmap;
		//是否上阵
		private var inBattle:Boolean =  false;
		//是否助阵
		private var inFetter:Boolean =  false;
		//灵蕴
		private var yhBg:ActiveBitmap;
		//按钮底线
		private var line:Bitmap;
		//默认打开基础属性面板
		private var index:int = 0;
		
		public function HeroHandbookFigurePanel()
		{
			this.init();
		}
		
		public static function get inst():HeroHandbookFigurePanel
		{
			return _instance ||= new HeroHandbookFigurePanel();
		}
		
		private function init():void
		{
			
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner3Bg);
			innerBg.scale9Grid = CommonSkin.windowInner3BgScale9Grid;
			innerBg.setSize(490, 510);
			innerBg.x = 34;
			innerBg.y = 58;
			addChild(innerBg);
			
			var rectBg:Bitmap = new Bitmap(HeroHandbookSkin.FIGURE_BG);
			rectBg.height = 510;
			rectBg.x = 526;
			rectBg.y = 58;
			addChild(rectBg);
			
			// 九宫格框
			innerBg = new ScaleBitmap(CommonSkin.windowInner3Bg);
			innerBg.scale9Grid = CommonSkin.windowInner3BgScale9Grid;
			innerBg.setSize(490, 510);
			innerBg.x = 560;
			innerBg.y = 58;
			addChild(innerBg);
			
			line = new Bitmap(HeroHandbookSkin.LINE);
			line.x = 560;
			line.y = 96;
			addChild(line);
			
			backBtn = HeroHandbookSkin.BTN_ARR[6] as SButton;
			backBtn.x = 972;
			backBtn.y = 493;
			backBtn.addEventListener(MouseEvent.CLICK,onBack);
			this.addChild(backBtn);
			
			arrow1 = HeroHandbookSkin.BTN_ARR[7] as SButton;
			arrow1.x = 494;
			arrow1.y = 272;
			this.addChild(arrow1);
			
			arrow2 = HeroHandbookSkin.BTN_ARR[8] as SButton;
			arrow2.scaleX = -1;
			arrow2.x = 63;
			arrow2.y = 272;
			this.addChild(arrow2);
 			
			nameLabel = new Label();
			nameLabel.color = GameDictionary.ORANGE;
			nameLabel.text = " ";
			nameLabel.size = 16;
			nameLabel.x = 253;
			nameLabel.y = 78;
			this.addChild(nameLabel);
			
			raceIcon = new Bitmap();
			raceIcon.x = 660;
			raceIcon.y = 80;
			this.addChild(raceIcon);
			
			this.skillLabel = new ActiveLabel();//技能
			this.skillLabel.cursorType = CursorManager.ARROW;
			this.skillLabel.label.align = Align.LEFT;
			this.skillLabel.label.color = GameDictionary.WINDOW_BLUE;
			this.skillLabel.hint = "";
			this.skillLabel.x = 443;
			this.skillLabel.y = 79;
			addChild(this.skillLabel);
			
			this.heroBg = new HeroHandbookSkin.HERO_BG() as MovieClip;
			this.heroBg.x = 145;
			this.heroBg.y = 390;
			this.addChild(this.heroBg);
			
			this.powerBg = new HeroHandbookSkin.POWER_BG() as MovieClip;
			this.powerBg.x = 154;
			this.powerBg.y = 460;
			this.powerBg.visible = false;
			this.addChild(this.powerBg);
			
			this.powerBmdNum = new BitmapNumber();
			this.powerBmdNum.y = 472;
			this.powerBmdNum.visible = false;
			this.addChild(this.powerBmdNum);
			
			yhBg = new ActiveBitmap(ItemSkin.LINGYUN);
			yhBg.x = 438;
			yhBg.y = 525;
			yhBg.hint = "";
			this.addChild(yhBg);
			
			soulNumLabel = new Label();
			soulNumLabel.color = GameDictionary.WINDOW_BLUE;
			soulNumLabel.text = "99999";
			soulNumLabel.x = 466;
			soulNumLabel.y = 530;
			this.addChild(soulNumLabel);
			
			heroJob = new Bitmap();
			heroJob.x = 390;
			heroJob.y = 176;
			this.addChild(heroJob);
			
			getSoulHT = new HtmlText();
			getSoulHT.text = "<a href='event:myEvent'><u>"+GameDictionary.GREEN_TAG2+ "残灵获得" + GameDictionary.COLOR_TAG_END2+"</u></a>";
			getSoulHT.x = 83;
			getSoulHT.y = 528;
			getSoulHT.visible = false;
			this.addChild(getSoulHT);
			
			breakSoulHT = new HtmlText();
			breakSoulHT.text = "<a href='event:myEvent'><u>"+GameDictionary.GREEN_TAG2+ "残灵分解" + GameDictionary.COLOR_TAG_END2+"</u></a>";
			breakSoulHT.x = 83;
			breakSoulHT.y = 528;
//			breakSoulHT.x = 242;
//			breakSoulHT.y = 528;
			this.addChild(breakSoulHT);
			
			var btnName:Array = ["基本","天赋"];
			var btn:GTextTabButton;
			for(var i:int = 0; i< btnName.length;i++)
			{
				btn = new GTextTabButton(CommonSkin.blueButton2Up,CommonSkin.blueButton2Down,CommonSkin.blueButton2Over);
				btn.label = btnName[i];
				btn.x = 628 + i*71;
				btn.y = 74;
				this.addChild(btn);
				this.tabBtnArr.push(btn);
			}
			
			//基础属性面板
			this.basePanel = new basicPanel();
			this.basePanel.x = 635;
			this.basePanel.y = 128;
			this.basePanel.visible = true;
			this.addChild(basePanel);
			//天赋属性面板
			this.talPanel = new talentPanel();
			this.talPanel.x = 635;
			this.talPanel.y = 128;
			this.talPanel.visible = false;
			this.addChild(talPanel);
			this.talPanel.change();
			
			this.panelArr.push(this.basePanel);
			this.panelArr.push(this.talPanel);
		}
		
		public function updata(heroVO:HeroVO,hPro:PRO_Hero):void
		{
			this.clear();
			
			this.heroVo = heroVO;
			this.heroPro = hPro;
			if(this.heroPro)
			{
				this.inBattle = FormationModel.inst.checkHeroInBattle(heroPro.base.id);
				this.inFetter = FormationModel.inst.checkHeroInHelp(heroPro.base.id);
			}
			
			for(var i:int = 0 ; i < this.tabBtnArr.length ; i++)
			{
				var btn:GTextTabButton = this.tabBtnArr[i];
				btn.addEventListener(MouseEvent.CLICK,onTabBtnClick);
			}
			getSoulHT.addEventListener(MouseEvent.CLICK,onSoul);
			breakSoulHT.addEventListener(MouseEvent.CLICK,onBreak);
			arrow1.addEventListener(MouseEvent.CLICK,changeHero);
			arrow2.addEventListener(MouseEvent.CLICK,changeHero);
			
			heroJob.bitmapData = HeroSkin.getJobSkin(heroVO.job);
			
			url = GameConfig.FIGURE_URL + "body_ui/" +  heroVO.id;
			figure =  new SpriteFigureItem(url, false , BattleFigureItem.UI_STAND);
			figure.frameRate = 12;
			figure.play();
			figure.x = 270;
			figure.y = 415;
			this.addChild(figure);
			
			nameLabel.text = heroVO.name;
			nameLabel.color = GameDictionary.getColorByQuality(int(heroVO.quality));
			
			var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(heroVO.special_skill_id);
			if(skill)
			{
				this.skillLabel.hint = Lang.instance.trans("skill_des_" + heroVo.special_skill_id);
				this.skillLabel.label.text = Lang.instance.trans(skill.name);
			}
			else
			{
				this.skillLabel.label.text = "";
			}
			
			if(hPro)
			{
				this.powerBg.visible = true;
				this.powerBmdNum.visible = true;
				this.powerBmdNum.update(BitmapNumber.WINDOW_S_YELLOW, hPro.base.power.toString());
				this.powerBmdNum.x = 268 - this.powerBmdNum.width/2;
			}
			else
			{
				this.powerBg.visible = false;
				this.powerBmdNum.visible = false;
			}
			
			HerohandbookModel.inst.resource.push(url);
			this.btnState();
			this.basePanel.change(heroVO);
			this.checkRace(heroVO.race);
			this.upDataSoulNum();
		}
		
		public function upDataSoulNum():void
		{
			soulNumLabel.text = "" + GameData.inst.playerExtraInfo.spirit;
			yhBg.hint = "灵蕴：" + soulNumLabel.text;
		}
		
		
		/**伙伴种族标识*/
		private function checkRace(race:String):void
		{
			switch(race)
			{
				case "0":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_1);
					break;
				
				case "1":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_1);
					break;
				
				case "2":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_2);
					break;
				
				case "3":
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_3);
					break;
				
				case "4":	
					this.raceActive = new ActiveBitmap(HeroSkin.RACE_4);
					break;
			}
			this.raceActive.hint = GameDictionary.getRaceHint(int(race));
			raceActive.x = 401;
			raceActive.y = 74;
			this.addChild(raceActive);
		}
		
		
		private function changeHero(evt:MouseEvent):void
		{
			var index:int = HerohandbookModel.inst.heroArr.indexOf(this.heroVo);
			var hVo:HeroVO;
			var hPro:PRO_Hero;
			if(evt.currentTarget == arrow1)
			{
				if( index + 1 < HerohandbookModel.inst.heroArr.length )
				{
					hVo = HerohandbookModel.inst.heroArr[index + 1];
					hPro = FormationModel.inst.getPHero(int(hVo.id));
					this.updata(hVo,hPro);
				}
			}
			else
			{
				if(HerohandbookModel.inst.heroArr.indexOf(this.heroVo)  > 0)
				{
					hVo = HerohandbookModel.inst.heroArr[index - 1];
					hPro = FormationModel.inst.getPHero(int(hVo.id));
					this.updata(hVo,hPro);
				}
			}
		}
		
		private function onSoul(evt:MouseEvent):void
		{
			DialogManager.inst.showCost(DialogManager.GO_FUBEN,"前往剧情副本获得残灵！",function():void
			{
				WindowManager.inst.openWindow(HurdleGuideWindow, WindowPostion.CENTER, false, false, true, 2);
			});
		}
		
		private function onBreak(evt:MouseEvent):void
		{
			if(this.heroPro)
			{
				if(!this.inBattle && !this.inFetter)
				{
					DialogManager.inst.showCost(DialogManager.CURRENT,"是否分解当前残灵！",function():void
					{
						sendBreak();
					});
				}
				else if(this.inBattle)
				{
					DialogManager.inst.showPrompt("当前伙伴已上阵！");
				}
				else if(this.inFetter)
				{
					DialogManager.inst.showPrompt("当前伙伴已助阵！");
				}
				/*else if(BagModel.inst.getSoulNum(int(this.heroVo.chips_id))<=0)
				{
					DialogManager.inst.showPrompt("当前伙伴碎片不足!");
				}*/
			}
			else
			{
				DialogManager.inst.showPrompt("当前伙伴未激活！");
			}
		}
		
		private function sendBreak():void
		{
			var msg:MSG_PHOTOAPPRAISAL_BREAK_REQ = new MSG_PHOTOAPPRAISAL_BREAK_REQ();
			msg.id = this.heroPro.base.id;
			this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_BREAK,msg));
		}
		
		private function onBack(evt:MouseEvent):void
		{
			this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.BACK));	
		}
		
		private function onTabBtnClick(evt:MouseEvent):void
		{
			var i:int;
			var mouseBtn:GTextTabButton = evt.target as GTextTabButton;
			this.index = this.tabBtnArr.indexOf(mouseBtn);
			this.btnState();
		}
		
		/**
		 * 按钮选中态
		 * */
		private function btnState():void
		{
			for(var i:int = 0;i<this.tabBtnArr.length;i++)
			{
				var btn:GTextTabButton = this.tabBtnArr[i] as GTextTabButton;
				btn.selected = i == index;
			}
			
			for(i = 0; i< this.panelArr.length ;i++)
			{
				(this.panelArr[i] as Sprite).visible = i == this.index;
			}
		}
		
		public function clear():void
		{
			
			for(var i:int = 0 ; i < this.tabBtnArr.length ; i++)
			{
				var btn:GTextTabButton = this.tabBtnArr[i];
				btn.removeEventListener(MouseEvent.CLICK,onTabBtnClick);
			}
			getSoulHT.removeEventListener(MouseEvent.CLICK,onSoul);
			breakSoulHT.removeEventListener(MouseEvent.CLICK,onBreak);
			arrow1.removeEventListener(MouseEvent.CLICK,changeHero);
			arrow2.removeEventListener(MouseEvent.CLICK,changeHero);
			
			if(this.raceActive)
			{
				this.raceActive.clear();
				this.removeChild(this.raceActive);
				this.raceActive = null;
			}
			if(figure)
			{
				figure.stop();
				this.removeChild(figure);
			}
			figure = null;
		}
		
	}
}


import com.gamehero.sxd2.data.GameDictionary;
import com.gamehero.sxd2.gui.formation.FormationModel;
import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookSkin;
import com.gamehero.sxd2.gui.player.hero.components.PropLabel;
import com.gamehero.sxd2.local.Lang;
import com.gamehero.sxd2.manager.HeroManager;
import com.gamehero.sxd2.vo.HeroFateVo;
import com.gamehero.sxd2.vo.HeroVO;

import flash.display.Bitmap;
import flash.display.Sprite;

import alternativa.gui.controls.text.Label;
import alternativa.gui.mouse.CursorManager;

/**
 * 基本属性面板
 * */

var introduceLabel:Label;
var tianyuanLabel:Label;
var baseArr:Vector.<PropLabel>;
class basicPanel extends Sprite
{
	public function basicPanel():void
	{
		//属性
		var bmp:Bitmap = new Bitmap(HeroHandbookSkin.BASE);
		addChild(bmp);
		
		bmp = new Bitmap(HeroHandbookSkin.INTROUDUCE);
		bmp.y = 118;
		addChild(bmp);
		
		bmp = new Bitmap(HeroHandbookSkin.FETTER);
		bmp.y = 265;
		addChild(bmp);
		
		baseArr = new Vector.<PropLabel>();
		var baseName:Array = ["武力","智力","根骨"];
		for(var i:int = 0; i<baseName.length;i++)
		{
			var baseLb:PropLabel = new PropLabel(baseName[i],"",null);
			baseLb.y = 30 + i*27;
			baseLb.x = -10;
			baseLb.cursorType = CursorManager.ARROW;
			baseLb.hint = Lang.instance.trans("hero_tips_"+(i+1));
			this.addChild(baseLb);
			baseArr.push(baseLb);
		}
		
		
		introduceLabel = new Label();
		introduceLabel.color = GameDictionary.WINDOW_BLUE;
		introduceLabel.text = "小红帽被灰太狼吃了，小红帽被灰太狼吃了。\n" +
							  "小红帽被灰太狼吃了，小红帽被灰太狼吃了。\n" +
						      "小红帽被灰太狼吃了，小红帽被灰太狼吃了。\n" +
							  "小红帽被灰太狼吃了，小红帽被灰太狼吃了。\n";
		introduceLabel.y = 151;
		introduceLabel.leading = 0.8;
		introduceLabel.letterSpacing = 0.8;
		this.addChild(introduceLabel);
		
		tianyuanLabel = new Label();
		tianyuanLabel.color = GameDictionary.WINDOW_BLUE;
		tianyuanLabel.text = "";
		tianyuanLabel.x = 0;
		tianyuanLabel.y = 291;
		tianyuanLabel.leading = 0.8;
		tianyuanLabel.letterSpacing = 0.8;
		this.addChild(tianyuanLabel);
	}
	
	public function change(vo:HeroVO):void
	{
		this.clear();
		//伙伴基础属性显示
		var baseNum:Array = [vo.force,vo.intellect,vo.skeleton];
		for(var i:int = 0;i<baseArr.length;i++)
		{
			var baseLabel:PropLabel = baseArr[i] as PropLabel;
			baseLabel.propNum = int(baseNum[i]);
		}
		
		//羁绊详情
		var heroFateInfo:HeroFateVo = HeroManager.instance.analysisFate(int(vo.job));
		//获得所有羁绊相关伙伴，不管是否获得该伙伴
		var fateList:Array = FormationModel.inst.getFetterNum(vo.id,heroFateInfo);
		//羁绊所有信息
		if(fateList.length > 0)
		{
			for(i = 0 ; i < fateList.length ; i++)
			{
				var hero:HeroVO = fateList[i];
				//羁绊详情
				var hasHero:Boolean = true/*this.checkHero(HeroModel.instance.fateHeroInfoList,hero)*/;
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
			tianyuanLabel.text += ("此伙伴单枪匹马!\n");
			tianyuanLabel.color  = GameDictionary.WINDOW_BLUE_GRAY;
		}
		
		
		introduceLabel.text = Lang.instance.trans("hero_des_" + vo.id).replace();
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
			tianyuanLabel.text += (GameDictionary.WINDOW_BLUE_TAG + strArr.shift()  + "，" + GameDictionary.COLOR_TAG_END
				+ GameDictionary.GREEN_TAG + strArr.shift() + GameDictionary.COLOR_TAG_END);
		}
		else
		{
			tianyuanLabel.text += (GameDictionary.WINDOW_BLUE_GRAY_TAG + str + GameDictionary.COLOR_TAG_END);
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
	
	public function clear():void
	{
		tianyuanLabel.text = "";
	}
	
}



/**
 * 天赋属性面板
 * */
class talentPanel extends Sprite
{
	function talentPanel():void
	{
		var lb:Label = new Label();
		lb.text = "此功能暂未开放";
		lb.color = GameDictionary.WINDOW_BLUE;
		lb.size = 20;
		this.addChild(lb);
	}
	
	function change():void
	{
	}
}