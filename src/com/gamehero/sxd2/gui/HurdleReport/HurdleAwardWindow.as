package com.gamehero.sxd2.gui.HurdleReport
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemGrid;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_AWARD_ACK;
	import com.gamehero.sxd2.pro.PRO_Map;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-9 上午11:28:10
	 * 
	 */
	public class HurdleAwardWindow extends GameWindow
	{
		public function HurdleAwardWindow(position:int, resourceURL:String="HurdleAwardWindow.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 633, 287);
		}
		/**
		 * 设置全屏幕可点区域 
		 */		
		private var _bgMask:Sprite;
		
		private var _bg:Bitmap;
		
		private var arrow:Bitmap;
		
		private var _timeId:int;
		
		private var _itemGrid:ItemGrid;
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			_bg = new Bitmap(getSwfBD("BG"));
			addChild(_bg);
			var label:Label = new Label();
			label.text = "获得奖励：";
			label.color = GameDictionary.YELLOW;
			label.bold = true;
			addChild(label);
			label.x = 295;
			label.y = 116;
			
			arrow = new Bitmap(getSwfBD("BTN"));
			addChild(arrow);
			arrow.x = 513;
			arrow.y = 219;
			
			label = new Label();
			label.x = 537;
			label.y = 216;
			addChild(label);
			label.text = "点击退出";
			label.color = GameDictionary.YELLOW;
		}
		override public function onShow():void
		{
			super.onShow();
			_bgMask = new Sprite();
			_bgMask.graphics.beginFill(0,0);
			_bgMask.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			_bgMask.graphics.endFill();
			addChild(_bgMask);
			_bgMask.x = -(stage.stageWidth - this.width >> 1);
			_bgMask.y = -(stage.stageHeight - this.height >> 1);

			_bgMask.addEventListener(MouseEvent.CLICK,onExit);
			var award:MSG_INSTANCE_AWARD_ACK = MSG_INSTANCE_AWARD_ACK(windowParam);
			var arr:Array = award.item;
			_itemGrid = new ItemGrid();
			addChild(_itemGrid);
			_itemGrid.x = 288;
			_itemGrid.y = 147;
			_itemGrid.gapX = 11;
			_itemGrid.col = 5;
			_itemGrid.data = arr;
			_timeId = setTimeout(close,5000);
		}
		
		protected function onExit(event:MouseEvent):void
		{
			var mapInfo:PRO_Map = new PRO_Map();
			mapInfo.id = 0;
			SXD2Main.inst.enterMap(mapInfo);
			if(_timeId > 0)
			{
				clearTimeout(_timeId);
				_timeId = 0;
			}
		}
		override public function close():void
		{
			super.close();
			if(_timeId > 0)
			{
				clearTimeout(_timeId);
				onExit(null);
			}
			_bgMask.removeEventListener(MouseEvent.CLICK,onExit);
			_bgMask.graphics.clear();
			removeChild(_bgMask);
			_bgMask = null;
			
			_itemGrid.clear();
			_itemGrid = null;
		}
	}
}