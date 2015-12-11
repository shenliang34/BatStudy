package com.gamehero.sxd2.gui.player.hero.components
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MouseSkin;
	
	import flash.display.Sprite;
	import flash.ui.MouseCursor;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 可以支持tips的label
	 * @author weiyanyu
	 * 创建时间：2015-8-21 下午4:06:04
	 * 
	 */
	public class ActiveLabel extends ActiveObject
	{
		/**
		 * 显示文本 
		 */		
		public var label:Label;
		public function ActiveLabel()
		{
			super();
			label = new Label();
			addChild(label);
		}
		
		/**
		 * x 响应区域X
		 * y 响应区域Y
		 * w 宽度
		 * h 高度
		 * 
		 * lbY 文本Y坐标  X坐标  = x
		 * */
		public function sethitArea(x:int,y:int,w:int,h:int,lbY:int):void
		{
			label.x = x;
			label.y = lbY;
			
			var hit:Sprite = new Sprite();
			hit.graphics.beginFill(0,0);
			hit.graphics.drawRect(x,y,w,h);
			hit.graphics.endFill();
			this.addChildAt(hit,0);
			this.hitArea = hit;
		}
	}
}