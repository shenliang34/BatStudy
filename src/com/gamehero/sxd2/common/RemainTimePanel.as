package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.Bitmap;
	
	/**
	 * 剩余时间倒计时面板
	 * @author xuwenyi
	 * @create 2015-02-10
	 **/
	public class RemainTimePanel extends BaseTimePanel
	{
		public function RemainTimePanel()
		{
			// 剩余时间
			var bmp:Bitmap = new Bitmap(MainSkin.REMAIN_TIME_BD);
			bmp.x = -5;
			bmp.y = 45;
			this.addChildAt(bmp , 0);
			
			super();
		}
	}
}