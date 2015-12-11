package com.gamehero.sxd2.gui.buyback
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.buyback.component.BuybackItem;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.core.event.UpdataEvent;
	import com.gamehero.sxd2.gui.core.group.DataGroup;
	import com.gamehero.sxd2.pro.MSG_UPDATE_STORE_BUY_BACK_ACK;
	
	import flash.display.Bitmap;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.controls.text.Label;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-23 11:20:51
	 * 
	 */
	public class BuybackWindow extends GeneralWindow
	{
		private var _itemGroup:DataGroup;
		private const MAX_ITEM:int = 8;
		
		public static var uiDomain:ApplicationDomain;
		
		public function BuybackWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, "BuyBackWindow.swf", 430, 535);
		}
		override protected function initWindow():void
		{
			super.initWindow();
			uiDomain = this.uiResDomain;
			
			var innerBg:InnerBg = new InnerBg();
			add(innerBg,8,39,414,479);
			var bmp:Bitmap = new Bitmap(getSwfBD("Bg"));
			add(bmp,15,46);
			bmp = new Bitmap(getSwfBD("Exclamation"));
			add(bmp,292,494);
			
			var label:Label = new Label();
			label.x = 306;
			label.y = 494;
			addChild(label);
			label.color = GameDictionary.WINDOW_BLUE;
			label.text = "双击物品可直接回购";
			
			_itemGroup = new DataGroup();
			addChild(_itemGroup);
			_itemGroup.x = 16;
			_itemGroup.y = 205;
			_itemGroup.col = 2;
			_itemGroup.gapX = 2;
			_itemGroup.gapY = 4;
			_itemGroup.itemRenderer = BuybackItem;
			_itemGroup.setOverClickMask(getSwfBD("ItemOver"),getSwfBD("ItemOver"));
			_itemGroup.mouseOverAble = true;
			_itemGroup.mouseClickAble = true;
		}
		override public function onShow():void
		{
			super.onShow();
			dispatchEvent(new UpdataEvent(UpdataEvent.WINDOW_ON_SHOW));
			
		}
		public function updata(msg:MSG_UPDATE_STORE_BUY_BACK_ACK):void
		{
			_itemGroup.clear();
			var needEmpty:int;//需要补充的空格数量
			if(msg)
			{
				needEmpty = MAX_ITEM - msg.id.length;
			}
			else
			{
				needEmpty = MAX_ITEM;
			}
			var needArr:Array = new Array(needEmpty);
			var dataProvider:Array;
			if(msg)
			{
				dataProvider = msg.id.concat(needArr);
			}
			else
			{
				dataProvider = needArr;
			}
			_itemGroup.dataProvider = dataProvider;
		}
		override public function close():void
		{
			super.close();
			_itemGroup.clear();
		}
	}
}