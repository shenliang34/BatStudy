package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.HeroSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-15 上午11:25:31
	 * 
	 */
	public class ItemHeroTips
	{
		private static var url:String;
		public function ItemHeroTips()
		{
		}
		
		
		/**
		 * 获取道具中伙伴类的tips 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function getHeroTips(data:ItemCellData):DisplayObject
		{
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(data.data.itemId);
			//获取伙伴信息
			var heroVo:HeroVO = HeroManager.instance.getHeroByID(propBaseVo.proValue[0]);
			var container:Sprite = new Sprite();
			var pre:DisplayObject;//上面的一个显示对象，用来对位
			
			var hero:ItemCell = new ItemCell();
			hero.data = data.data;
			
			var label:Label = new Label();//名字
			label.leading = 0.5;
			label.color = GameDictionary.getColorByQuality(int(heroVo.quality));
			label.text = propBaseVo.name;
			label.bold = true;
			container.addChild(label);
			label.x = 227 - label.width >> 1;
			label.y = 17;
			
			var tipsBg:MovieClip = new HeroSkin.TIP_BG() as MovieClip;
			tipsBg.x = 41;
			tipsBg.y = 172;
			container.addChild(tipsBg);
			
			var job:Bitmap = new Bitmap(HeroSkin.getJobSkin(heroVo.job));
			job.x = 165;
			job.y = 35;
			container.addChild(job);
			
			/*var url:String = GameConfig.FIGURE_URL + "body_ui/" +  heroVo.id;
			var figure:SpriteFigureItem = new SpriteFigureItem(url, false , BattleFigureItem.UI_STAND);*/
			
			url = GameConfig.BATTLE_FIGURE_URL + heroVo.url;
			var figure:SpriteFigureItem = new SpriteFigureItem(url , true , BattleFigureItem.STAND);
			figure.frameRate = 18;
			figure.play();
			figure.x = 113;
			figure.y = 190;
//			figure.scaleX = figure.scaleY = 0.5;
			container.addChild(figure);
			
			label = new Label();//种族
			label.leading = 0.5;
			label.color = GameDictionary.WINDOW_BLUE;
			label.text = "种族： " +  GameDictionary.createCommonText(Lang.instance.trans("AS_race_s" + heroVo.race));
			container.addChild(label);
			label.x = 29;
			label.y = 224;
			
			label = new Label();//技能
			var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(heroVo.special_skill_id);
			label.leading = 0.5;
			label.color = GameDictionary.WINDOW_BLUE;
			if(skill)
			{
				label.text = "技能： " + GameDictionary.createCommonText(skill.name);
			}
			else
			{
				label.text = "";
			}
			container.addChild(label);
			label.x = 117;
			label.y = 224;
			
			var bg:ScaleBitmap = new ScaleBitmap();
			bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
			var w:int = 207 + GameHint.paddingX * 2;
			var h:int = 237 + GameHint.paddingY * 2 + GameHintSkin.edge;
			bg.setSize(w , h);
			container.addChildAt(bg,0);
			return container;
		}
	}
}