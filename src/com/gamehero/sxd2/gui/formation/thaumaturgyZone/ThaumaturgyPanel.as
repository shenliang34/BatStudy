package com.gamehero.sxd2.gui.formation.thaumaturgyZone
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.ActiveBitmap;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.GTextTabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.TabPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.MSG_LEVELUP_MAGIC;
	import com.gamehero.sxd2.pro.MSG_MAGIC_INFO;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import alternativa.gui.container.tabPanel.TabData;
	import alternativa.gui.controls.text.Label;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-18 下午4:02:21
	 * 
	 */
	public class ThaumaturgyPanel extends Sprite
	{
//		private static var NAME_ARR:Array = ["功法","阵法"];
		
		//阅历
		private var ylLabel:Label;
		
		//当前面板编号
		private var index:int;
		
		//奇术滚动面板
		private var thaumScorPan:ThaumaturgyScrollPanel;
		/*private var tabPanel:TabPanel;*/
		private var tabBtnArr:Array;
		private var tabPanelArr:Array;
		
		public function ThaumaturgyPanel()
		{
			this.init();
		}
		
		/**
		 * 面板初始化
		 * */
		private function init():void
		{
			tabBtnArr = new Array();
			tabPanelArr = new Array();
			
			var bg:Bitmap = new Bitmap(FormationSkin.QISHU_BG);
			bg.x = 21;
			bg.y = 80;
			this.addChild(bg);
			
			var yl:ActiveBitmap = new ActiveBitmap(FormationSkin.YL);
			yl.hint = "阅历";
			yl.x = 853;
			yl.y = 44;
			this.addChild(yl);
			
			ylLabel = new Label();
			ylLabel.x = 878;
			ylLabel.y = 49;
			ylLabel.color = GameDictionary.WINDOW_BLUE;
			ylLabel.text = "阅历：999999";
			this.addChild(ylLabel);
			
			thaumScorPan = new ThaumaturgyScrollPanel();
			thaumScorPan.x = 15;
			thaumScorPan.y = 83;
			thaumScorPan.resize(955,496);
			this.addChild(thaumScorPan);

			var gray:Bitmap = new Bitmap(FormationSkin.GR);
			gray.x = 22;
			gray.y = 553;
			this.addChild(gray);
			
			/*tabPanel = new TabPanel(6, TabPanel.LayoutType_Horizontal);
			tabPanel.x = 15;
			tabPanel.y = 85;
			this.addChild(tabPanel);*/
			
			/*var tabButton:GTextTabButton;
			for(var i:int = 0 ; i < NAME_ARR.length ; i++)
			{
				//tabpanel
				thaumScorPan = new ThaumaturgyScrollPanel(i);
				thaumScorPan.padding= 5;
				//tabbtn
				tabButton = new GTextTabButton(CommonSkin.blueButton2Up,CommonSkin.blueButton2Down,CommonSkin.blueButton2Over);
				tabButton.name =  NAME_ARR[i];
				tabButton.label = NAME_ARR[i];
				tabBtnArr.push(tabButton);
				tabPanelArr.push(thaumScorPan);
				
				tabPanel.addTab(new TabData(tabButton, thaumScorPan));
				tabButton.addEventListener(MouseEvent.CLICK, onTabClickHandler);
			}*/
			//面板大小重绘
			/*tabPanel.resize(760,370);*/
		}
		
		/**
		 * 面板数据
		 * */
		public function upData(data:MSG_MAGIC_INFO):void
		{
			thaumScorPan.update(data);
		}
		
		/**
		 * 升级数据
		 * */
		public function upDataLvl(data:MSG_LEVELUP_MAGIC):void
		{
			thaumScorPan.upDataLvUp(data);
			/*var panel:ThaumaturgyScrollPanel = tabPanelArr[data.type];
			panel.upDataLvl(data);*/
		}
		
		/**
		 * Tab Click Handler 
		 * @param event
		 */
		private function onTabClickHandler(event:MouseEvent):void
		{
			//请求奇术信息
			this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_MAGIC_INFO));
		}	
		
		/**
		 * 销毁
		 * */
		public function close():void
		{
			thaumScorPan.clear();
			/*for(var i:int = 0 ;i < tabPanelArr.length ; i++)
			{
				var panel:ThaumaturgyScrollPanel = tabPanelArr[i];
				panel.clear();
			}*/
		}
		
	}
}