package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 技能分类面板
	 * @author zhangxueyou
	 * @create 2015-10-26
	 **/
	public class SkillTypePanel extends Sprite
	{
		private var skillItemCell:SkillItemCell;
		private var nameTxt:Label;
		private var levelTxt:Label;
		private var lockTxt:Label;
		
		/**
		 *构造 
		 * 
		 */		
		public function SkillTypePanel()
		{
			super();
			initUI()
		}
		
		/**
		 *初始化UI 
		 * 
		 */		
		private function initUI():void
		{
			// 列表九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(112, 103);
			addChild(innerBg);

			nameTxt = new Label();
			nameTxt.x = 10;
			nameTxt.y = 60;
			addChild(nameTxt);
			
			levelTxt = new Label();
			levelTxt.x = 10;
			levelTxt.y = 80;
			addChild(levelTxt);
			
			
			lockTxt = new Label();
			lockTxt.y = 70;
			addChild(lockTxt);
			
			skillItemCell = new SkillItemCell();
			skillItemCell.isAll = false;
			skillItemCell.x = this.width - skillItemCell.width >> 1;
			skillItemCell.y = 10;
			skillItemCell.isSlot = false;
			addChild(skillItemCell);
		}
		
		/**
		 *设置面板信息 
		 * @param info
		 * 
		 */		
		public function setPanelInfo(info:BattleSkill):void
		{
			if(!info) return;
			nameTxt.text = "";
			levelTxt.text = "";
			lockTxt.text = "";
			
			var obj:Object = SkillManager.instance.getRoleSkillBySkillID(info.skillId);
			
			if(obj)
			{
				var skillVo:BattleSkill = obj.skillVo;
				nameTxt.text = "名称：" + info.name;
				levelTxt.text = "等级：" + info.skillLevel.toString();
			}	
			else
			{
				var level:int = GameData.inst.playerInfo.level;
				if(level < info.skillLevel)
					lockTxt.text = "声望" + info.skillLevel + "级可学习";
				else
					lockTxt.text = "可学习";
				lockTxt.x = this.width - lockTxt.width >> 1; 
			}
			
			
			skillItemCell.data = info;
		}
		
		/**
		 *清理 
		 * 
		 */		
		public function clear():void
		{
			nameTxt.text = "";
			levelTxt.text = "";
			lockTxt.text = "";
			skillItemCell.clear();
		}
	}
}