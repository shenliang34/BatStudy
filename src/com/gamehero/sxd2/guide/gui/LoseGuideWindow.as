package com.gamehero.sxd2.guide.gui
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.WantStrManager;
	import com.gamehero.sxd2.vo.WantStrVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗失败快速引导窗口
	 * @author xuwenyi
	 * @create 2014-05-05
	 **/
	public class LoseGuideWindow extends SimpleWindow
	{
		private const WINDOW_WIDTH:int = 215;
		private const WINDOW_HEIGHT:int = 93;
		
		private static var _instance:LoseGuideWindow;
		
		// 描述文字
		private var desDic:Dictionary = new Dictionary();
		
		private var currentIdx:int;
		// 引导功能列表
		private var funcList:Array;
		// 当前显示的引导
		private var curMenuBtn:DisplayObject;
		
		// ui控件
		private var bgPanel:Sprite;
		private var iconPanel:Sprite;
		private var closeBtn:Button;
		private var leftArrow:Button;
		private var rightArrow:Button;
		private var pageLabel:Label;
		private var desLabel:Label;
		private var linkLabel:HtmlText;
		
		
		
		/**
		 * 构造函数
		 * */
		public function LoseGuideWindow()
		{
			super();
			
			/*var mgr:Lang = Lang.instance;
			desDic[1042] = mgr.trans("312");
			desDic[1043] = mgr.trans("313");
			desDic[1041] = mgr.trans("314");
			desDic[1011] = mgr.trans("315");
			desDic[1061] = mgr.trans("316");
			desDic[1080] = mgr.trans("317");
			desDic[1070] = mgr.trans("318");
			desDic[1071] = mgr.trans("319");*/
		}
		
		
		
		public static function get instance():LoseGuideWindow
		{
			return _instance ||= new LoseGuideWindow();
		}
		
		
		
		
		/**
		 * 初始化基础UI
		 */
		override protected function initWindow():void {
			
			super.initWindow();
			
			// 尺寸
			this.setSize(WINDOW_WIDTH , WINDOW_HEIGHT);
			
			// 初始化基础UI
			bgPanel = new Sprite();
			this.addChild(bgPanel);
			
			iconPanel = new Sprite();
			iconPanel.x = 9;
			iconPanel.y = 7;
			iconPanel.mouseEnabled = false;
			iconPanel.mouseChildren = false;
			this.addChild(iconPanel);
			
			// 关闭按钮
			closeBtn = new Button(MainSkin.closeButtonUpSkin, MainSkin.closeButtonDownSkin, MainSkin.closeButtonOverSkin, MainSkin.closeButtonDisableSkin);
			closeBtn.x = 187;
			closeBtn.y = 3;
			this.addChild(closeBtn);
			
			// 左右箭头
			/*leftArrow = new Button(WindowSkin.leftArrowUp,WindowSkin.leftArrowDown,WindowSkin.leftArrowOver,WindowSkin.leftArrowDisable);
			leftArrow.x = 8;
			leftArrow.y = 72;
			this.addChild(leftArrow);
			
			rightArrow = new Button(WindowSkin.rightArrowUp,WindowSkin.rightArrowDown,WindowSkin.rightArrowOver,WindowSkin.rightArrowDisable);
			rightArrow.x = 53;
			rightArrow.y = 72;
			this.addChild(rightArrow);*/
			
			// 页码
			/*pageLabel = new Label(false);
			pageLabel.align = Align.CENTER;
			pageLabel.x = 24;
			pageLabel.y = 74;
			pageLabel.width = 30;
			pageLabel.height = 20;
			this.addChild(pageLabel);*/
			
			// 说明文字
			desLabel = new Label(false);
			desLabel.x = 80;
			desLabel.y = 38;
			desLabel.leading = 0.4;
			desLabel.width = 120;
			desLabel.height = 36;
			desLabel.text = Lang.instance.trans("10127");
			this.addChild(desLabel);
			
			// 链接文字
			linkLabel = new HtmlText();
			linkLabel.x = 71;
			linkLabel.y = 70;
			linkLabel.text = GameDictionary.ORANGE_TAG2 + Lang.instance.trans("AS_1579");
			this.addChild(linkLabel);
		
			// 加载背景图
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.GUIDE_URL + "quickGuideBG.swf" , null , onLoaded);
		}
		
		
		
		
		
		/**
		 * 背景图加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 添加背景
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			bgPanel.addChild(new Bitmap(png));
		}
		
		
		
		
		/**
		 * 显示
		 * */
		public function show():void
		{
			this.clear();
			
			// 事件
			linkLabel.addEventListener(MouseEvent.CLICK , link);
			closeBtn.addEventListener(MouseEvent.CLICK , closeWindow);
			/*leftArrow.addEventListener(MouseEvent.CLICK , left);
			rightArrow.addEventListener(MouseEvent.CLICK , right);*/
			
			// 获取引导列表
			/*funcList = QuickGuideManager.instance.getFuncList2();
			if(funcList && funcList.length > 0)
			{
				currentIdx = 0;
				
				// 显示
				this.update();
			}*/
			
			// 显示
			this.update();
		}
		
		
		
		
		/**
		 * 左切页
		 * */
		private function left(e:MouseEvent):void
		{
			if(currentIdx > 0)
			{
				currentIdx--;
				
				this.update();
			}
		}
		
		
		
		/**
		 * 右切页
		 * */
		private function right(e:MouseEvent):void
		{
			if(currentIdx < funcList.length-1)
			{
				currentIdx++;
				
				this.update();
			}
		}
		
		
		
		/**
		 * 显示当前引导
		 * */
		private function update():void
		{
			// 左右箭头按钮
			/*leftArrow.locked = currentIdx <= 0;
			rightArrow.locked = currentIdx >= funcList.length-1;*/
			
			// 页码
			//pageLabel.text = (currentIdx+1) + "/" + funcList.length;
			
			// 显示图标
			Global.instance.removeChildren(iconPanel);
			
			//var vo:QuickGuideVO = funcList[currentIdx];
			var vo:WantStrVO = WantStrManager.instance.getEquipGuide();
			curMenuBtn = vo.menuBtn;
			curMenuBtn.x = 0;
			curMenuBtn.y = 0;
			iconPanel.addChild(curMenuBtn);
		}
		
		
		
		
		/**
		 * 打开窗口
		 * */
		private function link(e:MouseEvent):void
		{
			if(curMenuBtn)
			{
				linkLabel.removeEventListener(MouseEvent.CLICK , link);
				
				// 打开窗口
				/*var funcInfo:FunctionInfo = FunctionsManager.instance.getFuncInfo(int(curMenuBtn.name));
				MainUI.instance.openWindow2(funcInfo);*/
				
				// 打开我要变强
				MainUI.inst.openWindow(WindowEvent.WANT_STR_WINDOW);
				
				// 关闭窗口
				this.closeWindow();
			}
		}
		
		
		
		
		/**
		 * 关闭窗口
		 * */
		public function closeWindow(e:MouseEvent = null):void
		{
			if(parent)
			{
				this.clear();
				this.close();
			}
		}
		
		
		
		
		/**
		 * 自适应
		 * */
		override protected function onResize(e:Event = null):void
		{
			if(stage)
			{
				this.x = stage.stageWidth - width - 10;
				this.y = stage.stageHeight - height - 100;
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			currentIdx = 0;
			curMenuBtn = null;
			funcList = [];
			
			// 链接事件
			linkLabel.removeEventListener(MouseEvent.CLICK , link);
			closeBtn.removeEventListener(MouseEvent.CLICK , closeWindow);
			/*leftArrow.removeEventListener(MouseEvent.CLICK , left);
			rightArrow.removeEventListener(MouseEvent.CLICK , right);*/
		}
	}
}