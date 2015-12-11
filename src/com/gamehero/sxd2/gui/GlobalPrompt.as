package com.gamehero.sxd2.gui {
	
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.gui.core.GameWindow;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.DialogSkin;
    import com.greensock.TweenLite;
    
    import flash.display.Bitmap;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import org.bytearray.display.ScaleBitmap;
	
	
	
	/**
	 * Global Prompte Window 
	 * @author Trey
	 * @create-date 2013-9-2
	 */
	public class GlobalPrompt extends GameWindow implements IAlert {
		
		private const WINDOW_WIDTH:int = 250;
		private const WINDOW_HEIGHT:int = 78;
		
		
		private const HIDE_DELAY:int = 3;// 秒
		
		
		private var _showTimer:Timer;
//		private var _hideTweenLite:TweenLite;
		private var _tipLabel:Label;
		private var _promptlabel:Label;
		
		
		
		/**
		 * Constructor 
		 * @param windonPosition
		 * @param resourceURL
		 * 
		 */
		public function GlobalPrompt(windonPosition:int, resourceURL:String = null) {
			
			this.mouseEnabled = false;
			this.tabEnabled = false;
			
			super(windonPosition, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
			
			canOpenTween = false;
			
			this.initWindow();
		}
		
		
		
		/**
		 * Init Window  
		 */
		override protected function initWindow():void 
		{	
			var bg:ScaleBitmap;
			bg = new ScaleBitmap(DialogSkin.DIALOG_BG);
			bg.scale9Grid = DialogSkin.DIALOG_BG_9GRID;
			bg.width = this.width;
			bg.height = this.height;
			addChild(bg);
			
			// 惊叹号
			var tipsBP:Bitmap = new Bitmap(DialogSkin.EXCLAMATION);
			tipsBP.x = 30;
			tipsBP.y = 20;
			addChild(tipsBP);
			
			// 提示文字
			_promptlabel = new Label();
			_promptlabel.color = GameDictionary.WINDOW_BLUE;
			_promptlabel.bold = true;
			_promptlabel.size = 14;
			_promptlabel.x = 72;
			_promptlabel.y = 18;
			addChild(_promptlabel);
			
			
			_tipLabel = new Label();
			_tipLabel.x = 76;
			_tipLabel.y = 42;
			_tipLabel.width = 200;
			_tipLabel.color = GameDictionary.WINDOW_BLUE_GRAY;
			addChild(_tipLabel);
			
			
			_showTimer = new Timer(1000, HIDE_DELAY);
			_showTimer.addEventListener(TimerEvent.TIMER, showTimerHandler);
			
			_loaded = true;
		}
		
		
		/**
		 * Override onShow
		 * 
		 */
		override public function onShow():void {
			
			this.alpha = 1;
			
			_tipLabel.text = HIDE_DELAY + "秒后系统自动返回";
			
			_showTimer.reset();
			_showTimer.start();
			
			// 显示
			TweenLite.from(this, WindowManager.WINDOW_MOVE_DURATION, {y: this.y + 50});
		}
		
		
		
		/**
		 * Show Message
		 * @param text
		 * @param title
		 * @param buttonFlags
		 * @param maxChars 可输入字符数
		 * 
		 */
		public function setMessage(text:String = "", text2:String = "", buttonFlags:uint = 0x4, maxChars:int = 20):void
		{	
			_promptlabel.text = text;
		}
		
		
		
		/**
		 * 关闭窗口效果 
		 */
		private function showTimerHandler(e:TimerEvent):void 
		{	
			if(_showTimer.currentCount < HIDE_DELAY)
			{	
				_tipLabel.text = (HIDE_DELAY - _showTimer.currentCount) + "秒后系统自动返回";
			}
			else 
			{
				TweenLite.to(this, WindowManager.WINDOW_MOVE_DURATION, 
					{
						alpha:0, 
						y: y - 50,
						onComplete:function():void {close();}
					}
				);
				
				_showTimer.stop();
			}
		}

		
	}
}