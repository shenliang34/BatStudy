package com.gamehero.sxd2.gui.hurdleGuide.components
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-11-16 上午11:18:35
	 * 
	 */
	public class HurdleGuideTipsSprite extends Sprite
	{
		public function HurdleGuideTipsSprite()
		{
			super();
			addChild(new Bitmap(Global.instance.getBD(HurdleGuideModel.inst.guideDomain,"GuideTips")));
			
			var lb:Label = new Label();
			lb.text = "当前任务副本";
			addChild(lb);
			lb.x = 25;
			lb.y = 20;
			
		}
	}
}