package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {

	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import alternativa.gui.controls.button.BaseButton;


	/**
	 * RU:
	 * примитивная кнопка с фоном
     * EN:
     * simple button with a background
	 *
	 */
	/**
	 * 自定义SimpleButton 
	 * @author Trey
	 * @create-date 2013-9-3
	 */
	public class SimpleButton extends BaseButton {

		// RU: внутренний отступ
        // EN: padding
		protected var _padding:int = 5;

		public function SimpleButton() {
			
			super();
			// RU: задаем состояния
            // EN: set states
//			stateUP = createState(0xf7f7f7);
//			stateDOWN = new StretchRepeatHBitmap(DropDownMenuSkin.itemStateDownTexture, DropDownMenuSkin.itemStateEdge, DropDownMenuSkin.itemStateEdge);
//			stateOVER = new StretchRepeatHBitmap(DropDownMenuSkin.itemStateOverTexture, DropDownMenuSkin.itemStateEdge, DropDownMenuSkin.itemStateEdge);
			stateUP = createState(0xf7f7f7);
			stateOVER = new Bitmap(ChatSkin.itemMenuOver);
			stateDOWN = new Bitmap(ChatSkin.itemMenuOver);
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
//		override protected function calculateHeight(value:int):int {
//			
//			return NumericConst.itemHeight;
//		}

		public function get padding():int {
			return _padding;
		}

		public function set padding(value:int):void {
			_padding = value;
		}
		
	}
}
