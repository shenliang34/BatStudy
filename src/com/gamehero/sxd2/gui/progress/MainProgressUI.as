package com.gamehero.sxd2.gui.progress {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
//	import alternativa.gui.theme.defaulttheme.primitives.base.ProgressBar;
	
	
	/**
	 * Progress UI 
	 * @author Trey
	 * @create-date 2013-7-24
	 */
//	public class ProgressUI extends ProgressBar {
	public class MainProgressUI extends Sprite {
		
		static private var _instance:ProgressUI;
		
		private var progressMC:MovieClip;
		
		public function MainProgressUI() {
			
			super();
			
//			this.width = 300;
		}
		
		
		static public function get instance():ProgressUI {
			
			return _instance ||= new ProgressUI();
		}

//		override public function set percent(value:Number):void {
		public function set percent(value:Number):void {
			
//			super.percent = value / 100;
//			this.label = String(int(value)) + "%";
			
			progressMC.progress_mc.gotoAndStop(value);
			progressMC.progress_txt.text = String(int(value)) + "%";
		}
		
		
		public function show():void {
			
			if(!progressMC) {
				
				//progressMC = GameLoading.progressMC;
				addChild(progressMC);
			}
			
			App.ui.addChild(this);
			
//			this.x = (this.stage.stageWidth - this.width) >> 1;
//			this.y = (this.stage.stageHeight - this.height) >> 1;
			this.x = (this.stage.stageWidth - 1000) >> 1;
			this.y = (this.stage.stageHeight - 600) >> 1;
		}
		
		
		public function hide():void {
			
			if(App.ui.contains(this)) {
				
				App.ui.removeChild(this);
				this.percent = 0;
			}
		}
		
	}
}
