package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-14 下午4:50:29
	 * 伙伴激活面板
	 */
	public class HeroHandbookMoviePanel extends Sprite
	{
		private static var _instance:HeroHandbookMoviePanel
		private var maskBg:Bitmap;
		
		private var figure:SpriteFigureItem;
		
		private var effect:MovieClip;
		public function HeroHandbookMoviePanel()
		{
			this.init();
		}
		
		public static function get inst():HeroHandbookMoviePanel
		{
			return _instance ||= new HeroHandbookMoviePanel();
		}
		
		private function init():void
		{
			maskBg = new Bitmap(HeroHandbookSkin.BIG_MASK);
			maskBg.x = 20;
			maskBg.y = 45;
			this.addChild(maskBg);
		}
		
		public function show():void
		{
			this.visible = true;
			this.clear();
			//品质
			var index:int = int(HerohandbookModel.inst.activeHero.quality) - 1;
			effect = new (HeroHandbookSkin.EFFECT[index] as Class)() as MovieClip;
			effect.x = 542;
			effect.y = 330;
			effect.roleMc.addFrameScript(effect.roleMc.totalFrames - 1, onPlayEnd);
			this.addChild(effect);
		}
		
		/**
		 * 重绘伙伴形象
		 * */
		public function showFigure():void
		{
			this.addEventListener(MouseEvent.CLICK,onHidePanel);
			
			var url:String = GameConfig.FIGURE_URL + "body_ui/" +  HerohandbookModel.inst.activeHero.id;
			figure = new SpriteFigureItem(url, false , BattleFigureItem.UI_STAND);
			
			/*var url:String = GameConfig.BATTLE_FIGURE_URL + HerohandbookModel.inst.activeHero.url;
			figure = new SpriteFigureItem(url , false , BattleFigureItem.STAND);*/
			figure.frameRate = 18;
			figure.play();
			figure.x = 542;
			figure.y = 330;
			this.addChild(figure);
			
			HerohandbookModel.inst.activeHero = null;
			//最后全部销毁
			HerohandbookModel.inst.resource.push(url);
		}
		
		private function onPlayEnd():void
		{
			(effect.roleMc as MovieClip).gotoAndStop((effect.roleMc as MovieClip).totalFrames);
			this.showFigure();
		}
		
		private function onHidePanel(evt:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK,onHidePanel);
			this.clear();
			this.visible = false;
		}
		
		public function clear():void
		{
			if(effect)
			{
				this.removeChild(effect);
			}
			if(figure)
			{
				figure.stop();
				this.removeChild(figure);
			}
			effect = null;
			figure = null;
		}
	}
}