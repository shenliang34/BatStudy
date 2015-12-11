package com.gamehero.sxd2.gui.bag
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.component.ItemGrid;
	import com.gamehero.sxd2.gui.bag.component.ItemPool;
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemSrcTypeDict;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 
	 * 背包界面
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:55:56
	 * 
	 */
	public class BagWindow extends GeneralWindow
	{
		/**
		 * 格子框框 
		 */		
		private var _itemGrid:ItemGrid;
		
		private var _gridPanel:NormalScrollPane;
		/**
		 * 当前列数 
		 */		
		private const COL:int = 7;
		/**
		 * 显示的行数 
		 */		
		private const ROW:int = 8;
		
		/**
		 * 背包界面需要用到的数据<br>
		 * 背包界面打开后不需要自动排序,数据只是保留了打开背包界面时候的。 
		 */		
		private var viewUseBagArr:Array;
		
		
		public function BagWindow(position:int, resourceURL:String="BagWindow.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 430, 535);
		}
		
		override protected function initWindow():void
		{
			super.initWindow();
			BagModel.inst.domain = this.uiResDomain;
			initBackground();
		}
		
		private function initBackground():void{
			
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(414, 479);
			innerBg.y = 39;
			innerBg.x = 8;
			addChild(innerBg);
			
			var titelBag:Bitmap = new Bitmap( this.getSwfBD("BagName"));
			addChild(titelBag);
			titelBag.x = 195;
			titelBag.y = 12;
			_itemGrid = new ItemGrid();
			_itemGrid.col = COL;
			_itemGrid.itemSrcType = ItemSrcTypeDict.BAG;
			_itemGrid.clickAble = true;
			_itemGrid.mouseOverAble = true;
			_gridPanel = new NormalScrollPane();
			_gridPanel.width = 395;
			_gridPanel.content = _itemGrid;
			_gridPanel.height = 423;
			_gridPanel.x = 22;
			_gridPanel.y = 52;
			addChild(_gridPanel);
			
			var button:Button = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over,CommonSkin.blueButton1Disable);
			button.label = "当铺";
			button.width = 96;
			button.height = 32;
			button.x = 170;
			button.y = 478;
			button.addEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			addChild(button);
		}
		
		override public function onShow():void
		{
			super.onShow();
			
			viewUseBagArr = BagModel.inst.itemArr.concat();
			updataBag();
		}
		//============业务逻辑=========================
		
		
		/**
		 * 打开回购
		 * @param event
		 * 
		 */		
		protected function actionBtnClickHandle(event:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.BUYBACK_WINDOW);
		}
		/**
		 * 刷新背包内容 
		 * （只要承载物品格子的数目变化，就及时排序）
		 */		
		public function updataBagItem(event:BagEvent):void
		{
			var itemArr:Array = event.data as Array;
			var pro:PRO_Item;
			var hasItem:Boolean;//显示的道具中是否有该道具
			var isNumChange:Boolean;
			
			
			for each(var item:PRO_Item in itemArr)
			{
				var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(item.itemId);
				if(propBaseVo.type != ItemTypeDict.HERO_CHIPS)
					continue;
				for(var i:int = 0; i < viewUseBagArr.length; i++)
				{
					pro = viewUseBagArr[i];
					if(pro && item.id.toString() == pro.id.toString())
					{
						if(item.num == 0 || item.occupied)//删除道具
						{
							viewUseBagArr[i] = null;
							viewUseBagArr = BagModel.inst.itemArr.concat();
						}
						else//修改道具数量
						{
							pro.num = item.num;
						}
						hasItem = true;
						break;
						
					}
				}
				
				if(!hasItem && !item.occupied)//添加新的
				{
					viewUseBagArr.push(item);
					isNumChange = true;
					break;//需要自动排序，不用再遍历物品格子了。
				}
			}
			
			if(isNumChange)
				viewUseBagArr = BagModel.inst.itemArr.concat();
		
			updataBag();
		}
		
		private function updataBag():void
		{
			var addSpaceArr:Array;//填充的空格子
			var dataProvider:Array = viewUseBagArr;
			if(dataProvider.length < COL * ROW)
			{
				addSpaceArr = new Array(COL * ROW - dataProvider.length);
				dataProvider = dataProvider.concat(addSpaceArr);
			}
			var residue:int = dataProvider.length % COL;//为了多出来一行，还需要添加,
			
			var addNum:int = residue > 0 ? (COL - residue) + COL : COL;//当前页要比有数据的格子多出来一行。
			addSpaceArr = new Array(addNum);
			_itemGrid.data = dataProvider.concat(addSpaceArr);
			_gridPanel.refresh();
		}
		
		
		
		override public function close():void
		{
			super.close();
			WindowManager.inst.closeGeneralWindow(BuybackWindow);
			ItemPool.dispose();
		}
	}
}