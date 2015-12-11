package com.gamehero.sxd2.gui.formation.fetterZone
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	

	/**
	 * @author Wbin
	 * 创建时间：2015-9-23 上午10:58:08
	 * @用于不影响拖拽时的鼠标事件而建立的外部容器
	 */
	public class FormationFetterFigureCell extends Sprite
	{
		/**阵上伙伴信息*/
		public var heroVO:HeroVO;
		public var heroInfo:PRO_Hero;
		
		/**伙伴路径*/
		private var figure:SpriteFigureItem;
		
		/**阵上伙伴的位置*/
		public var pos:int;
		
		/**锁*/
		private var lockMc:MovieClip;
		private var cloudUpMc:MovieClip;
		private var cloudOverMc:MovieClip;
		
		//模型容器
		private var figureContainer:Sprite;
		
		public function FormationFetterFigureCell(index:int)
		{
			super();
			
			this.init(index);
		}
		
		private function init(index:int):void
		{
			this.cloudUpMc = new FormationSkin.CLOUD_MC_UP() as MovieClip;
			cloudUpMc.visible = true;
			this.addChild(cloudUpMc);
			
			this.cloudOverMc = new FormationSkin.CLOUD_MC_OVER() as MovieClip;
			cloudOverMc.visible = false;
			this.addChild(cloudOverMc);
			
			this.lockMc = new FormationSkin.LOCK_MV() as MovieClip;
			this.lockMc.x = -this.lockMc.width >> 1;
			this.lockMc.y = -(this.lockMc.height >> 1) - 50;
			this.addChild(this.lockMc);
			
			this.figureContainer = new Sprite();
			this.addChild(figureContainer);
		}
		
		/**此位置是否可拖拽*/
		public function setDrag(value:Boolean):void
		{
			this.lockMc.visible = !value;
		}
		
		
		/**更新当前位置上伙伴的信息*/
		public function upData(heroInfo:PRO_Hero):void
		{
			this.heroInfo  = heroInfo;
			this.heroVO = HeroManager.instance.getHeroByID(heroInfo.heroId+"");
			
			// 伙伴形象
			if(heroVO)
			{
				var url:String = GameConfig.BATTLE_FIGURE_URL + heroVO.url;
				figure = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
				figure.frameRate = 18;
				figure.play();
				figureContainer.addChild(figure);
				
				// 保存资源url,在阵容面板关闭时清除
				FormationModel.inst.addResource(url);
			}
		}
		
		/**
		 * 显示/隐藏模型
		 * */
		public function setFigureVisible(value:Boolean):void
		{
			//先隐藏模型
			if(figure != null)
			{
				figure.visible = value;
			}
			
			this.mouseEnabled = this.mouseChildren = value;
		}
		
		/**鼠标滑过处理*/
		public function mouseOver():void
		{
			this.cloudOverMc.visible = true;
			this.cloudUpMc.visible = false;
		}
		
		
		/**
		 * 鼠标移出处理
		 * */
		public function mouseOut():void
		{
			this.cloudOverMc.visible = false;
			this.cloudUpMc.visible = true;
		}
		
		
		public function clear():void
		{
			this.setDrag(false);
			
			cloudUpMc.stop();
			cloudOverMc.stop();
			heroVO = null;
			heroInfo = null;
			
			if(figure)
			{
				figure.stop();
				figure.visible = false;
				/*THIS.REMOVECHILD(FIGURE);*/
			}
			figure = null;
			
			while(figureContainer.numChildren > 0)
			{
				figureContainer.removeChildAt(0);
			}
		}
	}
}