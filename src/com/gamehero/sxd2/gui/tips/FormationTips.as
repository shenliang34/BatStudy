package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationBtn;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.manager.FormationManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.FormationVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	
	/**
	 * 阵容相关tips
	 * @author xuwenyi
	 * @create 2015-08-27
	 **/
	public class FormationTips
	{
		public function FormationTips()
		{
		}
		
		
		
		
		
		/**
		 * 单个阵型tips
		 * */
		public static function getFormationTips(btn:FormationBtn):DisplayObject
		{
			var formationVO:FormationVo = FormationManager.instance.getPosById(btn.ID+1);
			if(formationVO)
			{
				var tipsWidth:int = 190;
				// 容器
				var container:Sprite = new Sprite();
				container.mouseEnabled = false;
				container.mouseChildren = false;
				
				// 姓名
				var label:Label = new Label(false);
				label.x = 0;
				label.y = 0;
				var str:String = GameDictionary.createCommonText(formationVO.name);
				label.text = str;
				label.leading = 0.3;
				label.width = tipsWidth;
				container.addChild(label);
				
				return container;
			}
			
			return null;
		}
		
		
		
		
		
		
		/**
		 * 阵容界面右边伙伴tips
		 * */
		public static function getFormationHeroTips(cell:Object):DisplayObject
		{
			var tipsWidth:int = 190;
			var str:String;
			var preHeight:int;
			var lineBM:ScaleBitmap;
			
			var heroInfo:PRO_Hero = cell.heroInfo;
			
			if(heroInfo)
			{
				var heroVO:HeroVO = HeroManager.instance.getHeroByID(heroInfo.heroId+"");
				// 容器
				var container:Sprite = new Sprite();
				container.mouseEnabled = false;
				container.mouseChildren = false;
				
				// 姓名 战力
				var label:Label = new Label(false);
				label.x = 0;
				label.y = 6;
				str = GameDictionary.createCommonText(heroVO.name   + "\n", GameDictionary.getColorByQuality(int(heroVO.quality)) , 14 , true);
				str += GameDictionary.createCommonText("战力：" + heroInfo.base.power + "\n", GameDictionary.getColorByQuality(int(heroVO.quality)) , 12 , true);
				label.text = str;
				label.leading = 0.6;
				label.width = tipsWidth;
				container.addChild(label);
				preHeight = label.y + label.height + 5;
				
				// 分割线
				lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
				lineBM.scale9Grid = ChatSkin.lineScale9Grid;
				lineBM.setSize(175, 2);
				lineBM.y = preHeight + 5;
				container.addChild(lineBM);
				preHeight = lineBM.y + lineBM.height + 10;
				
				// 职业  绝招 
				var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(heroVO.special_skill_id);
				var skillName:String = "";
				if(skill)
				{
					skillName = skill.name;
				}
				str = GameDictionary.createCommonText("职业：" + GameDictionary.getJobName(heroVO.job)  + "\n" + "绝招：" + skillName,GameDictionary.WINDOW_BLUE);
				label = new Label(false);
				label.y = preHeight;
				label.text = str;
				label.leading = 0.8;
				label.width = tipsWidth;
				container.addChild(label);
				
				//tip  w h
				var w:int = container.width;
				var h:int = container.height +10;
				container.graphics.beginFill(0,0);
				container.graphics.drawRect(0,0,w,h);
				container.graphics.endFill();
				
				return container;
			}
			
			return null;
		}
	}
}