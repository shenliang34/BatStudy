package com.gamehero.sxd2.gui.formation.bagZone
{
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.CheckBox;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-21 下午2:50:26
	 * 
	 */
	public class FormationHeroBagPanel extends NormalScrollPane
	{
		private var bagContent:Sprite;
		//高亮框
		private var overBmp:Bitmap;
		
		//背包集合
		private var heroCells:Array = [];
		
		/**伙伴全显示Box*/
		/*private var showAllBox:CheckBox;*/
		
		public function FormationHeroBagPanel()
		{
			super();
			
			bagContent = new Sprite();
			this.content = bagContent;
			
			overBmp = new Bitmap(FormationSkin.bagOverBmp);
			
			/*showAllBox = new CheckBox();
			showAllBox.x = 100;
			showAllBox.y = 479;
			showAllBox.label = "显示全部伙伴";
			showAllBox.locked = false;
			showAllBox.checked = false;
			addChild(showAllBox);*/
		}
		
		/**伙伴背包刷新*/
		public function updateHero():void
		{
			this.clear();
			
			/*showAllBox.addEventListener(MouseEvent.CLICK,onBoxClick);*/
			
			var heroAry:Array = FormationModel.inst.heroList;
			/*if(showAllBox.checked)
			{
				heroAry = FormationModel.inst.heroList;
			}
			else heroAry = FormationModel.inst.newHeroList;*/
			
			var heroCell:FormationHeroIconCell;
			var newHeroList:Array = FormationModel.inst.sortHeroList(heroAry);
			for(var i:int = 0;i<newHeroList.length;i++)
			{
				heroCell = new FormationHeroIconCell();
				heroCell.data = newHeroList[i];
				heroCell.x = 0;
				heroCell.y = 82*i + 7;
				bagContent.addChild(heroCell);
				heroCells.push(heroCell);
			}
			//滚动面板重绘
			this.refresh();
		}
		
		
		/**
		 * 盒子勾选
		 * */
		private function onBoxClick(evt:MouseEvent):void
		{
			this.updateHero();
		}
		
		
		/**数据清除*/
		private function clear():void
		{
			for(var i:int = 0;i<this.heroCells.length;i++)
			{
				var cell:FormationHeroIconCell = heroCells[i];
				cell.close();
			}
			while(bagContent.numChildren > 0)
			{
				bagContent.removeChildAt(0);
			}
		}
		
		/**关闭*/
		public function close():void
		{
			this.clear();
			/*showAllBox.removeEventListener(MouseEvent.CLICK,onBoxClick);*/
		}
		
	}
}