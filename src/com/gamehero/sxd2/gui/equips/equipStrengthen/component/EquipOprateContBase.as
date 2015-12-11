package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-30 下午4:23:56
	 * 
	 */
	public class EquipOprateContBase extends Sprite
	{
		protected var _itemCell:EquipStrenItemCell;
		
		private var _nameLb:Label;
		
		protected var _tween:TweenMax;
		
		protected var _itemCost:ItemCostVo;
		/**
		 * 正常状态下的物品x ，y 
		 */		
		protected var itemX:int = 0;
		
		protected var itemY:int = 0;
		
		/**
		 * 升级动画 
		 */		
		protected var _strenMc:MovieClip;
		
		public function EquipOprateContBase()
		{
			super();
			_itemCell = new EquipStrenItemCell();
			addChild(_itemCell);
			
			_strenMc = Global.instance.getRes(EquipModel.inst.domain,"Stren_Success") as MovieClip;
			_strenMc.fx.addChild(_itemCell);
			addChild(_strenMc);
			_strenMc.x = 434;
			_strenMc.y = 188;
			_strenMc.gotoAndStop(_strenMc.totalFrames);
			_itemCell.size = 120;
			
			_nameLb = new Label();
			addChild(_nameLb);
			_nameLb.width = 100;
			_nameLb.y = 279;
		}
		
		public function setLabel(value:String,color:uint):void
		{
			_nameLb.text = value;
			_nameLb.x = 364 + (_itemCell.size - _nameLb.width >> 1);
			_nameLb.color = color;
		}
		
		public function playChangePage():void
		{
			_itemCell.y = -40;
			_tween = TweenMax.to(_itemCell , .3 , {y:itemY , onComplete:stop});
		}
		
		
		public function stop():void
		{
			if(_tween) 
			{
				_tween.kill();
				_tween = null;
			}
			_itemCell.y = itemY;
		}
	}
}