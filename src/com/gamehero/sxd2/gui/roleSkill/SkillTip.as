package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.bytearray.display.ScaleBitmap;

	
	/**
	 * 技能提示
	 * @author zhangxueyou
	 * @create 2015-10-26
	 **/
	public class SkillTip
	{
		public function SkillTip()
		{
			
		}
		
		/**
		 *获取技能提示 
		 * @param data
		 * @param isAll
		 * @return 
		 * 
		 */		
		public static function getSkillCellTips(data:BattleSkill,isAll:Boolean):DisplayObject
		{
			var container:Sprite = new Sprite();
			var offset:int = 0;
			if(isAll)
			{
				var nameText:TextField = new TextField();
				var nameStr:String = "<font size='14' face='宋体' color='#ffad2c'>";
				nameText.htmlText = nameStr + data.name;
				nameText.x = -2;
				nameText.y = 3;
				container.addChild(nameText);
				
				var levelText:Label = new Label();
				levelText.text = data.skillLevel + "级";
				levelText.x = nameText.width + 10;
				levelText.y = 5;
				container.addChild(levelText);
				
				var typeText:Label = new Label();
				typeText.text = SkillManager.instance.getSkillTypeByDescribe(data.skillType);
				typeText.x = nameText.width + levelText.width + 40;
				typeText.y = 5;
				container.addChild(typeText);
			}
			else
				offset = 15;
			
			
			var descriptionText:TextField = new TextField();
			var descriptionStr:String = "<font size='12' face='宋体' color='#d7deed'>";
			descriptionText.multiline = true;
			descriptionText.wordWrap = true;
			descriptionText.width = 200;
			descriptionText.htmlText = descriptionStr + data.description;
			descriptionText.x = -2;
			descriptionText.y = 20 - offset;
			container.addChild(descriptionText);
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(200, 2);
			lineBM.y = 70 - offset;
			container.addChild(lineBM);
			
			var upConditionText:Label = new Label();
			if(data.skillLevel == 7)
				upConditionText.text = "本技能已满级";
			else	
				upConditionText.text = "下一等级：声望" + data.upCondition + "级开启";
			
			upConditionText.y = 78 - offset;
			container.addChild(upConditionText);
			
			lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(200, 2);
			lineBM.y = 96 - offset;
			container.addChild(lineBM);
			
			var opText:Label = new Label();
			opText.text = "双击或者拖动技能携带";
			opText.y = 104 - offset;
			container.addChild(opText);

			return container;
		}
		
	}
}