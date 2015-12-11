package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.BitmapData;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * innerbg
	 * @author weiyanyu
	 * 创建时间：2015-9-13 下午2:20:12
	 * 
	 */
	public class InnerBg extends ScaleBitmap
	{
		public function InnerBg(bmpData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			bmpData = CommonSkin.windowInner2Bg;
			scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			super(bmpData, pixelSnapping, smoothing);
		}
	}
}