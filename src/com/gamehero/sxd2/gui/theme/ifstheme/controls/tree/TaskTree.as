package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree {

	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	
	import flash.display.DisplayObject;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.tree.Tree;
	import alternativa.gui.controls.tree.TreeItemContainer;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	
	/**
	 * 自定义Tree 
	 * @author Trey
	 * @create-date 2013-9-5
	 */
	public class TaskTree extends Tree {
		
		public function TaskTree(itemRenderClass:Class) {
			
            // EN: set a background
//			background = new WhiteBG();
			
            // EN: padding
			_padding = NumericConst.basePadding;
			
            // EN: distance between the components
			_space = NumericConst.basePadding;
			
            // EN: items container
			container = new TreeItemContainer();
			scrollBar = new ScrollBar();
			
            // EN: visual class of the item
//			itemRenderer = TaskTreeObject;
			itemRenderer = itemRenderClass;
			
			super();
		}

		
        // EN: set the visual class of the item
		override public function set itemRenderer(value:Class):void {
			
            // EN: pass it to items container
			container.itemRenderer = value;
            // EN: set the number of pixels for the mouse wheel scroll
			(scrollBar as ScrollBar).mouseDelta = container.mouseDelta;
            // EN: Number of pixels in one step when you press the up/down scrollBar button
			(scrollBar as ScrollBar).stepScroll = container.stepScroll;
		}

		
        // EN: override the draw method. Set position to items container and to scrollBar
		override protected function draw():void {
			
			super.draw();
			
			if (_container != null) {
				var display:DisplayObject = (_container as DisplayObject)
				
				display.x = padding + NumericConst.borderThickness;
				display.y = padding + NumericConst.borderThickness;
				
				display.height = _height - 5 * 2;
				
				if (_scrollBar != null && _scrollBar.visible) {
					display.width = _width - _padding * 2 - _scrollBar.width - _space;
				} else {
					display.width = _width - _padding * 2 - NumericConst.borderThickness * 2;
				}
			}
			
		}


		// EN: if width value is less than the specified value, then return minimal width value
		override protected function calculateWidth(value:int):int {
			if (value < NumericConst.listMinWidth)
				value = NumericConst.listMinWidth;
			return value;
		}
	}
}
