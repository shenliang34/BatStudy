package com.gamehero.sxd2.guide.gui
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.drama.DramaManager;
	import com.pps.ifs.event.TaskEvent;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.guide.Guide;
	import com.gamehero.sxd2.guide.GuideArrow;
	import com.gamehero.sxd2.pro.GS_TaskActionType_Pro;
	import com.gamehero.sxd2.pro.GS_TaskAction_Pro;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	/**
	 * 欢迎界面 
	 * @author wulongbin
	 * @modify Trey
	 */	
	public class WelcomeWindow extends GameWindow
	{
		private const WINDOW_WIDTH:int = 630;
		private const WINDOW_HEIGHT:int = 470;
		
		private var startbtn:GTextButton;		// 开始按钮
		private var arrow:GuideArrow;			// 引导箭头
		
		
		
		/**
		 * 构造函数
		 * */
		public function WelcomeWindow(position:int, resourceURL:String = "Guide_WelcomeBG.swf") {
			
			super(position, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		
		override protected function initWindow():void {
			
			super.initWindow();
			
			var welcomeMC:MovieClip = this.getSwfInstance("MOVIE") as MovieClip;
			welcomeMC.x = 270;
			welcomeMC.y = 230;
			this.addChild(welcomeMC);
			
			startbtn = new GTextButton(MainSkin.redButton5Up, MainSkin.redButton5Down, MainSkin.redButton5Over);
			startbtn.label = Lang.instance.trans("AS_1398");   
			startbtn.x = WINDOW_WIDTH - 303;
			startbtn.y = WINDOW_HEIGHT - 203;
			this.addChild(startbtn);
			
			
			// 引导箭头
			arrow = new GuideArrow();
			this.addChild(arrow);
		}
		
		
		/**
		 * 显示面板
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			// 引导箭头
			arrow.setLabel(Lang.instance.trans("AS_1399") , Guide.Direct_Left);
			arrow.x = startbtn.x + startbtn.width + (arrow.width >> 1);
			arrow.y = startbtn.y - (startbtn.height >> 1);
			
			FiltersUtil.playGlowFilterMovie(startbtn , 0xFFFFCC);

			stage.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		
		private function onClick(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.CLICK , onClick);
			
			if(parent)
			{
			　	// 触发第一个任务
				var taskActionPro:GS_TaskAction_Pro = new GS_TaskAction_Pro();
				taskActionPro.taskID = Global.instance.getFirstTaskID();
				taskActionPro.actionType = GS_TaskActionType_Pro.ACCCEPT_TASK;
				DramaManager.instance.dispatchEvent(new TaskEvent(TaskEvent.TASK_ACTION_E, taskActionPro));
				
				
//				// 去掉引导箭头
//				if(arrow && this.contains(arrow) == true)
//				{
//					this.removeChild(arrow);
//				}
//				FiltersUtil.stopGlowFilterMovie(startbtn);
				
				// 关闭欢迎面板
				this.close();
			}
		}
		
		
		override public function close():void {
			
			// GC
			stage.removeEventListener(MouseEvent.CLICK , onClick);
			
			Global.instance.removeChildren(this);
			
			startbtn = null;
			
			FiltersUtil.stopGlowFilterMovie(startbtn);
			arrow = null;
			
			loader.removeAll();
			loader = null;
			
			super.close();
		}
		
		
	}
}