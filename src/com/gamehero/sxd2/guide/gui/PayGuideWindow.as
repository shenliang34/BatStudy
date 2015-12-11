package com.gamehero.sxd2.guide.gui
{
	import com.gamehero.sxd2.core.URI;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	
	/**
	 * 充值引导窗口
	 * @author xuwenyi
	 * @create 2014-05-13
	 **/
	public class PayGuideWindow extends GameWindow
	{
		private const WINDOW_WIDTH:int = 265;
		private const WINDOW_HEIGHT:int = 202;
		
		// 描述文字
		private var desLabel:Label;
		// 按钮
		private var yesBtn:GTextButton;
		private var noBtn:GTextButton;
		
		// x按钮
		private var xBtn:Button;
		
		
		/**
		 * 构造函数
		 * */
		public function PayGuideWindow(position:int, resourceURL:String = "PayGuideWindow.swf")
		{
			super(position, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		
		
		
		/**
		 * 复写
		 * */
		override protected function initWindow():void
		{
			super.initWindow();
			
			// 初始化固定UI
			// 背景
			var bmp:Bitmap = new Bitmap(this.getSwfBD("BG"));
			this.addChild(bmp);
			
			// 钻石icon
			bmp = new Bitmap(this.getSwfBD("DIAMOND_ICON"));
			bmp.x = 36;
			bmp.y = 62;
			this.addChild(bmp);
			
			// 按钮
			noBtn = new GTextButton(MainSkin.blueButton2Up, MainSkin.blueButton2Down, MainSkin.blueButton2Over, MainSkin.button2Disable);
			noBtn.label = Lang.instance.trans("AS_139");
			noBtn.x = 145;
			noBtn.y = 150;
			this.addChild(noBtn);
			
			yesBtn = new GTextButton(MainSkin.redButton2Up, MainSkin.redButton2Down, MainSkin.redButton2Over, MainSkin.button2Disable);
			yesBtn.label = Lang.instance.trans("AS_1282");
			yesBtn.x = 40;
			yesBtn.y = 150;
			this.addChild(yesBtn);
			
			xBtn = new Button(MainSkin.closeButton2Up,MainSkin.closeButton2Down,MainSkin.closeButton2Over,MainSkin.closeButton2Disable);
			xBtn.x = 229;
			xBtn.y = 54;
			this.addChild(xBtn);
			
			// 描述文字
			desLabel = new Label(false);
			desLabel.width = 120;
			desLabel.height = 50;
			desLabel.x = 120;
			desLabel.y = 80;
			desLabel.leading = 0.3;
			desLabel.text = Lang.instance.trans("chongzhi");
			this.addChild(desLabel);
		}
		
		
		
		/**
		 * 每次打开都会执行
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			yesBtn.addEventListener(MouseEvent.CLICK , onClick);
			noBtn.addEventListener(MouseEvent.CLICK , onClick);
			xBtn.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		
		
		
		
		/**
		 * 点击确定
		 * */
		private function onClick(e:MouseEvent):void
		{
			var btn:GTextButton = e.currentTarget as GTextButton;
			if(btn == yesBtn)
			{
				// 跳转充值页面
				URI.toPay();
			}
			else
			{
				this.close();
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void	
		{
			yesBtn.removeEventListener(MouseEvent.CLICK , onClick);
			noBtn.removeEventListener(MouseEvent.CLICK , onClick);
			xBtn.removeEventListener(MouseEvent.CLICK , onClick);
		}
		
		
		
		
		
		/**
		 * 关闭窗口
		 * */
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
	}
}