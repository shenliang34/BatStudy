package com.gamehero.sxd2.gui.formation
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.mouse.dnd.IDragObject;
	
	/**
	 * @author Wbin
	 * 创建时间：2015-8-24 下午6:15:45
	 * 
	 */
	public class FormationDragObject extends GUIobject implements IDragObject
	{
		private var _dataObject:Object;
		
		public function FormationDragObject(dataObject:Object)
		{
			super();
			
			if(dataObject)
			{
				_dataObject = dataObject;
				
				if(_dataObject.heroInfo)
				{
					var heroInfo:PRO_Hero = _dataObject.heroInfo as PRO_Hero;
					var hero:HeroVO = HeroManager.instance.getHeroByID(heroInfo.heroId+"");
					var url:String = GameConfig.BATTLE_FIGURE_URL + hero.url;
					var figure:SpriteFigureItem = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
					figure.frameRate = 18;
					figure.play();
					this.addChild(figure);
					
					// 保存资源url,在阵容面板关闭时清除
					FormationModel.inst.addResource(url);
					
					// 拖拽图像的坐标
					dataObject.dragOffset = new Point(0 , 0);
				}
			}
		}
		
		public function get data():Object
		{
			return _dataObject;
		}
		
		public function get graphicObject():DisplayObject
		{
			return this;
		}
	}
}