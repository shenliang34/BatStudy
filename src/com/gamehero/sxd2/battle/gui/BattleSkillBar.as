package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.BattleSkillEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import bowser.utils.data.Group;
	
	
	/**
	 * 战斗技能栏
	 * @author xuwenyi
	 * @create 2013-08-20
	 **/
	public class BattleSkillBar extends Sprite
	{
		// 快捷键文字
		private static const QUICK_KEY:Array = ["1","2","3","4","5"];
		
		// 技能icon容器
		private var angerUI:Sprite;
		
		// 怒气技能
		private var angerIconList:Array = [];
		
		// 是否可交互
		private var _enabled:Boolean = true;
		private var _keyboard:Boolean = true;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSkillBar()
		{
			
		}
		
		
		
		
		/**
		 * 初始化UI
		 * */
		public function initUI(bgBD:BitmapData):void
		{
			// 背景
			this.addChild(new Bitmap(bgBD));
			
			// 怒气和战意技能icon容器
			angerUI = new Sprite();
			angerUI.x = 12;
			angerUI.y = 124;
			this.addChild(angerUI);
		}
		
		
		
		
		/**
		 * 更新怒气/战意技能快捷栏
		 * */
		public function updateAngerSkills(skills:Group):void
		{
			this.clearAngerUI();
			
			// 创建技能icon
			for(var i:int=0;i<skills.length;i++)
			{
				var skill:BattleSkill = skills.getChildAt(i) as BattleSkill;
				var icon:BattleSkIcon = new BattleSkIcon(skill , QUICK_KEY[i]);
				icon.x = i*53;
				if(skill)
				{
					icon.addEventListener(BattleSkillEvent.SKILL_ICON_CLICK , onIconClick);
				}
				angerIconList[i] = icon;
				angerUI.addChild(icon);
			}
		}
		
		
		
		
		
		
		
		/**
		 * 启用/禁用 技能栏
		 * */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			var i:int = 0;
			var icon:BattleSkIcon;
			
			// 根据主角怒气及战意值判断技能是否可用
			if(value == true)
			{
				var leader:BPlayer = BattleDataCenter.instance.leader;
				
				// 怒气技
				for(i=0;i<angerIconList.length;i++)
				{
					icon = angerIconList[i];
					if(icon)
					{
						icon.update(leader);
					}
				}
				
				// 允许键盘事件
				if(_keyboard == true)
				{
					this.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
				}
			}
			// 禁用所有技能
			else
			{
				// 怒气技
				for(i=0;i<angerIconList.length;i++)
				{
					icon = angerIconList[i];
					if(icon)
					{
						icon.enabled = false;
					}
				}
				
				// 禁用键盘事件
				this.removeEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			}
		}
		
		
		
		
		/**
		 * 鼠标点击某个技能icon
		 * */
		private function onIconClick(e:BattleSkillEvent):void
		{
			var icon:BattleSkIcon = e.currentTarget as BattleSkIcon;
			this.useSkill(icon);
		}
		
		
		
		
		
		/**
		 * 处理键盘事件
		 * */
		private function onKeyDown(e:KeyboardEvent):void
		{
			// 焦点必须在战斗场景上才能触发按键
			if(stage.focus == this)
			{
				// 保存使用的技能
				var icon:BattleSkIcon;
				switch(e.keyCode)
				{
					// 怒气技能
					case Keyboard.NUMBER_1:
					case Keyboard.NUMPAD_1:
						icon = angerIconList[0];
						break;
					case Keyboard.NUMBER_2:
					case Keyboard.NUMPAD_2:
						icon = angerIconList[1];
						break;
					case Keyboard.NUMBER_3:
					case Keyboard.NUMPAD_3:
						icon = angerIconList[2];
						break;
					case Keyboard.NUMBER_4:
					case Keyboard.NUMPAD_4:
						icon = angerIconList[3];
						break;
					case Keyboard.NUMBER_5:
					case Keyboard.NUMPAD_5:
						icon = angerIconList[4];
						break;
				}
				// 使用技能
				this.useSkill(icon);
			}
		}
		
		
		
		
		
		/**
		 * 使用技能
		 * */
		private function useSkill(icon:BattleSkIcon):void
		{
			// 技能是否可使用
			if(icon && icon.enabled == true && icon.visible == true)
			{
				var skill:BattleSkill = icon.skill;
				this.dispatchEvent(new BattleSkillEvent(BattleSkillEvent.USE_SKILL , skill));
			}
		}
		
		
		
		
		/**
		 * 获取指定位置的技能icon实例
		 * */
		public function getSkIcon(pos:int):BattleSkIcon
		{
			return angerIconList[pos];
		}
		
		
		
		
		/**
		 * 创建快捷键文字
		 * */
		private function createNumLabel(text:String):Label
		{
			var label:Label = new Label(false);
			label.text = text;
			label.width = 20;
			label.height = 20;
			label.size = 11;
			label.color = GameDictionary.ORANGE;
			return label;
		}
		
		
		
		
		
		/**
		 * 是否允许键盘事件
		 * */
		public function set keyboard(value:Boolean):void
		{
			_keyboard = value;
			
			if(_keyboard == true && _enabled == true)
			{
				this.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			}
			else
			{
				this.removeEventListener(KeyboardEvent.KEY_DOWN , onKeyDown);
			}
		}
		
		
		
		
		
		/**
		 * 清空怒气技能面板
		 * */
		private function clearAngerUI():void
		{
			while(angerUI.numChildren > 0)
			{
				var icon:BattleSkIcon = angerUI.getChildAt(0) as BattleSkIcon;
				if(icon)
				{
					icon.removeEventListener(BattleSkillEvent.SKILL_ICON_CLICK , onIconClick);
					icon.clear();
					angerUI.removeChild(icon);
				}
			}
			angerIconList = [];
		}
		
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			this.clearAngerUI();	
			
			// 移除事件
			this.keyboard = false;
		}
		
	}
}