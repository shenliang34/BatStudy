package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.CheckBox;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import alternativa.gui.mouse.CursorManager;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午1:46:06
	 * 
	 */
	public class PlayerIconButton extends Sprite 
	{
		public  var _iconImage:PlayerIcon;
		private var _bgSprite:Sprite;
		
		public var _checkBox:CheckBox;
		
		public function PlayerIconButton(iconId:int = 0,isCheckBox:Boolean = false)
		{
			_bgSprite = new Sprite();
			_bgSprite.graphics.beginFill(0x00000,0.5);
			_bgSprite.graphics.drawRect(0,0,50,50);
			_bgSprite.graphics.endFill();
			addChild(_bgSprite);
			
			_iconImage = new PlayerIcon();
			addChild(_iconImage);
			_iconImage.iconId = iconId;
			
			if(isCheckBox){
				_checkBox = new CheckBox();
				_checkBox.x = -5;
				_checkBox.y = -5;
				_checkBox.locked = true;
				this.addChild(_checkBox);
			}
			
			this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			super();
		}
		
		
		protected function onOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			CursorManager.cursorType = CursorManager.ARROW;
			this.filters = [];
		}
		
		protected function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			CursorManager.cursorType = CursorManager.BUTTON;
			this.filters = [new GlowFilter(0xBBBBBB,1,4,4,1,1,false)];
		}
		
//		override public function set locked(value:Boolean):void {
//			super.locked = value;
//			if (_locked) {
//				this.filters = FiltersUtil.BW_Fiter;
//			} else {
//				this.filters = null;
//			}
//		}
	}
}