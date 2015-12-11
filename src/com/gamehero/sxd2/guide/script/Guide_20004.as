package com.gamehero.sxd2.guide.script
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.gamehero.sxd2.battle.gui.TipsSkIcon;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.skill.SkillButton;
	import com.gamehero.sxd2.gui.skill.SkillDragObject;
	import com.gamehero.sxd2.gui.skill.SkillWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import alternativa.gui.mouse.MouseManager;
	
	
	/**
	 * 第四个技能学习后自动飞向技能栏
	 * @author xuwenyi
	 * @create 2014-09-16
	 **/
	public class Guide_20004 extends Guide
	{
		private var skillBtn:SkillButton;
		private var window:SkillWindow;
		// 学习技能icon
		private var skIcon:TipsSkIcon;
		// 鼠标timer
		private var mouseTimer:Timer;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_20004()
		{
			super();
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 静止所有鼠标事件
			this.mouseEnabled = false;
			// 若5秒后鼠标仍然没有启用,则做个容错
			this.startMouseTimer();
			
			// 技能面板
			window = WindowManager.inst.getWindowInstance(SkillWindow ,  WindowPostion.CENTER) as SkillWindow;
			// 升级的按钮
			skillBtn = param as SkillButton;
			
			// 技能图标飞向技能栏
			this.fly();
		}
		
		
		
		
		/**
		 * 飞向技能栏
		 * */
		private function fly():void
		{	
			// 要飞的技能
			var skill:BattleSkill = skillBtn.skill;
			skIcon = new TipsSkIcon();
			skIcon.x = skillBtn.x + 28 + 5;
			skIcon.y = skillBtn.y + 61 + 5;
			skIcon.load(skill.skillId);
			window.addChild(skIcon);
			
			// 技能图标飞向技能栏
			var posX:int = 359;
			var posY:int = 450;
			// 飞到技能栏中
			TweenMax.to(skIcon , 0.6 , {x:posX,y:posY,ease:Expo.easeOut,onComplete:over});
			
			function over():void
			{
				if(skIcon && window.contains(skIcon) == true)
				{
					window.removeChild(skIcon);
				}
				
				// 手动装备
				var dragObject:SkillDragObject = new SkillDragObject(skillBtn , null);
				var equipBtn:SkillButton = window.getEquipBtn(4);
				equipBtn.drop(dragObject);
				
				// 引导结束
				guideCompleteHandler();
			}
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(skIcon && window)
			{
				if(window.contains(skIcon) == true)
				{
					window.removeChild(skIcon);
				}
			}
			window = null;
			skillBtn = null;
			skIcon = null;
			
			// 启用所有鼠标事件
			this.mouseEnabled = true;
			this.clearMouseTimer();
			
			super.guideCompleteHandler(e);
		}
		
		
		
		
		/**
		 * 启动鼠标tiemr
		 * */
		private function startMouseTimer():void
		{
			mouseTimer = new Timer(5000 , 1);
			mouseTimer.addEventListener(TimerEvent.TIMER_COMPLETE , onMouseTimer);
			mouseTimer.start();
		}
		
		
		
		
		/**
		 * 清除鼠标tiemr
		 * */
		private function clearMouseTimer():void
		{
			if(mouseTimer)
			{
				mouseTimer.stop();
				mouseTimer.removeEventListener(TimerEvent.TIMER_COMPLETE , onMouseTimer);
				mouseTimer = null;
			}
		}
		
		
		
		
		/**
		 * 容错timer
		 * */
		private function onMouseTimer(e:TimerEvent):void
		{
			this.mouseEnabled = true;
			this.clearMouseTimer();
		}
		
		
		
		
		/**
		 * 启用/禁用鼠标
		 * */
		private function set mouseEnabled(value:Boolean):void
		{
			MouseManager.enabled = value;
		}
		
		
		
		
		private function get mouseEnabled():Boolean
		{
			return MouseManager.enabled;
		}
	}
}