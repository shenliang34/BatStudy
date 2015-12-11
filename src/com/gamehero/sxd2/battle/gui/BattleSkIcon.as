package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleBuff;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.BattleSkillEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BuffVO;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	import bowser.utils.effect.color.ColorTransformUtils;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 快捷栏上的技能icon
	 * @author xuwenyi
	 * @create 2013-08-09
	 **/
	public class BattleSkIcon extends ActiveObject
	{
		// 技能icon层
		private var iconPanel:Sprite;
		private var iconURL:String;
		// 圆形容器及遮罩
		private var circle:Sprite;
		private var circleMask:Shape;
		// CD数字层
		private var cdPanel:Sprite;
		// 鼠标选中框
		private var selectedBG:Bitmap;
		private var selectedTween:TweenMax;
		// 高级技能提示效果
		private var skillHint:MovieClip;
		
		// 技能数据
		public var skill:BattleSkill;
		// 技能是否可用
		private var _enabled:Boolean = false;
		
		
		/**
		 * 构造函数
		 * @param skill 技能数据
		 * @param key 快捷键
		 * */
		public function BattleSkIcon(skill:BattleSkill , key:String)
		{
			this.skill = skill;
			
			// 技能icon
			iconPanel = new Sprite();
			iconPanel.mouseEnabled = iconPanel.mouseChildren = false;
			
			// 圆形容器
			circle = new Sprite();
			circle.addChild(iconPanel);
			this.addChild(circle);
			
			// 圆形遮罩
			circleMask = new Shape();
			circleMask.graphics.beginFill(0,0);
			circleMask.graphics.drawCircle(21 , 21 , 21);
			circleMask.graphics.endFill();
			circle.addChild(circleMask);
			iconPanel.mask = circleMask;
			
			// 快捷键数字
			/*var numIcon:Bitmap = new Bitmap(BattleSkin.SKILL_QUICK_NUM_BG);
			numIcon.x = 28;
			numIcon.y = 28;
			this.addChild(numIcon);*/
			var label:Label = this.createNumLabel(key);
			label.x = 40;
			label.y = 35;
			this.addChild(label);
			// cd
			cdPanel = new Sprite();
			cdPanel.mouseEnabled = cdPanel.mouseChildren = false;
			this.addChild(cdPanel);
			
			// 高级技能提示效果
			if(skill && (skill.aiClass == "3"||skill.aiClass == "4"||skill.aiClass == "6"||skill.aiClass == "8"))
			{
				skillHint = new BattleSkin.SKILL_HINT() as MovieClip;
				skillHint.gotoAndStop(0);
				skillHint.visible = false;
				this.addChild(skillHint);
			}
			
			// 画一个透明背景
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,42,42);
			this.graphics.endFill();
			
			
			// 是否需要tips
			if(skill)
			{
				this.hint = " ";
				
				// 加载技能图标
				iconURL =  GameConfig.ICON_URL + "skill/" + skill.iconId + ".jpg";
				var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
				loader.addWithListener(iconURL , null , onLoaded);
			}
			
			// 移除场景后
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		
		
		/**
		 * 添加后
		 * */
		private function onAdd(e:Event):void
		{
			if(skill)
			{
				this.addEventListener(MouseEvent.CLICK , onClick);
				this.addEventListener(MouseEvent.ROLL_OVER , onRollOver);
				this.addEventListener(MouseEvent.ROLL_OUT , onRollOut);
			}
		}
		
		
		
		
		/**
		 * 移除后
		 * */
		private function onRemove(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
			
			this.removeEventListener(MouseEvent.CLICK , onClick);
			this.removeEventListener(MouseEvent.ROLL_OVER , onRollOver);
			this.removeEventListener(MouseEvent.ROLL_OUT , onRollOut);
		}
		
		
		
		
		
		/**
		 * icon加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 添加头像
			var bmp:Bitmap = imageItem.content;
			if(bmp)
			{
				var icon:Bitmap = new Bitmap(bmp.bitmapData);
				var global:Global = Global.instance;
				global.removeChildren(iconPanel);
				iconPanel.addChild(icon);
			}
		}
		
		
		
		
		
		/**
		 * 更新此icon状态
		 * */
		public function update(player:BPlayer):void
		{
			if(skill)
			{
				var role:PRO_BattlePlayer = player.role;
				var base:PRO_PlayerBase = role.base;
				
				// buff
				var buffs:Array = player.buffs;
				// skill
				var skills:Array = role.skills;
				
				// 查找技能的cd
				var cd:int = 0;
				var i:int = 0;
				/*for(var i:int=0;i<skills.length;i++)
				{
					var s:GS_RoleSkill_Pro = skills[i];
					if(s.skillID == int(skill.skillId))
					{
						cd = s.round;
						break;
					}
				}*/
				
				// 是否显示CD数字
				this.showCD(true , cd);
				
				// 是否怒气或战意不足
				
				var num:Number = role.anger;
				if(base.hp == 0)
				{
					this.enabled = false;
					return;
				}
				else if(num < int(skill.consumeValue))
				{
					this.enabled = false;
					return;
				}
				// 技能CD
				else if(cd > 0)
				{
					this.enabled = false;
					return;
				}
				// 是否中了眩晕冰冻等不能出手的debuff
				else if(buffs && buffs.length > 0)
				{
					for(i=0;i<buffs.length;i++)
					{
						var buff:BattleBuff = buffs[i];
						var buffVO:BuffVO = buff.vo;
						if(buffVO && buffVO.cannotUseSkill == "1")
						{
							this.enabled = false;
							return;
						}
					}
				}
				
				this.enabled = true;
				
				// 高级技能激活时会出现火焰提示
				if(skillHint)
				{
					skillHint.visible = true;
					
					var mp:MovieClipPlayer = new MovieClipPlayer();
					mp.play(skillHint , 1.3 , 0 , skillHint.totalFrames);
					mp.addEventListener(Event.COMPLETE , over);
					
					function over(e:Event):void
					{
						e.currentTarget.removeEventListener(Event.COMPLETE , over);
						
						skillHint.visible = false;
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 点击事件
		 * */
		private function onClick(e:MouseEvent):void
		{
			if(this.skill && this.enabled == true)
			{
				this.dispatchEvent(new BattleSkillEvent(BattleSkillEvent.SKILL_ICON_CLICK));
			}
		}
		
		
		
		
		
		
		/**
		 * 鼠标滑过
		 * */
		private function onRollOver(e:MouseEvent):void
		{
			if(enabled == true)
			{
				this.focus = true;
			}
			else
			{
				this.focus = false;
			}
		}
		
		
		
		
		
		
		/**
		 * 鼠标滑出
		 * */
		private function onRollOut(e:MouseEvent):void
		{
			this.focus = false;
		}
		
		
		
		
		
		
		/**
		 * 是否显示CD数字
		 * */
		private function showCD(value:Boolean , cd:int = 0):void
		{
			var global:Global = Global.instance;
			global.removeChildren(cdPanel);
			if(value == true && cd > 0)
			{
				var bmd:BitmapData = BattleSkin["CD" + cd];
				var cdIcon:Bitmap = new Bitmap(bmd);
				cdPanel.addChild(cdIcon);
			}
		}
		
		
		
		
		
		
		
		/**
		 * 设置技能可使用否
		 * */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			// 颜色工具
			var util:ColorTransformUtils = ColorTransformUtils.instance;
			
			// 还原亮度
			util.clear(circle);
			
			if(value == true)
			{
				// 若鼠标正选中此ICON
				if(mouseX > 0 && mouseX < selectedBG.width && mouseY > 0 && mouseY < selectedBG.height)
				{
					// 渐现
					this.focus = true;
				}
			}
			else
			{
				// 亮度变暗
				util.addSaturation(circle , -100);
				
				// 渐隐
				this.focus = false;
			}
		}
		
		
		
		
		
		/**
		 * 技能是否可用
		 * */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		
		
		
		
		
		/**
		 * 渐现或渐隐焦点框
		 * */
		private function set focus(value:Boolean):void
		{
			// 先停止之前的动画
			if(selectedTween)
			{
				selectedTween.kill();
			}
			
			if(value == true)
			{
				selectedTween = TweenMax.to(selectedBG , 0.5 , {alpha:1});
			}
			else
			{
				selectedTween = TweenMax.to(selectedBG , 0.5 , {alpha:0});
			}
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
		 * 清空
		 * */
		public function clear():void
		{
			Global.instance.removeChildren(iconPanel);
			Global.instance.removeChildren(cdPanel);
			Global.instance.removeChildren(circle);
			Global.instance.removeChildren(this);
			
			skill = null;
			this.hint = "";
			
			selectedBG.visible = false;
			selectedBG = null;
			skillHint = null;
			
			if(selectedTween)
			{
				selectedTween.kill();
				selectedTween = null;
			}
		}
		
		
	}
}