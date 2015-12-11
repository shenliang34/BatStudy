package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.events.MouseEvent;
	
	import bowser.render.display.RenderItem;

	/**
	 * 不会移动的怪物
	 * @author weiyanyu
	 * 创建时间：2015-6-15 下午5:39:41
	 * 
	 */
	public class MapMonster extends MapRoleBase
	{
		
		private var _pk:RenderItem;
		public function MapMonster()
		{
			super();
			setAvatar("hero_heishanlaoyao01_m");
		}
		
		override public function onMouseOverHandler(event:MouseEvent):void
		{
			this.filters = MapConfig.NPCFILTER;
			if(_pk == null)
			{
				_pk = new RenderItem(GameConfig.RESOURCE_URL + "gui/pk.png");
				this.addChild(_pk);
			}
			_pk.x = 0;
			_pk.y = -avatar.height >> 1;
			_pk.visible = true;
		}
		
		override public function onMouseOutHandler(event:MouseEvent):void
		{
			_pk.visible = false;
			this.filters = null;
		}
	}
}