package com.gamehero.sxd2.gui.progress {
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.ProgressBar;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	
	/**
	 * Progress UI 
	 * @author Trey
	 * @create-date 2013-7-24
	 */
	public class ProgressUI extends ProgressBar {
		
		static private var _instance:ProgressUI;
		private var thumb:MovieClip;
		
		public function ProgressUI() {
			
			super(MainSkin.mainProgressBg, MainSkin.mainProgressFull, MainSkin.progressMask);
			this.labelTF.color = GameDictionary.WHITE;
			this.width = 250;
			
			var innerBg:Bitmap = new Bitmap(MainSkin.mainProgressFg);
			this.addForeground(innerBg);
			
			thumb = new (MainSkin.mainProgressThumbClass);
			thumb.y = -(thumb.height >> 1) + 7;
			addChild(thumb);
		}
		
		
		static public function get instance():ProgressUI {
			
			return _instance ||= new ProgressUI();
		}
		
		
		private var _tips:String = "";
		public function updateProgress(percent:Number, tips:String = ""):void {
			
			_tips = tips;
			this.percent = percent;
		}

		override public function set percent(value:Number):void {
			
			super.percent = value / 100;
//			this.label = String(int(value)) + "%";
			this.label = _tips + String(int(value)) + "%";
			_tips = "";
			
			thumb.x = this.fullLine.width - (thumb.width >> 1);
		}
		
		
		
		
		public function show():void {
			
			App.ui.addChild(this);
			
			this.x = (this.stage.stageWidth - this.width) >> 1;
			this.y = (this.stage.stageHeight - this.height) >> 1;
			
			// FORTEST
			/*super.percent = 0;
			setInterval(testPercent, 50);*/
		}
		
		/*private function testPercent():void {
			
			super.percent = percent + .01;
			this.label = String(int(super.percent * 100)) + "%";
			thumb.x = this.fullLine.width - (thumb.width >> 1);
			
			if(percent >= 1) {
				
				super.percent = 0;
			}
		}*/
		
		
		public function hide():void {
			
			if(App.ui.contains(this)) {
				
				App.ui.removeChild(this);
//				this.percent = 0;
			}
		}
		
	}
}
