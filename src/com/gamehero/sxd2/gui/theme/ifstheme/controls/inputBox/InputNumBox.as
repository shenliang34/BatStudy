package com.gamehero.sxd2.gui.theme.ifstheme.controls.inputBox
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * 通用组件逻辑：<br/>
	 * 1、数量显示范围0-999；输入范围0-999，空值<br/>
	 * 2、失焦后，若输入栏为空值，则显示默认值<br/>
	 * 3、默认值：根据不同功能，可配置所显示数量的初始默认值，默认值可为定值或者逻辑计算后的数值；若默认值大于玩家可使用最大值，则显示玩家可使用最大值。<br/>
	 * 4、输入过程中，数值超过玩家最大可使用值时，直接显示玩家可使用最大值<br/>
	 * 5、输入过程中，可以进行退格操作；全选数字后删除或输入数字 <br/>
	 * @author Administrator
	 * 
	 */	
	public class InputNumBox extends Sprite
	{
		/** 最大数量 **/
		private var m_maxNum:int = 999;
		/** 最小数量 **/
		private var m_minNum:int = 0;
		
		// +-按钮
		private var plusBtn:Button;
		private var minusBtn:Button;
		/**
		 * 最大数量按钮 
		 */		
		private var minBtn:Button;
		/**
		 * 最小数量按钮 
		 */		
		private var maxBtn:Button;
		
		/** 数量文本 **/
		private var numField:TextField;
		
		// 是否在改变文本数值时发送事件
		private var _needEvent:Boolean = false;
		
		
		private var _defaultNum:int;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function InputNumBox()
		{
			minBtn = new Button(CommonSkin.MinStepper_Up,CommonSkin.MinStepper_Down,CommonSkin.MinStepper_Over);
			addChild(minBtn);
			// +-按钮
			minusBtn = new Button(CommonSkin.LeftStepper_Up,CommonSkin.LeftStepper_Down,CommonSkin.LeftStepper_Over);//资源宽高是 18 * 18
			this.addChild(minusBtn);
			minusBtn.x = minBtn.width + minBtn.x;
			
			var bmp:Bitmap = new Bitmap(CommonSkin.NUMBER_INPUT_BG);//资源宽高是26*15
			addChild(bmp);
			bmp.x = minusBtn.x + minusBtn.width;
			bmp.y = minusBtn.height - bmp.height >> 1;
			
			// 物品使用个数输入文本
			numField = new TextField();
			numField.maxChars = 3;
			numField.restrict = "0-9";
			numField.width = bmp.width;
			numField.type = TextFieldType.INPUT;
			
			var tf:TextFormat = new TextFormat();
			tf.size = 12;
			tf.font = GameDictionary.FONT_NAME;
			tf.color = GameDictionary.WHITE;
			tf.align = TextFormatAlign.CENTER;
			numField.defaultTextFormat = tf;
			
			this.addChild(numField);
			numField.x = bmp.x;
			numField.y = bmp.y ;
			
			plusBtn = new Button(CommonSkin.RightStepper_Up,CommonSkin.RightStepper_Down,CommonSkin.RightStepper_Over);
			plusBtn.x = bmp.width + bmp.x;
			this.addChild(plusBtn);
			
			maxBtn = new Button(CommonSkin.MaxStepper_Up,CommonSkin.MaxStepper_Down,CommonSkin.MaxStepper_Over);
			addChild(maxBtn);
			maxBtn.x = plusBtn.x + plusBtn.width;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddtoStage);
		}
		
		
		
		
		public function get needEvent():Boolean
		{
			return _needEvent;
		}
		
		public function set needEvent(value:Boolean):void
		{
			_needEvent = value;
			if(value)
			{
				numField.type = TextFieldType.INPUT;
				plusBtn.addEventListener(MouseEvent.CLICK, plus);
				minusBtn.addEventListener(MouseEvent.CLICK, minus);
				numField.addEventListener(Event.CHANGE, changeNum);
				numField.addEventListener(FocusEvent.FOCUS_OUT,onOutFocus);
				
				minBtn.addEventListener(MouseEvent.CLICK,onMin);
				maxBtn.addEventListener(MouseEvent.CLICK,onMax);
			}
			else
			{
				numField.type = TextFieldType.DYNAMIC;
				plusBtn.removeEventListener(MouseEvent.CLICK, plus);
				minusBtn.removeEventListener(MouseEvent.CLICK, minus);
				numField.removeEventListener(Event.CHANGE, changeNum);
				numField.removeEventListener(FocusEvent.FOCUS_OUT,onOutFocus);
				
				minBtn.removeEventListener(MouseEvent.CLICK,onMin);
				maxBtn.removeEventListener(MouseEvent.CLICK,onMax);
			}
		}
		
		protected function onMax(event:MouseEvent):void
		{
			num = maxNum;
		}
		
		protected function onMin(event:MouseEvent):void
		{
			num = minNum;
		}
		
		public function get defaultNum():int
		{
			return _defaultNum;
		}
		/**
		 * 默认值 
		 * @param value
		 * 
		 */
		public function set defaultNum(value:int):void
		{
			_defaultNum = value;
		}
		
		private function onAddtoStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddtoStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			
			needEvent = true;
		}
		
		protected function onOutFocus(event:FocusEvent):void
		{
			if(numField.text == "" || numField.text == " "||numField.text == "  " || numField.text == "   ")
			{
				numField.text = defaultNum.toString();
				changeNum(null);
			}
		}		
		
		
		
		private function onRemoveFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			needEvent = false;
		}
		
		/**
		 * 最大值
		 */
		public function get maxNum():int
		{
			return m_maxNum;
		}
		public function set maxNum(value:int):void
		{
			m_maxNum = value;
			if(num > m_maxNum){
				num = m_maxNum;
			}
		}
		
		/**
		 * 最小值
		 */
		public function get minNum():int
		{
			return m_minNum;
		}
		public function set minNum(value:int):void
		{
			m_minNum = value;
			if(num < m_minNum){
				num = m_minNum;
			}
		}
		
		/**
		 * 获取数量
		 * */
		public function get num():int
		{
			return int(numField.text);
		}
		public function set num(value:int):void
		{
			numField.text = value + "";
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * 增加数量
		 * */
		private function plus(e:MouseEvent):void
		{
			var _num:int = num;
			if(_num < m_maxNum){
				_num++;
				num = _num;
			}
		}
		
		/**
		 * 减少数量
		 * */
		private function minus(e:MouseEvent):void
		{
			var _num:int = num;
			if(_num > m_minNum){
				_num--;
				num = _num;
			}
		}
		
		/**
		 * 更改物品数量
		 * */
		private function changeNum(e:Event):void
		{
			if(numField.text == "" || numField.text == " "||numField.text == "  " || numField.text == "   ")
			{
			}
			else
			{
				var _num:int = num;
				if(_num > m_maxNum){
					_num = m_maxNum;
				}else if(_num < m_minNum){
					_num = m_minNum;
				}
				num = _num;
			}
		}
	}
}