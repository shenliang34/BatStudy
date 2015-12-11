package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.gui.friend.ui.PlayerIconItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListGrid;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.events.Event;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午12:08:02
	 * 
	 * 头像
	 * 
	 */
	public class HeadPortraitWindow extends GeneralWindow
	{
		private var _iconList:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
		private var _iconPanel:SimplePanel;
		private var _iconListGrid:ListGrid;
		public function HeadPortraitWindow(position:int, resourceURL:String="HeadPortraitWindow.swf", width:Number=451, height:Number=256)
		{
			super(position, resourceURL, width, height);
		}
		
		public function get iconListGrid():ListGrid
		{
			return _iconListGrid;
		}

		public function get iconList():Array
		{
			return _iconList;
		}

		override public function close():void
		{
			// TODO Auto Generated method stub
			super.close();
			if(_iconListGrid.selectIndex>=0){
				FriendModel.inst.myIconId = _iconList[_iconListGrid.selectIndex];
			}
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
			add(innerBg, 10, 39, 430, 210);
			
			// 背景、装饰
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 430, 70);
			
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 109, 430, 70);
			
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 179, 430, 70);
			
			_iconPanel = new SimplePanel();
			add(_iconPanel,10,39,430,210);
			
			_iconListGrid = new ListGrid(PlayerIconItemObject,440,220);
			_iconListGrid.setGridAndItem(60,70,40,50);
			_iconListGrid.data = _iconList;
			add(_iconListGrid,10,39);
			_iconListGrid.addEventListener(Event.SELECT,onSelectIcon);
//			for (var i:int = 0; i < iconList.length; i++) 
//			{
//				var icon:PlayerIconButton = new PlayerIconButton(iconList[i],true);
//				iconPanel.addChild(icon);
//				icon.x = (i % 7) * 60 + 10;
//				icon.y = (Math.floor(i/7)) * 70 + 10;
//			}
		}
		
		protected function onSelectIcon(event:Event):void
		{
			// TODO Auto-generated method stub
//			var index:int = iconListGrid.selectIndex;
//			var item:PlayerIconItemObject = iconListGrid.selectItem as PlayerIconItemObject;
//			item._checkBox.checked = true;
		}
		
		override public function onShow():void
		{
			// TODO Auto Generated method stub
			super.onShow();
		}
		
	}
}