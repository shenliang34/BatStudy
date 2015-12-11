package com.gamehero.sxd2.gui.formation.formationZone
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
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	
	
	/**
	 * 用于不影响拖拽时的鼠标事件而建立的外部容器
	 * @author xuwenyi
	 * @create 2015-09-01
	 **/
	public class FormationFigureCell extends Sprite
	{
		/**阵上伙伴信息*/
		public var heroVO:HeroVO;
		public var heroInfo:PRO_Hero;
		
		/**伙伴路径*/
		private var figure:SpriteFigureItem;
		
		/**阵上伙伴的位置*/
		public var pos:int;
		
		//布阵脚底框 
		private var rectDisable:Bitmap;
		private var rectEnable:Bitmap;
		private var rectOver:Bitmap;
		
		//模型容器
		private var figureContainer:Sprite;
		
		
		/**
		 * 构造函数
		 * */
		public function FormationFigureCell(index:int)
		{
			super();
			
			this.init(index);
		}
		
		
		
		
		
		private function init(index:int):void
		{
			rectDisable = new Bitmap(FormationSkin.KUANG_DISABLE_NEW[index]);
			rectEnable = new Bitmap(FormationSkin.KUANG_ENABLE_NEW[index]); 
			rectOver = new Bitmap(FormationSkin.KUANG_OVER_NEW[index]);
			
			rectDisable.visible = rectEnable.visible = rectOver.visible = false;
			rectDisable.x = rectEnable.x = rectOver.x = -rectDisable.width >> 1;
			rectDisable.y = rectEnable.y = rectOver.y = -rectDisable.height >> 1;
			
			this.addChild(rectDisable);
			this.addChild(rectEnable);
			this.addChild(rectOver);
			
			this.figureContainer = new Sprite();
			this.addChild(figureContainer);
		}
		
		
		
		
		/**
		 * 设置此格子是否可拖拽
		 * */
		public function setDrag(value:Boolean):void
		{
			if(value == true)
			{
				rectDisable.visible = false;
				rectEnable.visible = true;
				rectOver.visible = false;
			}
			else
			{
				rectDisable.visible = true;
				rectEnable.visible = false;
				rectOver.visible = false;
			}
		}
		
		
		
		
		/**伙伴信息更新*/
		public function upData(heroInfo:PRO_Hero):void
		{
			this.heroInfo = heroInfo;
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
		
		
		
		
		/**
		 * 鼠标滑过处理
		 * */
		public function mouseOver():void
		{
			rectEnable.visible = false;
			rectOver.visible = true;
		}
		
		
		
		
		/**
		 * 鼠标移出处理
		 * */
		public function mouseOut():void
		{
			// 移除高亮状态图
			rectEnable.visible = true;
			rectOver.visible = false;
		}
		
		
		
		
		
		
		public function clear():void
		{
			this.setDrag(false);
			
			heroVO = null;
			heroInfo = null;
			
			if(figure)
			{
				figure.stop();
				figure.visible = false;
				/*this.removeChild(figure);*/
			}
			figure = null;
			while(figureContainer.numChildren > 0)
			{
				figureContainer.removeChildAt(0);
			}
		}
	}
}