package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree {

	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import alternativa.gui.controls.button.BaseButton;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;


	/**
	 * RU:
	 * примитивная кнопка с фоном
     * EN:
     * simple button with a background
	 *
	 */
	public class TaskTreeSimpleButton extends BaseButton {

		// RU: внутренний отступ
        // EN: padding
		protected var _padding:int = 10;
		
		
		private var TREE_SIMPLEBUTTON_UP:Class;
		private var TREE_SIMPLEBUTTON0_UP:Class;
		
		

		/**
		 * 
		 * @param TREE_SIMPLEBUTTON_UP 根节点鼠标UP State
		 * @param TREE_SIMPLEBUTTON0_UP 子节点鼠标UP State
		 * 
		 */
		public function TaskTreeSimpleButton(TREE_SIMPLEBUTTON_UP:Class = null, TREE_SIMPLEBUTTON0_UP:Class = null) {
			
			super();
			/*
			
			this.TREE_SIMPLEBUTTON_UP = TREE_SIMPLEBUTTON_UP;
			this.TREE_SIMPLEBUTTON0_UP = TREE_SIMPLEBUTTON0_UP;
			
			
			// RU: задаем состояния
            // EN: set states
//			stateUP = createState(0xf7f7f7);
//			stateDOWN = new StretchRepeatHBitmap(DropDownMenuSkin.itemStateDownTexture, DropDownMenuSkin.itemStateEdge, DropDownMenuSkin.itemStateEdge);
//			stateOVER = new StretchRepeatHBitmap(DropDownMenuSkin.itemStateOverTexture, DropDownMenuSkin.itemStateEdge, DropDownMenuSkin.itemStateEdge);
			
			stateUP = createState(0xf7f7f7);
			if(TREE_SIMPLEBUTTON_UP) {
				
				stateUP = createState(0xf7f7f7);
				stateDOWN = new Bitmap(new TREE_SIMPLEBUTTON_UP());
				stateOVER = new Bitmap(new TREE_SIMPLEBUTTON_UP());
			}
			else {
				
				stateUP = createState(0xf7f7f7);
				stateDOWN = createState(0xf7f7f7);
				stateOVER = createState(0xf7f7f7);
			}
			*/
		}
		
		
		public function setSkin(level:int):void {
			
			if(level == 0) {
				
				if(TREE_SIMPLEBUTTON0_UP) {
					
					stateUP = new Bitmap(new TREE_SIMPLEBUTTON0_UP());
					stateDOWN = new Bitmap(new TREE_SIMPLEBUTTON0_UP());
					stateOVER = new Bitmap(new TREE_SIMPLEBUTTON0_UP());
				}
				else {
					
					stateUP = createState(0xf7f7f7);
					stateDOWN = createState(0xf7f7f7);
					stateOVER = createState(0xf7f7f7);
				}
			}
			else if(level > 0) {
				
				if(TREE_SIMPLEBUTTON_UP) {
					
					stateUP = createState(0xf7f7f7);
					stateDOWN = new Bitmap(new TREE_SIMPLEBUTTON_UP());
					stateOVER = new Bitmap(new TREE_SIMPLEBUTTON_UP());
				}
				else {
					
					stateUP = createState(0xf7f7f7);
					stateDOWN = createState(0xf7f7f7);
					stateOVER = createState(0xf7f7f7);
				}
			}
		}
		

		protected function createState(color:Number):Sprite {
			
			var sp:Sprite = new Sprite();
//			sp.graphics.beginFill(color,1);
			sp.graphics.beginFill(color,0);
			sp.graphics.drawRect(0,0,10,10);
			sp.mouseEnabled = false;
			sp.tabEnabled = false;
			return sp;
		}

		// RU: фиксированная высота
        // EN: fixed height
		override protected function calculateHeight(value:int):int {
			
			return NumericConst.itemHeight;
		}

		public function get padding():int {
			return _padding;
		}

		public function set padding(value:int):void {
			_padding = value;
		}
	}
}
