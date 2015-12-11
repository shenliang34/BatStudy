package com.gamehero.sxd2.gui.hurdleGuide.components
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemGrid;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-6 上午11:22:51
	 * 
	 */
	public class HurdleClearItemRender extends ActiveObject
	{
		/**
		 * 扫荡次数 
		 */		
		private var _num:int = 0;
		/**
		 * 标题 
		 */		
		private var _titleLabel:Label;
		/**
		 * 格子容器 
		 */		
		private var _grid:ItemGrid;
		
		
		public function HurdleClearItemRender()
		{
			super();
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,280,95);
			this.graphics.endFill();
			_titleLabel = new Label();
			addChild(_titleLabel);
			_titleLabel.color = GameDictionary.WINDOW_WHITE;
			_titleLabel.y = 14;
			_grid = new ItemGrid();
			_grid.clickAble = false;
			addChild(_grid);
			_grid.gapX = 2;
			_grid.y = 36;
			_grid.col = 5;
			this.width = 280;
			this.height = 95;
		}
		/**
		 * 设置奖励道具
		 * @param arr 道具数组 
		 * @param count 次数
		 * 
		 */		
		public function setData(arr:Array,count:int):void
		{
			_num = count;
			_titleLabel.text = "扫荡第" + (count + 1) + "次";
			_grid.data = arr;
		}
		
		/**
		 * 统计信息 
		 * @param str 说明文本
		 */		
		public function statistics(arr:Array,str:String):void
		{
			_titleLabel.text = str;
			_grid.data = arr;
		}
		
		public function clear():void
		{
			removeChild(_titleLabel);
			_titleLabel = null;
			_grid.clear();
			removeChild(_grid);
			_grid = null;
			
		}
	}
}