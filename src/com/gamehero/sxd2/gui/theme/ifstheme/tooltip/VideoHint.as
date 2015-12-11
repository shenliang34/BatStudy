package com.gamehero.sxd2.gui.theme.ifstheme.tooltip
{
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.mouse.IHint;
	
	
	/**
	 * 用于战报录像的tips
	 * @author xuwenyi
	 * @create 2015-09-02
	 **/
	public class VideoHint extends ActiveObject implements IHint
	{
		public function VideoHint()
		{
			super();
		}
		
		public function set text(value:String):void
		{
		}
		
		public function get available():Boolean
		{
			return false;
		}
	}
}