package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {

	import com.gamehero.sxd2.gui.theme.ifstheme.controls.scrollBar.ScrollBar;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.NumericConst;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.controls.text.TextArea;

	use namespace alternativagui;

	
	/**
	 * Custom TextArea
	 * @author Trey
	 * @create-date 2013-11-30
	 */
	public class TextArea extends alternativa.gui.controls.text.TextArea {
		
        // EN: background
//		protected var background:WhiteBG;
		
        // EN: background frame thickness
		protected var borderThickness:int = NumericConst.borderThickness;

		public function TextArea() {
			super();

			textInput.color = NumericConst.textColor;

			/*background = new WhiteBG();
			addChildAt(background, 0);*/
			
            // EN: create and add scrollBar
			scrollBar = new ScrollBar();
			(scrollBar as ScrollBar).stepScroll = NumericConst.textAreaStepScroll;
			(scrollBar as ScrollBar).mouseDelta = NumericConst.textAreaMouseDelta;
			addChild(scrollBar);
			
            // EN: set listeners for the scrollBar
			configureScrollBarListeners(scrollBar);
		}
		
		
        // EN: set position and sizes
		override protected function redrawGraphiсs():void {
			
//			background.resize(_width, _height);
			
			textInput.x = textInput.y = _padding + borderThickness;
			textInput.resize((_width - _padding * 2 - borderThickness * 2), (_height - _padding * 2 - borderThickness * 2));
			scrollBar.x = _width - scrollBar.width;
			scrollBar.height = _height;
			if (textInput.tf.maxScrollV > 1) {
				
				scrollBar.visible = true;
//				textInput.resize((_width - _padding * 2 - scrollBar.width + 2 - borderThickness * 2), (_height - _padding * 2 - borderThickness * 2));
				textInput.resize((_width - _padding * 2 - scrollBar.width + 2 - borderThickness * 2), (_height - _padding * 2 - borderThickness * 2));
//				textInput.resize((200 - _padding * 2 - scrollBar.width + 2 - borderThickness * 2), (200 - _padding * 2 - borderThickness * 2));
			} else {
				
				scrollBar.visible = false;
			}
		}
	}
}
