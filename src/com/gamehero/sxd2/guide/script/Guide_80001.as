package com.gamehero.sxd2.guide.script
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.WindowPostion;
	import com.gamehero.sxd2.gui.growup.GrowupLevelUpWindow;
	import com.gamehero.sxd2.gui.growup.GrowupWindow;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideVO;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.GS_PackItem_Pro;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import bowser.logging.Logger;
	
	
	/**
	 * 坐骑引导
	 * @author xuwenyi
	 * @create 2014-04-16
	 **/
	public class Guide_80001 extends Guide
	{
		private var mountWindow:GrowupWindow;
		private var mountLevelUpWindow:GrowupLevelUpWindow;
		
		
		/**
		 * 构造函数
		 * */
		public function Guide_80001()
		{
			super();
			
			isForceGuide = false;
		}
		
		
		
		
		
		override public function playGuide(info:GuideVO, callBack:Function=null, param:Object = null):void
		{
			super.playGuide(info, callBack);
			
			// 坐骑面板
			mountWindow = WindowManager.inst.getWindowInstance(GrowupWindow,WindowPostion.CENTER) as GrowupWindow;
			if(mountWindow)
			{
				if(mountWindow.loaded)
				{
					this.next1();
				}
				else
				{
					mountWindow.addEventListener(Event.COMPLETE , next1);
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
			
			// 判断背包中低级进阶耗材的数量
			var itemID:int = int(Global.instance.getData("MountLowItem"));
			var num:int = ItemManager.instance.getItemNum(compare);
			function compare(element:*, index:int, arr:Array):Boolean
			{
				var packItem:GS_PackItem_Pro = (element as GS_PackItem_Pro);
				return packItem.item.itemId == itemID;
			}
			
			// 数量大于0则开始引导
			if(num > 0)
			{
				// 坐骑进阶按钮
				var levelUp_Bt:DisplayObject = mountWindow.leveUp_Bt;
				this.popupClickGuide(levelUp_Bt, false, Lang.instance.trans("AS_1430"), Direct_Left, next2);
			}
			else
			{
				// 没有材料
				Logger.debug(Guide_20002 , "没有进阶材料,引导结束!");
				this.finish();
			}
		}
		
		
		
		
		
		
		/**
		 * 打开坐骑进阶面板
		 * */
		private function next2():void
		{
			// 坐骑进阶面板
			mountLevelUpWindow = WindowManager.inst.getWindowInstance(GrowupLevelUpWindow,WindowPostion.CENTER) as GrowupLevelUpWindow;
			if(mountLevelUpWindow)
			{
				if(mountLevelUpWindow.loaded)
				{
					this.next3();
				}
				else
				{
					mountLevelUpWindow.addEventListener(Event.COMPLETE , next3);
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
			var btn:DisplayObject = mountLevelUpWindow.leveUp_Bt;
			//mountLevelUpWindow.addEventListener(MountEvent.MOUNT_AUTO_LEVEL_UP_CANCEL , next4);
			this.popupClickGuide(btn, false, Lang.instance.trans("AS_1430"), Direct_Right , next4);
		}
		
		
		
		
		/**
		 * 引导骑乘
		 * */
		private function next4():void
		{	
			//e.currentTarget.removeEventListener(MountEvent.MOUNT_AUTO_LEVEL_UP_CANCEL , next4);
			
			// 骑乘按钮
			var rideButton:DisplayObject = mountWindow.rideButton;
			this.popupClickGuide(rideButton, false, Lang.instance.trans("AS_1431"), Direct_Right , finish);
		}
		
		
		
		
		
		/**
		 * 完成引导
		 * */
		private function finish():void
		{
			// 关闭窗口
			if(mountWindow)
			{
				WindowManager.inst.closeWindow(mountWindow);
			}
			if(mountLevelUpWindow)
			{
				WindowManager.inst.closeWindow(mountLevelUpWindow);
			}
			
			this.guideCompleteHandler();
		}
		
		
		
		override protected function guideCompleteHandler(e:GuideEvent=null):void
		{
			if(mountWindow)
			{
				mountWindow.removeEventListener(Event.COMPLETE , next1);
				mountWindow = null;
				
			}
			if(mountLevelUpWindow)
			{
				mountLevelUpWindow.removeEventListener(Event.COMPLETE , next3);
				//mountLevelUpWindow.removeEventListener(MountEvent.MOUNT_AUTO_LEVEL_UP_CANCEL , next4);
				mountLevelUpWindow = null;
			}
			
			super.guideCompleteHandler(e);
		}
	}
}