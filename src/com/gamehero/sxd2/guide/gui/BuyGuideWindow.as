package com.gamehero.sxd2.guide.gui
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.item.ItemCell;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextInput;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.ProduceGuideManager;
	import com.gamehero.sxd2.vo.ItemProVO;
	import com.gamehero.sxd2.vo.PackItemProVO;
	import com.gamehero.sxd2.vo.ProduceVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	import alternativa.gui.enum.Align;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 快速购买引导
	 * @author xuwenyi
	 * @create 2014-05-12
	 **/
	public class BuyGuideWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 356;
		private const WINDOW_HEIGHT:int = 268;
		
		// 可购买数量最大值
		private const MAX_BUY_NUM:int = 99;
		
		// 确认按钮
		private var confirmBtn:GTextButton;
		// 物品
		private var itemCell:ItemCell;
		private var itemLabel:Label;
		
		// +-按钮
		private var plusBtn:Button;
		private var minusBtn:Button;
		
		// 钻石数量文本
		private var singlePriceLabel:Label;
		private var totalPriceLabel:Label;
		private var itemNumField:TextInput;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BuyGuideWindow(windowPosition:int , resourceURL:String = "BuyGuideWindow.swf")
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
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(MainSkin.windowInnerBg);
			innerBg.scale9Grid = MainSkin.windowInnerBgScale9Grid;
			innerBg.setSize(325, 200);
			innerBg.x = 15;
			innerBg.y = 50;
			this.addChild(innerBg);
			
			innerBg = new ScaleBitmap(MainSkin.windowInner3Bg);
			innerBg.scale9Grid = MainSkin.windowInner3BgScale9Grid;
			innerBg.setSize(305, 135);
			innerBg.x = 25;
			innerBg.y = 60;
			this.addChild(innerBg);
			
			// 固定文本
			var label:Label = new Label(false);
			label.x = 162;
			label.y = 110;
			label.width = 50;
			label.text = Lang.instance.trans("AS_875");
			label.color = GameDictionary.GRAY;
			this.addChild(label);
			
			label = new Label(false);
			label.x = 65;
			label.y = 165;
			label.width = 50;
			label.text = Lang.instance.trans("AS_876");
			label.color = GameDictionary.GRAY;
			this.addChild(label);
			
			label = new Label(false);
			label.x = 193;
			label.y = 165;
			label.width = 50;
			label.text = Lang.instance.trans("AS_877");
			label.color = GameDictionary.GRAY;
			this.addChild(label);
			
			// 钻石icon
			var bmp:Bitmap = new Bitmap(MainSkin.diamondIcon);
			bmp.x = 226;
			bmp.y = 107;
			this.addChild(bmp);
			
			bmp = new Bitmap(bmp.bitmapData);
			bmp.x = 283;
			bmp.y = 162;
			this.addChild(bmp);
			
			// 物品
			itemCell = new ItemCell();
			itemCell.useable = 1;
			itemCell.x = 95;
			itemCell.y = 80;
			this.addChild(itemCell);
			
			// 物品名
			itemLabel = new Label(false);
			itemLabel.width = 150;
			itemLabel.x = 160;
			itemLabel.y = 85;
			this.addChild(itemLabel);
			
			// 价格文本
			singlePriceLabel = new Label(false);
			singlePriceLabel.x = 186;
			singlePriceLabel.y = 110;
			singlePriceLabel.width = 38;
			singlePriceLabel.align = Align.RIGHT
			singlePriceLabel.color = GameDictionary.ORANGE;
			this.addChild(singlePriceLabel);
			
			totalPriceLabel = new Label(false);
			totalPriceLabel.x = 243;
			totalPriceLabel.y = 165;
			totalPriceLabel.width = 38;
			totalPriceLabel.align = Align.RIGHT
			totalPriceLabel.color = GameDictionary.ORANGE;
			this.addChild(totalPriceLabel);
			
			// 物品购买个数输入文本
			itemNumField = new TextInput(false);
			itemNumField.background = new Bitmap(this.getSwfBD("ITEM_NUM_BG"));
			itemNumField.maxChars = 2;
			itemNumField.tf.restrict = "0-9";
			itemNumField.align = TextFormatAlign.CENTER;
			itemNumField.x = 117;
			itemNumField.y = 161;
			itemNumField.width = 55;
			itemNumField.height = 21;
			this.addChild(itemNumField);
			
			// +-按钮
			minusBtn = new Button(MainSkin.minusButtonUp,MainSkin.minusButtonDown,MainSkin.minusButtonOver,MainSkin.minusButtonDisable);
			minusBtn.x = 98;
			minusBtn.y = 163;
			this.addChild(minusBtn);
			
			plusBtn = new Button(MainSkin.plusButtonUp,MainSkin.plusButtonDown,MainSkin.plusButtonOver,MainSkin.plusButtonDisable);
			plusBtn.x = 175;
			plusBtn.y = 163;
			this.addChild(plusBtn);
			
			// 确认按钮
			confirmBtn = new GTextButton(MainSkin.redButton2Up, MainSkin.redButton2Down, MainSkin.redButton2Over, MainSkin.button2Disable);
			confirmBtn.label = Lang.instance.trans("AS_126");
			confirmBtn.x = 140;
			confirmBtn.y = 210;
			this.addChild(confirmBtn);
			
			// line
			var lineBM:ScaleBitmap = new ScaleBitmap(MainSkin.line);
			lineBM.scale9Grid = MainSkin.lineScale9Grid;
			lineBM.setSize(260, 2);
			lineBM.x = 45;
			lineBM.y = 143;
			this.addChild(lineBM);
		}
		
		
		
		/**
		 * 每次打开都会执行
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			plusBtn.addEventListener(MouseEvent.CLICK , plus);
			minusBtn.addEventListener(MouseEvent.CLICK , minus);
			confirmBtn.addEventListener(MouseEvent.CLICK , buy);
			itemNumField.addEventListener(Event.CHANGE , changeItemNum);
			
			this.update();
		}
		
		
		
		
		/**
		 * 显示
		 * */
		private function update():void
		{
			var produce:ProduceVO = ProduceGuideManager.instance.currentProduce;
			if(produce)
			{
				// 物品
				var itemID:String = produce.itemID;
				var packItem:PackItemProVO = ItemManager.instance.getItemData(int(itemID));
				var itemVO:ItemProVO = packItem.itemVO;
				itemCell.cellData = packItem;
				// 物品名
				itemLabel.text = itemVO.name;
				itemLabel.color = GameDictionary.getColorByQuality(itemVO.quality);
				// 物品单价
				singlePriceLabel.text = produce.cost;
				
				// 更新价格
				this.updatePrice(1);
			}
		}
		
		
		
		
		
		/**
		 * 更新价格
		 * */
		private function updatePrice(num:int):void
		{
			itemNumField.text = num+"";
			
			// 计算总价
			var singlePrice:int = int(singlePriceLabel.text);
			totalPriceLabel.text = (num * singlePrice) + "";
		}
		
		
		
		
		/**
		 * 增加购买数量
		 * */
		private function plus(e:MouseEvent):void
		{
			var num:int = buyNum;
			if(num < MAX_BUY_NUM)
			{
				num++;
				
				// 更新
				this.updatePrice(num);
			}
		}
		
		
		
		
		/**
		 * 增加购买数量
		 * */
		private function minus(e:MouseEvent):void
		{
			var num:int = buyNum;
			if(num > 1)
			{
				num--;
				
				// 更新
				this.updatePrice(num);
			}
		}
		
		
		
		
		/**
		 * 更改物品数量
		 * */
		private function changeItemNum(e:Event):void
		{
			// 更新
			this.updatePrice(buyNum);
		}
		
		
		
		
		/**
		 * 购买
		 * */
		private function buy(e:Event):void
		{
			var produce:ProduceVO = ProduceGuideManager.instance.currentProduce;
			var num:int = buyNum;// 购买数量
			if(produce && num > 0)
			{
				var data:Object = new Object();
				data.itemID = int(produce.itemID);
				data.buyNum = num;
				this.dispatchEvent(new GuideEvent(GuideEvent.GUIDE_QUICK_BUY , data));
				
				// 关闭窗口
				this.close();
			}
		}
		
		
		
		
		
		/**
		 * 获取购买数量
		 * */
		private function get buyNum():int
		{
			var num:int = int(itemNumField.text);
			return num;
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void	
		{
			plusBtn.removeEventListener(MouseEvent.CLICK , plus);
			minusBtn.removeEventListener(MouseEvent.CLICK , minus);
			confirmBtn.removeEventListener(MouseEvent.CLICK , buy);
			itemNumField.removeEventListener(Event.CHANGE , changeItemNum);
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