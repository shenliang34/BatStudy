package com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel {

	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.GText;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.TabPanelSkin;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.theme.defaulttheme.controls.buttons.ToggleButton;
	import alternativa.gui.theme.defaulttheme.primitives.base.StretchBitmapOffset;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 * 自定义TabButton With Gradient Text
	 * @author Trey
	 * @create-date 2013-11-10
	 */
	public class GTextTabButton extends ToggleButton {

		private var _gText:GText;
		
//		public function GTextTabButton(stateUpClass:Class, stateDownClass:Class, stateOverClass:Class) {
		public function GTextTabButton(stateUpSkin:BitmapData, stateDownSkin:BitmapData, stateOverSkin:BitmapData) {
			
            // EN: set the button states
			stateDOWN = new StretchBitmapOffset(stateDownSkin, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffsetLf);
			stateOVER = new StretchBitmapOffset(stateOverSkin, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
			var statUpBD:BitmapData = stateUpSkin;
			stateUP = new StretchBitmapOffset(statUpBD, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);

			_height = statUpBD.height;
			_width = statUpBD.width;
			
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.CLICK, onClick);
		}

        // EN: return the fixed height
		override protected function calculateHeight(value:int):int {
			return _height;
		}
		
		// EN: if width value is less than the specified value, then return minimal width value
		override protected function calculateWidth(value:int):int {
			return _width;
		}
		
		override public function set label(value:String):void {
			if (_gText == null) {
				_gText = new GText();
				_gText.alpha = NumericConst.lockedAlpha;
				addChild(_gText);
			}
			
			_gText.text = value;
			
			draw();
		}
		
		override public function get label():String
		{
			return _gText.text;
		}
		
		
		override protected function draw():void {
			
			super.draw();
			
			if (_gText != null) {
				
				_gText.x = (_width - int(_gText.width)) >> 1;
				_gText.y = (_height - int(_gText.height)) >> 1;
			}
		}
		
		
		override public function set selected(value:Boolean):void {
			
			super.selected = value;
			
			if(_gText) {
				
				if (_selected) {
					
					_gText.alpha = 1;
				} 
				else {
					
					_gText.alpha = NumericConst.lockedAlpha;
				}
			}
		}
		
		
		override public function set over(value:Boolean):void {
			
			super.over = value;
			
			if(!_selected && _gText) {
				
				if (_over) {
					
					_gText.alpha = 1;
				} 
				else {
					
					_gText.alpha = NumericConst.lockedAlpha;
				}
			}
		}
		
		/**
		 * 点击
		 */
		private function onClick(evt:MouseEvent):void
		{
			SoundManager.inst.play(SoundConfig.ITEM_CLICK);
		}
		
		/**
		 * 鼠标移入
		 */
		private function onOver(evt:MouseEvent):void
		{
			/*SoundManager.inst.play(SoundConfig.ITEM_CLICK);*/
		}
		
	}
}
