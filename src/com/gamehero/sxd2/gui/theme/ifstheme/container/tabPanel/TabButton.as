package com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel {

	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.TabPanelSkin;
	
	import flash.display.BitmapData;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.theme.defaulttheme.controls.buttons.ToggleButton;
	import alternativa.gui.theme.defaulttheme.primitives.base.StretchBitmapOffset;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;

	use namespace alternativagui;

	/**
	 *
	 * RU: Кнопка - вкладка для TabPanel
     * EN: Button-tab for TabPanel
	 *
	 */
	/**
	 * 自定义TabButton 
	 * @author Trey
	 * @create-date 2013-10-27
	 */
	public class TabButton extends ToggleButton {
		
//		public function TabButton() {
		public function TabButton(stateUp:BitmapData, stateDown:BitmapData, stateOver:BitmapData) {
			
			// RU: задаем состояния кнопки
            // EN: set the button states
//			stateDOWN = new StretchBitmapOffset(TabPanelSkin.stateDownBD, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
//			stateOVER = new StretchBitmapOffset(TabPanelSkin.stateOverBD, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
//			stateUP = new StretchBitmapOffset(TabPanelSkin.stateUpBD, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
			stateDOWN = new StretchBitmapOffset(stateDown, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
			stateOVER = new StretchBitmapOffset(stateOver, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);
			var statUpBD:BitmapData = stateUp;
			stateUP = new StretchBitmapOffset(statUpBD, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, TabPanelSkin.buttomEdge, true, TabPanelSkin.buttomTopOffset, TabPanelSkin.buttomHorOffset, TabPanelSkin.buttomHorOffset);

			// RU: задаем высоту кнопки
            // EN: ste the button height
//			_height = NumericConst.tabButtonHeight;
//			_height = 27;
//			_width = 68;
			_height = statUpBD.height;
			_width = statUpBD.width;
		}

		// RU: отдаем фикисированную высоту
        // EN: return the fixed height
		override protected function calculateHeight(value:int):int {
			
			return _height;
		}
		
		// RU: смотрим значение ширины, если меньше заданного, отдаем минимальную ширину
		// EN: if width value is less than the specified value, then return minimal width value
		override protected function calculateWidth(value:int):int {
			
			return _width;
		}
		
		override public function set label(value:String):void {
			
			
			super.label = value;
			
			_label.color = GameDictionary.WHITE;
			_label.size = 12;
			_label.width = 68;
		}
		
		override public function set selected(value:Boolean):void {
			
			super.selected = value;
			
			if(_label) {
				
				if (_selected) {
					
					_label.alpha = 1;
				} 
				else {
					
					_label.alpha = NumericConst.lockedAlpha;
				}
			}
		}
		override public function set over(value:Boolean):void {
			
			super.over = value;
			
			if(!_selected && _label) {
				
				if (_over) {
					
					_label.alpha = 1;
				} 
				else {
					
					_label.alpha = NumericConst.lockedAlpha;
				}
			}
		}
		/**
		 * set label color 
		 * @param value
		 * 
		 */		
		public function setLabelColor(value:uint):void
		{
			_label.color = value;
		}
		
		
		override protected function draw():void {
			
			super.draw();
			if (_label != null) {
				
				_label.x = (_width - int(_label.width)) >> 1;
				_label.y = (_height - int(_label.height)) >> 1;
			}
		}
	}
}
