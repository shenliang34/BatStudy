package com.gamehero.sxd2.gui.theme.ifstheme.controls.progressBar
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.events.Event;
	
	import alternativa.gui.base.ActiveObject;
	
	import org.bytearray.display.ScaleBitmap;
	
	public class ColorProgressBar extends ActiveObject
	{
		static public const BULE:String = "BAR_BLUE";
		static public const GREEN:String = "BAR_GREEN";
		static public const PURPLE:String = "BAR_PURPLE";
		static public const YELLOW:String = "BAR_YELLOW";
		
		//===============数据==================
		/** 宽度 **/
		private var m_width:Number;
		/** 当前进度 **/
		private var m_progress:Number;
		/** 颜色 **/
		private var m_colorType:String;
		
		//===============界面==================
		/** 底图 **/
		private var bg:ScaleBitmap;
		/** 进度条 **/
		private var bar:ScaleBitmap;
		
		/**
		 * 进度条
		 * @param width 宽度
		 * @param progress 进度值
		 * @param colorType 颜色类型
		 */
		public function ColorProgressBar(width:int=200, progress:Number=0, colorType:String=BULE)
		{
			super();
			m_width = width;
			m_progress = progress;
			m_colorType = colorType;
			
			init();
			update();
		}
		private function init():void
		{
			bg = new ScaleBitmap(MainSkin.PROGRESS_BAR_BG);
			bg.scale9Grid = MainSkin.barBGScale9Grid;
			addChild(bg);
			
			bar = new ScaleBitmap(MainSkin.BAR_BLUE);
			bar.scale9Grid = MainSkin.barScale9Grid2;
			bar.x = -1;
			bar.y = -1;
			addChild(bar);
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
		 * 当前进度（0~1之间的数值）
		 */
		public function get progress():Number
		{
			return m_progress;
		}
		public function set progress(value:Number):void
		{
			if(m_progress == value){
				return;
			}
			m_progress = value;
			updateLater();
		}
		
		/**
		 * 进度条颜色
		 */
		public function get colorType():String
		{
			return m_colorType;
		}
		public function set colorType(value:String):void
		{
			if(m_colorType == value){
				return;
			}
			m_colorType = value;
			updateLater();
		}
		
		/**
		 * 延迟更新
		 */
		private function updateLater():void
		{
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * 更新界面
		 */
		private function update(evt:Event=null):void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			
			bg.setSize(int(width), 10);
			
			bar.bitmapData = MainSkin[colorType];
			bar.setSize(int(width*progress), 12);
		}
		
	}
}