package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons {
	
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.manager.SoundManager;
	
	import flash.display.BitmapData;
	
	import alternativa.gui.controls.button.ITriggerButton;
	import alternativa.gui.controls.button.RadioButtonGroup;
	import alternativa.gui.controls.button.TriggerButtonGroup;

	/**
	 * 
	 * RU: обsчная кнопка, которая ведёт себя как radiobutton
     * EN: big button -
	 * 
	 */	
	/**
	 * Toggle Button 
	 * @author Trey
	 * @create-date 2013-8-23
	 */
	public class ToggleButton extends Button implements ITriggerButton {
		
		// RU: флаг выделения
        // EN: flag of selection
		protected var _selected:Boolean = false;
		
		// RU: группа, к которой принадлежит данная кнопка
        // EN: group of this button
		protected var _group:RadioButtonGroup;

//		public function ToggleButton(statUPClass:Class, stateDOWNClass:Class, stateOVERClass:Class, stateOFFClass:Class = null) {
		public function ToggleButton(statUPClass:BitmapData, stateDOWNClass:BitmapData, stateOVERClass:BitmapData, stateOFFClass:BitmapData = null) {
			
			super(statUPClass, stateDOWNClass, stateOVERClass, stateOFFClass);
		}
		
		// RU: при выделении кнопки, сообщаем радиогруппе. Меняем состояния
        // EN: inform radiogroup on button selection. Change the state
		public function set selected(value:Boolean):void {
			
			_selected = value;

			if (_group != null && _selected) {
				_group.buttonSelected(this);
			}
			if (_selected) {
				
				setState(_stateDOWN);
				
				// Add by Trey, 选中状态不再接受鼠标事件
//				this.cursorActive = false;
			} 
			else {
				
				// Add by Trey
//				this.cursorActive = true;
				
				
//				if (_over) {
//					setState(_stateOVER);
//				} else {
					setState(_stateUP);
//				}
			}
		}

		public function get selected():Boolean {
			return _selected;
		}
		
		// RU: задаем радогруппу для данной кнопки
        // EN: Set the radiogroup to this button
		public function set group(value:TriggerButtonGroup):void {
			_group = value as RadioButtonGroup;
		}

		public function get group():TriggerButtonGroup {
			return _group;
		}

		override public function set pressed(value:Boolean):void {
			if (!_locked)
				_pressed = value;

			if (_pressed) {
				if (_group != null) {
					selected = true;
				} else {
					selected = !_selected;
				}
			}
			
			// 点击音效
			if(value == true)
			{
				SoundManager.inst.play(SoundConfig.TOOGLE_CLICK);
			}
		}

		override public function set over(value:Boolean):void {
			if (!_locked) {
				_over = value;
			}

			if (!_locked && !_pressed) {
				if (!_selected) {
					setState(value ? _stateOVER : _stateUP);
				}
			}
			
			// 悬浮音效
			if(value == true)
			{
				SoundManager.inst.play(SoundConfig.TOOGLE_CLICK);
			}
		}

	}
}
