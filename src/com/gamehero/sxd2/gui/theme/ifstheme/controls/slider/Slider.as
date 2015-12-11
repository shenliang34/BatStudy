package com.gamehero.sxd2.gui.theme.ifstheme.controls.slider
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	import org.bytearray.display.ScaleBitmap;
	
	public class Slider extends ActiveObject
	{
		//===============数据==================
		/** 当前数值 **/
		private var m_currentNum:Number;
		/** 最大值 **/
		private var m_maxNum:Number;
		/** 最小值 **/
		private var m_minNum:Number;
		/** 步长 **/
		private var m_stepNum:Number;
		/** 宽度 **/
		private var m_width:Number;
		//===============界面==================
		/** 滑块 **/
		private var runner:Button;
		private var sp:Sprite;
		/** 总滑轨 **/
		private var totalTrack:ScaleBitmap;
		/** 进度滑轨 **/
		private var currentTrack:ScaleBitmap;
		
		/** 舞台 **/
		private var stage:Stage;
		
		/**
		 * 滑块组件
		 * @param currentNum 当前数值
		 * @param minNum 最小值
		 * @param maxNum 最大值
		 * @param stepNum 步长
		 * @param width 宽度
		 */
		public function Slider(currentNum:Number=0, minNum:Number=0, maxNum:Number=10, stepNum:Number=1, width=100)
		{
			stage = App.stage;
			
			m_minNum = minNum;
			m_maxNum = maxNum;
			m_stepNum = stepNum;
			m_currentNum = currentNum;
			m_width = width;
			
			totalTrack = new ScaleBitmap(MainSkin.PROGRESS_BAR_BG);
			totalTrack.scale9Grid = MainSkin.barBGScale9Grid;
			this.addChild(totalTrack);
			
			currentTrack = new ScaleBitmap(MainSkin.BAR_BLUE);
			currentTrack.scale9Grid = MainSkin.barScale9Grid;
			currentTrack.x = -2;
			currentTrack.y = -2;
			this.addChild(currentTrack);
			
			sp = new Sprite();
			this.addChild(sp);
			runner = new Button(MainSkin.RUNNER_BTN_DOWN, MainSkin.RUNNER_BTN_DOWN, MainSkin.RUNNER_BTN_OVER);
			runner.y = -7;
			sp.addEventListener(MouseEvent.MOUSE_DOWN, onRunnerMouseDown);
			sp.addChild(runner);
			
			update();
		}
		
		/**
		 * 宽度
		 */
		override public function get width():Number
		{
			return m_width;
		}
		override public function set width(value:Number):void
		{
			if(m_width == value){
				return;
			}
			m_width = value;
			updateLater();
		}
		
		/**
		 * 当前数值
		 */
		public function get currentNum():Number
		{
			return m_currentNum;
		}
		public function set currentNum(value:Number):void
		{
			if(m_currentNum == value){
				return;
			}
			m_currentNum = value;
			updateLater();
		}
		
		/**
		 * 最大值
		 */
		public function get maxNum():Number
		{
			return m_maxNum;
		}
		public function set maxNum(value:Number):void
		{
			if(m_maxNum == value){
				return;
			}
			m_maxNum = value;
			updateLater();
		}
		
		/**
		 * 最小值
		 */
		public function get minNum():Number
		{
			return m_minNum;
		}
		public function set minNum(value:Number):void
		{
			if(m_minNum == value){
				return;
			}
			m_minNum = value;
			updateLater();
		}
		
		/**
		 * 步长
		 */
		public function get stepNum():Number
		{
			return m_stepNum;
		}
		public function set stepNum(value:Number):void
		{
			if(m_stepNum == value){
				return;
			}
			m_stepNum = value;
			updateLater();
		}
		
		/**
		 * 延迟更新
		 */
		private function updateLater():void
		{
			this.addEventListener(Event.ENTER_FRAME, update);
			this.dispatchEvent(new SliderEvent(SliderEvent.SLIDER_CHANGE));
		}
		
		/**
		 * 更新界面
		 */
		private function update(evt:Event=null):void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			
			totalTrack.setSize(int(width), 10);
			currentTrack.setSize(int(width*(currentNum-minNum)/(maxNum-minNum)), 12);
			runner.x = width*(currentNum-minNum)/(maxNum-minNum)-runner.width/2;
		}
		
		/**
		 * 鼠标按下
		 */
		private function onRunnerMouseDown(evt:MouseEvent):void
		{
			sp.removeEventListener(MouseEvent.MOUSE_DOWN, onRunnerMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		/**
		 * 鼠标移动
		 */
		private function onStageMouseMove(evt:MouseEvent):void
		{
			if(this.mouseX>=width){
				currentNum = maxNum;
			}else{
				var currentWidth:Number = Math.max(this.mouseX, 0);
				var stepWith:Number = width/((maxNum-minNum)/stepNum);
				var steps:int = Math.round(currentWidth/stepWith);
				currentNum = steps*stepNum+minNum;
			}
		}
		
		/**
		 * 鼠标弹起
		 */
		private function onStageMouseUp(evt:MouseEvent):void
		{
			sp.addEventListener(MouseEvent.MOUSE_DOWN, onRunnerMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		/**
		 * 清除
		 */
		private function clear():void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			sp.removeEventListener(MouseEvent.MOUSE_DOWN, onRunnerMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
	}
}