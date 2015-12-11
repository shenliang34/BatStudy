package com.gamehero.sxd2.gui {
	
    import com.gamehero.sxd2.core.Global;
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.event.CloseEvent;
    import com.gamehero.sxd2.gui.core.GeneralWindow;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.CheckBox;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextInput;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.DialogSkin;
    import com.gamehero.sxd2.local.Lang;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;
    
    import alternativa.gui.enum.Align;
    
    import bowser.utils.GameTools;
    import bowser.utils.time.TimeTick;
    import bowser.utils.time.TimeTickData;
    
    import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * Global Alert Window 
	 * @author Trey
	 * @create-date 2013-12-5
	 */
	public class GlobalAlert extends GeneralWindow implements IAlert {
		
		private static const WINDOW_WIDTH:int = 250;
		private static const WINDOW_HEIGHT:int = 130;
		
		// 红色按钮还是蓝色按钮
		public static const RED:String = "RED";
		public static const BLUE:String = "BLUE";
		
		
		// Button Mode
		public static const YES:uint = 0x0001;
		public static const NO:uint = 0x0002;
		public static const OK:uint = 0x0004;
		public static const CANCEL:uint= 0x0008;
		public static const INPUT:uint= 0x0010;
		public static const CHECK:uint = 0x0020;
		public static const TIME:uint = 0x0040;
		public static const NONMODAL:uint = 0x8000;
		
		// Button Label
		// 默认名称
		private static var _okLabel:String;
		private static var _cancelLabel:String;
		private static var _yesLabel:String;
		private static var _noLabel:String;
		
		public static var okLabel:String;
		public static var cancelLabel:String;
		public static var yesLabel:String;
		public static var noLabel:String;
		public static var checkLabel:String = "不再提示";
		public static var checkSelected:Boolean = false;

		
		private var _listeners:Dictionary;
		
		private var buttonContainer:Sprite;
		
		// 红蓝按钮对象池
		private var redBtnPool:Vector.<Button> = new Vector.<Button>();
		private var blueBtnPool:Vector.<Button> = new Vector.<Button>();

		/*private var _titleGt:GText;*/
		/** 用在显示框的提示上 **/
		private var _messageLb:Label;
		/** 用在输入框的提示上 **/
		private var _messageLb2:Label;
		private var _inputTi:TextInput;
		private var _iconBP:Bitmap;
		private var _check:CheckBox;
		/** 用在倒计时框的提示上 **/
		private var _timeLb:Label;
		private var _timeTick:TimeTick;
		private var _timeTickData:TimeTickData;
		
		
		//背景素材
		private var _innerBg:ScaleBitmap;
		private var m_isShow:Boolean;
		
		
		
		
		/**
		 * Constructor 
		 * @param windonPosition
		 * @param resourceURL
		 * 
		 */
		public function GlobalAlert(windonPosition:int, resourceURL:String = null) {
			
//			this.mouseEnabled = false;
//			this.tabEnabled = false;
			
			super(windonPosition, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
			
			canOpenTween = false;
			
			_okLabel = "确定";
			_cancelLabel = "取消";
			_yesLabel = "是";
			_noLabel = "否";
			
			okLabel = _okLabel;
			cancelLabel = _cancelLabel;
			yesLabel = _yesLabel;
			noLabel = _noLabel;
			
			initWindow();
		}
		
		/**
		 * 是否在显示中
		 */
		public function get isShow():Boolean
		{
			return m_isShow;
		}
		
		/**
		 * Init Window 
		 * 
		 */
		override protected function initWindow():void
		{	
			super.initWindow();
			
			_resizeNum = int.MAX_VALUE;
			
			_innerBg = new ScaleBitmap(DialogSkin.DIALOG_BG);
			_innerBg.scale9Grid = DialogSkin.DIALOG_BG_9GRID;
			this.addChild(_innerBg);
			
			_messageLb = new Label(false);
			_messageLb.align = Align.CENTER;
			_messageLb.leading = 0.5;
			this.addChild(_messageLb);
			
			_messageLb2 = new Label();
			_messageLb2.leading = 0.5;
			_messageLb2.x = 41;
			_messageLb2.y = 90;
			_messageLb2.width = 220;
			this.addChild(_messageLb2);
			
			_inputTi = new TextInput();
			_inputTi.x = 61;
			_inputTi.y = 72;
			_inputTi.width = 180;
			_inputTi.height = 24;
			this.addChild(_inputTi);
			
			
			_iconBP = new Bitmap();
			_iconBP.x = 270;
			_iconBP.y = 112;
			this.addChild(_iconBP);
			
			buttonContainer = new Sprite();
			this.addChild(buttonContainer);
			
			_loaded = true;
		}
		
		
		
		
		
		override public function onShow():void
		{
			super.onShow();
			m_isShow = true;
		}
		
		
		
		
		
		
		
		/**
		 * Show Message
		 * @param text
		 * @param title
		 * @param buttonFlags
		 * @param maxChars 可输入字符数
		 * @param duration 倒计时时间
		 */
		public function setMessage(text:String = "", buttonFlags:uint = 0x4, btnStyle:String = BLUE , icon:BitmapData = null , duration:int = 30, leading:Number = .5):void {
			
			//自动移除所有监听函数
			removeAllEventLiteners();
			setAllVisiable(false);
			
			/** 模式选择 */
			// 输入模式
			if (buttonFlags & INPUT) {
				
				_inputTi.text = "";
				_inputTi.maxChars = 20;

				if(!GameTools.isNull(text)) {
					_messageLb2.y = 112;
					_messageLb2.visible = true;
					_messageLb2.text = text;
				}
				_inputTi.visible = true;

			}
			// 显示模式
			else 
			{	
				_messageLb.visible = true;
				
				_messageLb.text = text.replace(/\\n/gi , "\n");
				_messageLb.leading = leading;
				
				_messageLb.y = 60 + ((68 - _messageLb.height) >> 1);
			}
			
			// 居中文字
			_messageLb2.x = (this.width - _messageLb2.width) >> 1;
			
			// Icon Class
			if(icon) {
				
				_iconBP.visible = true;
				
				_iconBP.bitmapData = icon;
				_iconBP.y = _messageLb2.y - 4;
				
				_messageLb2.x = (this.width - _messageLb2.width - _iconBP.width) >> 1
				_iconBP.x = _messageLb2.x + _messageLb2.width + 10;　
			}
			
			//显示 check组件
			if(buttonFlags & CHECK)
			{	
				if(_check == null) 
				{	
					_check  = new CheckBox();
				}
				_check.visible = true;
				_check.label = checkLabel;
				_check.setLabelColor(GameDictionary.GRAY);
				_check.checked = checkSelected;
				addChild(_check);
			}
			
			// 倒计时模式
			if(buttonFlags & TIME)
			{
				if(!_timeLb){
					_timeLb = new Label();
					_timeLb.leading = 0.5;
					_timeLb.align = Align.CENTER;
					_timeLb.width = 220;
					addChild(_timeLb);
				}
				_timeLb.visible = true;
				
				if(_timeTick){
					_timeTick.clear();
					_timeTick.removeListener(_timeTickData);
				}
				
				// 启动倒计时
				_timeTickData = new TimeTickData(duration , 1000 , timeUpdate , timeComplete);
				_timeTick = new TimeTick();
				_timeTick.addListener(_timeTickData);
				
				var str:String = GameDictionary.createCommonText(Lang.instance.trans("AS_105"));
				str += GameDictionary.createCommonText("" + duration , GameDictionary.ORANGE);
				str += GameDictionary.createCommonText(Lang.instance.trans("AS_106"));
				_timeLb.text = str;
			}
			
			/** 排列按钮 */
			if(buttonContainer.numChildren > 0)
			{	
				Global.instance.removeChildren(buttonContainer);
			}
			
			var button:Button;
			if(buttonFlags & OK) 
			{
				button = this.getButton(btnStyle);
				button.name += OK.toString();
				button.label = okLabel;
				buttonContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onCloseButtonClick, false, 0, true);
			}
			if (buttonFlags & CANCEL)
			{
				button = this.getButton(btnStyle);
				button.name += CANCEL.toString();
				button.label = cancelLabel;
				buttonContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onCloseButtonClick, false, 0, true);
			}
 			if (buttonFlags & YES)
			{
				button = this.getButton(btnStyle);
				button.name += YES.toString();
				button.label = yesLabel;
				buttonContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onCloseButtonClick, false, 0, true);
			}
			if (buttonFlags & NO)
			{
				button = this.getButton(btnStyle);
				button.name += NO.toString();
				button.label = noLabel;
				buttonContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onCloseButtonClick, false, 0, true);
			}
			
			if(button == null) return;
			
			asynResize();
			
		}
		
		/**
		 * 设置所有相关的显示文字等是否可见（默认是false）
		 */
		private function setAllVisiable(boo:Boolean=false):void
		{
			_messageLb.visible = boo;
			_inputTi.visible = boo;
			_messageLb2.visible = boo;
			
			if(_check){
				_check.visible = boo;
			}
			
			if(_iconBP){
				_iconBP.visible = boo;
			}
			
			if(_timeLb){
				_timeLb.visible = boo;
			}
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			
			if(!_listeners) {
				
				_listeners = new Dictionary(true);
			}
			
			
			//存储全部事件侦听
			_listeners[type] = listener;
		}
		
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			
			super.removeEventListener(type, listener, useCapture);
			
			delete _listeners[type];
		}
		


		/**
		 * Button Click Handler 
		 */
		override protected function onCloseButtonClick(evt:MouseEvent):void
		{	
			// 回收按钮
			var targetBtn:Button = evt.target as Button;
			targetBtn.removeEventListener(MouseEvent.CLICK, onCloseButtonClick);
			
			var btnName:String = targetBtn.name;
			var pool:Vector.<Button>;
			if(btnName.indexOf(BLUE) >= 0)
			{
				pool = blueBtnPool;
				btnName = btnName.replace(BLUE , "");// 将name还原
			}
			else
			{
				pool = redBtnPool;
				btnName = btnName.replace(RED , "");// 将name还原
			}
			targetBtn.name = "";
			pool.push(targetBtn);
			
			
			// checkbox
			if(_check)
			{
				checkSelected = _check.checked;
				removeChild(_check);
				_check = null;
			}
			
			
			// TRICKY: 必须在事件发送前关闭，否则会导致无法再次打开GlobalAlert的问题
			// Close
			this.close();

			
			// Dispatch Event
			var closeEvent:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
			closeEvent.detail = uint(btnName);
			if(_inputTi.visible) {
				
				closeEvent.input = _inputTi.text;
			}
			this.dispatchEvent(closeEvent);
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		//	PRIVATE
		///////////////////////////////////////////////////////////////////////////////
		/**
		 * 创建一个btn
		 */
		private function getButton(btnStyle:String = BLUE):Button 
		{	
			var pool:Vector.<Button> = btnStyle == BLUE ? blueBtnPool : redBtnPool;
			if(pool.length > 0) 
			{	
				return pool.pop();
			}
			else 
			{	
				var btn:Button;
				if(btnStyle == BLUE)
				{
					btn = new Button(CommonSkin.tBlueBtn1Up, CommonSkin.tBlueBtn1Down, CommonSkin.tBlueBtn1Over);
					btn.name = "BLUE";
				}
				else
				{
					btn = new Button(CommonSkin.tRedBtn1Up, CommonSkin.tRedBtn1Down, CommonSkin.tRedBtn1Over);
					btn.name = "RED";
				}
				
				return btn;
			}
		}
		
		
		
		/**
		 * 移除全部事件侦听
		 * 
		 */
		private function removeAllEventLiteners():void {
			
			for(var type:String in _listeners) {
				
				removeEventListener(type, _listeners[type]);
			}
		}
		
		
		override protected function onResize():void
		{
			super.onResize();
			if(canResize)
			{
				// 背景
				_innerBg.setSize(width , height);
				
				_messageLb.x = 10;
				_messageLb.width = width - 20;
				_messageLb.y = 30;
				
				var pre:DisplayObject;//用来定位的
				
				if(_check)
				{
					_check.x = width - _check.width >> 1;
					_check.y = _messageLb.y  + _messageLb.height + 17;
					pre = _check;
				}
				
				// 倒计时文本
				if(_timeLb)
				{
					_timeLb.x = width - _timeLb.width >> 1;
					_timeLb.y = _messageLb.y  + _messageLb.height + 17;
					pre = _timeLb;
				}
				
				var numChildren:int = buttonContainer.numChildren;
				var button:DisplayObject;
				if(numChildren>0)
				{
					button = buttonContainer.getChildAt(numChildren-1);
					
					var startX:int = (this.width - button.width * numChildren - (numChildren - 1) * 20) >> 1;
					for(var i:int = 0; i < numChildren; i++) {
						
						button = buttonContainer.getChildAt(i);
						button.x = startX;
						if(pre)
						{
							button.y = pre.y + pre.height + 10;
						}
						else
						{
							button.y = this.height - button.height - 18;
						}
						
						startX += button.width + 20;
					}
				}
			}
		}
		
		
		
		/**
		 * 倒计时更新
		 * */
		private function timeUpdate(data:TimeTickData):void
		{
			if(_timeLb)
			{
				var str:String = GameDictionary.createCommonText(Lang.instance.trans("AS_105"));
				str += GameDictionary.createCommonText("" + int(data.remainTime*0.001) , GameDictionary.ORANGE);
				str += GameDictionary.createCommonText(Lang.instance.trans("AS_106"));
				_timeLb.text = str;
			}
		}
		
		
		
		
		/**
		 * 倒计时结束
		 * */
		private function timeComplete(data:TimeTickData):void
		{
			// 默认选择取消
			this.timeClear();
			
			closeButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		
		
		
		/**
		 * 清除time
		 * */
		private function timeClear():void
		{
			if(_timeLb)
			{
				if(this.contains(_timeLb) == true)
				{
					this.removeChild(_timeLb);
				}
				_timeLb = null;
			}
			
			if(_timeTick)
			{
				_timeTick.removeListener(_timeTickData);
				_timeTick = null;
				_timeTickData = null;
			}
		}
		
		
		
		
		/**
		 * clear
		 * */
		public function clear():void
		{
			m_isShow = false;
			// 恢复Button Label
			okLabel = _okLabel;
			cancelLabel = _cancelLabel;
			yesLabel = _yesLabel;
			noLabel = _noLabel;
			
			_iconBP.visible = false;
			
			// 清除计时器
			this.timeClear();
		}
		
		
		
		
		
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
		
	}
}