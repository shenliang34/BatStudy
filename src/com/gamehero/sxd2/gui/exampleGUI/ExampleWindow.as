package com.gamehero.sxd2.gui.exampleGUI
{
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.pro.PRO_Item;

	/**
	 * @author weiyanyu
	 * 创建时间：2015-9-13 17:16:40
	 * 
	 */
	public class ExampleWindow extends GeneralWindow
	{
		
		public function ExampleWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 1024, 800);
		}
		override protected function initWindow():void
		{
			super.initWindow();
			var label:Label = new Label();
			var inner:InnerBg = new InnerBg();
			add(inner,20,30,20,30);
			add(label,20,30,20,30);
			label.text = "InnerBg";
			
			var itemCell:ItemCell = new ItemCell();
			var pro:PRO_Item = new PRO_Item();
			pro.itemId = 10010001;
			pro.num = 20;
			itemCell.data = pro;
			add(itemCell,50,30);
			
		}
		override public function onShow():void
		{
			super.onShow();
		}
		override public function close():void
		{
			super.close();
		}
	}
}