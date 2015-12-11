package com.gamehero.sxd2.gui.friend
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.friend.ui.AudienceItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.List;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import alternativa.gui.data.DataProvider;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午12:01:07
	 * 
	 */
	public class AudienceTipBoxWindow extends GeneralWindow
	{
		/**
		 * 关注按钮
		 * */
		private var _allAudienceBtn:GTextButton;
		/**
		 * 忽略按钮
		 * */
		private var _allIgnoreBtn:GTextButton;
		/**
		 *关注列表 
		 */		
		private var _audienceList:List;
		private var _audienceDataProvider:DataProvider;
		
		private var _audiencePanel:SimplePanel;
		public function AudienceTipBoxWindow(position:int, resourceURL:String="AudienceTipBox.swf", width:Number=311, height:Number=239)
		{
			super(position, resourceURL, width, height);
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
			add(innerBg, 10, 39, 290, 187);
			
			// 背景、装饰
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			add(innerBg, 10, 39, 290, 150);
			
			_allIgnoreBtn = new GTextButton(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			_allIgnoreBtn.label = "全部忽略";
			_allIgnoreBtn.x = 180;
			_allIgnoreBtn.y = 190;
			this.addChild(_allIgnoreBtn);
			
			
			_allAudienceBtn = new GTextButton(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			_allAudienceBtn.label = "全部关注";
			_allAudienceBtn.x = 64;
			_allAudienceBtn.y = 190;
			this.addChild(_allAudienceBtn);
			
			_audienceList = new List();
			_audienceList.itemRenderer = AudienceItemObject;
			_audienceDataProvider = new DataProvider();
			
			_audienceList.dataProvider = _audienceDataProvider;
			
//			_audiencePanel = new SimplePanel();
//			_audiencePanel.padding = 5;
//			_audiencePanel.content = _audienceList;
			add(_audienceList,10,39,290,150);
//			addChild(_audienceList);
			for (var i:int = 0; i < 10; i++) 
			{
				var tempInfo:Object =new Object();
				_audienceDataProvider.addItem(tempInfo);
			}
			
			
			
			
		}
		
		override public function onShow():void
		{
			// TODO Auto Generated method stub
			super.onShow();
		}
		
	}
}