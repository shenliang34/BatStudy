package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.event.SkillEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.skill.SkillButton;
	import com.gamehero.sxd2.gui.skill.SkillWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.SkillManager;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import alternativa.gui.mouse.MouseManager;
	
	import bowser.logging.Logger;
	
	
	/**
	 * 第二场技能面板引导
	 * @author xuwenyi
	 * @create 2014-04-16
	 **/
	public class Guide_20002 extends Guide
	{
		private var skillBtn:SkillButton;
		private var window:SkillWindow;
		
		// 学习技能的groupID
		private var groupID:int;
		// 鼠标timer
		private var mouseTimer:Timer;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_20002()
		{
			super();
		}
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 技能面板
			window = WindowManager.inst.getWindowInstance(SkillWindow ,  WindowPostion.CENTER) as SkillWindow;
			window.addEventListener(SkillEvent.ON_GET_SKILL_LIST , next1);
		}
		
		
		
		
		/**
		 * 出现引导箭头
		 * */
		private function next1(e:Event = null):void
		{
			if(e != null)
			{
				e.currentTarget.removeEventListener(SkillEvent.ON_GET_SKILL_LIST , next1);
			}
			
			// 是否存在技能点
			if(SkillManager.instance.pointRemain > 0)
			{
				// 技能按钮
				var career:uint = GameData.inst.roleInfo.roleBase.career;
				var groupIds:Array = guideInfo.param1.split("^");
				groupID = groupIds[career - 1];
				skillBtn = window.getSkillBtn(groupID);
				//用于禁止点击升级按钮
				skillBtn.enabled = false;
				
				this.popupClickGuide(skillBtn, true, Lang.instance.trans("AS_1411"), Direct_Down, next2);
				
				//_mask.resetTargetMask(50,50);
			}
			else
			{
				// 没有技能点
				Logger.debug(Guide_20002 , "没有技能点,引导结束!");
				this.finish();
			}
			
		}
		
		
		
		/**
		 * 发送请求
		 * */
		private function next2():void
		{
			// 静止所有鼠标事件
			this.mouseEnabled = false;
			// 若5秒后鼠标仍然没有启用,则做个容错
			this.startMouseTimer();
			
			//手动升级
			skillBtn.enabled = true;
			skillBtn.dispatchEvent(new SkillEvent(SkillEvent.BTN_UPGRADE_SKILL));
			
			window.addEventListener(SkillEvent.UPGRADE_SUCCESS , next3);
		}
		
		
		
		
		/**
		 * 间隔1秒后执行
		 * */
		private function next3(e:SkillEvent):void
		{
			if(window)
			{
				e.currentTarget.removeEventListener(SkillEvent.UPGRADE_SUCCESS , next3);
				
				setTimeout(finish , 1000);
			}
		}
		
		
		
		
		
		
		
		/**
		 * 引导关闭面板
		 * */
		private function finish():void
		{
			// 启用所有鼠标事件
			this.mouseEnabled = true;
			this.clearMouseTimer();
			
			popupClickGuide(window.getCloseBtn() , true , Lang.instance.trans("AS_1412"), Direct_Right , guideCompleteHandler);
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				window.removeEventListener(SkillEvent.ON_GET_SKILL_LIST , next1);
				window.removeEventListener(SkillEvent.UPGRADE_SUCCESS , next3);
				window = null;
			}
			skillBtn = null;
			
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