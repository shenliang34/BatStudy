package com.gamehero.sxd2.guide.gui
{
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.gui.shop.ShopProxy;
	import com.gamehero.sxd2.pro.GS_Pack_Buy_Pro;
	import com.gamehero.sxd2.pro.GS_STORE_TYPE_Pro;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 快速购买窗口的mediator
	 * @author xuwenyi
	 * @create 2014-05-14
	 **/
	public class BuyGuideMediator extends Mediator
	{
		[Inject]
		public var view:BuyGuideWindow;
		[Inject]
		public var proxy:ShopProxy;
		
		
		/**
		 * 构造函数
		 * */
		public function BuyGuideMediator()
		{
			super();
		}
		
		
		
		/**
		 * 初始化
		 * */
		override public function initialize():void
		{
			super.initialize();
			
			// 监听事件
			this.addViewListener(GuideEvent.GUIDE_QUICK_BUY , quickBuy);
		}
		
		
		
		/**
		 * 销毁
		 * */
		override public function destroy():void
		{
			super.destroy();
			
			// 移除事件
			this.removeViewListener(GuideEvent.GUIDE_QUICK_BUY , quickBuy);
		}
		
		
		
		
		/**
		 * 快速购买
		 * */
		private function quickBuy(e:GuideEvent):void
		{
			var data:Object = e.data;
			// 构建消息数据
			var info:GS_Pack_Buy_Pro = new GS_Pack_Buy_Pro();
			info.storeType = GS_STORE_TYPE_Pro.QUICKBUY;
			info.order = data.itemID;
			info.buyNum = data.buyNum;
			proxy.packBuy(info);
		}
		
	}
}