package com.gamehero.sxd2.gui.tips
{
    import com.gamehero.sxd2.battle.data.BattleBuff;
    import com.gamehero.sxd2.battle.display.BPlayer;
    import com.gamehero.sxd2.core.GameConfig;
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
    import com.gamehero.sxd2.manager.SkillManager;
    import com.gamehero.sxd2.pro.PRO_BattlePlayer;
    import com.gamehero.sxd2.pro.PRO_BattlePlayerType;
    import com.gamehero.sxd2.pro.PRO_PlayerBase;
    import com.gamehero.sxd2.pro.PRO_Property;
    import com.gamehero.sxd2.util.BitmapLoader;
    import com.gamehero.sxd2.vo.BattleSkill;
    import com.gamehero.sxd2.vo.BuffVO;
    
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    
    import alternativa.gui.enum.Align;
    
    import bowser.utils.data.Group;
    
    import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 战斗UI中的tips
	 * @author xuwenyi
	 * @create 2013-12-06
	 **/
	public class BattleTips
	{
		
		
		/**
		 * buff tips
		 * */
		/*public static function getBuffTips(buffIcon:BattleBuffIcon):DisplayObject
		{
			var str:String;
			var buff:BattleBuff = buffIcon.buff;
			
			if(buff)
			{
				var data:GS_BattleBuff_Pro = buff.data;
				var vo:BuffVO = buff.vo;
				
				// 容器
				var container:Sprite = new Sprite();
				container.mouseEnabled = false;
				container.mouseChildren = false;
				
				var label:Label = new Label(false);
				label.leading = 0.3;
				label.y = 0;
				// buff名
				var titleColor:int = 0;
				switch(vo.buffClass)
				{
					// 增益
					case "1":
						titleColor = GameDictionary.BLUE;
						break;
					// 减益
					case "2":
						titleColor = GameDictionary.RED;
						break;
					// 特殊
					case "3":
						titleColor = GameDictionary.ORANGE;
						break;
				}
				str = GameDictionary.createCommonText(vo.cname+" " , titleColor) + "\n";
				// buff描述
				str += GameDictionary.createCommonText(Lang.instance.trans("AS_1019") + vo.formatDescription(data.num)) + "\n";
				// 剩余回合数
				if(vo.expireType != "3" && vo.expireType != "5" && data.expire >= 0)
				{
					var remainRoundText:String;
					switch(vo.expireType)
					{
						// 攻击次数
						case "1":
							remainRoundText = data.expire + Lang.instance.trans("AS_1020");
							break;
						// 被攻击次数
						case "2":
							remainRoundText = Lang.instance.trans("AS_1021") + data.expire + Lang.instance.trans("AS_1022");
							break;
						// 攻击次数或被攻击次数
						case "4":
							remainRoundText = Lang.instance.trans("AS_1023") + data.expire + Lang.instance.trans("AS_1022");
							break;
					}
					str += GameDictionary.createCommonText(remainRoundText , GameDictionary.ORANGE , 12) + "\n";
				}
				
				label.text = str;
				label.width = 230;
				container.addChild(label);
				
				return container;
			}
			return null;
		}*/
		
		
		
		
		
		
		
		/**
		 * 战斗角色tips
		 * */
		public static function getBattleRoleTips(player:BPlayer):DisplayObject
		{
			var tipsWidth:int = 190;
			var str:String;
			var preHeight:int;
			var role:PRO_BattlePlayer = player.role;
			var lineBM:ScaleBitmap;
			
			if(role)
			{
				var base:PRO_PlayerBase = role.base;
				
				// 容器
				var container:Sprite = new Sprite();
				container.mouseEnabled = false;
				container.mouseChildren = false;
				
				// 职业(若有)
				//if(base.sexOrJob > 0)
				{
					var jobIcon:Bitmap = new Bitmap(BattleSkin.TIPS_JOB_1);
					jobIcon.x = 1;
					jobIcon.y = -1;
					container.addChild(jobIcon);
				}
				
				// 姓名
				var label:Label = new Label(false);
				label.x = 39;
				label.y = 6;
				str = GameDictionary.createCommonText(player.name + " " , GameDictionary.ORANGE , 12 , true);
				// 等级
				str += GameDictionary.createCommonText("Lv." + base.level , GameDictionary.WHITE , 12 , true) + "\n";
				label.text = str;
				label.width = tipsWidth;
				container.addChild(label);
				preHeight = label.y + label.height + 18;
				
				// ==================================================================================
				
				if(role.playerType != PRO_BattlePlayerType.PLAYER)
				{
					var BLOOD_BG_WIDTH:int = 142;
					var BLOOD_WIDTH:int = 138;
					
					// 生命
					label = new Label(false);
					label.y = preHeight;
					label.text = GameDictionary.createCommonText("血量" , GameDictionary.WHITE);
					label.width = tipsWidth;
					container.addChild(label);
					
					// 生命条
					var hpBG:ScaleBitmap = new ScaleBitmap(BattleSkin.TIPS_BLOOD_BG);
					hpBG.scale9Grid = new Rectangle(10,6,2,3);
					hpBG.x = 38;
					hpBG.y = label.y - 1;
					hpBG.setSize(BLOOD_BG_WIDTH , 15);
					container.addChild(hpBG);
					var hpBar:ScaleBitmap = new ScaleBitmap(BattleSkin.TIPS_BLOOD);
					hpBar.scale9Grid = new Rectangle(6,4,3,3);
					hpBar.x = hpBG.x + 2;
					hpBar.y = hpBG.y + 2;
					var hpWidth:Number = Math.floor(BLOOD_WIDTH * (base.hp/base.maxhp));
					if(hpWidth > 0)
					{
						hpBar.visible = true;
						hpBar.setSize(hpWidth , 11);
					}
					else
					{
						hpBar.visible = false;
					}
					container.addChild(hpBar);
					label = new Label(false);
					label.x = hpBG.x;
					label.y = hpBG.y + 1;
					label.text = GameDictionary.createCommonText(base.hp + "/" + base.maxhp);
					label.width = BLOOD_BG_WIDTH;
					label.align = Align.CENTER;
					container.addChild(label);
					preHeight = label.y + label.height + 13;
					
					// 怒气
					label = new Label(false);
					label.y = preHeight;
					label.text = GameDictionary.createCommonText("气势" , GameDictionary.WHITE);
					label.width = tipsWidth;
					container.addChild(label);
					
					// 怒气条
					var angerBG:ScaleBitmap = new ScaleBitmap(BattleSkin.TIPS_BLOOD_BG);
					angerBG.scale9Grid = new Rectangle(10,6,2,3);
					angerBG.x = 38;
					angerBG.y = label.y - 1;
					angerBG.setSize(BLOOD_BG_WIDTH , 15);
					container.addChild(angerBG);
					var angerBar:ScaleBitmap = new ScaleBitmap(BattleSkin.TIPS_ANGER);
					angerBar.scale9Grid = new Rectangle(6,4,3,3);
					angerBar.x = angerBG.x + 2;
					angerBar.y = angerBG.y + 2;
					var angerWidth:Number = Math.floor(BLOOD_WIDTH * (role.anger/role.maxAnger));
					if(angerWidth > 0)
					{
						angerBar.visible = true;
						angerBar.setSize(angerWidth , 11);
					}
					else
					{
						angerBar.visible = false;
					}
					container.addChild(angerBar);
					label = new Label(false);
					label.x = angerBG.x;
					label.y = angerBG.y + 1;
					label.text = GameDictionary.createCommonText(role.anger + "/" + role.maxAnger);
					label.width = BLOOD_BG_WIDTH;
					label.align = Align.CENTER;
					container.addChild(label);
					preHeight = label.y + label.height + 13;
				}
				
				
				// =====================================================================================
				
				// 绝技
				var skills:Group = player.skills;
				if(skills && skills.length > 0)
				{
					// 分割线
					lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
					lineBM.scale9Grid = ChatSkin.lineScale9Grid;
					lineBM.setSize(175, 2);
					lineBM.y = preHeight + 10;
					container.addChild(lineBM);
					preHeight = lineBM.y + lineBM.height + 10;
					
					var skill:BattleSkill = skills.getChildAt(0) as BattleSkill;
					
					// 绝技
					label = new Label(false);
					label.x = 0;
					label.y = preHeight;
					label.text = GameDictionary.createCommonText("绝技：" , GameDictionary.BLUE);
					label.width = tipsWidth;
					container.addChild(label);
					
					// 技能名
					label = new Label(false);
					label.x = 38;
					label.y = preHeight;
					label.text = GameDictionary.createCommonText(skill.name , GameDictionary.BLUE);
					label.width = tipsWidth;
					container.addChild(label);
					preHeight = label.y + label.height + 10;
				}
				
				// ================================================================================
				
				// 状态(若有)
				var buffs:Array = player.buffs;
				if(buffs && buffs.length > 0)
				{
					buffs = buffs.concat();
					
					// 状态名
					str = "";
					label = new Label(false);
					label.y = preHeight;
					
					var buff:BattleBuff;
					var vo:BuffVO;
					while(buffs.length > 0)
					{
						buff = buffs[0];
						vo = buff.vo;
						str += GameDictionary.createCommonText(vo.cname + " 剩余" , GameDictionary.GREEN) + GameDictionary.createCommonText(vo.expireValue + "回合\n");
						// 移除数组
						buffs.splice(0,1);
					}
					label.text = str;
					label.width = tipsWidth;
					container.addChild(label);
					
					preHeight = label.y + label.height + 10;
				}
				
				// 最后加上空白行
				label = new Label(false);
				label.x = 0;
				label.y = preHeight - 5;
				label.text = "\n";
				label.width = tipsWidth;
				container.addChild(label);
				
				return container;
			}
			return null;
		}
		
		
		
		
		
		
		
		
		
		
		/**
		 * 战斗主角tips
		 * */
		public static function getBattleLeaderTips(player:BPlayer):DisplayObject
		{
			var tipsWidth:int = 230;
			var str:String;
			var preHeight:int;
			var role:PRO_BattlePlayer = player.role;
			var lineBM:ScaleBitmap;
			
			if(role)
			{
				// 容器
				var container:Sprite = new Sprite();
				container.mouseEnabled = false;
				container.mouseChildren = false;
				
				var base:PRO_PlayerBase = role.base;
				var property:PRO_Property = base.property;
				
				// 头像
				var head:BitmapLoader = new BitmapLoader();
				
				// 姓名 等级 团队先攻
				var label:Label = new Label(false);
				label.x = 60;
				label.y = 0;
				label.leading = 0.5;
				str = GameDictionary.createCommonText(player.name + "\n" , GameDictionary.ORANGE , 12 , true);
				str += GameDictionary.createCommonText("等级:" , GameDictionary.GRAY);
				str += GameDictionary.createCommonText(base.level + "\n");
				str += GameDictionary.createCommonText("团队先攻:" , GameDictionary.GRAY);
				str += GameDictionary.createCommonText("" + role.teamSpeed);
				label.text = str;
				label.width = tipsWidth;
				container.addChild(label);
				preHeight = label.y + label.height + 18;
				
				// 可耻的分割线
				lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
				lineBM.scale9Grid = ChatSkin.lineScale9Grid;
				lineBM.setSize(175, 2);
				lineBM.y = preHeight;
				container.addChild(lineBM);
				preHeight = lineBM.y + lineBM.height + 10;
				
				// 进攻
				label = new Label(false);
				label.x = 0;
				label.y = 80;
				str = GameDictionary.createCommonText("进攻  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "\n");
				str += GameDictionary.createCommonText("身法  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "\n");
				str += GameDictionary.createCommonText("会心  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "\n");
				str += GameDictionary.createCommonText("攻击  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "");
				label.text = str;
				label.width = tipsWidth;
				container.addChild(label);
				preHeight = label.y + label.height + 18;
				
				// 御守
				label = new Label(false);
				label.x = 110;
				label.y = 80;
				str = GameDictionary.createCommonText("御守  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "\n");
				str += GameDictionary.createCommonText("招架  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "\n");
				str += GameDictionary.createCommonText("穿刺  " , GameDictionary.BLUE);
				str += GameDictionary.createCommonText(property.attack + "");
				label.text = str;
				label.width = tipsWidth;
				container.addChild(label);
				preHeight = label.y + label.height + 18;
				
				// 主角存在技能
				var skills:Array = [];//player.skills.toArray();
				for(var x:int=0;x<5;x++)
				{
					var bs:BattleSkill = SkillManager.instance.getSkillBySkillID("10000101");
					skills.push(bs);
				}
				if(skills.length > 0)
				{
					// 可耻的分割线
					lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
					lineBM.scale9Grid = ChatSkin.lineScale9Grid;
					lineBM.setSize(175, 2);
					lineBM.y = preHeight + 10;
					container.addChild(lineBM);
					preHeight = lineBM.y + lineBM.height + 10;
					
					// 主角技能
					label = new Label(false);
					label.x = 0;
					label.y = preHeight;
					str = GameDictionary.createCommonText("主角技能  " , GameDictionary.ORANGE , 12 , true);
					label.text = str;
					label.width = tipsWidth;
					container.addChild(label);
					preHeight = label.y + label.height + 18;
					
					// 具体技能
					var rounds:Array = ["一","二","三","四","五"];
					for(var i:int=0;i<skills.length;i++)
					{
						var skill:BattleSkill = skills[i];
						
						label = new Label(false);
						label.x = 0;
						label.y = preHeight;
						str = GameDictionary.createCommonText("第" + rounds[i] +  "回合" , GameDictionary.GRAY);
						str += GameDictionary.createCommonText("【" + skill.name +  "】" , GameDictionary.PURPLE);
						// 是否已使用
						var s:String = player.checkUsedSkill(skill) == true ? GameDictionary.createCommonText("(已使用)" , GameDictionary.RED) : GameDictionary.createCommonText("(未使用)" , GameDictionary.GREEN);
						str += s;
						label.text = str;
						label.width = tipsWidth;
						container.addChild(label);
						preHeight = label.y + label.height + 10;
						
						// 技能图标
						var icon:BitmapLoader = new BitmapLoader();
						icon.url = GameConfig.SKILL_ICON_URL + skill.groupId + ".png";
						icon.x = 0;
						icon.y = preHeight;
						container.addChild(icon);
						
						label = new Label(false);
						label.x = 45;
						label.y = icon.y;
						str = GameDictionary.createCommonText(skill.description , GameDictionary.GRAY);
						label.text = str;
						label.width = tipsWidth;
						label.height = 60;
						container.addChild(label);
						preHeight = icon.y + 55;
					}
				}
				
				return container;
			}
			return null;
		}
		
		
	}
}