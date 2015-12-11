package com.gamehero.sxd2.gui.bag.component
{

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.mouse.dnd.IDragObject;

	use namespace alternativagui;
	

	/**
	 * Item Drag Object 
	 * @author Trey
	 * @create-date 2013-8-16
	 */
	public class ItemDragObject extends Sprite implements IDragObject {
		
		private var dataObject:Object;

		
		public function ItemDragObject(dataObject:Object) {
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.dataObject = dataObject;
			
			if(dataObject.bd) {
				
				var bitmap:Bitmap = new Bitmap(dataObject.bd);
				bitmap.alpha = .5;
				bitmap.width = bitmap.height = bitmap.width;
				addChild(bitmap);
			}
		}

		
		public function get data():Object {
			
			return dataObject;
		}

		public function get graphicObject():DisplayObject {
			
			return this;
		}
	}
}
