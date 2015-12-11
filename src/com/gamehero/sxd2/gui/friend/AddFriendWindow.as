package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextInput;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 上午11:24:46
	 * 
	 */
	public class AddFriendWindow extends GeneralWindow
	{
		
		// 红蓝按钮对象池
		private var redBtnPool:Vector.<Button> = new Vector.<Button>();
		private var blueBtnPool:Vector.<Button> = new Vector.<Button>();
		
		/**
		 * 关注按钮
		 * */
		private var _followsBtn:GTextButton;
		//输入框
		private var _inputTi:TextInput;
		/**
		 *玩家姓名 
		 */		
		private var playerName:Bitmap
		
		public function AddFriendWindow(position:int, resourceURL:String="AddFriendWindow.swf", width:Number=311, height:Number=175)
		{
			super(position, resourceURL, width, height);
		}
		
		override protected function initWindow():void
		{
			// TODO Auto Generated method stub
			super.initWindow();
			
			this.init();
		}
		
		private function init():void
		{
			// 背景、装饰
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 290, 123);
			
			// 背景、装饰
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 290, 80);
			
			_followsBtn = new GTextButton(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			_followsBtn.label = "添加关注";
			_followsBtn.x = 120;
			_followsBtn.y = 125;
			this.addChild(_followsBtn);
			
			var nameInputBitmap:Bitmap = new Bitmap();
			nameInputBitmap.bitmapData = this.getSwfBD("BitmapInputBg");
			add(nameInputBitmap,109,62);
			
			var nameBitmap:Bitmap = new Bitmap();
			nameBitmap.bitmapData = this.getSwfBD("BitmapInputName");
			add(nameBitmap,32,69);
			
			
			playerName = new Bitmap();
			playerName.bitmapData = this.getSwfBD("BitmapPlayerName");
			add(playerName,118,69);
			
			_inputTi = new TextInput();
			_inputTi.size = 15;
			_inputTi.maxChars = 20;
			add(_inputTi,110,72,180,24);
			
			
		}
		
		protected function onTextInput(event:Event):void
		{
			// TODO Auto-generated method stub
			playerName.visible = _inputTi.text.length<=0;
		}
		
		override public function close():void
		{
			// TODO Auto Generated method stub
			super.close();
			_inputTi.removeEventListener(Event.CHANGE,onTextInput);
			_followsBtn.removeEventListener(MouseEvent.CLICK,onClickFollowsBtn);
		}
		
		override public function onShow():void
		{
			// TODO Auto Generated method stub
			super.onShow();
			_inputTi.addEventListener(Event.CHANGE,onTextInput);
			_inputTi.text = "";
			playerName.visible = true;
			
			_followsBtn.addEventListener(MouseEvent.CLICK,onClickFollowsBtn);
		}
		
		protected function onClickFollowsBtn(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			WindowManager.inst.closeGeneralWindow(AddFriendWindow);
			MainUI.inst.openWindow(WindowEvent.AUDIENCE_TIPBOX_WINDOW);
		}		
		
	}
}