package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-2 下午6:02:53
	 * 伙伴图鉴功能
	 */
	public class HeroHandbookWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 1084;
		private const WINDOW_HEIGHT:int = 599;
		
		public var _heroBookPanel:HeroHandbookPanel
		public var _heroFigurePanel:HeroHandbookFigurePanel;
		public var _heroMoviePanel:HeroHandbookMoviePanel;
		
		
		public function HeroHandbookWindow(windowPosition:int,resourceURL:String = "HeroHandbookWindow.swf")
		{
			super(windowPosition,resourceURL,WINDOW_WIDTH,WINDOW_HEIGHT);
		}
		
		/**
		 * 复写面板UI
		 * */
		override protected function initWindow():void
		{
			super.initWindow();
			//美术资源初始化
			HeroHandbookSkin.init(this.uiResDomain);
			this.init();
			HerohandbookModel.inst.getAllHero();
		}
		
		/**
		 * init
		 * */
		private function init():void
		{
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(1062, 551);
			innerBg.x = 11;
			innerBg.y = 38;
			addChild(innerBg);
			
			var bg:Bitmap = new Bitmap(HeroHandbookSkin.BG_1);
			bg.width = bg.width + 10;
			bg.height = bg.height +10;
			bg.x = 16;
			bg.y = 43;
			this.addChild(bg);
			
			this.addChild(this._heroBookPanel = HeroHandbookPanel.inst);
			this.addChild(this._heroFigurePanel = HeroHandbookFigurePanel.inst);
			this.addChild(this._heroMoviePanel = HeroHandbookMoviePanel.inst);
		}
		
		/**
		 * 打开
		 * */
		override public function onShow():void
		{
			super.onShow();
			
			this._heroBookPanel.visible = true;
			this._heroFigurePanel.visible = false;
			this._heroMoviePanel.visible = false;
			
			this._heroBookPanel.addlistener();
			this._heroBookPanel.addEventListener(HeroHandbookEvent.OPEN_FIGURE,onOpenFigure);
			this._heroBookPanel.updata();
			
			this._heroFigurePanel.addEventListener(HeroHandbookEvent.BACK,onBack);
		}
		
		
		/**
		 * 前往伙伴详细信息面板
		 * */
		private function onOpenFigure(evt:HeroHandbookEvent):void
		{
			this._heroBookPanel.visible = false;
			this._heroFigurePanel.visible = true;
			
			this._heroFigurePanel.updata((evt.data.heroVo) as HeroVO,(evt.data.proHero) as PRO_Hero);
		}
		
		private function onBack(evt:HeroHandbookEvent):void
		{
			this._heroBookPanel.visible = true;
			this._heroFigurePanel.visible = false;
		}
		
		
		/**
		 * 关闭
		 * */
		override public function close():void
		{
			super.close();
			this._heroBookPanel.clear();
			this._heroFigurePanel.clear();
			this._heroBookPanel.removeEventListener(HeroHandbookEvent.OPEN_FIGURE,onOpenFigure);
			this._heroFigurePanel.removeEventListener(HeroHandbookEvent.BACK,onBack);
			HerohandbookModel.inst.clear();
		}
	}
}