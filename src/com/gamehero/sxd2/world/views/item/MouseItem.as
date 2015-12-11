package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.SpriteItem;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2015-7-29 下午9:20:56
	 * 
	 */
	public class MouseItem extends SwfRenderItem
	{
		public function MouseItem(url:String, isSS:Boolean=false, clearMemory:Boolean=true, loader:BulkLoaderSingleton=null, loadProps:Object=null, isSWF:Boolean=true)
		{
			super(url, isSS, clearMemory, loader, loadProps, isSWF);
			addEventListener(SwfRenderEvent.ISOVER,isOverLooped);
			status = "a0";
			loop = 1;
		}
		
		protected function isOverLooped(event:Event):void
		{
			(this.parent as SpriteItem).removeChild(this);
			removeEventListener(SwfRenderEvent.ISOVER,isOverLooped);
			gc();
		}
	}
}