package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.gui.friend.ui.FriendItemObject;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListGrid;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.PageButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.inputBox.InputNumBox;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.events.Event;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-18 下午12:44:11
	 * 
	 * 
	 * 我的听众
	 * 
	 */
	public class MyAudienceWindow extends GeneralWindow
	{
		//窗口宽高
		private const  WINDOW_WIDTH:Number = 451;
		private const  WINDOW_HEIGHT:Number = 446; 
		//列表宽高
		private const LIST_WIDTH:int = 430;
		private const LIST_HEIGHT:int = 360;
		//单个听众宽高
		private const ITEM_WIDTH:int = 200;
		private const ITEM_HEIGHT:int = 38;
		//
		private var col:int = 0;
		private var row:int = 0;
		
		private var pageButton:PageButton;//翻页按钮
		private var pageBtn:InputNumBox;
		private var listGrid:ListGrid;//听众列表
		//所有听众
		private var audienceList:Array;
		public function MyAudienceWindow(position:int, resourceURL:String="MyAudienceWindow.swf")
		{
			//TODO: implement function
			super(position, resourceURL,WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		override public function close():void
		{
			// TODO Auto Generated method stub
			super.close();
		}
		
		override protected function initWindow():void
		{
			// TODO Auto Generated method stub
			super.initWindow();
			this.init();
		}
		
		private function init():void
		{
			// 背景、装饰
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 430, 394);
			
			// 背景、装饰
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 430, 360);
			
			pageBtn = new InputNumBox();
			pageBtn.x = 170;
			pageBtn.y = 410;
			addChild(pageBtn);
			pageBtn.addEventListener(Event.CHANGE,onPageChangeHandler);
			
			
			listGrid = new ListGrid(FriendItemObject, LIST_WIDTH, LIST_HEIGHT);
			listGrid.setGridAndItem(ITEM_WIDTH, ITEM_HEIGHT);
			listGrid.x = 35;
			listGrid.y = 50;
			addChild(listGrid);
			
			col = LIST_WIDTH / ITEM_WIDTH;
			row = LIST_HEIGHT / ITEM_HEIGHT;
		}
		/**
		 *刷新 
		 * @param arr
		 * 
		 */		
		public function updateListener(arr:Array = null):void
		{
			if(arr){
				audienceList = arr;
			}else{
				audienceList = FriendModel.inst.listeners;
			}
			initPage();
		}
		
		protected function onPageChangeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			onChangePage();
		}
		
		private function createData():void
		{
			//测试代码
			audienceList = FriendModel.inst.listeners;
			initPage();
		}
		
		/**
		 *初始化列表从第一页开始 
		 * 
		 */		
		public function initPage():void
		{
			pageBtn.minNum = 1;
			pageBtn.maxNum = Math.ceil(audienceList.length / ( row * col ));
			onChangePage();
		}
		
		/**
		 * 点击翻页后的处理逻辑
		 * 
		 */		
		public function onChangePage():void
		{
			var page:int = pageBtn.num - 1;
			var data:Array = audienceList.slice(page * col * row,Math.min(audienceList.length,(page+1) * col * row));
			listGrid.data = data;
		}
		
		override public function onShow():void
		{
			super.onShow();
			pageBtn.needEvent = true;
			dispatchEvent(new FriendEvent(FriendEvent.GET_AUDIENCE_LIST));
		}
		
	}
}