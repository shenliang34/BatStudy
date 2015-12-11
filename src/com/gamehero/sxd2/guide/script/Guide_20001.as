package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.pps.ifs.event.SkillEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.skill.SkillButton;
	import com.gamehero.sxd2.gui.skill.SkillWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 *技能引导 
	 * @author wulongbin
	 * 
	 */	
	public class Guide_20001 extends Guide
	{
		private var window:SkillWindow;
		private var button:SkillButton;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_20001()
		{
			super();
		}
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			var skillBtn:DisplayObject = FunctionsManager.instance.getFuncInfoByName(WindowEvent.SKILL_WINDOW).button;
			popupClickGuide(skillBtn, true, Lang.instance.trans("AS_1409"), Direct_Right, next1);		
		}
		
		
		
		
		
		private function next1():void
		{
			window = WindowManager.inst.getWindowInstance(SkillWindow, 0) as SkillWindow;
			if(window.loaded)
			{
				this.next2();
			}
			else
			{
				window.addEventListener(Event.COMPLETE, next2);
			}
		}
		
		
		/**
		 * 指向技能按钮
		 * */
		protected function next2(event:Event = null):void
		{
			window.removeEventListener(Event.COMPLETE, next2);
			
			var career:uint = GameData.inst.roleInfo.roleBase.career;
			var groupIds:Array = guideInfo.param1.split("^");
			var groupId:uint = groupIds[career - 1];
			button = window.getSkillBtn(groupId);
			//用于禁止点击升级按钮
			button.enabled = false;
			
			popupClickGuide(button , true, Lang.instance.trans("AS_1410"), Direct_Right, next3);
			
			mask.resetTargetMask(50,50);
		}
		
		
		
		
		/**
		 * 发送升级请求
		 * */
		private function next3():void
		{
			//手动升级
			button.enabled = true;
			button.dispatchEvent(new SkillEvent(SkillEvent.BTN_UPGRADE_SKILL));
			
			this.finish();
		}
		
		
		
		
		private function finish():void
		{
			WindowManager.inst.closeWindow(window);
			
			this.guideCompleteHandler();
		}
		
		
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(window)
			{
				window.removeEventListener(Event.COMPLETE, next2);
				window = null;
			}
			button = null;
			
			super.guideCompleteHandler(e);
		}
	}
}