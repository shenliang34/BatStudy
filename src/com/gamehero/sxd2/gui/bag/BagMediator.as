package com.gamehero.sxd2.gui.bag
{
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 背包管理
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午7:56:42
	 * 
	 */
	public class BagMediator extends Mediator
	{
		[Inject]
		public var view:BagWindow;
		
		private var _model:BagModel;
		
		public function BagMediator()
		{
			super();
			_model = BagModel.inst;
		}
		
		override public function initialize():void
		{
			super.initialize();
			//道具使用
			BagModel.inst.addEventListener(BagEvent.ITEM_UPDATA_SINGLE,onUpdataBag);
		}
		/**
		 * 更新背包道具 
		 * @param event
		 * 
		 */		
		protected function onUpdataBag(event:BagEvent):void
		{
			view.updataBagItem(event);
		}
		
		override public function destroy():void
		{
			super.destroy();
			GameProxy.inst.removeEventListener(BagEvent.ITEM_UPDATA_SINGLE,onUpdataBag);
		}
	}
}