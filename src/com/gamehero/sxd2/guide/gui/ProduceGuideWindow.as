package com.gamehero.sxd2.guide.gui
{
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.event.ProduceGuideEvent;
    import com.gamehero.sxd2.event.WindowEvent;
    import com.gamehero.sxd2.gui.core.GeneralWindow;
    import com.gamehero.sxd2.gui.main.MainLeaderPanel;
    import com.gamehero.sxd2.gui.main.MainUI;
    import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
    import com.gamehero.sxd2.local.Lang;
    import com.gamehero.sxd2.manager.DialogManager;
    import com.gamehero.sxd2.manager.FunctionInfo;
    import com.gamehero.sxd2.manager.ItemManager;
    import com.gamehero.sxd2.manager.ProduceGuideManager;
    import com.gamehero.sxd2.vo.ItemProVO;
    import com.gamehero.sxd2.vo.PackItemProVO;
    import com.gamehero.sxd2.vo.ProduceVO;
    
    import flash.display.Sprite;
    
    import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 物品产出引导
	 * @author xuwenyi
	 * @create 2014-05-12
	 **/
	public class ProduceGuideWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 356;
		private const WINDOW_HEIGHT:int = 268;
		
		
		// 带滚动条的容器
		private var produceScrollPanel:NormalScrollPane;
		private var producePanel:Sprite;
		
		// 描述文字
		private var desLabel:Label;
		
		// 产出列表
		private var produceAreaList:Array = [];
		
		
		
		/**
		 * 构造函数
		 * */
		public function ProduceGuideWindow(windowPosition:int , resourceURL:String = "HeroHandbookWindow.swf")
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
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(325, 200);
			innerBg.x = 15;
			innerBg.y = 50;
			this.addChild(innerBg);
			
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(305, 145);
			innerBg.x = 25;
			innerBg.y = 95;
			this.addChild(innerBg);
			
			// 带滚动条的容器
			producePanel = new Sprite();
			produceScrollPanel = new NormalScrollPane();
			produceScrollPanel.x = 32;
			produceScrollPanel.y = 97;
			produceScrollPanel.width = 297;
			produceScrollPanel.height = 140;
			produceScrollPanel.content = producePanel;
			this.addChild(produceScrollPanel);
			
			// 描述文字
			desLabel = new Label(false);
			desLabel.width = 300;
			desLabel.height = 20;
			desLabel.x = 50;
			desLabel.y = 68;
			this.addChild(desLabel);
		}
		
		
		
		/**
		 * 每次打开都会执行
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			this.clear();
			this.update();
		}
		
		
		
		
		
		/**
		 * 显示
		 * */
		private function update():void
		{
			/*var produce:ProduceVO = ProduceGuideManager.instance.currentProduce;
			if(produce)
			{
				// 描述文字
				var str:String = "";
				// 物品
				var itemID:String = produce.itemID;
				var packItem:PackItemProVO = ItemManager.instance.getItemData(int(itemID));
				var itemVO:ItemProVO = packItem.itemVO;
				str += GameDictionary.createCommonText(itemVO.name , GameDictionary.getColorByQuality(itemVO.quality));
				// 固定描述
				str += GameDictionary.createCommonText(Lang.instance.trans("AS_1396") , GameDictionary.WHITE);
				desLabel.text = str;
				
				var funcID:String;
				var area:ProduceGuideArea;
				// 是否存在快速购买
				if(produce.isQuickBuy == "1")
				{
					area = new ProduceGuideArea(this.uiResDomain);
					area.x = 0;
					area.y = 0;
					// 写死1008,只有体力购买引导需要特殊处理
					area.update(null , produce.id != "1008" ? 1 : 2);
					area.addEventListener(ProduceGuideEvent.GOTO_WINDOW , onGotoWindow);
					producePanel.addChild(area);
					
					produceAreaList.push(area);
				}
				
				// 其他产出引导
				var preHeight:int = produce.isQuickBuy == "1" ? 70 : 0;
				var funcIDList:Array = produce.func.split("^");
				for(var i:int=0;i<funcIDList.length;i++)
				{
					funcID = funcIDList[i];
					area = new ProduceGuideArea(this.uiResDomain);
					area.x = 0;
					area.y = preHeight;
					area.update(funcID);
					area.addEventListener(ProduceGuideEvent.GOTO_WINDOW , onGotoWindow);
					producePanel.addChild(area);
					
					produceAreaList.push(area);
					
					// 保存上一个高度
					preHeight = area.y + 70;
				}
				
				// 更新list面板
				produceScrollPanel.refresh();
			}*/
		}
		
		
		
		
		/**
		 * 前往某窗口
		 * */
		private function onGotoWindow(e:ProduceGuideEvent):void
		{
			super.close();
			MainUI.inst.openWindow(WindowEvent.HERO_HANDBOOK_WINDOW);
			
			/*var area:ProduceGuideArea = e.currentTarget as ProduceGuideArea;
			var funcInfo:FunctionInfo = area.funcInfo;
			var type:int = area.type;
			if(funcInfo)
			{	
				if(MainUI.inst.canOpen(funcInfo.positionType) == true)
				{
					MainUI.inst.openWindow2(funcInfo);
				}
				else
				{
					DialogManager.inst.showPrompt(Lang.instance.trans("AS_1397"));
				}
			}
			else
			{
				// 快速购买
				if(type == 1)
				{
					MainUI.inst.openWindow(WindowEvent.BUY_GUIDE_WINDOW);
				}
				// 体力购买
				else
				{
					MainLeaderPanel.inst.buyStamina();
				}
			}*/
			
			this.clear();
		}
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void	
		{
			for(var i:int=0;i<produceAreaList.length;i++)
			{
				var area:ProduceGuideArea = produceAreaList[i];
				area.removeEventListener(ProduceGuideEvent.GOTO_WINDOW , onGotoWindow);
				area.clear();
				
				if(producePanel.contains(area) == true)
				{
					producePanel.removeChild(area);
				}
			}
			
			produceAreaList = [];
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