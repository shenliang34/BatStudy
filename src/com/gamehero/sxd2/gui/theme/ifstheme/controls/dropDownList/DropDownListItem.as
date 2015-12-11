package com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList
{
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.events.MouseEvent;
	
	import org.bytearray.display.ScaleBitmap;

	public class DropDownListItem extends ListItemObject
	{
		/** 高度 **/
		public static const HEIGHT:int = 20;
		/** 宽度 **/
		public static var WIDTH:int;
		
		/** 文本 **/
		private var label:Label;
		/** 选中的效果图片 **/
		private var scaleBitmap:ScaleBitmap;
		
		public function DropDownListItem()
		{
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
			
			scaleBitmap = new ScaleBitmap(MainSkin.itemMenuOver);
			scaleBitmap.setSize(width, height-1);
			scaleBitmap.visible = false;
			addChild(scaleBitmap);
			
			label = new Label();
			label.x = 10;
			label.y = 4;
			addChild(label);
			
			this.mouseChildren = false ;
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			scaleBitmap.visible = true;
		}
		protected function onRollOut(event:MouseEvent):void
		{
			scaleBitmap.visible = false;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!(value is DropDownListVO))
			{
				this.visible = false;
				return;
			}
			this.visible = true;
			
			label.text = ""+value.title;
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			scaleBitmap.visible = value;
			if(value){
				this.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				this.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}else{
				this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}
		}
		
		override public function get height():Number
		{
			return HEIGHT;
		}
		
		override public function get width():Number
		{
			return WIDTH;
		}
		
	}
}