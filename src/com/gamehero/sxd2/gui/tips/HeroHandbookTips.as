package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookSkin;
	import com.gamehero.sxd2.gui.heroHandbook.HerohandbookCell;
	import com.gamehero.sxd2.gui.heroHandbook.HerohandbookModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import alternativa.gui.controls.text.Label;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-3 上午10:57:47
	 * 图鉴相关tips
	 */
	public class HeroHandbookTips
	{
		public function HeroHandbookTips()
		{
		}
		
		/**
		 * 单个图鉴tips
		 * */
		public static function getHeroHandbookTips(obj:Object):DisplayObject
		{
			var tipsWidth:int = 0;
			var str:String;
			var preHeight:int;
			var lineBM:ScaleBitmap;
			
			var herovo:HeroVO = obj.heroVo;
			var enable:Boolean = false;
			
			var container:Sprite = new Sprite();
			container.graphics.beginFill(0,0);
			container.graphics.drawRect(0,0,207,250);
			container.graphics.endFill();
			container.mouseEnabled = false;
			container.mouseChildren = false;
			
			//标签
			var title:Label = new Label();
			title.color = GameDictionary.GREEN;
			title.x = 17;
			title.y = 14;
			if(obj is HerohandbookCell)
			{
				enable =  obj.enable as Boolean;
				title.text = enable?"点击召唤伙伴":"点击查看详情";//"点击获取元魂"
			}
			else 
			{
				title.text = "点击查看详情";
			}
			container.addChild(title);
			preHeight = title.y + title.height + 5;
			
			if(herovo)
			{
				var nameLabel:Label = new Label();
				nameLabel.color = GameDictionary.WHITE
				nameLabel.y = 40;
				nameLabel.text = herovo.name;
				nameLabel.color = GameDictionary.getColorByQuality(int(herovo.quality));
				nameLabel.x = container.width - nameLabel.width >> 1;
				container.addChild(nameLabel);
				preHeight = nameLabel.y + nameLabel.height + 5;
				
				var heroJob:Bitmap = new Bitmap(HeroSkin.getJobSkin(herovo.job));
				heroJob.x = 160;
				heroJob.y = 53;
				container.addChild(heroJob);
				
				var herobg:MovieClip = new HeroHandbookSkin.TIP_BG() as MovieClip;
				herobg.x = 30;
				herobg.y = 210;
				container.addChildAt(herobg,0);
				preHeight = herobg.y + herobg.height + 5;
				
				var hPro:PRO_Hero = FormationModel.inst.getPHero(int(herovo.id));
				if(hPro)
				{
					var powerBg:MovieClip = new HeroHandbookSkin.POWER_BG() as MovieClip
					powerBg.width = 196;
					powerBg.x = 5;
					powerBg.y = 250;
					container.addChild(powerBg);
					
					var powerNum:BitmapNumber = new BitmapNumber();
					powerNum.update(BitmapNumber.WINDOW_S_YELLOW, hPro.base.power.toString());
					powerNum.x = 215 - powerNum.width >> 1;
					powerNum.y = 265;
					container.addChild(powerNum);
					
					preHeight = powerNum.y + powerNum.height + 5;
				}
				
				var skillLabel:Label = new Label();
				skillLabel.color = GameDictionary.WINDOW_BLUE;
				var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(herovo.special_skill_id);
				if(skill)
				{
					skillLabel.text =  "技能： " + GameDictionary.createCommonText(skill.name);
				}
				skillLabel.x = 105;
				container.addChild(skillLabel);
				
				var raceLabe:Label = new Label();
				raceLabe.color = GameDictionary.WINDOW_BLUE;
				raceLabe.text = "种族： " +  GameDictionary.createCommonText(Lang.instance.trans("AS_race_s" + herovo.race));
				raceLabe.x = 17;
				container.addChild(raceLabe);
				
				var url:String = GameConfig.BATTLE_FIGURE_URL + herovo.url;
				var figure:SpriteFigureItem = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
				figure.frameRate = 18;
				figure.play();
				figure.x = 105;
				figure.y = 225;
				container.addChild(figure);
				
				raceLabe.y  = preHeight + 10;
				skillLabel.y = raceLabe.y ;
				
				HerohandbookModel.inst.resource.push(url);
			}
			else
			{
				return null;
			}
			
			return container;
		}
		
		
		
	}
}