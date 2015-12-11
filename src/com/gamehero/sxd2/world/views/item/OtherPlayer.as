package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.world.model.MapConfig;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bowser.iso.pathfinding.navmesh.geom.Vector2f;
	
	/**
	 * 其他玩家
	 * @author weiyanyu
	 * 创建时间：2015-7-20 上午11:36:32
	 * 
	 */
	public class OtherPlayer extends MapRunRoleBase
	{
		
		public function OtherPlayer()
		{
			super();
			
		}
		/**
		 * 更新玩家信息 
		 * @param pp
		 * 
		 */		
		public function updataInfo(pp:PRO_Player):void
		{
			if(pp.map)
			{
				setTarget(pp.map.x,pp.map.y);
			}
			if(pp.base)
			{
				setName(pp.base.name);
			}
		}
		
		/**
		 * 角色加载完成
		 * */
		override protected function avatarLoaded(e:Event):void
		{
			super.avatarLoaded(e);
		}
		
		override public function onMouseOverHandler(event:MouseEvent):void
		{
			this.filters = MapConfig.NPCFILTER;
		}
		override public function onMouseOutHandler(event:MouseEvent):void
		{
			this.filters = null;
		}
		
		/**
		 * 设置目标点 
		 * @param tx
		 * @param ty
		 * 
		 */		
		public function setTarget(tx:int,ty:int):void
		{
			var tg:Vector2f = new Vector2f();
			tg.x = tx;
			tg.y = ty;
			path = new Vector.<Vector2f>();
			path.push(tg);
		}
	}
}