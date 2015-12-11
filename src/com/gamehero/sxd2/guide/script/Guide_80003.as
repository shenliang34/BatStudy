package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.growup.GrowupLevelUpWindow;
	import com.gamehero.sxd2.gui.growup.GrowupWindow;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.pro.GS_GrowupType_Pro;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	/**
	 * 神兵引导
	 * @author xuwenyi
	 * @create 2014-12-31
	 **/
	public class Guide_80003 extends Guide
	{
		private var godweaponWindow:GrowupWindow;
		private var godweaponLevelUpWindow:GrowupLevelUpWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_80003()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 打开翅膀面板
			MainUI.inst.openWindow(WindowEvent.GROWUP_WINDOW , GS_GrowupType_Pro.GROWUP_GODWEAPON);
			godweaponWindow = WindowManager.inst.getWindowInstance(GrowupWindow,WindowPostion.CENTER) as GrowupWindow;
			if(godweaponWindow)
			{
				if(godweaponWindow.loaded)
				{
					this.next1();
				}
				else
				{
					godweaponWindow.addEventListener(Event.COMPLETE , next1);
				}
			}
		}
		
		
		
		
		/**
		 * 出现引导箭头
		 * */
		private function next1(e:Event = null):void
		{
			if(e != null)
			{
				e.currentTarget.removeEventListener(Event.COMPLETE , next1);
			}
			
			// 坐骑进阶按钮
			var levelUp_Bt:DisplayObject = godweaponWindow.leveUp_Bt;
			this.popupClickGuide(levelUp_Bt, false, Lang.instance.trans("AS_1432"), Direct_Left, next2);
		}
		
		
		
		
		
		
		/**
		 * 打开进阶面板
		 * */
		private function next2():void
		{
			// 进阶面板
			godweaponLevelUpWindow = WindowManager.inst.getWindowInstance(GrowupLevelUpWindow,WindowPostion.CENTER) as GrowupLevelUpWindow;
			if(godweaponLevelUpWindow)
			{
				if(godweaponLevelUpWindow.loaded)
				{
					this.next3();
				}
				else
				{
					godweaponLevelUpWindow.addEventListener(Event.COMPLETE , next3);
				}
			}
		}
		
		
		
		
		/**
		 * 间隔1秒后执行
		 * */
		private function next3(e:Event = null):void
		{
			if(e != null)
			{
				e.currentTarget.removeEventListener(Event.COMPLETE , next3);
			}
			
			// 手动进阶按钮
			var btn:DisplayObject = godweaponLevelUpWindow.autoLeveup_Bt;
			this.popupClickGuide(btn, false, Lang.instance.trans("AS_1433"), Direct_Right , finish);
		}
		
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{
			// 关闭窗口
			if(godweaponWindow)
			{
				godweaponWindow.close();
			}
			if(godweaponLevelUpWindow)
			{
				godweaponLevelUpWindow.close();
			}
			
			this.guideCompleteHandler();
		}
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(godweaponWindow)
			{
				godweaponWindow.removeEventListener(Event.COMPLETE , next1);
				godweaponWindow = null;
				
			}
			if(godweaponLevelUpWindow)
			{
				godweaponLevelUpWindow.removeEventListener(Event.COMPLETE , next3);
				godweaponLevelUpWindow = null;
			}
			
			super.guideCompleteHandler(e);
		}
	}
}